From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part1 PATCH 7/7] ARM64 / ACPI: Enable ARM64 in Kconfig
Date: Wed, 04 Dec 2013 23:55:45 +0800
Message-ID: <529F5081.3070403@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-8-git-send-email-hanjun.guo@linaro.org> <20131204101050.GQ2395@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:52279 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642Ab3LDP5D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 10:57:03 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so22419863pdj.26
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 07:57:01 -0800 (PST)
In-Reply-To: <20131204101050.GQ2395@xora-haswell.xora.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Al Stone <al.stone@linaro.org>

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 18:10, Graeme Gregory wrote:
> On Wed, Dec 04, 2013 at 12:36:51AM +0800, Hanjun Guo wrote:
>> Add Kconfigs to build ACPI on ARM64, and make ACPI runable on ARM64.
>>
>> acpi_idle driver is x86/IA64 dependent now, so make CONFIG_ACPI_PROC=
ESSOR
>> depends on X86 || IA64, and implement it on ARM in the furture.
>>
>> In order to make arm-core.c can both run on ARM and ARM64, introduce
>> CONFIG_ACPI_ARM to support it.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/Kconfig         |    2 ++
>>   drivers/acpi/Kconfig       |   12 +++++++++---
>>   drivers/acpi/plat/Makefile |    2 +-
>>   3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 88c8b6c1..a37795f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -280,6 +280,8 @@ source "net/Kconfig"
>>  =20
>>   source "drivers/Kconfig"
>>  =20
>> +source "drivers/acpi/Kconfig"
>> +
>>   source "fs/Kconfig"
>>  =20
>>   source "arch/arm64/kvm/Kconfig"
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 53f0f16..f43485e 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -2,13 +2,17 @@
>>   # ACPI Configuration
>>   #
>>  =20
>> +config ACPI_ARM
>> +	bool
>> +	select ACPI_REDUCED_HARDWARE
>> +
>>   menuconfig ACPI
>>   	bool "ACPI (Advanced Configuration and Power Interface) Support"
>>   	depends on !IA64_HP_SIM
>> -	depends on IA64 || X86
>> -	depends on PCI
>> +	depends on ((IA64 || X86) && PCI) || ARM64
>>   	select PNP
>> -	default y
>> +	select ACPI_ARM if (ARM || ARM64)
>> +	default y if !(ARM || ARM64)
> Should only be ARM64 here with the current files in this series, I th=
ink
> this is causing others confusion looking for arm 32bit support in pat=
ches
> where there is none yet!

ah, yes, my bad, will update it in next version.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
