From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 03/19] ARM64 / ACPI: Introduce lowlevel suspend function
Date: Tue, 29 Jul 2014 21:00:51 +0800
Message-ID: <53D79B03.5020104@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org> <1406206825-15590-4-git-send-email-hanjun.guo@linaro.org> <53D69665.5090709@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:50483 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbaG2NCH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jul 2014 09:02:07 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so11700532pdb.3
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2014 06:02:06 -0700 (PDT)
In-Reply-To: <53D69665.5090709@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>
Cc: "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@linaro.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2014-7-29 2:28, Sudeep Holla wrote:
> 
> 
> On 24/07/14 14:00, Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> acpi_wakeup_address is used on x86 as the address bios jumps into
>> when machine wakes up from suspend. As arm64 does not have such a
>> bios this mechanism will be provided by other means. But the define
>> is still required inside the acpi core.
>>
>> Introduce a null stub for acpi_suspend_lowlevel as this is also
>> required by core. This will be filled in when standards are
>> defined for arm64 ACPI global power states.
>>
>> Reviewed-by: Grant Likely <grant.likely@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/acpi.h |   12 ++++++++++++
>>   arch/arm64/kernel/acpi.c      |    7 +++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index e8581ea..44b617f 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -36,6 +36,18 @@ static inline bool acpi_has_cpu_in_madt(void)
>>       return 1;
>>   }
>>
>> +/* Low-level suspend routine.
>> + *
>> + * ACPI S-states for ARM64 have to be defined
>> + * and approved before doing anything else, maybe
>> + * we need update the ACPI spec, here we
>> + * just introduce function and macro needed by
>> + * ACPI core as IA64 did, and revisit them when
>> + * the spec is ready.
>> + */
>> +extern int (*acpi_suspend_lowlevel)(void);
>> +#define acpi_wakeup_address 0
>> +
> 
> While I understand that this is temporary solution, but will this be
> sufficient to make sure we don't enter acpi_suspend_enter ?
> 
> A brief look at acpi_suspend_enter showed access to write to
> ACPI_BITREG_SCI_ENABLE which might just explode. But if you are sure that
> it will not be executed, then it should be fine for now.

I think it will not be executed, since ARM64 do not support S1 and S3 in ACPI
for now, and that state will not defined, then acpi_suspend_enter will not be
called.

Thanks
Hanjun

