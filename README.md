Code samples and demos for the Apex portion of Spring '20 Release Readiness Live webinar. 
This is an updated fork of https://github.com/capeterson/tdx19-insecure-lwc-sample

Create org: `sfdx force:org:create -f config/project-scratch-def.json -a apex-demo -s`
Push metadata: `sfdx force:source:push -u apex-demo`
Open org: `sfdx force:org:open -u apex-demo`

For Apex security demo, open vscode with two files;
- lwc/quickcreate/quickcreate.js
- classes/QuickCreateController.cls
