From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Tue, 24 Mar 2015 15:02:53 -0700
Message-ID: <20150324220253.9595AC407F8@trevor.secretlab.ca>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
	<20150318190509.GM10863@arm.com> <550A4BFD.4070804@huawei.com>
	<20150319101727.GC24556@red-moon> <20150319193927.GG4751@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35586 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbCYGzh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2015 02:55:37 -0400
Received: by pagj7 with SMTP id j7so19165689pag.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2015 23:55:37 -0700 (PDT)
In-Reply-To: <20150319193927.GG4751@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "guohanjun@huawei.com" <guohanjun@huawei.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi@lists.

On Thu, 19 Mar 2015 19:39:27 +0000
, Will Deacon <will.deacon@arm.com>
 wrote:
> On Thu, Mar 19, 2015 at 10:17:27AM +0000, Lorenzo Pieralisi wrote:
> > On Thu, Mar 19, 2015 at 04:09:33AM +0000, Hanjun Guo wrote:
> > > On 2015/3/19 3:05, Will Deacon wrote:
> > > > On Wed, Mar 11, 2015 at 12:39:26PM +0000, Hanjun Guo wrote:
> > > >> This patch set already tested on multi platforms:
> > > >>  - AMD Seattle board;
> > > >>  - Cavium Thunder board;
> > > >>  - Huawei D02 board;
> > > >>  - Qualcomm ARM64 platform
> > > >>
> > > >> This version 10 patch set address some minor comments and collect ACKs and
> > > >> Reviewed-bys for v9:
> > > >>
> > > >>  - new Acks from Rafael, Olof, Grant, Lorenzo
> > > >>  - new way to handle typdef phys_cpuid_t which suggested by Rafael,
> > > >>    but no functional change
> > > >>  - Remove if(!phys) for early ioremappings
> > > >>  - Rework sleep function for ARM64
> > > >>  - Introduce linux/acpi_irq.h to hold acpi_irq_init()
> > > >>  - Disable ACPI if not HW_REDUCED_ACPI compliant
> > > >>  - Remove the doc of why ACPI on ARM
> > > > So I've had a look at the current state of this series and I think there
> > > > are a few immediate things left to do:
> > > >
> > > >   (1) Resolve the acpi=force cmdline issue highlighted by Lorenzo and
> > > >       Catalin
> > > 
> > > Sure, it will be done after the confirmation with Ard.
> > > 
> > > >
> > > >   (2) I believe Sudeep and Lorenzo have concerns about patch 13 (SMP init),
> > > >       so I'm assuming there will be additional patches from them that are
> > > >       required.
> > > 
> > > Sorry, I assume that it is about the print information for PSCI absent for SMP init, right?
> > 
> > Not only that, Sudeep has a patch to consolidate DT and ACPI SMP code,
> > I am working on it, I do not think it should be a blocking point, patch
> > coming asap on top of your series.
> 
> Well, I don't really want to merge the series without those patches so I
> do think it blocks the code from getting into mainline.

Really? It's a pretty minor duplication problem and it's been identified
as something requiring refactoring to both the ACPI and DT code. It
isn't at all dangerous. Why is this a blocking point?

g.

