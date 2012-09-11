From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/6] acpi : move the acpi_idle_driver variable declaration
Date: Tue, 11 Sep 2012 13:14:33 +0200
Message-ID: <504F1D19.1030702@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <1347013172-12465-2-git-send-email-daniel.lezcano@linaro.org> <201209072319.33742.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42551 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758737Ab2IKLOh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Sep 2012 07:14:37 -0400
Received: by eaac11 with SMTP id c11so194039eaa.19
        for <linux-acpi@vger.kernel.org>; Tue, 11 Sep 2012 04:14:36 -0700 (PDT)
In-Reply-To: <201209072319.33742.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

On 09/07/2012 11:19 PM, Rafael J. Wysocki wrote:
> On Friday, September 07, 2012, Daniel Lezcano wrote:
>> This variable is only used in the in processor_driver.c.
>> This patch reduces the scope of the variable by moving it
>> to this file.
>=20
> Well, the changelog is wrong (because the scope of the variable is
> not reduced by moving it out of the header) and I don't see the point=
=2E

Yes, you are right.

> Is there any _real_ problem with that definition in processor.h?

It is not a real problem. There is no issue fixed by this patch.
It is just reorganizing the code little by little. The intent is to
group what is related to cpuidle to the C files here processor_driver.c=
=2E


>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> ---
>>  drivers/acpi/processor_driver.c |    2 +-
>>  include/acpi/processor.h        |    1 -
>>  2 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processo=
r_driver.c
>> index bfc31cb..e1f6330 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -113,7 +113,7 @@ static struct acpi_driver acpi_processor_driver =
=3D {
>> =20
>>  DEFINE_PER_CPU(struct acpi_processor *, processors);
>>  EXPORT_PER_CPU_SYMBOL(processors);
>> -
>> +extern struct cpuidle_driver acpi_idle_driver;
>>  struct acpi_processor_errata errata __read_mostly;
>> =20
>>  /* ----------------------------------------------------------------=
----------
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index db427fa..8b2c39a 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -332,7 +332,6 @@ int acpi_processor_power_exit(struct acpi_proces=
sor *pr,
>>  			      struct acpi_device *device);
>>  int acpi_processor_suspend(struct device *dev);
>>  int acpi_processor_resume(struct device *dev);
>> -extern struct cpuidle_driver acpi_idle_driver;
>> =20
>>  /* in processor_thermal.c */
>>  int acpi_processor_get_limit_info(struct acpi_processor *pr);
>>
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
