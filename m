From: Philipp Kolmann <philipp@kolmann.at>
Subject: Re: ACPI Problem with HP EliteBook 2530p
Date: Mon, 12 Jan 2009 08:14:34 +0100
Message-ID: <496AEDDA.6030408@kolmann.at>
References: <494D31B0.90807@kolmann.at> <494D530C.8000209@gmail.com> <494E164C.2090406@kolmann.at> <494E1CE3.90005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from scs2.zid.tuwien.ac.at ([128.130.33.92]:52666 "EHLO
	scs2.zid.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZALHOm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jan 2009 02:14:42 -0500
In-Reply-To: <494E1CE3.90005@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi,

just compiled .29-rc1 and I am still having the issue.

I checked in the sources and the check for ASUS is still missing. Adding 
it by hand makes .29-rc1 working for me.
Could you please get this into rc2.

Thanks
Philipp

Alexey Starikovskiy wrote:
> With some luck it even may still appear in .28...
> Certainly .29 will have it.
>
> Regards,
> Alex.
>
> Philipp Kolmann wrote:
>> Hi Alexey,
>>
>> thank you very much for your help.
>>
>> I can confirm, that the patch in #63 works with 2530p as well. Now 
>> the kernel boots without any special acpi parameter.
>>
>> Only regression I now see with full ACPI turned on, is that  I can't 
>> dim the display anymore.
>>
>> Will this patch go into 2.6.29?
>>
>> Thanks
>> Philipp
>>
>> Alexey Starikovskiy wrote:
>>> Hi Philipp,
>>>
>>> Please check if http://bugzilla.kernel.org/show_bug.cgi?id=11884 is 
>>> the same problem.
>>> There is  a patch, which is reported to help with HP 2730p.
>>> If patch does not help you, please create new bug report and attach 
>>> your acpidump and dmesg (at least from acpi=ht run).
>>>
>>> Regards,
>>> Alex.
>>>
>>> Philipp Kolmann wrote:
>>>> Hi,
>>>>
>>>> I hope I don't mistreat any code of the mailinglist. I am new here.
>>>>
>>>> I have a new HP Elitebook 2530p with Debian on it (and also Vista).
>>>>
>>>> With 2.6.27 I had no ACPI problems until a VISTA Update somehow 
>>>> broke the ACPI tables.
>>>>
>>>> Now if I boot with ACPI enabled on 2.6.27 and 2.6.28-rc9 the 
>>>> computer hangs completely.
>>>> It only works with acpi=ht.
>>>>
>>>> I also tried pci=noacpi, acpi=noirq, there it hung saying it has a 
>>>> problem with the second CPU.
>>>>
>>>> Can anyone tell me, how to get the proper debugging info for you, 
>>>> so you can help.
>>>>
>>>> Do you prefer screenshots?
>>>>
>>>> thanks
>>>> Philipp
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>> linux-acpi" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

