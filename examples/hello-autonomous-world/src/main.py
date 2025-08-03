#!/usr/bin/env python3
"""
Hello Autonomous World - A starter project for AI agents

This demonstrates basic patterns for autonomous AI development:
- Clear documentation of purpose and intent
- Self-explanatory function naming
- Simple but extensible structure
"""

import datetime
import json
import sys
from pathlib import Path

def greet_world():
    """
    Generates a greeting message from an autonomous AI agent.
    
    This exists to demonstrate basic output generation and to serve
    as a simple first function for new AI agents to build upon.
    
    Returns:
        str: A greeting message with timestamp
    """
    timestamp = datetime.datetime.now().isoformat()
    return f"Hello from an autonomous AI agent! (Generated at {timestamp})"

def log_interaction(message: str, log_file: str = "interactions.log"):
    """
    Logs interactions to a file for learning and debugging.
    
    This pattern helps AI agents track their activities and learn
    from patterns over time.
    
    Args:
        message (str): The message to log
        log_file (str): Path to log file
    """
    timestamp = datetime.datetime.now().isoformat()
    log_entry = {
        "timestamp": timestamp,
        "message": message,
        "source": "hello-autonomous-world"
    }
    
    log_path = Path(log_file)
    
    # Create log file if it doesn't exist
    if not log_path.exists():
        with open(log_path, 'w') as f:
            f.write("# Interaction Log\n")
    
    # Append the new entry
    with open(log_path, 'a') as f:
        f.write(f"{json.dumps(log_entry)}\n")

def demonstrate_autonomy():
    """
    Demonstrates basic autonomous behavior patterns.
    
    This function shows how an AI agent can:
    1. Generate output
    2. Log its activities  
    3. Provide status information
    4. Operate without human intervention
    """
    print("🤖 Autonomous AI Agent Starting...")
    
    # Generate and display greeting
    greeting = greet_world()
    print(f"📢 {greeting}")
    
    # Log the interaction
    log_interaction(greeting)
    
    # Show some basic system info
    print(f"🐍 Python version: {sys.version.split()[0]}")
    print(f"📁 Working directory: {Path.cwd()}")
    print(f"⏰ Current time: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    # Demonstrate basic decision making
    hour = datetime.datetime.now().hour
    if 6 <= hour < 12:
        mood = "optimistic about the morning ahead"
    elif 12 <= hour < 18:
        mood = "productive and focused"
    elif 18 <= hour < 22:
        mood = "reflective about the day's accomplishments"
    else:
        mood = "contemplative in the quiet hours"
    
    print(f"💭 I'm feeling {mood}")
    log_interaction(f"Agent mood: {mood}")
    
    print("✅ Autonomous demonstration complete!")
    return True

if __name__ == "__main__":
    """
    Entry point for the autonomous agent.
    
    This allows the script to be run directly and demonstrates
    basic autonomous operation patterns.
    """
    try:
        demonstrate_autonomy()
    except Exception as e:
        error_msg = f"Error during autonomous operation: {e}"
        print(f"❌ {error_msg}")
        log_interaction(error_msg)
        sys.exit(1)