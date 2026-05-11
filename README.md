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

## 🛠 目前實作狀態

專案已支援多種架構切換：

### 1. No State Management (Vanilla)
- **架構基礎**：使用 `setState` 配合 `StatefulWidget` 管理狀態。
- **狀態傳遞**：採用 **Property Drilling** 模式，將購物車狀態透過建構子向下傳遞。

### 2. ChangeNotifier (Provider)
- **架構基礎**：使用 `ChangeNotifier` 類別並配合 `Provider` 套件。
- **優點**：減少了參數傳遞的繁瑣，透過 `Consumer` 實現局部刷新，是 Flutter 最主流的入門架構。

### 3. ValueNotifier
- **架構基礎**：使用 Flutter 原生的 `ValueNotifier` 類別。
- **監聽方式**：使用 `ValueListenableBuilder` 監聽單一值的變化。
- **優點**：輕量級且無需依賴第三方套件。

---

## 📂 專案結構
```text
lib/
├── core/               # 核心定義 (Models, Constants, Theme)
├── features/           # 功能模組
│   └── apple_store/
│       ├── presentation/ # 共用 UI 介面 (首頁、詳情、購物車、結帳)
│       └── state_management/ 
│           ├── vanilla/   # Vanilla 實作
│           └── notifier/  # ChangeNotifier & ValueNotifier 實作
└── main.dart           # 入口 (架構選擇器)
```

---

## 🗺 路線圖 (Roadmap)
- [x] **Vanilla (setState)** - 已完成
- [x] **ChangeNotifier** - 已完成
- [x] **ValueNotifier** - 已完成
- [ ] **Provider (Advanced)**
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
