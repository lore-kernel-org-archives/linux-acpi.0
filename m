From: Len Brown <lenb@kernel.org>
Subject: Re: sony-laptop: ACPI Exception when a Fn-Key is pressed
Date: Tue, 07 Apr 2009 01:12:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904070102450.5698@localhost.localdomain>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
 <20090406110154.GA25085@kamineko.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:46126 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbZDGFNE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 01:13:04 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHP00EXWT57K6LU@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 00:12:49 -0500 (CDT)
In-reply-to: <20090406110154.GA25085@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Rodrigo Luiz <rodrigo@gus-mg.org>, linux-acpi@vger.kernel.org, robert.moore@intel.com



On Mon, 6 Apr 2009, Mattia Dongili wrote:

> On Sun, Apr 05, 2009 at 09:27:06PM -0300, Rodrigo Luiz wrote:
> > Hi.
> > 
> > I have a Vaio VGN-FW235J and I tried today the latest kernel version
> > in git to test the latest changes in sony-laptop.
> > 
> > When I press any Fn-keys, i.e. brightness control, I received these
> > messages in syslog:
> > 
> > ACPI Error (hwvalid-0186): Denied AML access to port 0x00000080/4
> > (DMA1 0x0081-0x0083) [20090320]

this looks like a write to port 80 -- the debug port -- which is valid.

however, it looks like the size is 4, which overlaps with protected ports?


> > ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Returned by
> > Handler for [SystemIO] [20090320]
> > ACPI Error (psparse-0537): Method parse/execution failed [\P8XH] (Node
> > f7418c30), AE_AML_ILLEGAL_ADDRESS
> > ACPI Error (psparse-0537): Method parse/execution failed
> > [\_SB_.PCI0.LPCB.EC__._Q58] (Node f741bc00), AE_AML_ILLEGAL_ADDRESS
> > ACPI Error (hwvalid-0186): Denied AML access to port 0x00000080/4
> > (DMA1 0x0081-0x0083) [20090320]
> > ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Returned by
> > Handler for [SystemIO] [20090320]
> > ACPI Error (psparse-0537): Method parse/execution failed [\P8XH] (Node
> > f7418c30), AE_AML_ILLEGAL_ADDRESS
> > ACPI Error (psparse-0537): Method parse/execution failed
> > [\_SB_.PCI0.LPCB.EC__._Q59] (Node f741bc18), AE_AML_ILLEGAL_ADDRESS
> 
> Interesting. This is due to a change in current git it was not present
> in 2.6.29.
> 
> Does booting with acpi_osi=Linux makes things any worse? (it should fix
> the above error but might make some other functionality behave
> differently).
> Or eventually also see if there is a bios upgrade available for your
> laptop.
> 
> Len,
> it looks like most of the vaios define this in global scope:
> 
>     OperationRegion (PRT0, SystemIO, 0x80, 0x04)
>     Field (PRT0, DWordAcc, Lock, Preserve)
>     {   
>         P80H,   32
>     }
> 
> which falls in the DMA1 reserved area in >WinXP.
> No idea how windows copes with it if the same restrictions area really
> in place.

just defining the opregion is okay.

in 2.6.29 we checked at opregion definition time -- but had some false
hits on regions that were defined and never used.

so in 2.6.30 we have run-time checks only.

-Len Brown, Intel Open Source Technology Center




