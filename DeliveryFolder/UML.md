# UML diagram
## registration
```mermaid
sequenceDiagram
    actor Farmer
    participant System
    participant DataBase
    actor PolicyMaker
    Farmer->>+System: register(name, surname, password, email, location, geotracking)
    System->>+DataBase: exists(email)
    DataBase-->>-System: query response
    alt no email corresponding
        System-)Farmer: verificationEmail
        Farmer-)System: verification link
        System->>+DataBase: insertUser
        DataBase-->>-System: done
        System->>+DataBase: retrieveEmailPolicyMaker(location)
        DataBase-->>-System: emails
        System-)PolicyMaker: sendEmail
        System-->>Farmer: done
    else
        System-->>-Farmer: email already in use
    end
```
## login

```mermaid
sequenceDiagram
    actor Farmer
    participant System
    participant DataBase
    Farmer->>+System: login(email, password)
    System->>DataBase: retrieveEmail(email)
    Database-->>System: email and password
    alt email corresponding
        System->>System: encrypt password
        System->>System: test two passwords
        Note over System,System: test on correspondance of the passwords are the same is done using a library
        alt passwords corresponds
            System-->>Farmer: logged in
        else
            System-->>Farmer: invalid credentials
        end
    else
        System-->>Farmer: invalid credentials
    end
```
## production release
No need to do it, too simple case

## Forum Creation

```mermaid
sequenceDiagram
    actor Farmer1
    actor Farmer2
    participant System
    participant DataBase
    Farmer1->>+System: createForum(title, description, images)
    System->>+DataBase: insertForum(title, description, images)
    DataBase-->>-System: insertion ok
    System-->>-Farmer1: forum created succesfully

    Farmer2->>+System: replyToForum(id)
    System-->>-Farmer2: reply effective
```

## Request for Production Data
```mermaid
sequenceDiagram
    actor Farmer
    participant System
    System -) Farmer: send Email
    Note over System, Farmer: ask to release production data
    Farmer ->>+System: production data
    System ->>+DataBase: save production data
    DataBase->>-System: saved
    System-->>-Farmer: production data saved
    Farmer->>+System: complete production data
    System ->>+DataBase: save production data
    DataBase->>-System: saved
    System-->>-Farmer: complete effective
    Farmer->>+System: confirm the data
    System->>+DataBase: production data confirmed
    DataBase-->>-System: done
    System-->>-Farmer: data confirmed
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
    System-->>-PolicyMaker: done

    System->>+BestFarmer: request for advices
    BestFarmer-->>-System: advices

    System->>+PolicyMaker: advices
    PolicyMaker-->>-System: received
    PolicyMaker->>+System: less productive farmers
    System-->>PolicyMaker: farmers 
    PolicyMaker->> System: sendAdvices(message, farmers)
    System-)LessProductiveFarmer: advice(message)
    System-->>-PolicyMaker: done
```
### v2 more in accordance to the use cases
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
## help request
```mermaid
sequenceDiagram
    actor PolicyMaker
    participant System
    PolicyMaker ->>+System: login
    System-->>PolicyMaker: logged in
    PolicyMaker ->>System: production data
    System-->>-PolicyMaker: production data saved
    PolicyMaker->>+System: complete production data
    System-->>-PolicyMaker: complete effective
    PolicyMaker->>+System: confirm the data
    System-->>-PolicyMaker: data confirmed
```
