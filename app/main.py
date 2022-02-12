# -*- coding: utf-8 -*-
import sys

# メイン関数
def handler(event, context): 
    return 'Hello from AWS Lambda using Python' + sys.version + '!'

