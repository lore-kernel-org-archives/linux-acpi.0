From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part3 PATCH 1/2] clocksource / arch_timer: Use ACPI GTDT
 table to initialize arch timer
Date: Thu, 05 Dec 2013 21:52:34 +0800
Message-ID: <52A08522.6040203@linaro.org>
References: <1386088891-2917-1-git-send-email-hanjun.guo@linaro.org> <1386088891-2917-2-git-send-email-hanjun.guo@linaro.org> <201312050443.21858.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:54755 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146Ab3LENwr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 08:52:47 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so24820924pde.27
        for <linux-acpi@vger.kernel.org>; Thu, 05 Dec 2013 05:52:46 -0800 (PST)
In-Reply-To: <201312050443.21858.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, patches@linaro.org, Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>, Jon Masters <jonathan@jonmasters.org>, Grant Likely <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>

On 2013=E5=B9=B412=E6=9C=8805=E6=97=A5 11:43, Arnd Bergmann wrote:
> On Tuesday 03 December 2013, Hanjun Guo wrote:
>
>> +#ifdef CONFIG_ACPI
>> +void __init arch_timer_acpi_init(void)
>> +{
> ...
>> +}
>> +#else
>> +void __init arch_timer_acpi_init(void) { return; };
>> +#endif
>>  =20
> The #else clause is broken in combination with
>
>> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksou=
rce/arm_arch_timer.h
>> index 6d26b40..2654edf 100644
>> --- a/include/clocksource/arm_arch_timer.h
>> +++ b/include/clocksource/arm_arch_timer.h
>> @@ -66,6 +66,11 @@ static inline struct timecounter *arch_timer_get_=
timecounter(void)
>>   	return NULL;
>>   }
>>  =20
>> +static inline void arch_timer_acpi_init(void)
>> +{
>> +	return;
>> +}
>> +
>>   #endif
>>  =20
> this inline function. Have you build-tested this with CONFIG_ACPI dis=
abled?

Good catch! Thank you very much, will fix it in next version.

Thanks
hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
