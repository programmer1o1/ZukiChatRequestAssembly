; This code is an attempted Zuki API wrapper written in x86-64 assembly (or NASM).
; It uses the cURL command to make a POST request to the Zuki API endpoint.
; The code can be modified to work with other API endpoints as well.

section .data
    ; Define the API key (replace 'YOUR_API_KEY' with the actual key)
    ; Join the Discord server at https://discord.gg/zukijourney to get an API key
    api_key db 'YOUR_API_KEY', 0

    ; Define the AI model to use
    ; Available models: gpt-3.5-turbo, gpt-3.5-turbo-instruct, gpt-3.5-turbo-16k, gpt-4, gpt-4-32k,
    ;                   gpt-4-1106-preview, gpt-4-0125-preview, gpt-4-vision-preview, claude,
    ;                   claude-2, claude-2.1, claude-instant-v1, claude-instant-v1-100k,
    ;                   pplx-70b-online, palm-2, bard, gemini-pro, gemini-pro-vision,
    ;                   mixtral-8x7b, mixtral-8x7b-instruct, mistral-tiny, mistral-small,
    ;                   mistral-medium, mistral-7b-instruct, codellama-7b-instruct, llama-2-7b,
    ;                   llama-2-70b-chat, mythomax-l2-13b-8k, sheep-duck-llama, goliath-120b,
    ;                   nous-llama2, yi-34b, openchat, solar10-7b, pi
    model db 'gpt-3.5-turbo', 0

    ; Define the system message (initial context for the AI)
    system_message db 'You are a helpful assistant.', 0

    ; Define the user message (the input prompt for the AI)
    user_message db 'Hello! What can you do as an AI?', 0

    ; Define the cURL command template
    ; This command sends a POST request to the Zuki API endpoint with the specified parameters
    curl_cmd db 'curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer %s" -d "{\"model\":\"%s\",\"messages\":[{\"role\":\"system\",\"content\":\"%s\"},{\"role\":\"user\",\"content\":\"%s\"}]}" "https://zukijourney.xyzbot.net/v1/chat/completions"', 0

section .bss
    ; Reserve a buffer to store the formatted cURL command
    curl_cmd_buffer resb 4096

section .text
    ; Declare external functions used in the code
    extern system, sprintf

    ; Define the entry point of the program
    global _start

_start:
    ; Prepare the cURL command by formatting the command string
    ; The sprintf function is used to replace the placeholders in the command template
    ; with the actual values of the API key, model, system message, and user message
    mov rdi, curl_cmd_buffer    ; Destination buffer for the formatted command
    mov rsi, curl_cmd           ; cURL command template
    mov rdx, api_key            ; API key
    mov rcx, model              ; AI model
    mov r8, system_message      ; System message
    mov r9, user_message        ; User message
    call sprintf

    ; Execute the formatted cURL command using the system function
    ; This sends the API request and retrieves the response
    mov rdi, curl_cmd_buffer    ; Formatted cURL command
    call system

    ; Exit the program
    mov rax, 60                 ; System call number for exit
    xor rdi, rdi                ; Exit status (0 for success)
    syscall                     ; Invoke the system call to exit the program
