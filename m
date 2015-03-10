From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v9 08/21] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
Date: Tue, 10 Mar 2015 17:21:15 +0800
Message-ID: <54FEB78B.5040005@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org> <20150306183157.GC26888@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150306183157.GC26888@e102568-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B403=E6=9C=8807=E6=97=A5 02:31, Lorenzo Pieralisi wrote:
> On Wed, Feb 25, 2015 at 08:39:48AM +0000, Hanjun Guo wrote:
>
> [...]
>
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index 6f93c24..4095379 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -10,6 +10,7 @@
>>    *
>>    */
>>
>> +#include <linux/acpi.h>
>>   #include <linux/init.h>
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>> @@ -46,3 +47,27 @@ int pcibios_add_device(struct pci_dev *dev)
>>
>>   	return 0;
>>   }
>> +
>> +/*
>> + * raw_pci_read/write - Platform-specific PCI config space access.
>> + */
>> +int raw_pci_read(unsigned int domain, unsigned int bus,
>> +		  unsigned int devfn, int reg, int len, u32 *val)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +int raw_pci_write(unsigned int domain, unsigned int bus,
>> +		unsigned int devfn, int reg, int len, u32 val)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>
> It would be nice to see:
>
> https://lkml.org/lkml/2015/2/27/264
>
> merged at the same time, so that the two functions above disappear :)

I hope so, but MMCONFIG patches are being taken care of by Bjorn, it
would be nice to merge them through different tree (and it no harms),
and remove those two function when introducing the implementation
of pci_acpi_scan_root() in later patches.

Thanks
Hanjun
