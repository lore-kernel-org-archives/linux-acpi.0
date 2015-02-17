From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/3] ACPI / processor: remove incorrect comparison of
 phys_id
Date: Tue, 17 Feb 2015 15:20:30 +0000
Message-ID: <54E35C3E.3020200@arm.com>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com> <9584090.hqdaL9kipZ@vostro.rjw.lan> <5478C765.30504@arm.com> <25335106.4A2H4B9kq8@vostro.rjw.lan> <54DDAE42.3080104@linaro.org> <54E1C199.6060306@arm.com> <54E357DD.6040703@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37165 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbbBQPUK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Feb 2015 10:20:10 -0500
In-Reply-To: <54E357DD.6040703@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



On 17/02/15 15:01, Hanjun Guo wrote:
> On 2015=E5=B9=B402=E6=9C=8816=E6=97=A5 18:08, Sudeep Holla wrote:
>>
>>
>> On 13/02/15 07:56, Hanjun Guo wrote:
>>> On 2014=E5=B9=B411=E6=9C=8829=E6=97=A5 07:26, Rafael J. Wysocki wro=
te:
>>>> On Friday, November 28, 2014 07:05:09 PM Sudeep Holla wrote:
>>>>> Hi Rafael,
>>>>>
>>>>> On 26/11/14 22:26, Rafael J. Wysocki wrote:
>>>>>> On Wednesday, November 26, 2014 10:33:04 AM Sudeep Holla wrote:
>>>>>>> Hi Hanjun,
>>>>>>>
>>>>>>> On 26/11/14 09:53, Hanjun Guo wrote:
>>>>>>>> Hi Sudeep,
>>>>>>>>
>>>>>>>> On 2014-11-25 22:48, Sudeep Holla wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>>>>
>>>>>>>>> This patch removes that incorrect comparision in
>>>>>>>>> acpi_processor_hotadd_init as the lone user of this function =
is
>>>>>>>>> already checking for correctness of phys_id before calling it=
=2E
>>>>>>>>
>>>>>>>> if (apic_id < 0) acpi_handle_debug(pr->handle, "failed to get =
CPU
>>>>>>>> APIC ID.\n");
>>>>>>>>
>>>>>>>> it only check the value and print debug message but no returns=
, so I
>>>>>>>> think the check in the following patch is still needed.
>>>>>>>>
>>>>>>>
>>>>>>> Agreed, but that's something we need to fix in the logic and no=
t by
>>>>>>> changing these identifiers to signed values in the structures.
>>>>>>
>>>>>> I'd rather not change data structures just because of what one
>>>>>> funtion returns.
>>>>>>
>>>>>> Instead, I'd do something like
>>>>>>
>>>>>>      #define CPU_PHYS_ID_INVALID    (u32)(-1)
>>>>>>
>>>>>> change the function in question to return CPU_PHYS_ID_INVALID
>>>>>> instead of -1
>>>>>> and change the check to
>>>>>>
>>>>>>      if (phys_id =3D=3D CPU_PHYS_ID_INVALID)
>>>>>>          ...
>>>>>>
>>>>>
>>>>> Do I need to rebase this on top of Hanjun's cleanups to convert a=
pic_id
>>>>> to phys_id ? Since the variable is getting renamed it will confli=
ct.
>>>>
>>>> Yes, it's better to rebase IMO.
>>>
>>> Hi Sudeep, any updates for this patch? I'm working on introducing
>>> typedef u32 phys_cpuid_t for x86 and ia64 for phys_id, and need
>>> this CPU_PHYS_ID_INVALID macro, if you are not working on that, I
>>> will restart the work to address the comments from Lorenzo and
>>> Catalin [1].
>>>
>>
>> IMO, it would be good if you work on that instead, so that there's n=
o
>> dependency created as it's needed for your ARM64 port anyway.
>
> I think so, I just want to confirm that it will be no duplicate work
> for us. I will prepare a patch.

No issues, thanks for picking it up.

Regards,
Sudeep

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
