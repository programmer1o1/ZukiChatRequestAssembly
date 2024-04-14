# Zuki API Wrapper in x86-64 Assembly (NASM)

This is a Zuki API wrapper written in x86-64 assembly using NASM (Netwide Assembler). It demonstrates how to make a POST request to the Zuki API endpoint using the cURL command.

> [!IMPORTANT]  
> - This is an attempted or unfinished Zuki API Wrapper. (Hell, I don't want to continue this project.)
>
> - The code assumes a Linux environment with x86-64 architecture. Adjustments may be needed for other operating systems or architectures. Sooo, Windows and probs Mac are not supported or you can make it supported ig.
>
> - It also can work with other API endpoints. Which means not only Zuki API but OpenAI, and other stuff too. (You do need to modify the API request tho but it is probably unnecessary at most.)

## Prerequisites

To run this code, you need the following:

- NASM (Netwide Assembler) installed on your system.
- A valid API key from the Zuki API. Join the Discord server at [https://discord.gg/zukijourney](https://discord.gg/zukijourney) to obtain an API key.

## Configuration

Before running the code, make sure to replace the placeholder `'YOUR_API_KEY'` with your actual Zuki API key in the `api_key` definition:

```nasm
api_key db 'YOUR_API_KEY', 0
```

You can also modify the `model`, `system_message`, and `user_message` definitions to customize the AI model and the initial context for the conversation.

## Usage

1. Save the code to a file with a `.asm` extension (e.g., `zuki_wrapper.asm`) or download the file.

2. Assemble the code using NASM:
   ```
   nasm -f elf64 zuki_wrapper.asm
   ```
   This command generates an object file named `zuki_wrapper.o`.

3. Link the object file to create an executable:
   ```
   ld -o zuki_wrapper zuki_wrapper.o -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2
   ```
   This command links the object file with the C library and the dynamic linker, creating an executable named `zuki_wrapper`.

4. Run the executable:
   ```
   ./zuki_wrapper
   ```
   This command executes the Zuki API wrapper, sends the API request, and retrieves the response.

## Customization

You can modify the code to work with other API endpoints or to customize the behavior of the wrapper. Here are a few possible modifications:

- Change the `api_key`, `model`, `system_message`, and `user_message` definitions to suit your needs.
- Modify the cURL command template in the `curl_cmd` definition to include additional parameters or headers.
- Process the API response in a different way, such as parsing the JSON data or storing it in a file.
