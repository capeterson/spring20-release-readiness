Code samples and demos for the Apex portion of Spring '20 Release Readiness Live webinar. 

This is an updated fork of https://github.com/capeterson/tdx19-insecure-lwc-sample

- Create org: `sfdx force:org:create -f config/project-scratch-def.json -a apex-demo -s`
- Push metadata: `sfdx force:source:push -u apex-demo`
- Open org: `sfdx force:org:open -u apex-demo`

For Apex security demo, open vscode with two files;
- lwc/quickcreate/quickcreate.js
- classes/QuickCreateController.cls

For the demo open the org, admin user is fine since they specifically don't have FLS rights to Opportunity.Manager_Approved__c, but running as a low-priv user can help illustrate the point.

To run the demo, make sure the browser dev console is open, switch to the "Sales" app in lightning, and enter data into the Quick Create component on the right side of the default page.

When saving, the debugger breakpoint will hit, at which point highlight the `this.opp` status in the debugger to show it's the opportunity we just entered data for. Now, let's put on our black hat and maliciously inject an unexpected field into it: run `this.opp.Manager_Approved__c = true;` in the console tab.

Resume js execution, and a toast should pop noting that "Stopped field injection attempt with stripInaccessible". Open QuickCreateController.cls, and highlight that the malicious request made it past the old style describe checks, but didn't make it past the stripInaccessible check!

Key point: stripInaccessible isn't just a simplification of existing CRUD/FLS checking, but a material improvement in security posture due to it covering so many edge cases fully.