# UML diagram
## registration
```mermaid
sequenceDiagram
    actor Farmer
    participant AuthentificationSystem
    participant DataBase
    participant Mail
    actor PolicyMaker
    Farmer->>+AuthentificationSystem: registerAsFarmer(name, surname, password, email, location, geotracking)
    AuthentificationSystem->>+DataBase: exists(email)
    DataBase-->>-AuthentificationSystem: query response
    alt no email corresponding
        AuthentificationSystem-)Mail: verificationEmail(email, randomIdentifier)
        Mail-)Farmer: send email verification
        Farmer-)AuthentificationSystem: verification link
        AuthentificationSystem->>+DataBase: insertUser
        DataBase-->>-AuthentificationSystem: done
        AuthentificationSystem->>+DataBase: retrieveEmailPolicyMaker(location)
        DataBase-->>-AuthentificationSystem: emailPolicyMaker
        AuthentificationSystem-)Mail: sendEmail(emailPolicyMaker)
        Mail-)PolicyMaker: sendEmail(email)
        AuthentificationSystem-->>Farmer: done
    else
        AuthentificationSystem-->>-Farmer: email already in use
    end
```
## login

```mermaid
sequenceDiagram
    actor Farmer
    participant AuthentificationSystem
    participant DataBase
    Farmer->>+AuthentificationSystem: login(email, password)
    AuthentificationSystem->>+DataBase: retrieveEmail(email)
    DataBase-->>-AuthentificationSystem: password
    alt email corresponding
        AuthentificationSystem->>AuthentificationSystem: encrypt password
        AuthentificationSystem->>AuthentificationSystem: test two passwords
        Note over AuthentificationSystem,AuthentificationSystem: test on correspondance of the passwords are the same is done using a library
        alt passwords corresponds
            AuthentificationSystem-->>Farmer: logged in
        else
            AuthentificationSystem-->>Farmer: invalid credentials
        end
    else
        AuthentificationSystem-->>-Farmer: invalid credentials
    end
```

## Forum Creation

```mermaid
sequenceDiagram
    actor Farmer1
    actor Farmer2
    participant ForumSystem
    participant DataBase
    Farmer1->>+ForumSystem: createForum(title, description, images)
    ForumSystem->>+DataBase: insertForum(title, description, images)
    DataBase-->>-ForumSystem: done
    ForumSystem-->>-Farmer1: forum created succesfully
```
## send mail asking for prod data
```mermaid
sequenceDiagram
    actor MailFarmers
    ReleaseSystem ->> DataBase: getMailFarmers()
    DataBase -->> ReleaseSystem: farmersmails
    loop mail : farmersmails
        ReleaseSystem -) MailSystem: sendMail(mail, message)
        Note over ReleaseSystem, MailSystem: ask to release production data
        MailSystem -) MailFarmers: mail release production data
        Note over MailFarmers, MailSystem: one mail is sent to each farmer
    end
```
## Request for Production Data
before that the system gets the mail of the farmers and does a loop
```mermaid
sequenceDiagram
    actor Farmer
    participant ReleaseSystem
    Farmer ->>+ReleaseSystem: production data
    ReleaseSystem ->>+DataBase: save production data
    DataBase->>-ReleaseSystem: saved
    ReleaseSystem-->>-Farmer: production data saved
    Farmer->>+ReleaseSystem: complete production data
    ReleaseSystem ->>+DataBase: save production data
    DataBase->>-ReleaseSystem: saved
    ReleaseSystem-->>-Farmer: complete effective
    Farmer->>+ReleaseSystem: confirm the data
    ReleaseSystem->>+DataBase: production data confirmed
    DataBase-->>-ReleaseSystem: done
    ReleaseSystem-->>-Farmer: data confirmed
```

## Contact farmers
```mermaid
sequenceDiagram
    actor PolicyMaker
    actor BestFarmer
    actor LessProductiveFarmer
    participant System
    PolicyMaker->>+System: retreive best performers
    System-->>PolicyMaker: best performers
    PolicyMaker->>System: sendMessageToBestPerformers(message)
    System-)BestFarmer: message request for advices
    System-->>-PolicyMaker: done

    BestFarmer-)System: message giving advices

    System->>+PolicyMaker: advices
    PolicyMaker-->>-System: received
    PolicyMaker->>+System: less productive farmers
    System-->>PolicyMaker: farmers 
    PolicyMaker->> System: sendAdvices(message, farmers)
    System-)LessProductiveFarmer: advice(message)
    System-->>-PolicyMaker: done
```
