From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Thu, 19 Mar 2015 10:17:27 +0000
Message-ID: <20150319101727.GC24556@red-moon>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <20150318190509.GM10863@arm.com>
 <550A4BFD.4070804@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36586 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbbCSKRZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Mar 2015 06:17:25 -0400
Content-Disposition: inline
In-Reply-To: <550A4BFD.4070804@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Will Deacon <Will.Deacon@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-ke>

On Thu, Mar 19, 2015 at 04:09:33AM +0000, Hanjun Guo wrote:
> On 2015/3/19 3:05, Will Deacon wrote:
> > Hanjun,
> 
> Hi Will,
> 
> >
> > On Wed, Mar 11, 2015 at 12:39:26PM +0000, Hanjun Guo wrote:
> >> This patch set already tested on multi platforms:
> >>  - AMD Seattle board;
> >>  - Cavium Thunder board;
> >>  - Huawei D02 board;
> >>  - Qualcomm ARM64 platform
> >>
> >> This version 10 patch set address some minor comments and collect ACKs and
> >> Reviewed-bys for v9:
> >>
> >>  - new Acks from Rafael, Olof, Grant, Lorenzo
> >>  - new way to handle typdef phys_cpuid_t which suggested by Rafael,
> >>    but no functional change
> >>  - Remove if(!phys) for early ioremappings
> >>  - Rework sleep function for ARM64
> >>  - Introduce linux/acpi_irq.h to hold acpi_irq_init()
> >>  - Disable ACPI if not HW_REDUCED_ACPI compliant
> >>  - Remove the doc of why ACPI on ARM
> > So I've had a look at the current state of this series and I think there
> > are a few immediate things left to do:
> >
> >   (1) Resolve the acpi=force cmdline issue highlighted by Lorenzo and
> >       Catalin
> 
> Sure, it will be done after the confirmation with Ard.
> 
> >
> >   (2) I believe Sudeep and Lorenzo have concerns about patch 13 (SMP init),
> >       so I'm assuming there will be additional patches from them that are
> >       required.
> 
> Sorry, I assume that it is about the print information for PSCI absent for SMP init, right?

Not only that, Sudeep has a patch to consolidate DT and ACPI SMP code,
I am working on it, I do not think it should be a blocking point, patch
coming asap on top of your series.

Lorenzo
