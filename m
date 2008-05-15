From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware doesn't define one
Date: Thu, 15 May 2008 12:40:16 +0100
Message-ID: <20080515114016.GA22798@srcf.ucam.org>
References: <20080514010820.GD21608@srcf.ucam.org> <200805132330.20159.lenb@kernel.org> <20080514093304.GB28678@srcf.ucam.org> <1210812916.2929.6.camel@rzhang-crestline.sh.intel.com> <20080515010426.GA13927@srcf.ucam.org> <1210814699.2929.10.camel@rzhang-crestline.sh.intel.com> <20080515015831.GA14829@srcf.ucam.org> <1210817739.2929.24.camel@rzhang-crestline.sh.intel.com> <20080515022431.GA15085@srcf.ucam.org> <1210820783.2929.55.camel@rzhang-crestline.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42402 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbYEOLkn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 07:40:43 -0400
Content-Disposition: inline
In-Reply-To: <1210820783.2929.55.camel@rzhang-crestline.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, May 15, 2008 at 11:06:23AM +0800, Zhang Rui wrote:
> On Thu, 2008-05-15 at 03:24 +0100, Matthew Garrett wrote:

> ACPI thermal zone knows how to throttle a processor,
> but it never knows how to throttle the LCD and memory controller.
>
> Device throttling is implemented in its native driver, like ACPI
> processor, ACPI video and intel_menlow etc, and all the driver may be
> loaded as a module.
> I don't like the idea of adding hooks like we do for processors.
> what do you think?

I think it would be beneficial if the ACPI thermal code could call into 
the native device code, kind of like the processor thermal code does 
with cpufreq. But that's for the future, rather than something I'm 
worried about now. Doing that through the generic thermal code rather 
than the ACPI layer itself seems like the right way to do it, assuming 
that we can tie all the physical devices to their ACPI handles.
 
> > The alternative is to leave it as it is currently in my patch. If the 
> > userspace daemon starts, it disables the ACPI control and will handle it 
> > itself. If it doesn't start, the kernel does the only thing it can - 
> > reduce the speed of the CPU.
> 
> it can work and it doesn't break the current flowchart on menlow.
> but I still doubt if this is the right way to go.
> As you said, a _TZD method means these devices need to be throttled when
> overheating, it's also presumable that BIOS doesn't want to throttle the
> processor for a thermal zone without _PSV, e.g. the thermal zone is for
> the skin temperature and throttling the processor doesn't help.
> anyway, a fake passive trip point is a little tricky IMO. :)

Like I said, if the device is within 5 degrees of a critical shutdown 
then it seems likely that it's going to power off in the near future 
unless we do something about it. If the BIOS doesn't provide a passive 
zone or a _TZD package, then the only thing we can do is throttle the 
CPU. It might help, or it might not - but it's certainly not going to 
icnrease the instantaneous heat load on the device.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
