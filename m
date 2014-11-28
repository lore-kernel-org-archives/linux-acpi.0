From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/3] ACPI / processor: remove incorrect comparison of
 phys_id
Date: Fri, 28 Nov 2014 19:05:09 +0000
Message-ID: <5478C765.30504@arm.com>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com> <5475A307.8040605@linaro.org> <5475AC60.9000506@arm.com> <9584090.hqdaL9kipZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48435 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbaK1TFG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Nov 2014 14:05:06 -0500
In-Reply-To: <9584090.hqdaL9kipZ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Rafael,

On 26/11/14 22:26, Rafael J. Wysocki wrote:
> On Wednesday, November 26, 2014 10:33:04 AM Sudeep Holla wrote:
>> Hi Hanjun,
>>
>> On 26/11/14 09:53, Hanjun Guo wrote:
>>> Hi Sudeep,
>>>
>>> On 2014-11-25 22:48, Sudeep Holla wrote:

[...]

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
> 		...
>

Do I need to rebase this on top of Hanjun's cleanups to convert apic_id
to phys_id ? Since the variable is getting renamed it will conflict.

Regards,
Sudeep

