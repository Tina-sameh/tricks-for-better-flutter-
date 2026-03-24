## 🚀 Day 1: Flutter Architecture & Performance Optimization
### 📌 Overview
Today’s focus was on understanding how Flutter works under the hood (the Three Trees) and applying the "Golden Rules" to transform inefficient code into professional, high-performance applications.

### 🛠️ Key Concepts Learned
The Three Trees: Understanding the relationship between the Widget Tree (Configuration), Element Tree (Lifecycle/Manager), and Render Tree (Painting).

Constraints Flow: Mastering the rule: "Constraints go down, sizes go up, parent sets position."

Rebuild Optimization: Learning how to minimize the "Rebuild Scope" to keep the UI smooth (60/120 FPS).

### ✍️ Applied Best Practices (The 6 Commands)
Modularization: Breaking down large pages into small, reusable widgets to isolate state changes.

Const Constructors: Using const to cache static widgets and reduce memory allocation.

Constraint Management: Using Expanded and Flexible to handle layout boundaries and prevent overflows.

Logic Separation: Moving heavy calculations out of the build method and into initState or external controllers.

Local State Management: Using setState only within the smallest possible widget scope (e.g., a standalone Button widget).

Object Identity (Keys): Implementing ValueKey in lists to help the Element Tree maintain the correct state of dynamic items.
