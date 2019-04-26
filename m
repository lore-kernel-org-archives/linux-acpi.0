From: Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH 7/7] irqchip/al-msi: Add ACPI support
Date: Fri, 26 Apr 2019 11:49:06 +0200
Message-ID: <a1eb85a9-3fd0-db0a-67a5-8286afac875b@csgraf.de>
References: <1554035733-11827-1-git-send-email-hhhawa@amazon.com>
 <1554035733-11827-3-git-send-email-hhhawa@amazon.com>
 <86pnq65v48.wl-marc.zyngier@arm.com>
 <cc40b029-b06e-1367-2411-1ec325d3b97b@amazon.com>
 <a882317e-1f19-3bed-b790-10b8b8a3e839@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a882317e-1f19-3bed-b790-10b8b8a3e839@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Zeev Zilberman <zeev@amazon.com>, Hanna Hawa <hhhawa@amazon.com>
Cc: tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, ronenk@amazon.com, dwmw@amazon.co.uk, vaerov@amazon.com, alisaidi@amazon.com, talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com, barakw@amazon.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-acpi@vger.kernel.org

On 12.04.19 14:08, Marc Zyngier wrote:
> Hi Zeev,
> 
> On 04/04/2019 15:45, Zeev Zilberman wrote:
>> Hi Marc,
>>
>> We have considered exposing our interrupt controller both via MADT 
>> OEM-specific entry and via DSDT.
>> We've chosen MADT OEM-specific entry, because it seemed like a 
>> reasonable placeholder for custom interrupt controller, but we can move 
>> to DSDT, if this seems like a better way to represent it.
>>
>> Either way we chose, we'll need to solve the ordering issue of the 
>> drivers probing.
>> The desired order of driver probing in the system, because of the 
>> dependencies, is:
>> GIC -> AL MSIX controller driver -> PCI
>> If we keep using MADT, we can't just use IRQCHIP_DECLARE, because there 
>> is no way we found to control ordering of MADT probing. So, GIC might be 
>> probed after our driver in this case.
>> The reason we used early_initcall, is that the early_initcalls are 
>> invoked after MADT probing in the system (and before DSDT probing).
>>
>> If we move to using DSDT we need to solve the ordering problem from 
>> another direction - make sure that MSIX driver is probed before PCI.
>> In the patches that were posted for xgene interrupt controller (and 
>> weren't accepted) we saw that they proposed to solve the same issue
>> by modifying ACPI subsystem code by defining a new type for msi drivers 
>> and probing them before PCI drivers 
>> (https://patchwork.ozlabs.org/patch/818771/).
>>  From the feedback on that patch 
>> (https://patchwork.ozlabs.org/cover/818767/#1788415) it seemed that 
>> alternative solution is in the works,
>> but we didn't manage to find any followup on this.
>>
>> We would be glad to hear what you propose for fixing the ordering issue 
>> and rework the patches accordingly.
> 
> There are multiple issues here, but the main one is that you're trying
> to do something that is completely contrary to the ACPI spec by
> inventing a new interrupt controller.
> 
> The use case for ACPI is quite simple: you have HW that matches the ACPI
> spec, and everything will work out of the box. This means GICv2+GICv2m
> or GICv3+ITS. There is zero space for creativity. Now, if you want your
> own interrupt controller, the only choice is to stick with DT. That's
> the place for weird and wonderful stuff that ACPI cannot support.

I've had a quick chat about this with Marc at Linaro Connect and there
might be a 3rd viable option: Create a standard ACPI binding for
GICv3+MBI (akin to GICv2m) and use that.

Zeev, Hanna, what exactly is the reason you need to use your own MSI
translation engine here? Can't you just reuse the GICv3 built-in one?
After all, I would assume that your PCIe complex is able to send DMA
requests to external devices?

If you could, we could start working towards an ACPI definition for that
instead and make everyone happy.


Alex
