From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [update][PATCH v10 06/21] ACPI / sleep: Introduce CONFIG_ACPI_GENERIC_SLEEP
Date: Mon, 16 Mar 2015 20:14:52 +0800
Message-ID: <5506C93C.704@linaro.org>
References: <1426234469-6434-1-git-send-email-hanjun.guo@linaro.org> <2027737.r7gkxqZ3Xv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35590 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbbCPMPB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2015 08:15:01 -0400
Received: by pabyw6 with SMTP id yw6so63452977pab.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2015 05:15:01 -0700 (PDT)
In-Reply-To: <2027737.r7gkxqZ3Xv@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On 2015=E5=B9=B403=E6=9C=8814=E6=97=A5 05:49, Rafael J. Wysocki wrote:
> On Friday, March 13, 2015 04:14:29 PM Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> ACPI 5.1 does not currently support S states for ARM64 hardware but
>> ACPI code will call acpi_target_system_state() and acpi_sleep_init()
>> for device power management, so introduce CONFIG_ACPI_GENERIC_SLEEP
>> and select it for x86 and ia64 only to make sleep functions availabl=
e,
>> and also introduce stub function to allow other drivers to function
>> until S states are defined for ARM64.
>>
>> It will be no functional change for x86 and IA64.
>>
>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: Robert Richter <rrichter@cavium.com>
>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/ia64/Kconfig       | 1 +
>>   arch/x86/Kconfig        | 1 +
>>   drivers/acpi/Kconfig    | 4 ++++
>>   drivers/acpi/Makefile   | 2 +-
>>   drivers/acpi/internal.h | 4 ++++
>>   5 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
>> index 074e52b..e8728d7 100644
>> --- a/arch/ia64/Kconfig
>> +++ b/arch/ia64/Kconfig
>> @@ -10,6 +10,7 @@ config IA64
>>   	select ARCH_MIGHT_HAVE_PC_SERIO
>>   	select PCI if (!IA64_HP_SIM)
>>   	select ACPI if (!IA64_HP_SIM)
>> +	select ACPI_GENERIC_SLEEP if ACPI
>>   	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
>>   	select HAVE_UNSTABLE_SCHED_CLOCK
>>   	select HAVE_IDE
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index b7d31ca..9804431 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -22,6 +22,7 @@ config X86_64
>>   ### Arch settings
>>   config X86
>>   	def_bool y
>> +	select ACPI_GENERIC_SLEEP if ACPI
>
> One more nit.  If you did
>
> +	select ACPI_GENERIC_SLEEP if ACPI_SLEEP
>
> here (and above for ia64), you'd avoid having to make ACPI_SLEEP
> depend on ACPI_GENERIC_SLEEP which goes somewhat backwards.

In sleep.c,

#ifdef CONFIG_ACPI_SLEEP
acpi_target_system_state()
{
}
#endif

and CONFIG_ACPI_SLEEP depends on SUSPEND || HIBERNATION,
which one of them will be enabled on ARM64 so ACPI_SLEEP
will also enabled too.

So if we

+select ACPI_GENERIC_SLEEP if ACPI_SLEEP

and

+acpi-$(CONFIG_ACPI_GENERIC_SLEEP) +=3D sleep.o

it will lead to errors for acpi_target_system_state() that
is declared but not defined, so I will keep the code as
it is, what do you think?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
