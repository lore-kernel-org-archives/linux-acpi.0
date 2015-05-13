From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 7/7] ACPI / processor: Introduce invalid_phys_cpuid()
Date: Wed, 13 May 2015 14:39:20 +0800
Message-ID: <5552F198.4030304@linaro.org>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org> <1430793998-21631-8-git-send-email-hanjun.guo@linaro.org> <5548A8C5.1080406@arm.com> <5548C219.9060100@linaro.org> <20150511163542.GB2942@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35215 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbbEMGj1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 02:39:27 -0400
Received: by pdbqd1 with SMTP id qd1so41526311pdb.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2015 23:39:26 -0700 (PDT)
In-Reply-To: <20150511163542.GB2942@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 2015=E5=B9=B405=E6=9C=8812=E6=97=A5 00:35, Lorenzo Pieralisi wrote:
> On Tue, May 05, 2015 at 02:14:01PM +0100, Hanjun Guo wrote:
>> On 2015???05???05??? 19:25, Sudeep Holla wrote:
>>>
>>>
>>> On 05/05/15 03:46, Hanjun Guo wrote:
>>>> Introduce invalid_phys_cpuid() to identify cpu with invalid
>>>> physical ID, then used it as replacement of the direct comparisons
>>>> with PHYS_CPUID_INVALID.
>>>>
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> ---
>>>>    drivers/acpi/acpi_processor.c | 4 ++--
>>>>    drivers/acpi/processor_core.c | 4 ++--
>>>>    include/linux/acpi.h          | 5 +++++
>>>>    3 files changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/acpi_processor.c
>>>> b/drivers/acpi/acpi_processor.c
>>>> index 62c846b..92a5f73 100644
>>>> --- a/drivers/acpi/acpi_processor.c
>>>
>>> [...]
>>>
>>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>>> index 913b49f..cc82ff3 100644
>>>> --- a/include/linux/acpi.h
>>>> +++ b/include/linux/acpi.h
>>>> @@ -163,6 +163,11 @@ static inline bool invalid_logical_cpuid(u32 =
cpuid)
>>>>        return (int)cpuid < 0;
>>>>    }
>>>>
>>>> +static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
>>>> +{
>>>> +    return (int)phys_id < 0;
>>>
>>> Should this be phys_id =3D=3D PHYS_CPUID_INVALID ? else I don't see=
 why we
>>> need to even define PHYS_CPUID_INVALID
>>
>> I'm OK with this. For now, CPU phys_id will be valid value or
>> PHYS_CPUID_INVALID in all cases for ACPI processor driver, but
>> I want ask Rafael's opinion on this, is it OK to you too, Rafael?
>
> Is your worry related to functions returning error values
> other than PHYS_CPUID_INVALID (when they are expected to return a
> physical id) ?

Yes.

> Is there any in the current kernel ?

No such returns as far as I know.

>
> static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
> {
> 	return phys_id =3D=3D PHYS_CPUID_INVALID;
> }
>
> This should do, and if we need more mapping functions that are suppos=
ed
> to return physical ids they should return PHYS_CPUID_INVALID on failu=
re.

OK, I will send a update version for this patch only.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
