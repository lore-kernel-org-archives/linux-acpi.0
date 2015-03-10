From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v9 08/21] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
Date: Tue, 10 Mar 2015 17:34:59 +0800
Message-ID: <54FEBAC3.9050804@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org> <20150309150119.GG16268@e106497-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46614 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbCJJfI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2015 05:35:08 -0400
Received: by pabli10 with SMTP id li10so324635pab.13
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2015 02:35:07 -0700 (PDT)
In-Reply-To: <20150309150119.GG16268@e106497-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kern>

On 2015=E5=B9=B403=E6=9C=8809=E6=97=A5 23:01, Liviu Dudau wrote:
> On Wed, Feb 25, 2015 at 08:39:48AM +0000, Hanjun Guo wrote:
>> CONFIG_ACPI depends CONFIG_PCI on x86 and ia64, in ARM64 server
>> world we will have PCIe in most cases, but some of them may not,
>> make CONFIG_ACPI depend CONFIG_PCI on ARM64 will satisfy both.
>>
>> With that case, we need some arch dependent PCI functions to
>> access the config space before the PCI root bridge is created, and
>> pci_acpi_scan_root() to create the PCI root bus. So introduce
>> some stub function here to make ACPI core compile and revisit
>> them later when implemented on ARM64.
>>
>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Tested-by: Jon Masters <jcm@redhat.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Tested-by: Robert Richter <rrichter@cavium.com>
>> Acked-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/pci.h |  6 ++++++
>>   arch/arm64/kernel/pci.c      | 25 +++++++++++++++++++++++++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/p=
ci.h
>> index 872ba93..fded096 100644
>> --- a/arch/arm64/include/asm/pci.h
>> +++ b/arch/arm64/include/asm/pci.h
>> @@ -24,6 +24,12 @@
>>    */
>>   #define PCI_DMA_BUS_IS_PHYS	(0)
>
> Hanjun,

Hi Liviu,

>
>>
>> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int c=
hannel)
>> +{
>> +	/* no legacy IRQ on arm64 */
>> +	return -ENODEV;
>> +}
>> +
>
> Could you explain to me what situation you encountered where you need=
ed
> to define this? I'm trying to figure out when this would be needed an=
d the
> only thing I can come up with would be for drivers/pnp/resource.c, bu=
t that
> is guarded by #ifdef CONFIG_PCI, which would mean that you should mov=
e this
> a bit further down in the file,

Agreed, will move it to #ifdef CONFIG_PCI .. #endif.

> but also contradicts the last comment on
> this patch (i.e. PCI on ACPI is not really implemented, so presumably
> CONFIG_PCI is not enabled?)

CONFIG_ACPI depends on CONFIG_PCI in the Kconfig, so CONFIG_PCI will be
enabled even PCI on ACPI is not really implemented now, did I
understand your question correctly?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
