From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 1/3] ACPI / processor: remove incorrect comparison of
 phys_id
Date: Thu, 27 Nov 2014 10:43:37 +0800
Message-ID: <54768FD9.9000808@linaro.org>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com> <5475A307.8040605@linaro.org> <5475AC60.9000506@arm.com> <9584090.hqdaL9kipZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:53956 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbaK0Cpp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2014 21:45:45 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so4036129pdi.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2014 18:45:45 -0800 (PST)
In-Reply-To: <9584090.hqdaL9kipZ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 2014-11-27 6:26, Rafael J. Wysocki wrote:
> On Wednesday, November 26, 2014 10:33:04 AM Sudeep Holla wrote:
>> Hi Hanjun,
>>
>> On 26/11/14 09:53, Hanjun Guo wrote:
>>> Hi Sudeep,
>>>
>>> On 2014-11-25 22:48, Sudeep Holla wrote:
>>>> phys_id in acpi_processor structure is unsigned 32-bit integer,
>>>> comparing it with signed value is incorrect.
>>>
>>> Yes, this is a bug :)
>>>
>>> But the phys_id in acpi_processor structure should be signed value
>>> because acpi_get_phys_id() will return -1 if there if no CPU entry
>>> found in MADT table.
>>>
>>> I found the id in acpi_processor structure should also be signed
>>> value by unsigned now, we should fix that too.
>>>
>>
>> I tend to disagree, since the physical(h/w) and logical identifiers are
>> unsigned integers, the structure elements must also be the same. Though
>> for checking the correctness of those identifiers, the functions can
>> manage through signed values or any other alternates IMO(i.e. more
>> implementation details)
>>
>> Let's see what's Rafael's opinion on this.
>>
>>>>
>>>> This patch removes that incorrect comparision in
>>>> acpi_processor_hotadd_init as the lone user of this function is
>>>> already checking for correctness of phys_id before calling it.
>>>
>>> if (apic_id < 0) acpi_handle_debug(pr->handle, "failed to get CPU
>>> APIC ID.\n");
>>>
>>> it only check the value and print debug message but no returns, so I
>>> think the check in the following patch is still needed.
>>>
>>
>> Agreed, but that's something we need to fix in the logic and not by
>> changing these identifiers to signed values in the structures.
> 
> I'd rather not change data structures just because of what one funtion returns.
> 
> Instead, I'd do something like
> 
> 	#define CPU_PHYS_ID_INVALID	(u32)(-1)
> 
> change the function in question to return CPU_PHYS_ID_INVALID instead of -1
> and change the check to
> 
> 	if (phys_id == CPU_PHYS_ID_INVALID)

I'm fine with this :)

Thanks
Hanjun

