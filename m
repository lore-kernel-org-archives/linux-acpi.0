From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/5] acpi : move the acpi_idle_driver variable declaration
Date: Fri, 27 Jul 2012 10:14:43 +0200
Message-ID: <50124DF3.40605@linaro.org>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org> <1343213162-8064-2-git-send-email-daniel.lezcano@linaro.org> <50122B4C.3030509@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39072 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab2G0IOr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jul 2012 04:14:47 -0400
Received: by eeil10 with SMTP id l10so573686eei.19
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jul 2012 01:14:46 -0700 (PDT)
In-Reply-To: <50122B4C.3030509@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linaro-dev@lists.linaro.org

On 07/27/2012 07:46 AM, Deepthi Dharwar wrote:
> Hi Daniel,
>=20
>=20
> On 07/25/2012 04:15 PM, Daniel Lezcano wrote:
>=20
>> This variable is only used in the in processor_driver.c.
>> This patch reduces the scope of the variable by moving it
>> to this file.
>>
>=20
>=20
> This is true after applying your second patch .
> Maybe you can check the sequencing of patches in the series.
> As a thumb rule one should be able to build the kernel
> by applying each and every patch in the series .

Thanks Deepthi. I think I already git bisect tested the patchset.
This patch does not break the build, the variable is defined in the
processor_driver.c file.



> There would be a build break after applying this one as
> acpi_idle_driver is still used in processor_idle.c by applying
> just this patch.
>=20
> Cheers,
> Deepthi
>=20
> =20
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/acpi/processor_driver.c |    2 +-
>>  include/acpi/processor.h        |    1 -
>>  2 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processo=
r_driver.c
>> index 7048b97..017b39d 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -113,7 +113,7 @@ static struct acpi_driver acpi_processor_driver =
=3D {
>>
>>  DEFINE_PER_CPU(struct acpi_processor *, processors);
>>  EXPORT_PER_CPU_SYMBOL(processors);
>> -
>> +extern struct cpuidle_driver acpi_idle_driver;
>>  struct acpi_processor_errata errata __read_mostly;
>>
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
>>
>>  /* in processor_thermal.c */
>>  int acpi_processor_get_limit_info(struct acpi_processor *pr);
>=20
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
