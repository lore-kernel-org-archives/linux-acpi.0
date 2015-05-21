From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 10/11] irqchip / GICv2 / ACPI: Consolidate GICv2 ACPI
 related init code
Date: Thu, 21 May 2015 22:27:54 +0800
Message-ID: <555DEB6A.8090404@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org> <1431953961-22706-11-git-send-email-hanjun.guo@linaro.org> <555CF23B.1000002@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34532 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbbEUO2D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2015 10:28:03 -0400
Received: by pabru16 with SMTP id ru16so107169452pab.1
        for <linux-acpi@vger.kernel.org>; Thu, 21 May 2015 07:28:02 -0700 (PDT)
In-Reply-To: <555CF23B.1000002@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2015=E5=B9=B405=E6=9C=8821=E6=97=A5 04:44, Tomasz Nowicki wrote:
> Hi Hanjun,
>
> On 05/18/2015 02:59 PM, Hanjun Guo wrote:
>> Move GICv2 ACPI related init code in irq-gic.c to irq-gic-acpi.c,
>> this can make the ACPI related GIC init code slef-contained.
>>
>> Introduce set_acpi_core_irqdomain() to set acpi_irqdomain then
>> it will be no need to make gic_data[] as a global value, and
>> it will save the confilcts with GICv3's gic_data in the later
>> patch.
>>
>> acpi_gic_parse_distributor() have the same function as
>> gic_acpi_parse_madt_distributor() to get the GIC distributor
>> physical base address, so just remove the duplicate one, and
>> only get the GIC version when it is unknown.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/irqchip/irq-gic-acpi.c       |  95
>> +++++++++++++++++++++++++++++++-
>>   drivers/irqchip/irq-gic.c            | 103
>> +----------------------------------
>>   include/linux/irqchip/arm-gic-acpi.h |   5 ++
>>   3 files changed, 101 insertions(+), 102 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-acpi.c
>> b/drivers/irqchip/irq-gic-acpi.c
>> index 1388d9e..8463e48 100644
>> --- a/drivers/irqchip/irq-gic-acpi.c
>> +++ b/drivers/irqchip/irq-gic-acpi.c
>> @@ -13,12 +13,16 @@
>>
>>   #include <linux/acpi.h>
>>   #include <linux/init.h>
>> +#include <linux/irqchip/arm-gic.h>
>>   #include <linux/irqchip/arm-gic-acpi.h>
>>   #include <linux/irqchip/arm-gic-v3.h>
>
> arm-gic.h and arm-gic-v3.h describe register map for respective drive=
rs
> and should be used separately within parent driver only.

Seems that there is no duplicate macros in that two head
file, but yes, it will confuse people.

Consolidating all ACPI GIC code is an improvement to make
ACPI related code self-contained, but also have some drawbacks,

Marc, what do you think?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
