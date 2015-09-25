From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/5] ACPI probing infrastructure
Date: Sat, 26 Sep 2015 01:45:42 +0200
Message-ID: <1698028.ftHN1K8oZa@vostro.rjw.lan>
References: <1442152943-24493-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61390 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753389AbbIYXR2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2015 19:17:28 -0400
In-Reply-To: <1442152943-24493-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sunday, September 13, 2015 03:02:18 PM Marc Zyngier wrote:
> IRQ controllers and timers are the two types of device the kernel
> requires before being able to use the device driver model.
> 
> The Device Tree infrastructure makes it very easy to make these
> discoverable by the rest of the kernel. For example, each interrupt
> controller driver has at least one entry like this:
> 
> IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);
> 
> which says: if you find a node having "arm,gic-400" as a compatible
> string in the device tree, then call gic_of_init with this node as a
> parameter. The probing itself is done by the OF layer when the
> architecture code calls of_irq_init() (usually via irqchip_init).
> 
> This has a number of benefits:
> 
> - The irqchip code is self-contained. No architecture specific entry
> point, no exposed symbols. Just a standard interface.
> 
> - The low-level architecture code doesn't have to know about which
> interrupt controller is present. It just calls into the firmware
> interface (of_irq_init) which is going to sort things out.
> 
> Similar infrastructure is provided for the timers/clock sources. Note
> that this is not a replacement for the device model, but acts as a
> probing infrastructure for things that are required too early for the
> device infrastructure to be available.
> 
> What I'm aiming for is to introduce the same level of abstraction for
> ACPI, or at least for the few bits that are required before a full blown
> ACPI/device model can be used. For this, I introduce something vaguely
> similar:
> 
> IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
> 		     gic_validate_dist, ACPI_MADT_GIC_VERSION_V2,
> 		     gic_v2_acpi_init);
> 
> which says: if you find a ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR entry in
> MADT (implied by the macro), and that entry is of type
> ACPI_MADT_GIC_VERSION_V2 (as checked by gic_validate_dist), then call
> gic_v2_acpi_init with the entry as a parameter. A bit more convoluted,
> but still without any special entry point.
> 
> The various interrupt controller drivers can then implement the above,
> and the arch code can use a firmware-specific call to get the probing
> done, still oblivious to what interrupt controller is being used. It
> also makes the adaptation of a DT driver to ACPI easier.
> 
> It turns out that providing such a probing infrastructure is rather
> easy, and provides a much deserved cleanup in both the arch code, the
> GIC driver, and the architected timer driver.
> 
> I'm sure there is some more code to be deleted, and one can only
> wonder why this wasn't done before the arm64 code was initially merged
> (the diffstat says it all...).
> 
> Patches are against v4.3-rc1, and a branch is available at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git acpi/device-probing-v2
> 
> * From the initial version:
>   - Make the infrastructure more DT like by providing an
>     acpi_probe_entry array per "device type" (one for irqchips, one
>     for clocksources). This means that entries can depend on any ACPI
>     static table.
>   - Use some cpp magic to reduce the amount of code added to an
>     absolute minimum.
>   - Rebased on v4.3-rc1
> 
> Marc Zyngier (5):
>   acpi: Add basic device probing infrastructure
>   irqchip/acpi: Add probing infrastructure for ACPI-based irqchips
>   irqchip/gic: Convert the GIC driver to ACPI probing
>   clocksource/acpi: Add probing infrastructure for ACPI-based
>     clocksources
>   clocksource/arm_arch_timer: Convert to ACPI probing

I'm generally fine with this (modulo a couple of super-minor nits in the
first patch), but it needs ACKs from Thomas for the irqchip-related and
clocksource-related patches.

Plus [3/5] needs to be rebased on top of the Al's patches removing BAD_MADT_ENTRY
(currently in my bleeding-edge branch).

Thanks,
Rafael

