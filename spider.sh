#!/bin/bash


encrypt_file() {
    local input_file="$1"
    local output_file="$2"


    salt=$(openssl rand -hex 16)


    key=$(openssl rand -base64 32)


    openssl enc -aes-256-cbc -salt -S "$salt" -iter 100000 -in "$input_file" -out "$output_file.enc" -pass pass:"$key"

    echo "File encryption complete. Encrypted file: $output_file.enc"
    echo "Encryption key: $key"
    echo "Salt: $salt"
}


decrypt_file() {
    local input_file="$1"
    local output_file="$2"
    local key="$3"
    local salt="$4"


    openssl enc -aes-256-cbc -d -salt -S "$salt" -iter 100000 -in "$input_file" -out "$output_file" -pass pass:"$key"

    echo "File decryption complete. Decrypted file: $output_file"
}


read -p "Enter the path of the input file: " input_file
read -p "Enter the path of the output file: " output_file
read -p "Enter the encryption key: " key
read -p "Enter the salt: " salt

echo "Choose an option:"
echo "1. Encrypt the file"
echo "2. Decrypt the file"

read -p "Enter your choice (1/2): " choice

case $choice in
    1)
        encrypt_file "$input_file" "$output_file"
        ;;
    2)
        decrypt_file "$input_file" "$output_file" "$key" "$salt"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac
