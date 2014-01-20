From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 06/20] ARM64 / ACPI: Introduce some PCI functions when
 PCI is enabled
Date: Mon, 20 Jan 2014 16:08:01 +0800
Message-ID: <52DCD961.70303@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-7-git-send-email-hanjun.guo@linaro.org> <201401171504.24525.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:59050 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbaATIJg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jan 2014 03:09:36 -0500
Received: by mail-pd0-f171.google.com with SMTP id g10so5823152pdj.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jan 2014 00:09:36 -0800 (PST)
In-Reply-To: <201401171504.24525.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com

On 2014-1-17 22:04, Arnd Bergmann wrote:
> On Friday 17 January 2014, Hanjun Guo wrote:
>> +++ b/arch/arm64/pci/Makefile
>> @@ -0,0 +1 @@
>> +obj-y                 += pci.o
>> diff --git a/arch/arm64/pci/pci.c b/arch/arm64/pci/pci.c
>> new file mode 100644
>> index 0000000..4e46790
>> --- /dev/null
>> +++ b/arch/arm64/pci/pci.c
>> @@ -0,0 +1,33 @@
>> +#include <linux/acpi.h>
>> +#include <linux/types.h>
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +
>> +/**
>> + * raw_pci_read - Platform-specific PCI config space access.
>> + *
>> + * Default empty implementation.  Replace with an architecture-specific setup
>> + * routine, if necessary.
>> + */
>> +int __weak raw_pci_read(unsigned int domain, unsigned int bus,
>> +			unsigned int devfn, int reg, int len, u32 *val)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +int __weak raw_pci_write(unsigned int domain, unsigned int bus,
>> +			unsigned int devfn, int reg, int len, u32 val)
>> +{
>> +	return -EINVAL;
>> +}
> 
> I'd rather not see __weak functions here. Just provide them unconditionally
> so that we can add a proper implementation when needed. You could also
> define these as 'static inline' in a header file to keep them from consuming
> space in the object code.

Ok, I will remove __weak in next version.

> 
>> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
>> index 3c8521d..1835b21 100644
>> --- a/drivers/acpi/plat/arm-core.c
>> +++ b/drivers/acpi/plat/arm-core.c
>> @@ -100,6 +100,25 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>>  
>> +int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
>> +{
>> +	return -1;
>> +}
>> +
>> +int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
>> +{
>> +	/* TBD */
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(acpi_register_ioapic);
>> +
>> +int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
>> +{
>> +	/* TBD */
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(acpi_unregister_ioapic);
>> +
> 
> My feeling is that these are better handled in the ACPI code by not
> calling them on architectures that have no ISA or no IOAPIC support.
> 
> We have configuration symbols for both, so you don't have to make
> it depend on CONFIG_ARM64 or CONFIG_X86.

Do you mean introduce a stub function when there is no ISA support?

acpi_register_ioapic()/acpi_unregister_ioapic() will be used for IOAPIC
hotplug and GIC distributor is something like IOAPIC on x86, so I think
these two functions can be reserved for future use.

Thanks
Hanjun
