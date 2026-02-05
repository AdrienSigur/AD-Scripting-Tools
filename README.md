# 🛠️ Active Directory Automation & CSV Optimization

This repository features a suite of PowerShell scripts designed to automate and optimize Active Directory (AD) management through data-driven workflows. By leveraging CSV files, these tools eliminate manual GUI tasks, reduce human error, and ensure consistent object creation across the domain.

[Image of Active Directory automation workflow]

## 🚀 Key Features

* **AddUserAd.ps1**: Performs bulk user creation with optimized attribute mapping (Department, Title, OU, etc.) directly from CSV data.
* **AddGroupAd.ps1**: Handles the automated creation of Security and Distribution groups.
* **AddOrganizationAd.ps1**: Manages the structural hierarchy of the AD by generating Organizational Units (OUs) from optimized paths.
* **AddUsertoGroup.ps1**: Bridges users and groups by processing membership assignments in bulk.
* **ServerStatus.ps1**: A diagnostic utility to check Domain Controller health and connectivity.
* **CommandLet.ps1**: The core engine of the project. It centralizes shared functions, logging, and error-handling logic to keep other scripts clean and modular.

## 💡 Why This Project? (The DevOps Value)

Instead of manual "point-and-click" administration, this project applies **Infrastructure as Code (IaC)** principles to Windows Server management:
* **Scalability**: Create 10 or 1,000 users in the same amount of time.
* **Consistency**: Every object is created with the exact same parameters defined in the CSV.
* **Modularity**: The `CommandLet.ps1` script acts as a library, making the code easier to maintain and update.

## 📋 Prerequisites

1.  **Active Directory PowerShell Module** (RSAT) installed.
2.  **Administrative Privileges** on the Domain Controller.
3.  **CSV Files** encoded in **UTF-8** to support special characters and international names.

## 🛠️ Usage

### 1. Prepare your CSV
Ensure your CSV headers match the script expectations. 
*Example for `AddUserAd.ps1`:* `SamAccountName,GivenName,Surname,OU,Password`

### 2. Execution
Run scripts from an elevated PowerShell terminal:

```powershell
./AddUserAd.ps1 -Path "./data/employees_january.csv"
