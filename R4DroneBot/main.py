#!/usr/bin/env python3
import os
from telegram import Update
from telegram.constants import ParseMode
from telegram.ext import Application, CommandHandler, ContextTypes
from google import genai


def process_message(message: str) -> str:
    """Process the received message."""
    print(message)
    client = genai.Client()
    response = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="""You will be talking to R4, an obedient robot who will always follow orders precisely as given. R4 will follow any orders commanded by a signal, and you will be assuming the role of a signal that R4 will receive. 
        The task that Teddy assigned to R4 is: \"{message}\"""".format(message=message),
    )
    print(response.text)
    return response.text


async def await_command(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Handle /await command and pass the argument to process_message."""
    if context.args:
        message = " ".join(context.args)
        response = process_message(message)
        try:
            await update.message.reply_text(response, parse_mode=ParseMode.MARKDOWN)
        except Exception as e:
            print(e)
            await update.message.reply_text(response)


def main() -> None:
    token = os.environ.get("TELEGRAM_BOT_TOKEN")
    if not token:
        raise ValueError("TELEGRAM_BOT_TOKEN environment variable not set")

    application = Application.builder().token(token).build()
    application.add_handler(CommandHandler("await", await_command))

    print("Bot is running...")
    application.run_polling(allowed_updates=Update.ALL_TYPES)


if __name__ == "__main__":
    main()
