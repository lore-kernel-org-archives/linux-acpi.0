From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware
	doesn't define one
Date: Thu, 15 May 2008 11:06:23 +0800
Message-ID: <1210820783.2929.55.camel@rzhang-crestline.sh.intel.com>
References: <20080514010000.GB21608@srcf.ucam.org>
	 <20080514010300.GC21608@srcf.ucam.org>
	 <20080514010820.GD21608@srcf.ucam.org> <200805132330.20159.lenb@kernel.org>
	 <20080514093304.GB28678@srcf.ucam.org>
	 <1210812916.2929.6.camel@rzhang-crestline.sh.intel.com>
	 <20080515010426.GA13927@srcf.ucam.org>
	 <1210814699.2929.10.camel@rzhang-crestline.sh.intel.com>
	 <20080515015831.GA14829@srcf.ucam.org>
	 <1210817739.2929.24.camel@rzhang-crestline.sh.intel.com>
	 <20080515022431.GA15085@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34350 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbYEODGU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 23:06:20 -0400
In-Reply-To: <20080515022431.GA15085@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>


On Thu, 2008-05-15 at 03:24 +0100, Matthew Garrett wrote:
> On Thu, May 15, 2008 at 10:15:39AM +0800, Zhang Rui wrote:
> > On Thu, 2008-05-15 at 02:58 +0100, Matthew Garrett wrote:
> > > I'll modify my patch so it uses the devices in a _TZD package if they're 
> > > present.
> > > 
> > Hmm, ACPI thermal zone doesn't know how to throttle the devices in a
> > _TZD package, so I don't think we can use the _TZD devices.
> 
> If they have a _TZD, it's presumably because they need cooling.
Agree.

>  If the 
> kernel isn't going to be able to do that,
It is complicated to throttle devices in kernel.
Take this for example:
            Method (_TZD, 0, Serialized)
            {
                If (MPEN)
                {
                    Return (Package (0x04)
                    {
                        \_PR.P001,
                        \_PR.P002,
                        \_SB.PCI0.GFX0.DD04,
                        MEM0
                    })
                }

                Return (Package (0x04)
                {
                    \_SB.PCI0.GFX0.DD03,
                    \_SB.PCI0.GFX0.DD04,
                    \_PR.P001,
                    MEM0
                })
            }
ACPI thermal zone knows how to throttle a processor,
but it never knows how to throttle the LCD and memory controller.

Device throttling is implemented in its native driver, like ACPI
processor, ACPI video and intel_menlow etc, and all the driver may be
loaded as a module.
I don't like the idea of adding hooks like we do for processors.
what do you think?

>  what happens if the userspace 
> daemon crashes or fails to start for some reason? 
Well, the current solution depends on the userspace daemon.

A possible solution is to throttle the devices in the generic thermal
class, as only the generic thermal driver knows the temperature and trip
point info and know hows to throttle all the cooling devices in a
thermal zone. But I haven't thought about it carefully.

> 
> The alternative is to leave it as it is currently in my patch. If the 
> userspace daemon starts, it disables the ACPI control and will handle it 
> itself. If it doesn't start, the kernel does the only thing it can - 
> reduce the speed of the CPU.

it can work and it doesn't break the current flowchart on menlow.
but I still doubt if this is the right way to go.
As you said, a _TZD method means these devices need to be throttled when
overheating, it's also presumable that BIOS doesn't want to throttle the
processor for a thermal zone without _PSV, e.g. the thermal zone is for
the skin temperature and throttling the processor doesn't help.
anyway, a fake passive trip point is a little tricky IMO. :)

thanks,
rui


