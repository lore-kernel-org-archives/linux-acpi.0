From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/3] ACPI / processor: remove incorrect comparison of
 phys_id
Date: Wed, 26 Nov 2014 10:33:04 +0000
Message-ID: <5475AC60.9000506@arm.com>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com> <1416926930-792-2-git-send-email-sudeep.holla@arm.com> <5475A307.8040605@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36200 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaKZKdG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2014 05:33:06 -0500
In-Reply-To: <5475A307.8040605@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Hanjun,

On 26/11/14 09:53, Hanjun Guo wrote:
> Hi Sudeep,
>
> On 2014-11-25 22:48, Sudeep Holla wrote:
>> phys_id in acpi_processor structure is unsigned 32-bit integer,
>> comparing it with signed value is incorrect.
>
> Yes, this is a bug :)
>
> But the phys_id in acpi_processor structure should be signed value
> because acpi_get_phys_id() will return -1 if there if no CPU entry
> found in MADT table.
>
> I found the id in acpi_processor structure should also be signed
> value by unsigned now, we should fix that too.
>

I tend to disagree, since the physical(h/w) and logical identifiers are
unsigned integers, the structure elements must also be the same. Though
for checking the correctness of those identifiers, the functions can
manage through signed values or any other alternates IMO(i.e. more
implementation details)

Let's see what's Rafael's opinion on this.

>>
>> This patch removes that incorrect comparision in
>> acpi_processor_hotadd_init as the lone user of this function is
>> already checking for correctness of phys_id before calling it.
>
> if (apic_id < 0) acpi_handle_debug(pr->handle, "failed to get CPU
> APIC ID.\n");
>
> it only check the value and print debug message but no returns, so I
> think the check in the following patch is still needed.
>

Agreed, but that's something we need to fix in the logic and not by
changing these identifiers to signed values in the structures.

Regards,
Sudeep



