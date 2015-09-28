From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/5] ACPI probing infrastructure
Date: Mon, 28 Sep 2015 15:53:52 +0200
Message-ID: <39030379.kalO2V72FV@vostro.rjw.lan>
References: <1442152943-24493-1-git-send-email-marc.zyngier@arm.com> <1698028.ftHN1K8oZa@vostro.rjw.lan> <560939A7.3030603@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64930 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757367AbbI1NZe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Sep 2015 09:25:34 -0400
In-Reply-To: <560939A7.3030603@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday, September 28, 2015 01:59:19 PM Marc Zyngier wrote:
> Hi Rafael,
> 
> On 26/09/15 00:45, Rafael J. Wysocki wrote:
> 
> >> Marc Zyngier (5):
> >>   acpi: Add basic device probing infrastructure
> >>   irqchip/acpi: Add probing infrastructure for ACPI-based irqchips
> >>   irqchip/gic: Convert the GIC driver to ACPI probing
> >>   clocksource/acpi: Add probing infrastructure for ACPI-based
> >>     clocksources
> >>   clocksource/arm_arch_timer: Convert to ACPI probing
> > 
> > I'm generally fine with this (modulo a couple of super-minor nits in the
> > first patch), but it needs ACKs from Thomas for the irqchip-related and
> > clocksource-related patches.
> 
> Sure. I've now addressed your comments, and I'll post the updated series
> later today.
> 
> > Plus [3/5] needs to be rebased on top of the Al's patches removing BAD_MADT_ENTRY
> > (currently in my bleeding-edge branch).
> 
> Al's patches were there on Friday, but vanished over the weekend. Do you
> have another (stable?) branch with these patches in (assuming they are
> still aimed at 4.4)?

The Al's patches are gone for now, because they introduced a 0-day testing
regression.

I guess this means I can apply your patches first and ask Al to rebase his
next version on them.

Thanks,
Rafael

