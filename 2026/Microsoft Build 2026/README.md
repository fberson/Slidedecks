# Deploying Infrastructure and Turning on the Light: Bicep Beyond Azure

## Microsoft Build 2026

What happens if we treat Bicep not just as an Azure deployment language, but as a declarative control plane for any system with an API?

This repository contains all source code, demos, and supporting material used during my Microsoft Build 2026 session:

**Deploying Infrastructure and Turning on the Light: Bicep Beyond Azure**

📅 Microsoft Build 2026  
🎤 Speaker: Freek Berson (Microsoft MVP)  
🔗 Session: https://build.microsoft.com/en-US/sessions/LTG454

---

![Microsoft Build 2026](https://github.com/fberson/Slidedecks/blob/main/2026/Microsoft%20Build%202026/photos/conference-center.JPEG)

---

## Session Overview

Infrastructure as Code is traditionally associated with deploying cloud resources.

In this session, we explored a different idea:

> What if Bicep could be used as a declarative control plane for any system that exposes an API?

To demonstrate the concept, I created a custom Bicep local-deploy extension that controls a physical Zigbee light through Home Assistant.

The light bulb is intentionally simple.

The real goal is to demonstrate how the same Infrastructure as Code principles we apply in Azure can also be applied to:

- Third-party APIs
- Edge environments
- On-premises systems
- Operational tooling
- Internal enterprise platforms
- Any system that exposes a REST API

The key message from the session:

> Bicep as the declarative control plane for any system with an API.

---

![Session Demo](https://github.com/fberson/Slidedecks/blob/main/2026/Microsoft%20Build%202026/photos/session1.png)

---

## Session Deck

The complete slide deck used during the session can be downloaded here:

📄 **Session Deck (PDF)**

https://github.com/fberson/Slidedecks/blob/main/2026/Microsoft%20Build%202026/2026%20-%2005%20-%20Deploying%20Infrastructure%20and%20Turning%20on%20the%20Light%20-%20Bicep%20Beyond%20Azure.pdf

---

## Repository Structure

The live demo was presented in Visual Studio Code using the same structure shown below:

```text
Source
│
├── Step 1 - Source code
├── Step 2 - Build Extension
├── Step 3 - Bicep
└── Shared
```

Each step represents a stage in building and consuming a Bicep local-deploy extension.

---

# Step 1 - Source Code

📂 Folder

https://github.com/fberson/Slidedecks/tree/main/2026/Microsoft%20Build%202026/Source/Step%201

In this step we build the extension itself.

Key components include:

| File | Purpose |
|--------|--------|
| Models.cs | Defines the resource model exposed to Bicep |
| LightHandler.cs | Implements convergence logic |
| HomeAssistantClient.cs | Handles communication with Home Assistant |
| Program.cs | Registers the resource handlers |
| HomeAssistExtension.csproj | Project definition |

Conceptually, this is where we create our own resource provider.

From Bicep's perspective:

- The resource has a schema
- The resource has inputs
- The resource has outputs
- The resource converges toward a desired state

In other words:

> It's just a resource.

---

# Step 2 - Build Extension

📂 Folder

https://github.com/fberson/Slidedecks/tree/main/2026/Microsoft%20Build%202026/Source/Step%202

After creating the extension, it must be built and packaged.

The build process consists of three stages:

1. Build the project
2. Publish the executable
3. Package it using Bicep Local Deploy

This step contains the scripts used during the session to create the extension artifact that Bicep can consume locally.

The result is a local extension that can be referenced from `bicepconfig.json`.

---

# Step 3 - Bicep

📂 Folder

https://github.com/fberson/Slidedecks/tree/main/2026/Microsoft%20Build%202026/Source/Step%203

This is where the extension is consumed from Bicep.

Files include:

| File | Purpose |
|--------|--------|
| main.bicep | Resource definition |
| main.bicepparam | Deployment parameters |
| bicepconfig.json | Extension registration |

The deployment looks and feels exactly like any other Bicep deployment.

The only difference is that instead of talking to Azure Resource Manager, Bicep invokes our local extension.

From that point forward:

- Bicep passes the desired state
- The extension performs convergence
- The API is called
- Outputs are returned

The deployment experience remains identical.

---

## Why This Matters

This approach allows developers to reuse existing Infrastructure as Code knowledge beyond Azure.

Benefits include:

- Declarative control
- Idempotency
- Consistency
- Reusable modules
- Strong typing
- Deployment stacks
- Familiar Bicep workflows

Potential use cases include:

- Home Assistant
- Certificate management
- Internal enterprise APIs
- Edge infrastructure
- Hypervisors
- Operational tooling
- Third-party platforms

Anywhere there is an API, there is an opportunity to model resources declaratively.

---

![San Francisco](https://github.com/fberson/Slidedecks/blob/main/2026/Microsoft%20Build%202026/photos/golden-gate.JPEG)

---

## Additional Resources

### GitHub

https://github.com/fberson

### Slide Deck Repository

https://github.com/fberson/Slidedecks

### Microsoft Build Session

https://build.microsoft.com/en-US/sessions/LTG454

---

## Connect

If you found this session useful, feel free to connect with me and share your own ideas for extending Bicep beyond Azure.

I would love to hear what APIs, platforms, or systems you would model as resources next.

---

**Freek Berson**  
Microsoft MVP (Azure & Azure Virtual Desktop)

> Infrastructure as Code stops being only about cloud resources and starts being about controlling complex systems predictably.
