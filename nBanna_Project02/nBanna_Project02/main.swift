//
//  main.swift
//  nBanna_Project02
//
//  Created by Nader Banna on 2/22/21.
//

import Foundation

var masterPasswordList = [String: String]()
var passphrase: String = "helpme"

masterPasswordList = ["Google": "strongPassword"]

print("Hello, World!")
var run = true

while run == true{
print("Welcome to your Password Manager. What would you like to do?")
print("1. View all password names")
print("2. View a single password")
print("3. Add a single password")
print("4. Delete a password")
print("5. Exit Program")
let userOption = readLine()

if userOption == "1"{
    //iterate through dictionary and print keys
    for (key, _) in masterPasswordList{
        print("Key: \(key)")
    }
}
else if userOption == "2"{
    print("Which password would you like to view? Enter the key")
    let userKey = readLine()
    
    if masterPasswordList.keys.contains(userKey!){
        print("Please enter the passphrase: ")
        let userPPH = readLine()
        
        //need to change to descramble password then display
        if userPPH == passphrase{
            print("Password:  \(masterPasswordList[userKey!]!)")
        }else{
            print("You entered the wrong passphrase")
        }
    }
}
else if userOption == "3"{
    print("Enter the password name (key): ")
    let userKey = readLine()
    print("Enter the password: ")
    let userPassword = readLine();
    print("Enter your passphrase")
    let userPPH = readLine()
    
    let newPassword: String = userPassword!+userPPH!
    
    masterPasswordList[userKey!] = newPassword
    
}
else if userOption == "4"{
    print("in 4")
}
else if userOption == "5"{
    run = false
}
else {
    print("Invalid Input")
}

}
