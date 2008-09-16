From: "Phil Endecott" <phil_hmpau_endecott@chezphil.org>
Subject: Toggling VGA out on Eee 901
Date: Tue, 16 Sep 2008 22:43:12 +0100
Message-ID: <1221601392651@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:2384 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbYIPWfP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Sep 2008 18:35:15 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.69)
	(envelope-from <phil_hmpau_endecott@chezphil.org>)
	id 1KfiKH-0003Eg-O4
	for linux-acpi@vger.kernel.org; Tue, 16 Sep 2008 22:43:13 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>

Dear Experts,

I'm trying to work out how to get console video out toggling working on 
my ASUS EEE 901 (running Debian).  I get the feeling that I may be the 
first person to try to do this, and I knew almost nothing about ACPI 
until a couple of hours ago.  Can anyone help?

Output toggling for X works fine, but that doesn't use ACPI.  If the 
machine is booted with an external monitor connected, console VGA out 
is enabled; if the monitor is not connected it's not enabled.  Looking 
in /proc/acpi/video/VGA/CRTD/state I see

state: 0x1f
query: 0x01

when the machine was booted with the monitor connected and

state: 0x0d
query: 0x00

when the machine was booted without the monitor.  Following the advice 
of an old ACPI HOWTO I tried to store 0x80000001 in that file:

# /bin/echo 0x80000001 > /proc/acpi/video/VGA/CRTD/state
/bin/echo: write error: Bad address

I had a look at my iasl-disassembled /proc/dsdt and found this:

Device (VGA)
{
     .....
     Name (DONE, Zero)
     .....

     Device (CRTD)
     {
         .....
         Method (_DSS, 1, NotSerialized)
         {
             If (And (Arg0, 0x40000000))
             {
                 If (And (Arg0, 0x80000000))
                 {
                     Store (One, DONE)
                 }
             }
         }
     }
}

I have never looked at this stuff before, but I don't get the 
impression that it's actually going to do anything to the hardware 
registers, is it?  Am I looking in the wrong place?  Based on that I 
did try to store 0xC0000000 and 0xC0000001, and in this case there was 
no "Bad address" error - but no output change either.

Can someone point me in the right direction?
I have put the complete dsdt.dsl here: http://chezphil.org/tmp/eee_901_dsdt.dsl


Many thanks,  Phil.

(Please cc: me in any replies)



