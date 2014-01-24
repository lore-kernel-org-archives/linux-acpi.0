From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 07/20] ARM64 / ACPI: Enable ARM64 in Kconfig
Date: Fri, 24 Jan 2014 22:45:03 +0800
Message-ID: <52E27C6F.1070503@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-8-git-send-email-hanjun.guo@linaro.org> <20140123163939.GB25927@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36160 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbaAXOpM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jan 2014 09:45:12 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so3346626pab.29
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jan 2014 06:45:11 -0800 (PST)
In-Reply-To: <20140123163939.GB25927@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, graeme.gregory@lin

On 2014=E5=B9=B401=E6=9C=8824=E6=97=A5 00:39, Catalin Marinas wrote:
> On Fri, Jan 17, 2014 at 12:25:01PM +0000, Hanjun Guo wrote:
>> Add Kconfigs to build ACPI on ARM64, and make ACPI runable on ARM64.
>>
>> acpi_idle driver is x86/IA64 dependent now, so make CONFIG_ACPI_PROC=
ESSOR
>> depends on X86 || IA64, and implement it on ARM/ARM64 in the furture=
=2E
>>
>> In order to make arm-core.c can both run on ARM and ARM64, introduce
>> CONFIG_ACPI_ARM to support it.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/Kconfig         |    2 ++
>>   drivers/acpi/Kconfig       |   11 ++++++++---
>>   drivers/acpi/plat/Makefile |    2 +-
>>   3 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 6d4dd22..2b1fb1d 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -279,6 +279,8 @@ source "net/Kconfig"
>>  =20
>>   source "drivers/Kconfig"
>>  =20
>> +source "drivers/acpi/Kconfig"
>> +
>>   source "fs/Kconfig"
>>  =20
>>   source "arch/arm64/kvm/Kconfig"
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 4770de5..cae5dc9 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -2,13 +2,16 @@
>>   # ACPI Configuration
>>   #
>>  =20
>> +config ACPI_ARM
>> +	bool
> Could be better as def_bool ARM64
>
>> +
>>   menuconfig ACPI
>>   	bool "ACPI (Advanced Configuration and Power Interface) Support"
>>   	depends on !IA64_HP_SIM
>> -	depends on IA64 || X86
>> -	depends on PCI
>> +	depends on ((IA64 || X86) && PCI) || ARM64
>>   	select PNP
>> -	default y
>> +	select ACPI_ARM if ARM64
> And remove this select here.

Thanks for the guidance, will update in next version.

>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
