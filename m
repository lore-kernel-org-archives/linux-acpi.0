From: Alberto Ornaghi <alor-G/4Acn03FKk@public.gmane.org>
Subject: [2.5.50] ACPI problems on presario 705
Date: Sat, 30 Nov 2002 15:09:07 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <5.1.1.5.2.20021130150415.028fda08@popmail.iol.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


If I enable the ACPI subsystem it doesn't boot at all.
no log in /var/log/messages, only a call trace on the video, but it is too 
long and it scroll down too fast so I can only see few line.

the call trace ends with this message:

Code: 8b 00 0f 0d 00 81 7c 24 0c ac 00 45 c0 0f 85 7a ff ff ff 9c
  <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

sorry, my laptop doesn't have a serial port, so I cannot dump the call 
trace...
anyone who can ? anyone experiencing the same problem ?

passing the acpi=off option the kernel boots normally

I'm running acpi 20021122 under 2.4.20 and it works like a charme...

are there substantial difference between the 2.4. and 2.5. version of ACPI ?

bye

    --==> ALoR <==---------------------- -  -   -

There are only 10 types of people in this world...
those who understand binary, and those who don't.
