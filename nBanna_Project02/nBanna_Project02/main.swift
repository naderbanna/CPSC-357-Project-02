//
//  main.swift
//  nBanna_Project02
//
//  Created by Nader Banna on 2/22/21.
//

import Foundation


var masterPasswordList = [String: String]()


class Program{
    init(){
        
        read()
        
        var reply = ""
        var keepRunning = true
        
        while keepRunning{
            print("")
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
                                write(dict: masterPasswordList)
                                keepRunning = false;
                            }

                        }else if reply == "yes"{
                            //delete password
                            reply = Ask.AskQuestion(questionText: "Enter the password name (key) to delete: ", acceptableReplies: [])
                            masterPasswordList.removeValue(forKey: reply)
                            write(dict: masterPasswordList)
                        }
                    }else if reply == "yes"{
                        //enter new password
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
                        
                        for letter in str{
                            strShift += String(translate(l: letter, trans: shift))
                        }
                                                
                        masterPasswordList[userKey] = strShift
                        write(dict: masterPasswordList)
                    }
                }else if reply == "yes"{
                    //View a single password
                    reply = Ask.AskQuestion(questionText: "Which password would you like to view? Enter the key: ", acceptableReplies: [])
                
                    if masterPasswordList.keys.contains(reply){
                        let tempPass = masterPasswordList[reply]!
                        
                        let shift = 26-tempPass.count
                        var strShift = ""
                        
                        for letter in tempPass{
                            strShift += String(translate(l: letter, trans: shift))
                        }
                        
                        let usrPass = String(strShift.reversed())
                        
                        reply = Ask.AskQuestion(questionText: "Enter your passphrase to display: ", acceptableReplies: [])
                    
                        print("")
                        if usrPass.contains(reply){
                            print("Password: \(usrPass.dropLast(reply.count))")
                        }
                    
                }
            }
            }else if reply == "yes"{
                //View all Passwords
                reply = Ask.AskQuestion(questionText: "Enter your passphrase to display all passwords: ", acceptableReplies: [])

                print("")
                for (key, _) in masterPasswordList{
                    let tempPass = masterPasswordList[key]!
                    
                    let shift = 26-tempPass.count
                    var strShift = ""
                    
                    for letter in tempPass{
                        strShift += String(translate(l: letter, trans: shift))
                    }
                    
                    let usrPass = String(strShift.reversed())
                    
                
                    if usrPass.contains(reply){
                        print("\(key) Password: \(usrPass.dropLast(reply.count))")
                    }
            }
        }
    }
}
}

let p = Program()


class Ask{
    static func AskQuestion(questionText output: String, acceptableReplies inputArr: [String], caseSensative: Bool = false) -> String{
        print(output) // ask our question
        
        //handle response
        guard let response = readLine() else{
            // they didnt type anything at all
            print("Invalid input")
            return AskQuestion(questionText: output, acceptableReplies: inputArr)
        }
        if(inputArr.contains(response) || inputArr.isEmpty){
            return response
        }else{
            print("Invalid input")
            return AskQuestion(questionText: output, acceptableReplies: inputArr)
        }
    }
}


func write(dict input: [String: String]){
    do{
        
        let fileURL = try FileManager.default
            //change the directory to pick where it goes
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("passwords_nBanna_Proj02.json")

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
        .appendingPathComponent("passwords_nBanna_Proj02.json")
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
        if ascii >= 97 && ascii <= 122{
            outputInt = abs((Int(ascii)-97+trans)%26)+97
        }else if (ascii >= 65 && ascii <= 90){
            outputInt = abs((Int(ascii)-65+trans)%26)+65
        }
        return Character(UnicodeScalar(outputInt)!)
    }
    return Character("")
}

