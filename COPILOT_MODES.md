# Copilot 4 Loại Agent - Giải Thích Thực Tế

> Nguồn:
> - https://code.visualstudio.com/docs/copilot/agents/local-agents
> - https://code.visualstudio.com/docs/copilot/agents/copilot-cli
> - https://code.visualstudio.com/docs/copilot/agents/cloud-agents

---

## Tổng quan: 2 chiều phân biệt

```
                    CHẠY Ở ĐÂU?
                 Máy bạn │ Server từ xa
                ──────────┼──────────────
Tương tác  │ Interactive │  LOCAL        │  (CLOUD / Third-party)
thế nào?   │             │  (VS Code)    │
           ├─────────────┼───────────────┤
           │ Background  │  COPILOT CLI  │  CLOUD / Third-party
           │             │  (nền máy)    │  (remote background)
```

- **Local** = máy bạn + interactive (bạn ngồi xem)
- **Copilot CLI** = máy bạn + background (AI tự chạy, bạn làm việc khác)
- **Cloud** = server GitHub + background + kết quả qua PR
- **Third-party** = model của Anthropic/OpenAI, có thể dùng local hoặc cloud

---

## 1. LOCAL Agent

**Chạy ở đâu**: Máy bạn, **bên trong VS Code**
**Tương tác**: **Interactive** — bạn ngồi tương tác từng bước trong Chat view

### Đặc điểm chính (theo docs)
- Chạy trong VS Code editor, khi VS Code đóng → agent dừng
- Full access: workspace, extension tools, MCP servers, tất cả models (kể cả BYOK)
- Có 3 built-in mode:
  - **Agent**: tự làm task phức tạp, chạy terminal, sửa nhiều file
  - **Plan**: tạo implementation plan trước khi code
  - **Ask**: hỏi đáp về codebase, không sửa file

### Khi nào dùng (theo docs)
- ✅ Brainstorm, explore, task chưa định nghĩa rõ → cần trao đổi qua lại
- ✅ Fix bug cần **context từ editor**: linting errors, stack traces, unit test results
- ✅ Cần dùng VS Code extension tools hoặc MCP servers cụ thể
- ✅ Task không cần team collaboration

### Ví dụ thực tế
```
Bug xuất hiện: "TypeError: Cannot read property 'id' of undefined"
Test đang fail, linting error đang hiển thị trong VS Code

→ Mở Chat view trong VS Code, gõ:
  "Fix this TypeError, here's the stack trace: [paste]"

→ Local agent thấy ngay:
  - File đang mở trong editor
  - Stack trace bạn paste
  - Linting errors ở sidebar
  - Unit test output ở terminal

→ AI sửa file ngay trong editor
→ Bạn thấy diff, nhấn Accept/Reject từng thay đổi
→ Nếu test vẫn fail, hỏi tiếp ngay trong cùng chat session

Tại sao LOCAL phù hợp ở đây?
→ Vì cần context runtime (stack trace, linting, test results)
   mà chỉ có khi đang chạy trong VS Code
```

---

## 2. COPILOT CLI Agent

**Chạy ở đâu**: Máy bạn, **ngoài VS Code** (background process độc lập)
**Tương tác**: **Background** — giao task rồi làm việc khác, AI tự chạy nền

### Đặc điểm chính (theo docs)
- Chạy **độc lập ngoài VS Code** — VS Code đóng vẫn chạy tiếp
- Có thể chạy **nhiều session song song** (parallel)
- Hỗ trợ 2 isolation mode:
  - **Worktree isolation**: tạo Git worktree riêng, thay đổi không ảnh hưởng branch hiện tại → auto Bypass Approvals
  - **Workspace isolation**: thay đổi trực tiếp vào workspace hiện tại → có thể chọn permission level
- **Hạn chế**: không có VS Code extension tools, không có run-time context (test failures, linting)

### Khi nào dùng (theo docs)
- ✅ Task đã định nghĩa rõ, đủ context, không cần tương tác nhiều
- ✅ Muốn AI làm 1 việc trong khi **bạn tiếp tục làm việc khác**
- ✅ Thử **nhiều variants / proof of concept song song** (nhiều CLI sessions cùng lúc)
- ✅ Implement từ 1 plan đã có sẵn

### Ví dụ thực tế
```
Bạn đã có plan chi tiết cho feature "Add JWT authentication"
Bạn muốn AI implement trong khi bạn tiếp tục làm feature khác

→ Tạo Copilot CLI session
→ Chọn "Worktree isolation" (AI làm trên branch riêng, không đụng code bạn đang làm)
→ Gõ:
  "Implement JWT authentication for the user API endpoints
   based on this plan: [paste plan]"

→ CLI tạo Git worktree riêng (folder tách biệt)
→ AI tự chạy nền: đọc code, sửa file, chạy tests, commit từng bước

→ Bạn quay lại làm feature khác trong VS Code
→ Code của bạn KHÔNG bị ảnh hưởng

→ Khi CLI báo xong:
  - Mở worktree trong VS Code để review diff
  - Merge vào branch chính nếu ổn

Tại sao CLI phù hợp ở đây?
→ Task rõ ràng, không cần debug context từ editor,
   muốn song song 2 việc, cần isolate thay đổi
```

---

## 3. CLOUD Agent

**Chạy ở đâu**: **Server của GitHub** (remote infrastructure)
**Tương tác**: **Fully autonomous + PR-based** — giao task, AI tự làm, kết quả là Pull Request

### Đặc điểm chính (theo docs)
- Chạy trên GitHub infrastructure, **không cần máy bạn online**
- Kết quả qua **Pull Request** trên GitHub — tích hợp workflow của team
- **Hạn chế**: không access VS Code built-in tools, không có run-time context (failed tests, text selections), chỉ dùng được MCP servers và models cấu hình trên cloud service
- Có thể assign GitHub Issues trực tiếp cho agent

### Khi nào dùng (theo docs)
- ✅ Task scope rõ ràng, đủ context, **cần tạo PR** cho team review
- ✅ Large-scale refactoring trên toàn repo
- ✅ Muốn AI hoàn toàn tự chủ, team collaboration qua PR
- ✅ Assign GitHub issue trực tiếp cho agent

### Ví dụ thực tế
```
Manager assign GitHub issue #42:
"Refactor authentication module to use OAuth2 + JWT,
 optimize DB queries for user sessions"

→ Trong VS Code, tạo Cloud session
  Hoặc assign issue trực tiếp cho Copilot trên GitHub.com

→ Gõ (hoặc issue description tự trở thành prompt):
  "Implement the requirements in GitHub issue #42"

→ Bạn tắt máy đi ngủ / đi họp
→ Copilot coding agent chạy trên server GitHub:
  - Đọc toàn bộ repo
  - Sửa code, refactor
  - Chạy CI/CD
  - Tự tạo PR với description chi tiết

→ Sáng hôm sau GitHub notify:
  "PR #87: Refactor auth module (fixes #42) - Ready for review"
→ Bạn và team review, comment, merge

Tại sao CLOUD phù hợp ở đây?
→ Cần PR workflow cho team, task lớn, không cần giám sát,
   không cần máy bạn online
```

---

## 4. THIRD-PARTY Agent

**Chạy ở đâu**: Server của **Anthropic (Claude)** hoặc **OpenAI (Codex)**
**Tương tác**: Tùy provider — có thể local hoặc cloud background

### Đặc điểm chính (theo docs)
- Dùng model và infrastructure của Anthropic hoặc OpenAI **thay vì** GitHub Copilot model
- Không cần cài extension riêng của provider
- Cần enable trong Copilot account settings
- VS Code hỗ trợ: **Claude coding agent** và **Codex coding agent**

### Khi nào dùng (theo docs)
- ✅ Muốn dùng Claude hoặc Codex cụ thể cho 1 task
- ✅ So sánh kết quả giữa các providers
- ✅ Task đặc thù phù hợp hơn với model nhất định

---

## So sánh trực tiếp — Cùng 1 task

**Task**: "Implement user login with JWT"

| | **Local** | **Copilot CLI** | **Cloud** |
|---|---|---|---|
| **Bạn làm gì khi AI chạy** | Ngồi xem, confirm | Làm việc khác | Tắt máy / họp |
| **AI chạy ở đâu** | Trong VS Code | Nền máy bạn | Server GitHub |
| **Code thay đổi ở đâu** | Workspace hiện tại | Git worktree riêng | GitHub repo (remote) |
| **Kết quả** | Code sửa ngay trong editor | Code trong worktree, bạn review merge | Pull Request trên GitHub |
| **VS Code cần mở** | ✅ Cần | ❌ Không cần | ❌ Không cần |
| **Có debug context** | ✅ Stack trace, linting, test | ❌ Không | ❌ Không |
| **Song song nhiều task** | ❌ | ✅ Nhiều sessions | ✅ |
| **Phù hợp khi** | Bug fix, task cần trao đổi | Task rõ ràng, muốn parallel | Cần PR, team review |

---

## Workflow kết hợp (Handoff) — Docs khuyến khích

```
BƯỚC 1: LOCAL → Plan mode
  → Brainstorm, clarify requirements, tạo implementation plan
  → AI hỏi clarifying questions, bạn trả lời
  → Output: plan chi tiết từng bước

         ↓  "Start Implementation" → "Continue in Copilot CLI"

BƯỚC 2: COPILOT CLI → Background
  → Implement plan trên Git worktree riêng
  → Bạn làm việc khác trong khi CLI chạy
  → Output: code changes trong worktree

         ↓  /delegate

BƯỚC 3: CLOUD → Pull Request
  → Tạo PR chính thức trên GitHub
  → Team review, comment, CI/CD chạy
  → Output: merged PR
```
