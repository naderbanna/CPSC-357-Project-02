//
//  main.swift
//  nBanna_Project02
//
//  Created by Nader Banna on 2/22/21.
//

import Foundation


var masterPasswordList = [String: String]()

//do not have this hardcoded
var passphrase: String = "_helpme"

//masterPasswordList = ["Google": "strongPassword"+passphrase, "Snapchat": "543EasteWalnut"+passphrase]


class Program{
    init(){
        
        let str = "Hellojeff Jeff"
        var strShift = ""
        var shift = str.count
        
        print("newPassword: \(str)")
        for letter in str{
            strShift += String(translate(l: letter, trans: shift))
        }
        
        print(strShift)
        
        let strE = strShift
        shift = -strE.count
        strShift = ""
        
        
        for letter in strE{
            strShift += String(translate(l: letter, trans: shift))
        }
        
        print(strShift)
        
        var reply = ""
        var keepRunning = false
        
        reply = Ask.AskQuestion(questionText: "Enter your passphrase: ", acceptableReplies: [])
        if reply == passphrase{
            read()
            
        }else{
            print("Incorrect passphrase. Program will exit")
            keepRunning = false
        }
        
        while keepRunning{
            //ask a question
            // act on that question
            // if not, change keeprunning = false
            //application will end
            //write(dict: masterPasswordList)
            
//            let testDict = masterPasswordList

//            for (key, value) in testDict{
//                print("Key: \(key) \nValue: \(value)")
//            }
           
            print("Welcome to your Password Manager. Here are your 5 options")
            
            print("1. View all password names \n2. View a single password \n3. Add a single password \n4. Delete a password \n5. Exit Program \n______________________\n")
            reply = Ask.AskQuestion(questionText: "View all passwords? ('yes' or 'no')", acceptableReplies: ["no", "yes"])
            if reply == "no"{
                reply = Ask.AskQuestion(questionText: "View a single password? ('yes' or 'no')", acceptableReplies: ["no", "yes"])
                if reply == "no"{
                    reply = Ask.AskQuestion(questionText: "Add a single password? ('yes' or 'no')", acceptableReplies: ["no", "yes"])
                    if reply == "no"{
                        reply = Ask.AskQuestion(questionText: "Delete a password? ('yes' or 'no')", acceptableReplies: ["no", "yes"])
                        if reply == "no"{
                            reply = Ask.AskQuestion(questionText: "Exit Program? ('yes' or 'no')", acceptableReplies: ["no", "yes"])
                            if reply == "yes"{
                                //exit program
                                keepRunning = false;
                            }

                        }else if reply == "yes"{
                            //delete password
                            
                            
                        }
                    }else if reply == "yes"{
//                        print("Enter the password name (key): ")
//                        let userKey = readLine()
//                        print("Enter the password: ")
//                        let userPassword = readLine();
//                        print("Enter your passphrase")
//                        let userPPH = readLine()
                        
                        reply = Ask.AskQuestion(questionText: "Enter the password name (key): ", acceptableReplies: [])
                        let userKey = reply
                        reply = Ask.AskQuestion(questionText: "Enter the password: ", acceptableReplies: [])
                        let userPassword = reply
                        reply = Ask.AskQuestion(questionText: "Enter your passphrase: ", acceptableReplies: [])
                        let userPPH = reply
                        
                        
                        //append passphrase, reverse, pass to Caesar Cipher function
                        let newPassword: String = userPassword+userPPH
                        
                        let str = newPassword.reversed()
                        var strShift = ""
                        let shift = str.count
                        
                        print("newPassword: \(str)")
                        for letter in str{
                            strShift += String(translate(l: letter, trans: shift))
                        }
                        
                        print(strShift)
                        
                        masterPasswordList[userKey] = newPassword
                        write(dict: masterPasswordList)
                    }
                }else if reply == "yes"{
                    //View a single password
                    reply = Ask.AskQuestion(questionText: "Which password would you like to view? Enter the key: ", acceptableReplies: [])
                    
                    if masterPasswordList.keys.contains(reply){
                        print("Please enter the passphrase: ")
                        let userPPH = readLine()
                        //need to change to descramble password then display
                        if userPPH == passphrase{
                            
                            let tempPass = masterPasswordList[reply]!.dropLast(passphrase.count)
                            print(tempPass)
                        }else{
                            print("You entered the wrong passphrase")
                        }
                    }
                }

            }else if reply == "yes"{
                //View all Passwords
                for (key, _) in masterPasswordList{
                    print("Key: \(key)")
            }
            
           

        }
    }
}
}

class Ask{
    static func AskQuestion(questionText output: String, acceptableReplies inputArr: [String], caseSensative: Bool = false) -> String{
        print(output) // ask our question
        
        //handle response
        guard let response = readLine() else{
            // they didnt type anything at all
            print("Invalid input")
            return AskQuestion(questionText: output, acceptableReplies: inputArr)
        }
        //they typed in a valid answer
        // verify that the response is acceptable
        // or that we dont care what the response is
        if(inputArr.contains(response) || inputArr.isEmpty){
            return response
        }else{
            print("Invalid input")
            return AskQuestion(questionText: output, acceptableReplies: inputArr)
        }
    }
}

let p = Program()


func write(dict input: [String: String]){
    do{
        
        let fileURL = try FileManager.default
            //change the directory to pick where it goes
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("passwords_Proj02.json")

        try JSONSerialization.data(withJSONObject: input)
            .write(to: fileURL)
    } catch{
        print(error)
    }
}

func read(){
    do{
    //read JSON
    let fileURL = try FileManager.default
        //change the directory to pick where it goes
        .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("passwords_Proj02.json")
        //print(fileURL)
        let data = try Data(contentsOf: fileURL)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: String]
        if let object = json{
            masterPasswordList = object
        }
        

    }catch{
    //print(error)
        print("No data found")
    }
}

func translate(l: Character, trans: Int) -> Character{
    if let ascii = l.asciiValue{
        var outputInt = Int(ascii)
        if ascii >= 98 && ascii <= 122{
            // a = 97
            // 97 - 97 = 0
            // 0 + 27 = 27
            // 27 % 26 = 1
            // 98 = b
            outputInt = ((Int(ascii)-97+trans)%26)+97//something to do with UInt8 and casting
        }else if (ascii >= 65 && ascii <= 90){
            outputInt = ((Int(ascii)-65+trans)%26)+65
        }
        return Character(UnicodeScalar(outputInt)!)
    }
    return Character("")
}
