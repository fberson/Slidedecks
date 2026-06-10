# 💡 Deploying Infrastructure and Turning on the Light: Bicep Beyond Azure

Welcome to the source code repository accompanying my Microsoft Build 2026 session.

> What if Bicep could act as a declarative control plane for any system with an API?

This repository contains all source code, examples, and supporting material used during the session.

![Microsoft Build 2026](../photos/conference-center.JPEG)

---

## 🎤 Session Information

**Session:** Deploying Infrastructure and Turning on the Light: Bicep Beyond Azure

🔗 Microsoft Build Session  
https://build.microsoft.com/en-US/sessions/LTG454

📄 Session Deck  
https://github.com/fberson/Slidedecks/blob/main/2026/Microsoft%20Build%202026/2026%20-%2005%20-%20Deploying%20Infrastructure%20and%20Turning%20on%20the%20Light%20-%20Bicep%20Beyond%20Azure.pdf

---

## 💡 What is this?

Infrastructure as Code is traditionally associated with deploying cloud resources.

In this session, we explored a different idea:

> Bicep as a declarative control plane for any system with an API.

To demonstrate the concept, I built a custom Bicep Local Deploy extension that controls a physical Zigbee light through Home Assistant.

While a light bulb makes for a fun and visual demo, the underlying pattern can be applied to many real-world scenarios:

- Internal enterprise APIs
- Edge environments
- On-premises infrastructure
- Certificate management
- Operational tooling
- Third-party platforms
- Any system exposing a REST API

The goal is to bring familiar Infrastructure as Code concepts such as declarative state, convergence, idempotency, and consistency to systems beyond Azure.

---

## 📂 Repository Structure

The source code is split into three logical steps.

### 📂 Step 1 – Build the Extension

Create a custom Bicep Local Deploy extension using .NET.

🔗 https://github.com/fberson/Slidedecks/tree/main/2026/Microsoft%20Build%202026/Source/Step%201

**Key concepts**

- Resource models
- Resource handlers
- Convergence logic
- API integration
- Extension registration

---

### ⚙️ Step 2 – Package the Extension

Build, publish, and package the extension so it can be consumed by Bicep Local Deploy.

🔗 https://github.com/fberson/Slidedecks/tree/main/2026/Microsoft%20Build%202026/Source/Step%202

**Key concepts**

- dotnet build
- dotnet publish
- bicep publish-extension

---

### 📄 Step 3 – Consume from Bicep

Deploy and interact with the extension from Bicep.

🔗 https://github.com/fberson/Slidedecks/tree/main/2026/Microsoft%20Build%202026/Source/Step%203

**Key concepts**

- Extension registration
- Bicep resources
- Parameters
- Outputs
- Local Deploy

---

## 🏗️ Architecture

The flow demonstrated during the session is intentionally simple:

```text
Bicep
   ↓
Local Deploy Extension
   ↓
Home Assistant API
   ↓
Physical Device
