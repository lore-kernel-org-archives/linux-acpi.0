From: Len Brown <lenb@kernel.org>
Subject: Re: [Help] I can't get Intel Speedstep working
Date: Fri, 10 Apr 2009 22:51:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904102242160.8559@localhost.localdomain>
References: <cd5c26b90903110528x6762c035xb5bc26aa31f22c26@mail.gmail.com>
 <cd5c26b90903110540l19a721d1k1b7102f6f5c71d29@mail.gmail.com>
 <49DFE813.3020705@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:49275 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbZDKCvV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Apr 2009 22:51:21 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHX005U5192EXMZ@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Apr 2009 21:51:08 -0500 (CDT)
In-reply-to: <49DFE813.3020705@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Robert Szalai <krumpirluk@gmail.com>, linux-acpi@vger.kernel.org



On Fri, 10 Apr 2009, Robert Hancock wrote:

> Robert Szalai wrote:
> > Hello everybody,
> > 
> > I have a Shuttle K48 Barebone PC (Intel 945GC + ICH7 chipset) and a
> > Core 2 Duo E7300 CPU. I'm using Ubuntu 8.04 with 2.6.24-23-generic
> > kernel on my box. Everything works fine except Speedstep. When I try
> > to load acpi_cpufreq module, I get the following error:

Please try 2.6.29.

> > $ sudo modprobe acpi_cpufreq
> > FATAL: Error inserting acpi_cpufreq
> > (/lib/modules/2.6.24-23-generic/kernel/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.ko):
> > No such device
> > 
> > I've tried everything (other kernel versions, various patches) but the
> > result is the same.
> > I don't know if it is related to EIST or not but I've found these two
> > Exceptions in my dmesg:
> > 
> > [   20.675593] ACPI Exception (processor_core-0822): AE_NOT_FOUND,
> > Processor Device is not present [20070126]
> > [   20.675599] ACPI Exception (processor_core-0822): AE_NOT_FOUND,
> > Processor Device is not present [20070126]

This is actually sort of curious, but I'm too lazy to see why 2.6.24
blurts this.  Let me know if 2.6.29 still does.

> > After some research I've found that maybe a broken DSDT table is the
> > couse of my problem. I'm not an ACPI expert and I dont't know how to
> > locate and fix the problem in my DSDT. I've uploaded my dsdt.dsl to
> > 
> > http://www.easy-share.com/1903982677/dsdt.dsl
> > 
> > Any suggestions? I'd really like to use Speedstep on my Box.
> > You are my last hope Guys.
> 
> Your system doesn't seem to have anything interesting regarding CPU frequency
> scaling in the DSDT, but it's often in the FADT instead. Posting a full
> acpidump might be more useful..

yes, and the full dmesg please.
It is common for _PSS etc. to be dynamically loaded (though your DSDT has 
no Load's in it, so not in this case), or it could be included in an SSDT
that we'd see in the acpidump.

> Also make sure that any BIOS settings to allow CPU frequency scaling are
> enabled.

As it is a bare-bones system, you might also want to verify that you've
got the latest BIOS for the board.  It is possible that the BIOS 
you have doesn't know about the processor you have.

thanks,
-Len Brown, Intel Open Source Technology Center

