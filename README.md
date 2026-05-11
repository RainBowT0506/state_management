# 🍎 Apple Store Playground — Flutter State Management Showcase

這是一個實戰型的 Flutter 專案，以 **Apple iPhone 電商** 為核心情境，展示多種不同的 Flutter 狀態管理（State Management）架構。透過共用一套高品質的 UI 與商業邏輯，直觀地比較各架構在開發效率、程式碼可讀性與維護成本上的差異。

---

## 🚀 專案特色
- **精品級 UI 設計**：模擬 Apple Store 官方 App 體驗，包含細膩的動畫 (animate_do) 與 Typography (Google Fonts)。
- **完整電商流程**：從商品瀏覽、規格選擇、加入購物車到結帳完成。
- **動態功能**：
  - 顏色與容量切換（即時更新價格與圖片）。
  - AppleCare+ 保固加購。
  - 全域購物車狀態同步。
  - 模擬國際支付 (Apple Pay / Stripe / PayPal)。

---

## 🛠 目前實作狀態：No State Management (Vanilla)

專案的第一階段已完成 **「無狀態管理套件」** 的原生版本。

### 設計特點
- **架構基礎**：使用 `setState` 配合 `StatefulWidget` 管理狀態。
- **狀態傳遞**：採用 **Property Drilling** 模式，將購物車狀態 (`CartState`) 與操作函數從頂層透過建構子向下傳遞。
- **優點**：不依賴任何外部套件，適合理解 Flutter 原生渲染原理。
- **挑戰**：隨著頁面深度增加，參數傳遞會變得繁瑣。

### 核心檔案
- `lib/main.dart`: 應用程式進入點。
- `lib/features/apple_store/state_management/vanilla/vanilla_app.dart`: Vanilla 狀態容器。
- `lib/features/apple_store/presentation/`: 共用的 UI 頁面與組件。

---

## 📂 專案結構
```text
lib/
├── core/               # 核心定義 (Models, Constants, Theme)
│   ├── models/         # 領域模型 (Product, CartItem, CartState)
│   └── theme/          # Apple 風格設計規範
├── features/           # 功能模組
│   └── apple_store/
│       ├── presentation/ # 共用 UI 介面 (Pages, Widgets)
│       └── state_management/ # 各種架構實作 (Vanilla, Provider, etc.)
└── main.dart           # 入口
```

---

## 🗺 路線圖 (Roadmap)
接下來我們將依序導入以下架構：
- [x] **Vanilla (setState)** - 已完成
- [ ] **ChangeNotifier / ValueNotifier**
- [ ] **Provider**
- [ ] **Riverpod**
- [ ] **BLoC / Cubit**
- [ ] **GetX**
- [ ] **Redux**

---

## 📥 安裝與執行
1. 確保你已安裝 Flutter SDK。
2. 執行以下指令：
   ```bash
   flutter pub get
   flutter run
   ```

---
*Created with ❤️ by Antigravity AI Coding Assistant.*
