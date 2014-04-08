From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPI: Update the ownership and developers for ACPI in
 Kconfig
Date: Tue, 08 Apr 2014 19:07:15 +0800
Message-ID: <5343D863.5000802@linaro.org>
References: <1396528650-7402-1-git-send-email-hanjun.guo@linaro.org> <1487377.07icAKoM8K@vostro.rjw.lan> <53435C0F.3090908@linaro.org> <2050013.Bv5IMKBfN1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51526 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbaDHLH1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Apr 2014 07:07:27 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so871143pab.26
        for <linux-acpi@vger.kernel.org>; Tue, 08 Apr 2014 04:07:27 -0700 (PDT)
In-Reply-To: <2050013.Bv5IMKBfN1@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Grant Likely <grant.likely@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2014-4-8 19:08, Rafael J. Wysocki wrote:
> On Tuesday, April 08, 2014 10:16:47 AM Hanjun Guo wrote:
>> On 2014-4-7 20:21, Rafael J. Wysocki wrote:
>>> On Thursday, April 03, 2014 08:37:30 PM Hanjun Guo wrote:
>>>> The UEFI Forum included the ACPI spec in its portfolio in October 2013
>>>> and will host future spec iterations, following the ACPI v5.0a release.
>>>>
>>>> A UEFI Forum working group named ACPI Specification Working Group (ASWG)
>>>> has been established to handle future ACPI developments, any UEFI member
>>>> can join the group and contribute to ACPI specification.
>>>>
>>>> So update the ownership and developers for ACPI in Kconfig accordingly,
>>>> and update the website link to ACPI specification too.
>>>>
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> ---
>>>>  drivers/acpi/Kconfig |    5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>> index c205653..831e541 100644
>>>> --- a/drivers/acpi/Kconfig
>>>> +++ b/drivers/acpi/Kconfig
>>>> @@ -32,9 +32,10 @@ menuconfig ACPI
>>>>  	  <http://acpica.org/>
>>>>  
>>>>  	  ACPI is an open industry specification co-developed by
>>>> -	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.
>>>> +	  ACPI Specification Working Group (ASWG) under UEFI Forum, any
>>>> +	  UEFI member can join ASWG and contribute to ACPI specification.
>>>>  	  The specification is available at:
>>>> -	  <http://www.acpi.info>
>>>
>>> The spec is still available from here, so why are you removing this link?
>>
>> My bad, I thought the link below is the replacement for the above one.
>>
>>>
>>>> +	  <http://www.uefi.org/acpi/specs>
>>
>> How about the replacement below?
>>
>> -	  <http://www.acpi.info>
>> +	  <http://www.acpi.info>, or:
> 
> The "or" is redundant I think, just add the new link below the old one.

Ok, I will update my patch and send it out soon.

Thanks
Hanjun

