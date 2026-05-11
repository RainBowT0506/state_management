
# 專案介紹（Project Overview）
Github：

這是一個實戰型 Flutter 專案。

以：

> Apple iPhone 電商平台

作為核心場景。

透過：

* 統一 UI
* 相同商業邏輯
* 相同功能需求

比較不同 Flutter State Management 架構的差異。

---

# 專案目標（Project Goals）

## 核心目的

讓開發者理解：

* State 如何流動
* UI 如何同步更新
* 架構如何影響維護性
* 不同方案的 trade-off

---

## 希望解決的問題

### Flutter 初學者常見困惑

* Provider vs Riverpod？
* Bloc 是否太複雜？
* GetX 為什麼爭議大？
* Redux 是否還值得使用？
* 什麼情況該選哪個架構？

---

# 專案特色（Project Features）

## 精品級 UI

模擬 Apple Store App：

* 精細動畫
* 高質感 Typography
* Smooth Transition
* Premium UI Experience

---

## 完整電商流程

包含：

* 商品列表
* 商品詳情
* 顏色切換
* 容量切換
* AppleCare+ 加購
* 購物車
* Checkout
* Payment Flow

---

## 動態 State 更新

展示：

* 即時價格變化
* 全域購物車同步
* Reactive UI 更新
* 非同步流程管理

---

## 測試架構

每個 State Management：

* 都有對應測試
* 驗證 state transition
* 驗證 business logic

---

# 為什麼選擇 Apple Store 作為案例？

因為它同時具備：

| 功能           | State Complexity |
| ------------ | ---------------- |
| 商品規格切換       | Local State      |
| 購物車同步        | Global State     |
| 結帳流程         | Async State      |
| Payment 狀態   | Complex Flow     |
| Animation    | UI State         |
| User Session | Shared State     |

非常適合展示：

> State Management 的真實使用情境。

---

# Flutter 為什麼需要 State Management？

Flutter 是：

> Declarative UI Framework

UI：

```text
UI = Function(State)
```

當 State 改變：

* Widget rebuild
* UI 更新
* Reactive rendering

---

# 當 App 變大後的問題

## 常見問題

* Widget Tree 過深
* Property Drilling
* Business Logic 混亂
* UI 與邏輯耦合
* Async State 難管理
* 測試困難
* rebuild 過多

因此需要：

> 可維護的 State Architecture

---

# State 是什麼？

State：

> 會隨時間改變的資料。

例如：

* Login 狀態
* API Response
* 購物車內容
* Theme Mode
* Loading State
* Error State

---

# State Management 技術分類

| 類型                   | 核心概念          | 技術       |
| -------------------- | ------------- | -------- |
| Local State          | Widget 自己管理   | setState |
| DI-based             | 依賴注入          | Provider |
| Reactive             | 響應式更新         | Riverpod |
| Event-driven         | Event → State | Bloc     |
| Global Store         | 單一資料源         | Redux    |
| Lightweight Reactive | 簡化 reactive   | GetX     |

---

# 架構對照表

| 架構       | 複雜度 | 樣板代碼 | 適合場景       |
| -------- | --- | ---- | ---------- |
| Vanilla  | 低   | 極少   | 小型專案       |
| Provider | 中   | 少    | 中小型專案      |
| Riverpod | 中   | 中    | 中大型專案      |
| Bloc     | 高   | 多    | Enterprise |
| GetX     | 低   | 極少   | 快速開發       |
| Redux    | 高   | 多    | 高可預測系統     |

---

# 1. Vanilla (setState)

## 核心概念

使用：

```dart id="i96vdu"
setState()
```

管理 Widget State。

---

## 特點

* Flutter 原生
* 無第三方依賴
* 最低抽象

---

## 使用場景

適合：

* 單頁 UI
* Prototype
* 小型 App

---

## 問題

當 App 變大：

* State 分散
* Property Drilling
* 難測試
* 難維護

---

# 2. Provider

## 核心概念

使用：

* ChangeNotifier
* Consumer

進行狀態共享。

---

## 設計哲學

> Dependency Injection

---

## 優點

* 易學
* Flutter 官方推薦
* 生態成熟

---

## 使用場景

適合：

* 中小型 App
* User Session
* Theme Management
* Shopping Cart

---

## 問題

* Context 依賴
* Provider nesting

---

# 3. ValueNotifier

## 核心概念

Flutter 原生：

```dart id="p1sk6m"
ValueNotifier<T>
```

---

## 特點

* 輕量
* 無第三方依賴
* Reactive 更新

---

## 使用場景

適合：

* 簡單 reactive state
* 局部 UI 更新

---

## 問題

* 擴展性有限
* 不適合大型 App

---

# 4. Riverpod

## 核心概念

使用：

* Notifier
* ref.watch()
* Provider

---

## 設計哲學

> Compile-safe Reactive Architecture

---

## 優點

* Type-safe
* 無 Context
* 易測試
* Provider Override
* AutoDispose

---

## 使用場景

適合：

* 中大型產品
* Startup
* SaaS
* 長期維護專案

---

## 為什麼現代 Flutter 推薦 Riverpod？

因為它：

* 解決 Provider 缺點
* 更適合大型架構
* 更好的測試能力
* 更乾淨的 DI

---

# 5. Bloc / Cubit

## 核心概念

流程：

```text
Event → Bloc/Cubit → State → UI
```

---

## 設計哲學

> Event-driven Architecture

---

## 優點

* 高可預測性
* State flow 清晰
* 團隊協作佳
* 測試能力強

---

## 使用場景

適合：

* Enterprise
* 金流系統
* 複雜流程
* 多人協作

---

## 缺點

* Boilerplate 多
* 學習曲線高

---

# 6. GetX

## 核心概念

使用：

```dart id="pqagz6"
.obs
Obx()
```

---

## 設計哲學

> Minimal Boilerplate

---

## 優點

* 開發速度極快
* 簡潔
* 無 Context

---

## 使用場景

適合：

* MVP
* Prototype
* Side Project
* 快速驗證產品

---

## 問題

* Magic 過多
* 長期維護風險

---

# 7. Redux

## 核心概念

Single Source of Truth：

```text
Action → Reducer → New State
```

---

## 設計哲學

> Pure Functional Architecture

---

## 優點

* Immutable State
* 可預測
* Time-travel debugging
* 易測試

---

## 使用場景

適合：

* 複雜 State Flow
* Functional Team
* 高可預測系統

---

## 缺點

* Boilerplate 非常多
* 學習成本高

---

# State Management 差異比較

| 技術       | 開發速度 | 可測試性 | 維護性 | 擴展性 |
| -------- | ---- | ---- | --- | --- |
| setState | 很快   | 低    | 低   | 低   |
| Provider | 快    | 中    | 中   | 中   |
| Riverpod | 中    | 高    | 高   | 高   |
| Bloc     | 慢    | 非常高  | 非常高 | 非常高 |
| GetX     | 很快   | 中    | 中低  | 中   |
| Redux    | 慢    | 高    | 高   | 高   |

---

# 測試（Testing）

## 為什麼重要？

State Management：

> 是 UI 與 Business Logic 的核心。

---

## 測試內容

* State Transition
* Business Logic
* Async Flow
* Widget Rebuild
* Payment Flow

---

# 各架構測試能力比較

| 技術       | Unit Test | Widget Test | Mock 容易度 |
| -------- | --------- | ----------- | -------- |
| setState | 普通        | 普通          | 低        |
| Provider | 中         | 中           | 中        |
| Riverpod | 很強        | 很強          | 高        |
| Bloc     | 非常強       | 很強          | 非常高      |
| GetX     | 中         | 普通          | 中        |
| Redux    | 高         | 中           | 高        |

---

# Riverpod 測試優勢

## 核心原因

* Provider Override
* 無 Context
* Dependency Isolation

---

## 適合

* 高測試覆蓋率
* Clean Architecture
* API-heavy App

---

# Bloc 測試優勢

## Event-driven 非常容易驗證

```text
Given Event A
Expect State B
```

---

## 適合

* 金流
* Authentication
* 複雜流程
* Enterprise App

---

# 專案架構（Project Structure）

```text
lib/
├── core/
├── features/
│   └── apple_store/
│       ├── presentation/
│       └── state_management/
│           ├── vanilla/
│           ├── provider/
│           ├── riverpod/
│           ├── bloc/
│           ├── getx/
│           └── redux/
└── main.dart
```

---

# 架構設計理念

## UI 與 State 分離

目標：

> 同一份 UI，切換不同 State Architecture。

---

## 好處

可以直接觀察：

* rebuild 差異
* 程式碼量差異
* 開發體驗差異
* 可測試性差異

---

# 實際觀察結果

## setState

優點：

* 最簡單

缺點：

* 擴展困難

---

## Provider

優點：

* 平衡性高

缺點：

* Context 耦合

---

## Riverpod

優點：

* 現代化
* 測試友善

缺點：

* 抽象稍高

---

## Bloc

優點：

* 架構最完整

缺點：

* Boilerplate 多

---

## GetX

優點：

* 開發最快

缺點：

* 長期維護風險

---

## Redux

優點：

* 極高可預測性

缺點：

* 學習成本高

---

# 結論（Conclusion）

## 沒有最好的 State Management

只有：

* 團隊需求
* 專案規模
* 維護成本
* 開發速度

---

# 選擇建議

| 情境              | 推薦       |
| --------------- | -------- |
| Flutter 初學者     | Provider |
| 中大型專案           | Riverpod |
| Enterprise      | Bloc     |
| 快速 MVP          | GetX     |
| Functional Team | Redux    |

---

# 最重要的核心

真正重要的不是：

> 「學會某個框架 API」

而是理解：

* State 如何流動
* UI 如何更新
* Architecture 如何擴展
* 如何降低耦合
* 如何提升可測試性

---

# Final Takeaway

State Management 的本質：

> 管理複雜度（Managing Complexity）

當 App 規模變大：

真正的挑戰不是 UI。

而是：

* 資料流
* State Synchronization
* Architecture Scalability
* Maintainability
* Testability

這也是 Flutter 架構設計最核心的問題。
