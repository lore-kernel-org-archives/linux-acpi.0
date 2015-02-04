From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 06/21] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
Date: Wed, 04 Feb 2015 17:06:15 +0800
Message-ID: <54D1E107.9000307@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <20150203121546.GD3677@e104818-lin.cambridge.arm.com> <54D0CD58.2000609@linaro.org> <2157836.CgDKH4QWp1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35843 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbBDJG0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 04:06:26 -0500
Received: by mail-pa0-f43.google.com with SMTP id eu11so1150588pac.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2015 01:06:26 -0800 (PST)
In-Reply-To: <2157836.CgDKH4QWp1@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.o>

On 2015=E5=B9=B402=E6=9C=8803=E6=97=A5 22:55, Rafael J. Wysocki wrote:
> On Tuesday, February 03, 2015 09:30:00 PM Hanjun Guo wrote:
>> On 2015=E5=B9=B402=E6=9C=8803=E6=97=A5 20:15, Catalin Marinas wrote:
>>> On Mon, Feb 02, 2015 at 12:45:34PM +0000, Hanjun Guo wrote:
>>>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>>>> index ce5836c..c17e7ea 100644
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
>>>> @@ -68,3 +69,27 @@ void pci_bus_assign_domain_nr(struct pci_bus *b=
us, struct device *parent)
>>>>    	bus->domain_nr =3D domain;
>>>>    }
>>>>    #endif
>>>> +
>>>> +/*
>>>> + * raw_pci_read/write - Platform-specific PCI config space access=
=2E
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
>>>
>>> You said you'll make these return -ENOSYS, which I think makes more
>>> sense.
>>
>> I'm sorry, I missed that, my bad, I will fix that in next version.
>
> Actually, -ENOSYS *specifically* means "not implemented system call".
> It should not be used for anything other than that.  -ENXIO is what
> should be used instead.

Thanks for the suggestion :)

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
