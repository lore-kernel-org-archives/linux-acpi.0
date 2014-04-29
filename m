From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 part1 08/11] ARM64 / ACPI: Introduce PCI functions
 for ACPI on ARM64
Date: Tue, 29 Apr 2014 16:44:37 +0800
Message-ID: <535F6675.1060109@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org> <1398432017-8506-9-git-send-email-hanjun.guo@linaro.org> <201404281549.50738.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:37203 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbaD2IpB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2014 04:45:01 -0400
Received: by mail-pa0-f44.google.com with SMTP id ey11so4967535pad.17
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2014 01:45:00 -0700 (PDT)
In-Reply-To: <201404281549.50738.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@linaro.org>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, linaro-acpi@lists.linaro.org, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>

Hi Arnd,

On 2014-4-28 21:49, Arnd Bergmann wrote:
> On Friday 25 April 2014, Hanjun Guo wrote:
>> CONFIG_ACPI depends CONFIG_PCI now, and ACPI provides ACPI based
>> PCI hotplug and PCI host bridge hotplug, introduce some PCI
>> functions to make ACPI core can be compiled, some of the functions
>> should be revisited when implemented on ARM64.
> 
>> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
>> index d93576f..0aa3607 100644
>> --- a/arch/arm64/include/asm/pci.h
>> +++ b/arch/arm64/include/asm/pci.h
>> @@ -21,6 +21,17 @@ struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
>>  #define pcibios_assign_all_busses() \
>>  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
>>  
>> +static inline void pcibios_penalize_isa_irq(int irq, int active)
>> +{
>> +	/* we don't do dynamic pci irq allocation */
>> +}
>> +
>> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>> +{
>> +	/* no legacy IRQ on arm64 */
>> +	return -ENODEV;
>> +}
>> +
> 
> I think these would be better addressed in the caller. From what I can tell, they
> are only called by the ISAPNP code path for doing IRQ resource allocation, while
> the ACPIPNP code uses hardwired IRQ resources.

I agree. pcibios_penalize_isa_irq() is only used by x86 and I will send out a
patch to make pcibios_penalize_isa_irq() as __weak in PCI core and remove
all the stub function out except x86. For pci_get_legacy_ide_irq(), I think we
can fix it in the same way, does this make sense to you?

> 
>> @@ -171,3 +172,36 @@ unsigned long pci_ioremap_io(const struct resource *res, phys_addr_t phys_addr)
>>  	/* return io_offset */
>>  	return start * PAGE_SIZE - res->start;
>>  }
>> +
>> +/*
>> + * raw_pci_read - Platform-specific PCI config space access.
>> + *
>> + * Default empty implementation.  Replace with an architecture-specific setup
>> + * routine, if necessary.
>> + */
>> +int raw_pci_read(unsigned int domain, unsigned int bus,
>> +		  unsigned int devfn, int reg, int len, u32 *val)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +int raw_pci_write(unsigned int domain, unsigned int bus,
>> +		  unsigned int devfn, int reg, int len, u32 val)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +#ifdef CONFIG_ACPI
>> +/* Root bridge scanning */
>> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>> +{
>> +	/* TODO: Should be revisited when implementing PCI on ACPI */
>> +	return NULL;
>> +}
>> +
>> +void __init pci_acpi_crs_quirks(void)
>> +{
>> +	/* Do nothing on ARM64 */
>> +	return;
>> +}
>> +#endif
> 
> And these probably don't need to be done at the architecture level. I expect we
> will only have to worry about SBSA compliant PCI hosts, so this can be done in
> the host controller driver for compliant devices, which is probably the one
> that Will Deacon is working on already.
> 
> Note that we are aiming for an empty PCI implementation in ARM64, doing everything
> in either the PCI core or in the individual host drivers.

Ok, I will review Will Deacon's patch to find out the solution for
pci_acpi_scan_root().

> 
> For pci_acpi_crs_quirks(), it's probably enough to stub out the declaration and
> to make it x86 specific. ia64 already doesn't use it, and we can hope we won't
> need it for arm64 either.

Yes, I agree, thanks a lot for the great suggestion :)
I will send out a patch to address this according to your advice.

> 
> For raw_pci_{read,write} we can have a trivial generic implementation in
> the PCI core, like
> 
> int __weak raw_pci_read(unsigned int domain, unsigned int bus,
> 		  unsigned int devfn, int reg, int len, u32 *val)
> {
> 	struct pci_bus *bus = pci_find_bus(domain, bus);
> 	if (!bus)
> 		return -ENODEV;
> 
> 	return bus->ops->read(bus, devfn, reg, len, val);
> }
> 
> which won't work on x86 or ia64, but should be fine everywhere else. Alternatively,
> you can change the ACPI code to do the above manually and call the architecture
> independent interfaces, either bus->ops->read, or pci_bus_read_config_{byte,word,dword},
> which would actually simplify the ACPI code.

This may not work. ACPI needs to be able to access PCI config space before
we've done a PCI bus scan and created pci_bus structures, so the pointer
of bus will be NULL.

Thanks
Hanjun

