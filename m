From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot support
Date: Wed, 03 Sep 2014 19:17:16 +0800
Message-ID: <5406F8BC.7000503@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org> <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org> <5404AE56.80801@arm.com> <5405AE95.1020201@linaro.org> <5405BFE7.5060005@arm.com> <5405E626.4090306@linaro.org> <5406EDDC.3020208@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43710 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbaICLRp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 07:17:45 -0400
Received: by mail-pd0-f170.google.com with SMTP id r10so10890145pdi.15
        for <linux-acpi@vger.kernel.org>; Wed, 03 Sep 2014 04:17:40 -0700 (PDT)
In-Reply-To: <5406EDDC.3020208@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vg>


>>>>>> +
>>>>>> +#ifdef CONFIG_ACPI
>>>>>> +#define ACPI_MAX_GIC_CPU_INTERFACE_ENTRIES  65535
>>>>> With GICv2? I doubt it.
>>>> I will create macro for each GIC driver:
>>>> #define ACPI_MAX_GICV2_CPU_INTERFACE_ENTRIES    8
>>>> #define ACPI_MAX_GICV3_CPU_INTERFACE_ENTRIES    65535
>>> Where do you get this value (ACPI_MAX_GICV3_CPU_INTERFACE_ENTRIES) from?
>> This value is for max processors entries in MADT, and we will use it to scan MADT
>> for SMP/GIC Init, I just make it big enough for GICv3/4. since ACPI core will stop
>> scan MADT if the real numbers of processors entries are reached no matter
>> how big ACPI_MAX_GICV3_CPU_INTERFACE_ENTRIES is, I think we can just
>> define a number big enough then it will work (x86 and ia64 did the same thing).
> Also, with GICv3++, there is no such thing as a memory-mapped CPU
> interface anymore. What you get is a bunch of redistributors (one per
> CPU). I assume what you have here actually describe the redistributors,
> and its name should reflect that.

As Sudeep said, it is not to link to GIC architecture, so I think we can keep
it stick with ACPI spec, in ACPI spec, it called "GICC structure" (section 5.2.12.14
in ACPI 5.1), so we can name it as ACPI_MAX_GICC_STRUCTURE_ENTRIES no matter
GICv2 or GICv3/4 (with GICv2, it may have more than 8 entries with some disabled
ones, will no more than 8 enabled entries).

What do you think?

Thanks
Hanjun
