From: Peter Pregler <Peter_Pregler@email.com>
Subject: Re: S3 on acer travelmate 3022WTMi
Date: Sun, 15 Oct 2006 16:23:25 +0200
Message-ID: <egtg8u$ut4$1@sea.gmane.org>
References: <966a04530609260106y2bea58del50732ba061cdc9a9@mail.gmail.com>	 <efbtdo$s4f$1@sea.gmane.org> <1159382935.3610.399.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:57012 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750786AbWJOOYA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Oct 2006 10:24:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZ6ty-0000Av-An
	for linux-acpi@vger.kernel.org; Sun, 15 Oct 2006 16:23:42 +0200
Received: from 85-124-206-147.dynamic.xdsl-line.inode.at ([85.124.206.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 15 Oct 2006 16:23:42 +0200
Received: from Peter_Pregler by 85-124-206-147.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 15 Oct 2006 16:23:42 +0200
In-Reply-To: <1159382935.3610.399.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> On Tue, 2006-09-26 at 21:01 +0200, Peter Pregler wrote:
>> Arto Pastinen wrote:
>>> Hi,
>>>
>>> Has anyone got Suspend to Ram work on Acer TravelMate 3022WTMi?
>>>
>>> I even fixed DSDT, but it still freezes on return from sleep, the hard
>>> disc shows little action, but then everything is blank..
>> I think this describes the problem with all Acer TM 3xxx. I have a
>> TM3201 and have the same problem. Additional symptons: display backlight
>> is off, fan is running. I tried about all the tricks including all
>> debugging that is possible without a serial console with no success.
>> And since I have no docking station, i.e. no chance for a serial
>> console, I simply gave up.
> There is firescope, setting up the kernel console output over firewire:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114412300502236&w=2
> There might be some machines having problems with it (all you need is a
> cable and your firewire device must be OHCI1394 compliant AFAIK), but I
> tried it out once and it worked fine.

Okay, got it working. I used an almost minimal vanilla 2.6.18 with no
modules. Almost minimal because I included IDE since I have no initram
at hand. But I do not think that makes a difference. I tried out suspend
without IDE a few month ago and it did not work either.

Looking at the console log and bus-messages attached below it seems that
the bus is not initialized during resume. I will try now the early-init
patch I got. Hope that gets more information. Any idea what ACPI-debug
options to set so we see more what happens during suspend? Maybe that
gives a clue too?

-Peter


++++++++++++++++++++++++++++++

Bus-changes according to dmesg on the console-host:

due to suspend:

[4296157.983000] ieee1394: Node changed: 0-01:1023 -> 0-00:1023
[4296157.984000] ieee1394: Node suspended: ID:BUS[0-00:1023]
GUID[00c09f00002097ea]

due to wakup
[4296231.271000] ieee1394: The root node is not cycle master capable;
selecting a new root node and resetting...
[4296231.534000] ieee1394: Node changed: 0-00:1023 -> 0-01:1023


=======
Console log during suspend:

<7>[   13.029739] ieee1394: Node added: ID:BUS[0-01:1023]
GUID[00000e1003915c1f]
<4>[   13.293508] [ACPI Debug]  String: [0x1C] "Temperature decreasing:
_Q81"
<4>[   92.305450] [ACPI Debug]  String: [0x1C] "Temperature increasing:
_Q80"

<4>[  103.304517] [ACPI Debug]  String: [0x1C] "Temperature increasing:
_Q80"

<4>[  111.305416] [ACPI Debug]  String: [0x1C] "Temperature increasing:
_Q80"

<4>[  127.366549] Stopping tasks: =======|
<4>[  127.367933] [ACPI Debug]  String: [0x16] ">>>> _PTS ------------"
<4>[  127.368045] [ACPI Debug]  Integer: 0x00000003

=======
No console log after wakeup

Port 0 (ohci1394) opened, 2 nodes detected

FireScope
---------
Target : <unspecified>
Gen    : 18
[Ctrl-T] choose target
[Ctrl-H] this menu
[Ctrl-Q] quit
2 nodes available, local node is: 1
 0: ffc0, uuid: <err: 11>
 1: ffc1, uuid: 100e0000 1f5c9103 [LOCAL]
Cannot lookup log_buf_addr
Cannot find linux log buffer
Exiting...

=========

