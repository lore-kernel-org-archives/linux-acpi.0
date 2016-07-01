From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH 3/6] ACPICA: make use of new strtolower() function
Date: Thu, 30 Jun 2016 21:13:26 -0700
Message-ID: <CAGt4E5tRhiFtx-JsB2unQ2JMMZRv9Td_5jXcU9N4wG_Taedqng@mail.gmail.com>
References: <1467330612-26242-1-git-send-email-mmayer@broadcom.com>
 <1467330612-26242-4-git-send-email-mmayer@broadcom.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37E4C3731@ORSMSX110.amr.corp.intel.com>
 <CAGt4E5uqbjaubPWE4rq-T7MvqAmwpUhvakM+jv+Sen8est9U5g@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37E4C381C@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:32982 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbcGAEN3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 00:13:29 -0400
Received: by mail-vk0-f43.google.com with SMTP id k68so51526543vkb.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jun 2016 21:13:28 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4C381C@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

On 30 June 2016 at 19:59, Moore, Robert <robert.moore@intel.com> wrote:
> This is linux-specific code, ACPICA is os-independent. So we cannot accept
> such patch.

Understood. I wasn't aware that this was shared code.

> From: Markus Mayer [mailto:markus.mayer@broadcom.com]
> Sent: Thursday, June 30, 2016 7:50 PM
> To: Moore, Robert
> Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-acpi@vger.kernel.org;
> devel@acpica.org; linux-kernel@vger.kernel.org; Box, David E
> Subject: Re: [PATCH 3/6] ACPICA: make use of new strtolower() function
>
> On Thursday, 30 June 2016, Moore, Robert <robert.moore@intel.com> wrote:
>
> Where is "strtolower" implemented?
>
> First patch of the series:
>
> https://lkml.org/lkml/2016/6/30/733
>
>> -----Original Message-----
>> From: Markus Mayer [mailto:mmayer@broadcom.com]
>> Sent: Thursday, June 30, 2016 4:50 PM
>> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
>> Cc: Markus Mayer; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH 3/6] ACPICA: make use of new strtolower() function
>>
>> Call strtolower() rather than walking the string explicitly to convert it
>> to lowercase.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>
>> *** Please note that there don't seem to be any callers of
>> acpi_ut_strlwr().
>> *** It may be possible to remove the function altogether.
>>
>>  drivers/acpi/acpica/utnonansi.c | 13 +------------
>>  1 file changed, 1 insertion(+), 12 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/utnonansi.c
>> b/drivers/acpi/acpica/utnonansi.c index 3465fe2..b6e11dc 100644
>> --- a/drivers/acpi/acpica/utnonansi.c
>> +++ b/drivers/acpi/acpica/utnonansi.c
>> @@ -64,19 +64,8 @@ ACPI_MODULE_NAME("utnonansi")
>>
>> **************************************************************************
>> ****/
>>  void acpi_ut_strlwr(char *src_string)
>>  {
>> -     char *string;
>> -
>>       ACPI_FUNCTION_ENTRY();
>> -
>> -     if (!src_string) {
>> -             return;
>> -     }
>> -
>> -     /* Walk entire string, lowercasing the letters */
>> -
>> -     for (string = src_string; *string; string++) {
>> -             *string = (char)tolower((int)*string);
>> -     }
>> +     strtolower(src_string);
>>  }
>>
>>
>> /*************************************************************************
>> ******
>> --
>> 2.7.4
