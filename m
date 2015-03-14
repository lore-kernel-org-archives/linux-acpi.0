From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for HP Pavilion dv6
Date: Sat, 14 Mar 2015 20:46:25 +0800
Message-ID: <CAJ=jquZxC7rxj8rsy254Oy0ZYRYoKDNvXyEZ1ANP6FmbPaWikA@mail.gmail.com>
References: <1425364754-31900-1-git-send-email-alex.hung@canonical.com>
	<1941299.sLe76u91Cr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34521 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbbCNMqZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2015 08:46:25 -0400
Received: by qcaz10 with SMTP id z10so9696669qca.1
        for <linux-acpi@vger.kernel.org>; Sat, 14 Mar 2015 05:46:25 -0700 (PDT)
In-Reply-To: <1941299.sLe76u91Cr@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

Rafael,

Do you mean /sys/class/backlight/intel_backlight? It works but acpi_video fails.

We have some cases that needs working acpi_video interfaces. I'd also
like to backport to previous kernels that has not use native backlight
by default

Cheers,
Alex Hung

On Wed, Mar 11, 2015 at 6:20 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, March 03, 2015 02:39:14 PM Alex Hung wrote:
>> The brightness hotkeys of HP Pavilion dv6 does not work with Win8 OSI. Due
>> to insufficient documentation for the driver implementation, blacklist
>> it as a workaround.
>
> I gather that the native backlight interface doesn't work on those systems too,
> is that correct?
>
>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>> ---
>>  drivers/acpi/blacklist.c |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
>> index 9b693d5..98aa360 100644
>> --- a/drivers/acpi/blacklist.c
>> +++ b/drivers/acpi/blacklist.c
>> @@ -300,6 +300,18 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>>       },
>>
>>       /*
>> +      * The brightness hotkeys do not work on those machines when
>> +      * returning true for _OSI("Windows 2012")
>> +      */
>> +     {
>> +     .callback = dmi_disable_osi_win8,
>> +     .ident = "HP Pavilion dv6",
>> +     .matches = {
>> +                 DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>> +                 DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv6 Notebook PC"),
>> +             },
>> +     },
>> +     /*
>>        * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
>>        * Linux ignores it, except for the machines enumerated below.
>>        */
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.



-- 
Cheers,
Alex Hung
