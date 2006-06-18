From: =?ISO-8859-1?Q?Johny_=C5gotnes?= <johny@agotnes.com>
Subject: [Fwd: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues]
Date: Sun, 18 Jun 2006 21:38:51 +1000
Message-ID: <44953B4B.9040108@agotnes.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060806030802070402060101"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from munin.agotnes.com ([202.173.149.60]:13804 "EHLO
	mail.agotnes.com") by vger.kernel.org with ESMTP id S932072AbWFRLjC
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jun 2006 07:39:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.agotnes.com (Postfix) with ESMTP id BF5286004E
	for <linux-acpi@vger.kernel.org>; Sun, 18 Jun 2006 21:39:00 +1000 (EST)
Received: from mail.agotnes.com ([127.0.0.1])
 by localhost (munin.agotnes.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21664-16 for <linux-acpi@vger.kernel.org>;
 Sun, 18 Jun 2006 21:38:58 +1000 (EST)
Received: from [172.31.254.148] (unknown [172.31.254.148])
	by mail.agotnes.com (Postfix) with ESMTP id 2099460037
	for <linux-acpi@vger.kernel.org>; Sun, 18 Jun 2006 21:38:58 +1000 (EST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060806030802070402060101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

didn't go through due to missing vger. ...

--------------060806030802070402060101
Content-Type: message/rfc822;
 name*0="Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename*0="Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues"

Return-Path: <kernel@agotnes.com>
X-Original-To: kernel@agotnes.com
Delivered-To: kernel@agotnes.com
Received: from localhost (localhost [127.0.0.1])
	by mail.agotnes.com (Postfix) with ESMTP id 62E0D6004E;
	Sun, 18 Jun 2006 21:37:09 +1000 (EST)
Received: from mail.agotnes.com ([127.0.0.1])
 by localhost (munin.agotnes.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20280-20; Sun, 18 Jun 2006 21:37:06 +1000 (EST)
Received: from [172.31.254.148] (unknown [172.31.254.148])
	by mail.agotnes.com (Postfix) with ESMTP id A1CE960037;
	Sun, 18 Jun 2006 21:37:06 +1000 (EST)
Message-ID: <44953ADC.2080305@agotnes.com>
Date: Sun, 18 Jun 2006 21:37:00 +1000
From: Johny <kernel@agotnes.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Johny <kernel@agotnes.com>,
 USB development list <linux-usb-devel@lists.sourceforge.net>,
 kernel list <linux-kernel@vger.kernel.org>,  linux-acpi@kernel.org,
 akpm@osdl.org
Subject: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues
References: <Pine.LNX.4.44L0.0606151102220.6879-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0606151102220.6879-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: amavisd-new at agotnes.com

All,

I've now tested the following;

2.6.17-rc6-mm2 with the following patch applied;
---
git-acpi.patch from 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/broken-out/
---

With no difference to the end-result.

Next I stripped out 802.11 generic support and acx111 drivers from the 
kernel (including the acpi patches) to check if it clashes, but the same 
errors occur....

Thirdly, I booted with acpi=off on the command line with two kernels, 
the stock 2.6.17-rc6-mm2 (no acpi patch and including acx111) and the 
one including the acpi patch and no acx111, the results were;

acpi_patch;
works a treat, picks up USB devices as expected.

stock;
works a treat, picks up USB devices as expected, and my acx111 card 
works too :)


Now I'm looking for good suggestions again, this definitely looks like 
it is related to ACPI, hence the cc' to that list too, as requested by 
Andrew M.

I'm happy to apply patches / config changes as appropriate and for those 
who may ask for my .config files, please see;

http://www.agotnes.com/kernelStuff/config-2.6.17-rc6-mm2

http://www.agotnes.com/kernelStuff/config-2.6.17-rc6-mm2git-acpi_patch

Also, I left the output of lspci there for reference;

http://www.agotnes.com/kernelStuff/lspci

Cheers,

:)Johny

Alan Stern wrote:
> [Moved to linux-usb-devel in the hope of getting additional help]
> 
> On Thu, 15 Jun 2006, Johny wrote:
> 
>> Alan,
>>
>> See comments interspersed, thanks for your assistance :)
>>
>> Alan Stern wrote:
>>> On Tue, 13 Jun 2006, Johny wrote:
>>>
>>>> Is this best suited to this mailing list?
>>> It's appropriate.
>>>
>>>> I tried the kernel list with zero responses (so far ;), let me know if there is
>>>> anywhere else this should go.
>>> ...
>>>
>>>> Johny Ågotnes wrote:
>>>>> All,
>>>>>
>>>>> My USB hub isn't recognised with the latest -mm series, whereas with
>>>>> 2.6.16 vanilla it is picked up & used immediately.
>>>>>
>>>>> The error I get in dmesg is;
>>>>>
>>>>> hub 4-0:1.0: USB hub found
>>>>> hub 4-0:1.0: 2 ports detected
>>>>> usb 1-4: new high speed USB device using ehci_hcd and address 3
>>>>> ehci_hcd 0000:00:10.3: Unlink after no-IRQ?  Controller is probably
>>>>> using the wrong IRQ.
>>> That last line is a clue.  What interrupt numbers are assigned under
>>> 2.6.16?  If you unplug the SonyEricsson DCU-11 Cable before booting (and
>>> leave it unplugged), what shows up in /proc/interrupts for both versions
>>> of the kernel?
>> See attached, both with the DCU-11 cable disconnected.
> 
> From 2.6.16:
>            CPU0       
>   0:      16101          XT-PIC  timer
>   1:        148          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   7:          0          XT-PIC  parport0
>   9:          0          XT-PIC  acpi
>  10:        151          XT-PIC  ehci_hcd:usb1, uhci_hcd:usb4
>  11:          0          XT-PIC  uhci_hcd:usb2, uhci_hcd:usb3
>  12:        138          XT-PIC  i8042
>  14:        172          XT-PIC  ide0
>  15:       2458          XT-PIC  ide1
> NMI:          0 
> ERR:          0
> 
> From 2.6.17:
>            CPU0       
>   0:      35651    XT-PIC-level    timer
>   1:        129    XT-PIC-level    i8042
>   2:          0    XT-PIC-level    cascade
>   6:          3    XT-PIC-level    floppy
>   7:          0    XT-PIC-level    parport0
>   9:          0    XT-PIC-level    acpi
>  10:          0    XT-PIC-level    ehci_hcd:usb1, uhci_hcd:usb4
>  11:       1940    XT-PIC-level    uhci_hcd:usb2, uhci_hcd:usb3, wlan0
>  12:        162    XT-PIC-level    i8042
>  14:        171    XT-PIC-level    ide0
>  15:       4251    XT-PIC-level    ide1
> NMI:          0 
> ERR:          0
> 
> There's nothing obviously wrong.
> 
>>> Most likely this is a problem with the ACPI subsystem, not a USB problem.
>>>
>> I guessed USB due to the number of USB changes in the -mm series and, 
>> obviously, my USB devices stopped registering, however, I'd not know one 
>> from the other ;)
> 
> What happens if you boot with "acpi=off" on the boot command line?
> 
> Alan Stern
> 

--------------060806030802070402060101--
