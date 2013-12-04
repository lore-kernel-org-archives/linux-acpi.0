From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part1 PATCH 2/7] ARM64 : Add dummy asm/cpu.h
Date: Wed, 04 Dec 2013 23:00:46 +0800
Message-ID: <529F439E.6070101@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-3-git-send-email-hanjun.guo@linaro.org> <20131203171345.GC16025@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:52113 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257Ab3LDPBA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 10:01:00 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so23766656pbb.9
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 07:00:58 -0800 (PST)
In-Reply-To: <20131203171345.GC16025@e106331-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Jon Masters <jonathan@jonmasters.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro>

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 01:13, Mark Rutland wrote:
> On Tue, Dec 03, 2013 at 04:36:46PM +0000, Hanjun Guo wrote:
>> ACPI requires a cpu.h, add a dummy one copied from arm. This will ne=
ed
>> updated or replaced as ACPI based cpu hotplug for armv8 is worked ou=
t.
> What exactly requires cpu.h, and why?

CPI core will include this file and can not be compiled without it.

ACPI based CPU hotplug needs some functions below:
#ifdef CONFIG_HOTPLUG_CPU
extern int arch_register_cpu(int num);
extern void arch_unregister_cpu(int);
#endif

>
> Why copy the file verbatim rather than factoring it out?

ACPI based cpu hotplug is not implemented in this patch
set and will send out as drivers, so will factoring it
out at that time.
 =20

>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/cpu.h |   25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>   create mode 100644 arch/arm64/include/asm/cpu.h
>>
>> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/c=
pu.h
>> new file mode 100644
>> index 0000000..dbeb98d
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/cpu.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + *  Copyright (C) 2004-2005 ARM Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +#ifndef __ASM_ARM_CPU_H
>> +#define __ASM_ARM_CPU_H
>> +
>> +#include <linux/percpu.h>
>> +#include <linux/cpu.h>
>> +#include <linux/topology.h>
>> +
>> +struct cpuinfo_arm {
>> +	struct cpu	cpu;
>> +	u32		cpuid;
> We use a u64 elsewhere for the mpidr_el1 in arm64.

Good catch, will fix it

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
