From: Magnus Sandberg <mem-P9zfqOBuU5vLoDKTGw+V6w@public.gmane.org>
Subject: Re: FSC Amilo M-3438G
Date: Thu, 12 Jan 2006 22:51:02 +0100
Message-ID: <20060112215102.827BA1C812@debian.datakon.se>
References: <20060112092118.84F211C812@debian.datakon.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: Your message of "Thu, 12 Jan 2006 10:21:18 +0100."
             <20060112092118.84F211C812-FBVcP3zgNXfBmJu9jE4dRbNAH6kLmebB@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mem-P9zfqOBuU5vLoDKTGw+V6w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi again,

I should clarify that I'm running Debian Etch (testing) with Linux
kernel 2.6.12-1-686.

I have now tried to recompile the dsdt and got the following output.
How should I correct the warnings? Could this warnings have anything to do 
with my battery problems? Why is the new compiled DSDT.aml much smaller 
than the dumped one? I small difference in size is okay, I guess. But 13% 
smaller, is that okay?


# acpidump -b -t DSDT -o dsdt.aml
# iasl -d dsdt.aml

Intel ACPI Component Architecture
AML Disassembler version 20051117 [Nov 27 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

Loading Acpi table from file dsdt.aml
Acpi table [DSDT] successfully installed and loaded
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
............................................................................
............................................................................
............................................................................
............................................................................
......
Parsing completed
Disassembly completed, written to "dsdt.dsl"
# iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20051117 [Nov 27 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl  2017:                             Store (0x1F, DBG8)
Warning  2097 -              Statement is unreachable ^ 

dsdt.dsl  2022:                             Store (0x0F, DBG8)
Warning  2097 -              Statement is unreachable ^ 

dsdt.dsl  3357:                         Name (_WDG, Buffer (0x50)
Warning  2096 -            Unknown reserved name ^  (_WDG)

ASL Input:  dsdt.dsl - 4389 lines, 145148 bytes, 1799 keywords
AML Output: DSDT.aml - 16556 bytes 565 named objects 1234 executable opcodes

Compilation complete. 0 Errors, 3 Warnings, 0 Remarks, 614 Optimizations
# ls -lrt
total 344
-rw-r--r--  1 root root  19011 2006-01-12 22:06 dsdt.aml
-rw-r--r--  1 root root 145148 2006-01-12 22:07 dsdt.dsl
-rw-r--r--  1 root root 155519 2006-01-12 22:21 dsdt.hex
-rw-r--r--  1 root root  16556 2006-01-12 22:21 DSDT.aml


Regards,

                                  _\\|//_
                                  (-0-0-)
                    /-----------ooO-(_)-Ooo----------\
                    |           Magnus Sandberg      |
                    | Email:  mem (a) datakon <.> se |
                    |   GSM:    +46-70-205 81 84     |
                    \--------------------------------/
                                  ||   ||
                                 ooO   Ooo


 ----- On 12th of January 2006 Magnus Sandberg wrote; -----

Subject: FSC Amilo M-3438G
From: Magnus Sandberg
Date: Thu, 12 Jan 2006 10:21:18 +0100
To: linux-acpi

Hi,

I'm new to this list and I have just got a Fujitsu-Siemens Amilo M-3438G 
which I'm installing Debian on.

I have some problems with ACPI on the machine. The problems I have found so 
far is that;
- I don't get any events when the battery is discharged or running low
- The lid button only reports close events so the lid-state is always
  "closed"
- I don't know if "Fn"-keys should be reported via ACPI or not?
  I only get the "sleep mode" Fn-key event, no other Fn-keys.
- I don't get events for "special hot keys" like "silent mode", etc
  (The Amilo M3438 has 4 hot keys above the Fn-keys)

Things that do work;
- Power button generate event
- I get events for AC, CPU and BAT when I add or remove AC-adator
- As mentioned above Fn-key for sleep button works
- I can read battery state and battery info. Remaining capacity and voltage
  seams to be okay. Remaining capacity is like 2 mAh just before the
  machine dies. Warning and low levels seams to be calculated from
  "last full capacity", I don't know if that is the way it should be done?
- Thermal Zone seams to work, get values in the range 31 C - 53 C

My questions are if I have to compile a new DSDT or if I should do 
something else to correct the problems. And what things should or can ACPI 
support (like Fn-keys or hot keys, etc)?

I changed the scripts in /etc/acpi to send all unknown events via logger to 
/var/log/messages

If I remove the AC, I get the following;

ac_adapter AC0 00000080 00000000
battery BAT0 00000080 00000001
processor CPU1 00000080 00000006

If I connect the AC, I get;

ac_adapter AC0 00000080 00000001
battery BAT0 00000080 00000001
processor CPU1 00000080 00000005


<<< The rest of the email is removed >>>


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
