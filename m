From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Regression in module wmi since 2.6.32 (bisected to commit 1caab3c)
Date: Fri, 25 Dec 2009 15:35:49 -0600
Message-ID: <4B353035.4050208@lwfinger.net>
References: <4B352513.90302@lwfinger.net> <200912252056.08436.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757313AbZLYVfz@vger.kernel.org>
In-Reply-To: <200912252056.08436.carlos@strangeworlds.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Matthew Garrett <mjg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/25/2009 02:56 PM, Carlos Corbacho wrote:
> On Friday 25 December 2009 20:48:19 Larry Finger wrote:
>> If I modprobe wmi after the system is booted, the specific messages are as
>>  follows:
>>
>> ------------[ cut here ]------------
>> WARNING: at fs/sysfs/dir.c:477 sysfs_add_one+0xd6/0xee()
>> Hardware name: System Product Name
>> sysfs: cannot create duplicate filename
>> '/devices/virtual/wmi/05901221-D566-11D1-B2F0-00A0C9062910'
> 
> Interesting - what hardware is this? And can you post the DSDT?

The hardware is home-built with an ASUS M3N78-VM motherboard and an Athlon X2
6000 3.1G CPU running an x86_64 OS.

I ran the following commands per the instructions at
http://www.lesswatts.org/projects/acpi/overridingDSDT.php with the following
results:

=====================
desktop:~ # cp /proc/acpi/dsdt DSDT
desktop:~ # acpidump > acpidump.out
Wrong checksum for OEMB!
desktop:~ # acpixtract DSDT acpidump > DSDT.dat
desktop:~ # iasl -d DSDT.dat

Intel ACPI Component Architecture
AML Disassembler version 20081031 [Dec  3 2008]
Copyright (C) 2000 - 2008 Intel Corporation
Supports ACPI Specification Revision 3.0a

Loading Acpi table from file DSDT.dat
TableHeader length [0x62617420] greater than the input file size [0x35]
Could not get table from the file
==================

Do the messages indicate a BIOS problem? I have not updated for some time, and
would rather not do so unless necessary.

Should I attach the files DSDT.dat, acpidump.out, or DSDT?

Larry
