From: "Yong Lee" <yonglee@telus.net>
Subject: RE: acpi nic card flapping
Date: Wed, 29 Nov 2006 22:23:33 -0800
Message-ID: <000e01c71448$1001e930$6502a8c0@ben>
References: <456D3338.6070709@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from defout.telus.net ([204.209.205.55]:60886 "EHLO defout.telus.net")
	by vger.kernel.org with ESMTP id S1757642AbWK3GXg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Nov 2006 01:23:36 -0500
In-Reply-To: <456D3338.6070709@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Kenji Kaneshige' <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-acpi@vger.kernel.org

Thanks all for the feedback.  We're having problems with acpi turned off
leading me to suspect that acpi may not be the issue at all.  We're doing a
swap of the hardrive into a new identical machine to see if we can isolate
it as a hardware problem.

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Kenji Kaneshige
Sent: Tuesday, November 28, 2006 11:14 PM
To: Yong Lee
Cc: linux-acpi@vger.kernel.org
Subject: Re: acpi nic card flapping

Hi Yong Lee,

> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=0x5

This message means OSHP method is not found under _SB.PCI0.PBLO. This
message itself is harmless, I think.

But, IIRC, old shpchp driver had a problem that loading shpchp driver
may cause a master-abort on some ongoing PCI cards. The root cause is
old shpchp driver writes 0xFFFFFFFF to BARs of some ongoing PCI cards
to know the size of resources assigned to the cards at modprobe time.

I don't know this is related to your problem. But I hope this info is
helpful for you.

Thanks,
Kenji Kaneshige


Yong Lee wrote:
> Hi all,
> 
> I'm hoping that someone out there can lend me a hand with a problem that
we
> were seeing.  I'm not very familiar with the acpi tool so please bear with
> me.
> 
> We had an outage where we could not ssh into our web server and we had to
do
> a reboot from our console to get things running again.  It looks like an
> acpi problem and I'm trying to figure out what was going on.  Was ACPI
going
> crazy or was it trying to report a problem condition that we were not
aware
> of.
> 
> What we saw in the dmesg log was this :
> 
> shpchp: Address64 -------- Resource unparsed
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=0x5
> shpchp: acpi_shpchprm:   Slot sun(0) at s:b:d:f=0x00:04:1f:00
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=0x5
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> 
> During the time of the outage we saw from our router logs that the
> connection to the server was going up and down.
> 
> There was a lot of other messages on the console but our sysadmin guy
didn't
> capture this.
> 
> We're running redhat linux 2.6.9-34.0.2.ELsmp on intel xeon processors.  
> We have 2 intel nic cards : Intel Corporation 82541GI/PI Gigabit Ethernet
> Controller (rev 05)
> 
> Any light you can shed on this problem would be great.  Note that while
the
> kacpid kernel thread is running the acpid daemon was shut off during this
> incident.
> 
> Many thanks,
> Yong.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

