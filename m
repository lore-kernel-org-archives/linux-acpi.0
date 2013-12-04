From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use arch_timer_acpi_init()
Date: Wed, 04 Dec 2013 22:27:22 +0800
Message-ID: <529F3BCA.1020908@linaro.org>
References: <1386088891-2917-1-git-send-email-hanjun.guo@linaro.org> <1386088891-2917-3-git-send-email-hanjun.guo@linaro.org> <20131203170815.GB16025@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:48217 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227Ab3LDO1e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 09:27:34 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so22333425pdj.25
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 06:27:33 -0800 (PST)
In-Reply-To: <20131203170815.GB16025@e106331-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Jon Masters <jonathan@jonmasters.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro>

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 01:08, Mark Rutland wrote:
> On Tue, Dec 03, 2013 at 04:41:31PM +0000, Hanjun Guo wrote:
>> Use arch_timer_acpi_init() on ARM64 to initialise arch timer
>> in ACPI way when DT is not available.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/kernel/time.c |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
>> index 29c39d5..fb009da 100644
>> --- a/arch/arm64/kernel/time.c
>> +++ b/arch/arm64/kernel/time.c
>> @@ -67,6 +67,10 @@ void __init time_init(void)
>>  =20
>>   	clocksource_of_init();
>>  =20
>> +	/* if can't be initialised from DT, try ACPI way */
>> +	if (!arch_timer_get_rate())
>> +		arch_timer_acpi_init();
>> +
> As mentioned on the previous patch, I think for the timebeing we shou=
ld
> rely on CNTFREQ.
>
> Additionally, if you need to do this we should have an analagous
> mechanism to clocksource_of_init() that performs this initialisation =
for
> ACPI, and here we can call a clocksource_*_init function that does th=
e
> right thing.
>
> There's no need for this file to know anything about ACPI.

Oh, Amit already have some patches to introduce clocksource_acpi_init()
like clocksource_of_init() did, please refer to the link below.

http://marc.info/?l=3Dlinaro-acpi&m=3D138131929721943&w=3D2

is this the idea you mentioned in your comments?

Thanks
Hanjun


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
