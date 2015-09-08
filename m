From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/5] ACPI probing infrastructure
Date: Tue, 08 Sep 2015 10:45:58 +0100
Message-ID: <55EEAE56.9070804@arm.com>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com> <3667410.80mLyhGuXy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53698 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbbIHJqC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Sep 2015 05:46:02 -0400
In-Reply-To: <3667410.80mLyhGuXy@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/09/15 22:26, Rafael J. Wysocki wrote:
> On Friday, September 04, 2015 06:06:47 PM Marc Zyngier wrote:
>> IRQ controllers and timers are the two types of device the kernel
>> requires before being able to use the device driver model.
>>
>> ACPI so far lacks a proper probing infrastructure similar to the one
>> we have with DT, where we're able to declare IRQ chips and
>> clocksources inside the driver code, and let the core code pick it up
>> and call us back on a match. This leads to all kind of really ugly
>> hacks all over the arm64 code and even in the ACPI layer.
>>
>> It turns out that providing such a probing infrastructure is rather
>> easy, and provides a much deserved cleanup in both the arch code, the
>> GIC driver, and the architected timer driver.
> 
> Since I'm not familiar with the DT probing infrastructure mentioned above,
> can you please explain to me (possibly at a high level), how it is supposed
> to work in the ACPI case?

So let's start with DT. Each interrupt controller driver has at least
one entry like this:

IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);

which says: if you find a node having "arm,gic-400" as a compatible
string in the device tree, then call gic_of_init with this node as a
parameter. The probing itself is done by the OF layer when the
architecture code calls of_irq_init() (usually via irqchip_init).

This has a number of benefits:

- The irqchip code is self-contained. No architecture specific entry
point, no exposed symbols. Just a standard interface.

- The low-level architecture code doesn't have to know about which
interrupt controller is present. It just calls into the firmware
interface (of_irq_init) which is going to sort things out.

Similar infrastructure is provided for the timers/clock sources. Note
that this is not a replacement for the device model, but acts as a
probing infrastructure for things that are required too early for the
device infrastructure to be available.

What I'm aiming for is to introduce the same level of abstraction for
ACPI, or at least for the few bits that are required before a full blown
ACPI/device model can be used. For this, I introduce something  vaguely
similar:

IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
		     gic_validate_dist, ACPI_MADT_GIC_VERSION_V2,
		     gic_v2_acpi_init);

which says: if you find a ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR entry in
MADT (implied by the macro), and that entry is of type
ACPI_MADT_GIC_VERSION_V2 (as checked by gic_validate_dist), then call
gic_v2_acpi_init with the entry as a parameter. A bit more convoluted,
but still without any special entry point.

The various interrupt controller drivers can then implement the above,
and the arch code can use a firmware-specific call to get the probing
done, still being oblivious of what interrupt controller is being used.
It also makes the adaptation of a DT driver to ACPI easier.

Does this help?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
