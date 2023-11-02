# Setup Keys and Permissions

Login to your AWS Console and go to IAM. You can choose a different username. I'm creating a user called **tf-user**.

```bash
1. IAM --> Users --> Add user 
2. Add username --> Tick the "Access key - Programmatic Access" --> Next: permissions
3. Select "Attach existing policies directly" --> Tick "Administrator Access" --> Next: Tags
4. Key: "Name", Value: "tf-user" --> Next: Review
5. Create User
```

Once user is created, you should now see the user name, access ky ID, and Secret access key. Click the **Download .csv**

![](Images/builddevaws1.png)  

Next step is to create the credentials file. You can do this after installing the extensions.
