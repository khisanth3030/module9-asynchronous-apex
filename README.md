# Developer Kickstart Module: Asynchronous Apex

This repository is a cornerstone of the Developer Kickstart curriculum at Cloud Code Academy. Tailored for emerging Salesforce developers, this module dives into the powerful world of Asynchronous Apex, highlighting the diverse strategies and tools like Future methods, Batch Apex, Queueable Apex, and Scheduled jobs.

## Goals of the Practice

During this repository, you will enrich your understanding of:
- The essential nature of Asynchronous Apex in facilitating long-running operations without hogging system resources.
- Implementing Future methods to perform specific asynchronous actions, helping to evade governor limits.
- Crafting and managing Batch Apex jobs, allowing bulk processing of records in an optimized manner.
- Leveraging Queueable jobs to chain jobs sequentially, ensuring they run in a specific sequence.
- Setting up and managing Scheduled tasks, permitting the periodic execution of tasks based on specified intervals.
- Strategies to handle asynchronous exceptions and errors gracefully, ensuring data integrity and system robustness.

By conquering Asynchronous Apex techniques, you'll unlock the ability to develop highly scalable, efficient, and user-friendly applications in Salesforce. This prowess amplifies your proficiency in creating dynamic Salesforce solutions that can seamlessly manage large data volumes and extended processing times.

## Setup
[Setup Overview](https://learn.cloudcodeacademy.com/courses/salesforce-developer-kickstart-program/lectures/47317682)

## Setup Checklist
1. Create/Configure a trailhead playground or developer org to do your work throughout this program.
2. Install Visual Studio Code from [here](https://code.visualstudio.com/download).
3. Install Salesforce Extension Pack in Visual Studio Code. This can be done by searching 'Salesforce Extension Pack' in the Extensions view in VS Code and clicking Install.
4. Authorize your org in Visual Studio Code. Press `Ctrl/Cmd + Shift + P` to open the command palette and type 'SFDX: Authorize an Org', then press Enter. Follow the steps in the browser to log in to your org, then return to VS Code.
5. Save and deploy your changes into Salesforce from your local machine. This can be done through the command pallet or right-clicking the file you want to deploy and using the option `SFDX: Deploy this source to org`

## Getting Started
1. Navigate to the folder force-app/main/default/ and deploy the metadata to your Salesforce org. Right-click on the folder and select `SFDX: Deploy Source to Org`.
2. Review the files provided including the test class to understand the challenges.
3. Update the code and deploy it to your Salesforce org.
4. Run the test class to validate your code. Use `Ctrl/Cmd + Shift + P` to open the command palette and type 'SFDX: Run Apex Tests', then press Enter. You can also use `Run All Test` or `Run Test` on the test class.
5. Push your changes to your GitHub repository and submit the link to the assignment in the submission form in Slack.

## Resources

If you get stuck at any point, here are some resources that might help:

- [Apex Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dev_guide.htm)
- [Salesforce Stack Exchange](https://salesforce.stackexchange.com/)
- [Visual Studio Code Documentation](https://code.visualstudio.com/docs)
- [Salesforce Extensions for Visual Studio Code](https://developer.salesforce.com/tools/vscode/)

And remember, programming is often about solving problems, so don't be afraid to use search engines to find answers to your questions.

Good luck with your learning journey in Salesforce development!
