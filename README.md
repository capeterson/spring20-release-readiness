Code samples and demos for the Apex portion of Spring '20 Release Readiness Live webinar

Requires a Spring '20 devhub to run.
Create org: `sfdx force:org:create -f config/project-scratch-def.json -a apex-demo -s`
Push metadata: `sfdx force:source:push -u apex-demo`
Open org: `sfdx force:org:open -u apex-demo`

For Apex security demo, open vscode with two files;
- lwc/quickcreate/quickcreate.js
- classes/QuickCreateController.cls
