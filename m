From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [BUG, REGRESSION] ACPI: Set _PDC
Date: Thu, 17 Jun 2010 15:56:11 +0800
Message-ID: <4C19D51B.90100@linux.intel.com>
References: <201006170040.24736.pogadl.jan@googlemail.com> <20100617032413.GC2138@canonical.com> <201006170951.26455.pogadl.jan@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:56385 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757042Ab0FQH4O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jun 2010 03:56:14 -0400
In-Reply-To: <201006170951.26455.pogadl.jan@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Pogadl <pogadl.jan@googlemail.com>
Cc: Alex Chiang <achiang@canonical.com>, linux-acpi@vger.kernel.org

=E4=BA=8E 6/17/2010 3:51 PM, Jan Pogadl =E5=86=99=E9=81=93:
> On Thursday 17 June 2010 05:24:14 Alex Chiang wrote:
>
>>> with commit commit 5d554a7bb0643a6151a84319bfeba8270bf5269e (ACPI: =
processor:
>>> add internal processor_physically_present()) a new function got int=
roduced which
>>> always fails on machines with CONFIG_SMP disabled. Thus _PDC will n=
ever be
>>> initialized? set?.
>
>> Does this patch fix it?
>
> works great
> thanks
>
>> ---
>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_=
core.c
>> index 5128435..bcf0cf8 100644
>> --- a/drivers/acpi/processor_core.c
>> +++ b/drivers/acpi/processor_core.c
>> @@ -223,7 +223,7 @@ static bool processor_physically_present(acpi_ha=
ndle handle)
>>   	type =3D (acpi_type =3D=3D ACPI_TYPE_DEVICE) ? 1 : 0;
>>   	cpuid =3D acpi_get_cpuid(handle, type, acpi_id);
>>
>> -	if (cpuid =3D=3D -1)
>> +	if ((cpuid =3D=3D -1)&&  (num_online_cpus()>  1))
>>   		return false;
>>
>>   	return true;
>>
I have a puzzle why num_online_cpus is used here, instead of
num_possible_cpus. It will be possible under a hotplug scenario.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
