From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 1/3] ACPI / processor: remove incorrect comparison of
 phys_id
Date: Fri, 13 Feb 2015 15:56:50 +0800
Message-ID: <54DDAE42.3080104@linaro.org>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com> <9584090.hqdaL9kipZ@vostro.rjw.lan> <5478C765.30504@arm.com> <25335106.4A2H4B9kq8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:40315 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbBMH4k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Feb 2015 02:56:40 -0500
Received: by pdev10 with SMTP id v10so17785562pde.7
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2015 23:56:40 -0800 (PST)
In-Reply-To: <25335106.4A2H4B9kq8@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 2014=E5=B9=B411=E6=9C=8829=E6=97=A5 07:26, Rafael J. Wysocki wrote:
> On Friday, November 28, 2014 07:05:09 PM Sudeep Holla wrote:
>> Hi Rafael,
>>
>> On 26/11/14 22:26, Rafael J. Wysocki wrote:
>>> On Wednesday, November 26, 2014 10:33:04 AM Sudeep Holla wrote:
>>>> Hi Hanjun,
>>>>
>>>> On 26/11/14 09:53, Hanjun Guo wrote:
>>>>> Hi Sudeep,
>>>>>
>>>>> On 2014-11-25 22:48, Sudeep Holla wrote:
>>
>> [...]
>>
>>>>>>
>>>>>> This patch removes that incorrect comparision in
>>>>>> acpi_processor_hotadd_init as the lone user of this function is
>>>>>> already checking for correctness of phys_id before calling it.
>>>>>
>>>>> if (apic_id < 0) acpi_handle_debug(pr->handle, "failed to get CPU
>>>>> APIC ID.\n");
>>>>>
>>>>> it only check the value and print debug message but no returns, s=
o I
>>>>> think the check in the following patch is still needed.
>>>>>
>>>>
>>>> Agreed, but that's something we need to fix in the logic and not b=
y
>>>> changing these identifiers to signed values in the structures.
>>>
>>> I'd rather not change data structures just because of what one funt=
ion returns.
>>>
>>> Instead, I'd do something like
>>>
>>> 	#define CPU_PHYS_ID_INVALID	(u32)(-1)
>>>
>>> change the function in question to return CPU_PHYS_ID_INVALID inste=
ad of -1
>>> and change the check to
>>>
>>> 	if (phys_id =3D=3D CPU_PHYS_ID_INVALID)
>>> 		...
>>>
>>
>> Do I need to rebase this on top of Hanjun's cleanups to convert apic=
_id
>> to phys_id ? Since the variable is getting renamed it will conflict.
>
> Yes, it's better to rebase IMO.

Hi Sudeep, any updates for this patch? I'm working on introducing
typedef u32 phys_cpuid_t for x86 and ia64 for phys_id, and need
this CPU_PHYS_ID_INVALID macro, if you are not working on that, I
will restart the work to address the comments from Lorenzo and
Catalin [1].

[1]: https://lkml.org/lkml/2015/2/3/635

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
