From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH 11/12] ACPI: use of ACPI_FADT_32BIT_TIMER is not allowed
 in HW reduced mode
Date: Thu, 21 Nov 2013 16:43:59 -0700
Message-ID: <528E9ABF.1020003@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-12-git-send-email-al.stone@linaro.org> <1401228.IWQJyQWsXM@vostro.rjw.lan> <528D3488.9080905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:49038 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab3KUXoB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 18:44:01 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so876131iej.40
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2013 15:44:00 -0800 (PST)
In-Reply-To: <528D3488.9080905@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On 11/20/2013 03:15 PM, Al Stone wrote:
> On 11/17/2013 03:26 PM, Rafael J. Wysocki wrote:
>> On Saturday, November 09, 2013 06:36:21 PM al.stone@linaro.org wrote:
>>> From: Al Stone <ahs3@redhat.com>
>>
>> I'm reading the patch as "the timer resolution in HW reduced mode is
>> always
>> 32-bit".  Is my reading correct?
>
> Whups, I see what I did.  You are reading the patch correctly.
>
> However, what the code should ultimately do is ignore the
> ACPI_FADT_32BIT_TIMER flag completely.  Let me look at where the
> timer_resolution field is being used also since it is not immediately
> clear what value it should have, or if it should even be used, when
> in reduced HW mode.

On further investigation, I'll take this patch out of this set.
I think this needs better handling in the ACPICA code so I'll work
with them on that.

In the meantime, the spec seems to be completely mum on what the
timer resolution should be in reduced HW mode.  What's more, it
looks like acpi_get_system_info() never gets called in the first
place, so this change would be irrelevant.  Further, it also looks
like acpi_get_timer_resolution() (which returns the timer_resolution
value) never gets called either, nor is the timer_resolution used
outside of the ACPICA code in any way.

So, whenever the right answer gets figured out in ACPICA, it will 
eventually get pulled into Linux ACPI.

>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>> ---
>>>   drivers/acpi/acpica/utxface.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/acpica/utxface.c
>>> b/drivers/acpi/acpica/utxface.c
>>> index be322c8..fe94b3e 100644
>>> --- a/drivers/acpi/acpica/utxface.c
>>> +++ b/drivers/acpi/acpica/utxface.c
>>> @@ -187,7 +187,8 @@ acpi_status acpi_get_system_info(struct
>>> acpi_buffer * out_buffer)
>>>
>>>       /* Timer resolution - 24 or 32 bits  */
>>>
>>> -    if (acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER) {
>>> +    if (!acpi_gbl_reduced_hardware &&
>>> +        (acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER)) {
>>>           info_ptr->timer_resolution = 24;
>>>       } else {
>>>           info_ptr->timer_resolution = 32;
>>>
>
>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
