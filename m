From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 7/7] irqchip/al-msi: Add ACPI support
Date: Fri, 12 Apr 2019 13:08:00 +0100
Message-ID: <a882317e-1f19-3bed-b790-10b8b8a3e839@arm.com>
References: <1554035733-11827-1-git-send-email-hhhawa@amazon.com>
 <1554035733-11827-3-git-send-email-hhhawa@amazon.com>
 <86pnq65v48.wl-marc.zyngier@arm.com>
 <cc40b029-b06e-1367-2411-1ec325d3b97b@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cc40b029-b06e-1367-2411-1ec325d3b97b@amazon.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zeev Zilberman <zeev@amazon.com>, Hanna Hawa <hhhawa@amazon.com>
Cc: tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, ronenk@amazon.com, dwmw@amazon.co.uk, vaerov@amazon.com, alisaidi@amazon.com, talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com, barakw@amazon.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-acpi@vger.kernel.org

Hi Zeev,

On 04/04/2019 15:45, Zeev Zilberman wrote:
> Hi Marc,
> 
> We have considered exposing our interrupt controller both via MADT 
> OEM-specific entry and via DSDT.
> We've chosen MADT OEM-specific entry, because it seemed like a 
> reasonable placeholder for custom interrupt controller, but we can move 
> to DSDT, if this seems like a better way to represent it.
> 
> Either way we chose, we'll need to solve the ordering issue of the 
> drivers probing.
> The desired order of driver probing in the system, because of the 
> dependencies, is:
> GIC -> AL MSIX controller driver -> PCI
> If we keep using MADT, we can't just use IRQCHIP_DECLARE, because there 
> is no way we found to control ordering of MADT probing. So, GIC might be 
> probed after our driver in this case.
> The reason we used early_initcall, is that the early_initcalls are 
> invoked after MADT probing in the system (and before DSDT probing).
> 
> If we move to using DSDT we need to solve the ordering problem from 
> another direction - make sure that MSIX driver is probed before PCI.
> In the patches that were posted for xgene interrupt controller (and 
> weren't accepted) we saw that they proposed to solve the same issue
> by modifying ACPI subsystem code by defining a new type for msi drivers 
> and probing them before PCI drivers 
> (https://patchwork.ozlabs.org/patch/818771/).
>  From the feedback on that patch 
> (https://patchwork.ozlabs.org/cover/818767/#1788415) it seemed that 
> alternative solution is in the works,
> but we didn't manage to find any followup on this.
> 
> We would be glad to hear what you propose for fixing the ordering issue 
> and rework the patches accordingly.

There are multiple issues here, but the main one is that you're trying
to do something that is completely contrary to the ACPI spec by
inventing a new interrupt controller.

The use case for ACPI is quite simple: you have HW that matches the ACPI
spec, and everything will work out of the box. This means GICv2+GICv2m
or GICv3+ITS. There is zero space for creativity. Now, if you want your
own interrupt controller, the only choice is to stick with DT. That's
the place for weird and wonderful stuff that ACPI cannot support.

We've been around the block with XGene, and every "solution" was just
utter crap, prone to failure and in the end unmaintainable. Anything
involving an initcall definitely falls into that category.

I'll let Lorenzo speak his mind as the arm64 ACPI maintainer, but from
an irqchip perspective, I can't see how to support this unless we get
the ACPI spec to support this type of configuration.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
