From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 3/7] ACPI / processor: Introduce invalid_logical_cpuid()
Date: Tue, 05 May 2015 21:15:00 +0800
Message-ID: <5548C254.7060409@linaro.org>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org> <1430793998-21631-4-git-send-email-hanjun.guo@linaro.org> <1905565.04MrkTmlaM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35083 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945969AbbEENPI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2015 09:15:08 -0400
Received: by pabtp1 with SMTP id tp1so192951455pab.2
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2015 06:15:07 -0700 (PDT)
In-Reply-To: <1905565.04MrkTmlaM@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2015=E5=B9=B405=E6=9C=8805=E6=97=A5 20:01, Rafael J. Wysocki wrote:
> On Tuesday, May 05, 2015 10:46:34 AM Hanjun Guo wrote:
>> In ACPI processor drivers, we use direct comparisons of cpu logical
>> id with -1 which are error prone in case logical cpuid is accidental=
ly
>> assinged an error code and prevents us from returning an error-encod=
ing
>> cpuid directly in some cases.
>>
>> So introduce invalid_logical_cpuid() to identify cpu with invalid
>> logical cpu num, then it will be used to replace the direct comparis=
ons
>> with -1.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/acpi/acpi_processor.c | 4 ++--
>>   drivers/acpi/processor_pdc.c  | 5 +----
>>   include/linux/acpi.h          | 5 +++++
>>   3 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proce=
ssor.c
>> index 95492d0..62c846b 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -274,7 +274,7 @@ static int acpi_processor_get_info(struct acpi_d=
evice *device)
>>   		 * Handle UP system running SMP kernel, with no CPU
>>   		 * entry in MADT
>>   		 */
>> -		if ((pr->id =3D=3D -1) && (num_online_cpus() =3D=3D 1))
>> +		if (invalid_logical_cpuid(pr->id) && (num_online_cpus() =3D=3D 1)=
)
>>   			pr->id =3D 0;
>>   	}
>>
>> @@ -283,7 +283,7 @@ static int acpi_processor_get_info(struct acpi_d=
evice *device)
>>   	 *  less than the max # of CPUs. They should be ignored _iff
>>   	 *  they are physically not present.
>>   	 */
>> -	if (pr->id =3D=3D -1) {
>> +	if (invalid_logical_cpuid(pr->id)) {
>>   		int ret =3D acpi_processor_hotadd_init(pr);
>>   		if (ret)
>>   			return ret;
>> diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_p=
dc.c
>> index e5dd808..6dd98d0 100644
>> --- a/drivers/acpi/processor_pdc.c
>> +++ b/drivers/acpi/processor_pdc.c
>> @@ -52,10 +52,7 @@ static bool __init processor_physically_present(a=
cpi_handle handle)
>>   	type =3D (acpi_type =3D=3D ACPI_TYPE_DEVICE) ? 1 : 0;
>>   	cpuid =3D acpi_get_cpuid(handle, type, acpi_id);
>>
>> -	if (cpuid =3D=3D -1)
>> -		return false;
>> -
>> -	return true;
>> +	return invalid_logical_cpuid(cpuid) ? false : true;
>
> What about
>
> 	return !invalid_logical_cpuid(cpuid);

yes, cleaner, will update my patch.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
