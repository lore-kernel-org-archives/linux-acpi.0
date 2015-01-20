From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v7 06/17] ARM64 / ACPI: Make PCI optional for ACPI on
 ARM64
Date: Tue, 20 Jan 2015 10:39:16 +0800
Message-ID: <54BDBFD4.7050207@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org> <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org> <20150116094913.GA13634@e104818-lin.cambridge.arm.com> <54BB51F1.8000900@linaro.org> <20150119104240.GE11835@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53370 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbATCjl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jan 2015 21:39:41 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so42446091pab.12
        for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2015 18:39:41 -0800 (PST)
In-Reply-To: <20150119104240.GE11835@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, wangyijing@huawei

On 2015=E5=B9=B401=E6=9C=8819=E6=97=A5 18:42, Catalin Marinas wrote:
> On Sun, Jan 18, 2015 at 06:25:53AM +0000, Hanjun Guo wrote:
>> On 2015=E5=B9=B401=E6=9C=8816=E6=97=A5 17:49, Catalin Marinas wrote:
>>> On Wed, Jan 14, 2015 at 03:04:54PM +0000, Hanjun Guo wrote:
>>>> --- a/arch/arm64/kernel/pci.c
>>>> +++ b/arch/arm64/kernel/pci.c
>>>> @@ -10,6 +10,7 @@
>>>>     *
>>>>     */
>>>>
>>>> +#include <linux/acpi.h>
>>>>    #include <linux/init.h>
>>>>    #include <linux/io.h>
>>>>    #include <linux/kernel.h>
>>>> @@ -68,3 +69,30 @@ void pci_bus_assign_domain_nr(struct pci_bus *b=
us, struct device *parent)
>>>>    	bus->domain_nr =3D domain;
>>>>    }
>>>>    #endif
>>>> +
>>>> +/*
>>>> + * raw_pci_read/write - Platform-specific PCI config space access=
=2E
>>>> + *
>>>> + * Default empty implementation.  Replace with an architecture-sp=
ecific setup
>>>> + * routine, if necessary.
>>>> + */
>>>> +int raw_pci_read(unsigned int domain, unsigned int bus,
>>>> +		  unsigned int devfn, int reg, int len, u32 *val)
>>>> +{
>>>> +	return -EINVAL;
>>>> +}
>>>> +
>>>> +int raw_pci_write(unsigned int domain, unsigned int bus,
>>>> +		unsigned int devfn, int reg, int len, u32 val)
>>>> +{
>>>> +	return -EINVAL;
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_ACPI
>>>> +/* Root bridge scanning */
>>>> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>>>> +{
>>>> +	/* TODO: Should be revisited when implementing PCI on ACPI */
>>>> +	return NULL;
>>>> +}
>>>> +#endif
> [...]
>>> When PCI is enabled and the above functions are compiled in, do the=
y
>>> need to return any useful data or just -EINVAL. Are they ever calle=
d?
>>
>> They will be called if PCI root bridge is defined in DSDT, should I
>> print some warning message before it is implemented?
>
> My point: do they need to return real data when a PCI root bridge is
> defined in DSDT or you always expect them to always return some -E*? =
Can
> you explain why?

Not always return -E* or NULL;

=46or raw_pci_read/write(), they are needed to access the PCI config sp=
ace
before the PCI root bus is created. so they will return 0 if access to
PCI config space is ok; pci_acpi_scan_root() will return root bus
pointer if it is successfully created.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
