From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 7/7] ACPI / processor: Introduce invalid_phys_cpuid()
Date: Tue, 05 May 2015 21:14:01 +0800
Message-ID: <5548C219.9060100@linaro.org>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org> <1430793998-21631-8-git-send-email-hanjun.guo@linaro.org> <5548A8C5.1080406@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34768 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423443AbbEENOK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2015 09:14:10 -0400
Received: by pacyx8 with SMTP id yx8so192684361pac.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2015 06:14:10 -0700 (PDT)
In-Reply-To: <5548A8C5.1080406@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 2015=E5=B9=B405=E6=9C=8805=E6=97=A5 19:25, Sudeep Holla wrote:
>
>
> On 05/05/15 03:46, Hanjun Guo wrote:
>> Introduce invalid_phys_cpuid() to identify cpu with invalid
>> physical ID, then used it as replacement of the direct comparisons
>> with PHYS_CPUID_INVALID.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/acpi/acpi_processor.c | 4 ++--
>>   drivers/acpi/processor_core.c | 4 ++--
>>   include/linux/acpi.h          | 5 +++++
>>   3 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_processor.c
>> b/drivers/acpi/acpi_processor.c
>> index 62c846b..92a5f73 100644
>> --- a/drivers/acpi/acpi_processor.c
>
> [...]
>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 913b49f..cc82ff3 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -163,6 +163,11 @@ static inline bool invalid_logical_cpuid(u32 cp=
uid)
>>       return (int)cpuid < 0;
>>   }
>>
>> +static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
>> +{
>> +    return (int)phys_id < 0;
>
> Should this be phys_id =3D=3D PHYS_CPUID_INVALID ? else I don't see w=
hy we
> need to even define PHYS_CPUID_INVALID

I'm OK with this. For now, CPU phys_id will be valid value or
PHYS_CPUID_INVALID in all cases for ACPI processor driver, but
I want ask Rafael's opinion on this, is it OK to you too, Rafael?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
