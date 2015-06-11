From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 10/11] irqchip / GICv2 / ACPI: Consolidate GICv2 ACPI
 related init code
Date: Thu, 11 Jun 2015 21:25:34 +0800
Message-ID: <55798C4E.8070903@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org> <1431953961-22706-11-git-send-email-hanjun.guo@linaro.org> <555CF23B.1000002@linaro.org> <555DEB6A.8090404@linaro.org> <557865FB.1010502@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35267 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbbFKNZr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2015 09:25:47 -0400
Received: by pdbnf5 with SMTP id nf5so4449302pdb.2
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2015 06:25:46 -0700 (PDT)
In-Reply-To: <557865FB.1010502@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

Hi Marc,

On 06/11/2015 12:29 AM, Marc Zyngier wrote:
> On 21/05/15 15:27, Hanjun Guo wrote:
>> On 2015=E5=B9=B405=E6=9C=8821=E6=97=A5 04:44, Tomasz Nowicki wrote:
>>> Hi Hanjun,
>>>
>>> On 05/18/2015 02:59 PM, Hanjun Guo wrote:
>>>> Move GICv2 ACPI related init code in irq-gic.c to irq-gic-acpi.c,
>>>> this can make the ACPI related GIC init code slef-contained.
>>>>
>>>> Introduce set_acpi_core_irqdomain() to set acpi_irqdomain then
>>>> it will be no need to make gic_data[] as a global value, and
>>>> it will save the confilcts with GICv3's gic_data in the later
>>>> patch.
>>>>
>>>> acpi_gic_parse_distributor() have the same function as
>>>> gic_acpi_parse_madt_distributor() to get the GIC distributor
>>>> physical base address, so just remove the duplicate one, and
>>>> only get the GIC version when it is unknown.
>>>>
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> ---
>>>>    drivers/irqchip/irq-gic-acpi.c       |  95
>>>> +++++++++++++++++++++++++++++++-
>>>>    drivers/irqchip/irq-gic.c            | 103
>>>> +----------------------------------
>>>>    include/linux/irqchip/arm-gic-acpi.h |   5 ++
>>>>    3 files changed, 101 insertions(+), 102 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-acpi.c
>>>> b/drivers/irqchip/irq-gic-acpi.c
>>>> index 1388d9e..8463e48 100644
>>>> --- a/drivers/irqchip/irq-gic-acpi.c
>>>> +++ b/drivers/irqchip/irq-gic-acpi.c
>>>> @@ -13,12 +13,16 @@
>>>>
>>>>    #include <linux/acpi.h>
>>>>    #include <linux/init.h>
>>>> +#include <linux/irqchip/arm-gic.h>
>>>>    #include <linux/irqchip/arm-gic-acpi.h>
>>>>    #include <linux/irqchip/arm-gic-v3.h>
>>>
>>> arm-gic.h and arm-gic-v3.h describe register map for respective dri=
vers
>>> and should be used separately within parent driver only.
>>
>> Seems that there is no duplicate macros in that two head
>> file, but yes, it will confuse people.
>>
>> Consolidating all ACPI GIC code is an improvement to make
>> ACPI related code self-contained, but also have some drawbacks,
>>
>> Marc, what do you think?
>
> What I think is "Over my dead body".
>
> These include files are private to the respective interrupt controlle=
r
> code, and the only reason they are in linux/irqchip is because the
> corresponding KVM support code uses them too.

So for this patch, we are totally in the wrong direction, I will
remove the last two patches in next version.

Thanks for your constructive comments, much appreciated :)

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
