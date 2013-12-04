From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and
 its related head file
Date: Wed, 04 Dec 2013 23:48:36 +0800
Message-ID: <529F4ED4.20500@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org> <20131203180300.GD16025@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41047 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932404Ab3LDPst (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 10:48:49 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so22590100pdj.17
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 07:48:48 -0800 (PST)
In-Reply-To: <20131203180300.GD16025@e106331-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Jon Masters <jonathan@jonmasters.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro>

+CC Lv Zheng

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 02:03, Mark Rutland wrote:
> On Tue, Dec 03, 2013 at 04:36:49PM +0000, Hanjun Guo wrote:
>> introduce arm_core.c and its related head file, after this patch,
>> we can get ACPI tables from BIOS on ARM64 now.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/acpi.h |   57 +++++++++++
>>   arch/arm64/kernel/setup.c     |    8 ++
>>   drivers/acpi/Makefile         |    2 +
>>   drivers/acpi/plat/Makefile    |    1 +
>>   drivers/acpi/plat/arm-core.c  |  219 +++++++++++++++++++++++++++++=
++++++++++++
>>   5 files changed, 287 insertions(+)
>>   create mode 100644 drivers/acpi/plat/Makefile
>>   create mode 100644 drivers/acpi/plat/arm-core.c
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/=
acpi.h
>> index c186f5b..e9444e4 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -19,6 +19,43 @@
>>   #ifndef _ASM_ARM_ACPI_H
>>   #define _ASM_ARM_ACPI_H
>>  =20
>> +#include <asm/cacheflush.h>
>> +
>> +#include <linux/init.h>
>> +
>> +#define COMPILER_DEPENDENT_INT64	long long
>> +#define COMPILER_DEPENDENT_UINT64	unsigned long long
> Given we've already pulled in linux/init.h, which has pulled in
> linux/types.h, is there any reason we can't use s64 and u64 here?
>
> If we can, then why don't we unify this further up so each arch doesn=
't
> have to define this redundantly?

It make sense to me, I didn't notice that before, Lv, any comments abou=
t it?

>> +
>> +/*
>> + * Calling conventions:
>> + *
>> + * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, thre=
ads)
>> + * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
>> + * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
>> + * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list inte=
rfaces
>> + */
>> +#define ACPI_SYSTEM_XFACE
>> +#define ACPI_EXTERNAL_XFACE
>> +#define ACPI_INTERNAL_XFACE
>> +#define ACPI_INTERNAL_VAR_XFACE
>> +
>> +/* Asm macros */
>> +#define ACPI_FLUSH_CPU_CACHE() flush_cache_all()
> Can you elaborate on when ACPI needs to use this?

Mainly used in two cases:

1) system sleep, there are sleep states defined
in ACPI, such as S0, S1, S2, S3 and etc.
when system enter sleep states, flush cache is needed.

2) When CPU enter idle states deeper than C3.

Thanks
hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
