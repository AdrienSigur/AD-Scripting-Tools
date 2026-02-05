Devops
Gem personnalisé
Certainly! Here is the English version of the professional README for your GitHub repository. This version highlights your technical proficiency in Active Directory and PowerShell optimization.

🛠️ Active Directory Automation & CSV Optimization
This repository contains a suite of PowerShell scripts designed to automate Active Directory (AD) management using data-driven workflows (CSV). These tools are optimized to accelerate user, group, and organizational unit (OU) management while minimizing manual entry errors.

🚀 Key Features
AddUserAd.ps1: Bulk user creation with optimized attribute mapping from CSV files.

AddGroupAd.ps1: Streamlined creation of Security and Distribution groups.

AddUsertoGroup.ps1: Automated member assignment based on CSV data.

AddOrganizationAd.ps1: Structural AD management through Organizational Unit (OU) creation.

ServerStatus.ps1: Monitoring script to verify the health and connectivity of Domain Controllers.

CommandLet.ps1: A core toolkit containing reusable functions and error-handling logic for the entire suite.

📋 Prerequisites
Active Directory PowerShell Module must be installed on the execution machine.

Administrative Privileges on the target Domain Controller.

CSV Files formatted in UTF-8 (to ensure correct handling of special characters/accents).

🛠️ Usage
1. Data Preparation
Ensure your CSV files follow the required schema. Common columns include: SamAccountName, GivenName, Surname, OU, and Description.

2. Execution
Run the scripts from an elevated PowerShell console:

PowerShell
./AddUserAd.ps1 -Path "./data/users.csv"
🏗️ Script Architecture
To follow "Don't Repeat Yourself" (DRY) principles, the logic is centralized in CommandLet.ps1. This script handles data validation and error logging, allowing the main scripts to remain lightweight, efficient, and easy to maintain.

✍️ Author
 DevOps & Systems Automation - Your GitHub Profile
