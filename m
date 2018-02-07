From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Wed, 7 Feb 2018 12:05:56 -0800
Message-ID: <CAJ=jquYU9Uvb1D5c=eHc_Wq3AtL-1P4UDCZfssZ00pzA6HaAVw@mail.gmail.com>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
 <1517388005-14852-2-git-send-email-alex.hung@canonical.com> <20180205141447.6e1442ac@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53160 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754421AbeBGUF7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2018 15:05:59 -0500
Received: from mail-qt0-f197.google.com ([209.85.216.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <alex.hung@canonical.com>)
        id 1ejVyg-00045C-48
        for linux-acpi@vger.kernel.org; Wed, 07 Feb 2018 20:05:58 +0000
Received: by mail-qt0-f197.google.com with SMTP id z13so1873538qtb.19
        for <linux-acpi@vger.kernel.org>; Wed, 07 Feb 2018 12:05:58 -0800 (PST)
In-Reply-To: <20180205141447.6e1442ac@endymion>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kishon@ti.com, sayli karnik <karniksayli1995@gmail.com>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>, Mario.Limonciello@dell.com

On Mon, Feb 5, 2018 at 5:14 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Alex,
>
> On Wed, 31 Jan 2018 00:40:05 -0800, Alex Hung wrote:
>> A number of Dell systems require an OEM _OSI string "Linux-Dell-Video" as
>> a BIOS workaround for a system hang bug caused by discrete VGA. The form of
>> the OEM _OSI string is discussed in Documentation/acpi/osi.txt and is
>> defined by each OEM.
>
> I admit I don't understand how it is the operating system's job to
> carry the information from the BIOS to the BIOS.
>
>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>> ---
>>  drivers/acpi/osi.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>
>> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
>> index 76998a5..43e4349 100644
>> --- a/drivers/acpi/osi.c
>> +++ b/drivers/acpi/osi.c
>> @@ -477,6 +477,112 @@ static const struct dmi_system_id acpi_osi_dmi_table[] __initconst = {
>>       {}
>>  };
>>
>> +static int __init dmi_oem_osi_add(const struct dmi_system_id *d)
>> +{
>> +     struct acpi_osi_entry *osi;
>> +     const char *str = d->driver_data;
>> +     int i;
>> +
>> +     for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
>> +             osi = &osi_setup_entries[i];
>> +             if (!strcmp(osi->string, str)) {
>
> This can only happen if the user passes acpi_osi=Linux-Dell-Video or
> acpi_osi=!Linux-Dell-Video on the boot command line, right?
>
>> +                     osi->enable = true;
>
> Does this not prevent the user from explicitly disabling it with
> acpi_osi=!Linux-Dell-Video ?

Thanks for pointing this out.

This can be fixed by placing
"dmi_check_system(acpi_oem_osi_dmi_table)" call in
"early_acpi_osi_init" to fix this, as "osi_setup" used by the kernel
parameter acpi_osi is executed after early_acpi_osi_init. It is also
where other quirks are initialised too.

>
>> +                     continue;
>
> Are you not done at this point? I think you want to break, not
> continue, else you may add a duplicate Linux-Dell-Video entry below.

Thanks. "break" should be used here.

>
>> +             } else if (osi->string[0] == '\0') {
>> +                     osi->enable = true;
>> +                     strncpy(osi->string, str, OSI_STRING_LENGTH_MAX);
>> +                     break;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct dmi_system_id acpi_oem_osi_dmi_table[] __initconst = {
>> +     {
>> +     .callback = dmi_oem_osi_add,
>> +     .ident = "Dell Latitude 5491",
>> +     .matches = {
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0818]"),
>> +             },
>> +     .driver_data = "Linux-Dell-Video",
>> +     },
>> +     {
>> +     .callback = dmi_oem_osi_add,
>> +     .ident = "Dell Latitude 5591",
>> +     .matches = {
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0819]"),
>> +             },
>> +     .driver_data = "Linux-Dell-Video",
>> +     },
>> +     {
>> +     .callback = dmi_oem_osi_add,
>> +     .ident = "Dell Precision 3530",
>> +     .matches = {
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0820]"),
>> +             },
>> +     .driver_data = "Linux-Dell-Video",
>> +     },
>> +     {
>> +     .callback = dmi_oem_osi_add,
>> +     .ident = "Dell Inspiron 7777 AIO",
>> +     .matches = {
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0850]"),
>> +             },
>> +     .driver_data = "Linux-Dell-Video",
>> +     },
>> +     {
>> +     .callback = dmi_oem_osi_add,
>> +     .ident = "Dell Inspiron 5477 AIO",
>> +     .matches = {
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0851]"),
>> +             },
>> +     .driver_data = "Linux-Dell-Video",
>> +     },
>> +     {
>> +     .callback = dmi_oem_osi_add,
>> +     .ident = "Dell G5 5779",
>> +     .matches = {
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0886]"),
>> +             },
>> +     .driver_data = "Linux-Dell-Video",
>> +     },
>> +     {
>> +     .callback = dmi_oem_osi_add,
>> +     .ident = "Dell G5 5779",
>> +     .matches = {
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0870]"),
>> +             },
>> +     .driver_data = "Linux-Dell-Video",
>> +     },
>> +     {
>> +     .callback = dmi_oem_osi_add,
>> +     .ident = "Dell G5 5579",
>> +     .matches = {
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "1[086F]"),
>> +             },
>> +     .driver_data = "Linux-Dell-Video",
>> +     },
>> +     {
>> +     .callback = dmi_oem_osi_add,
>> +     .ident = "Dell G5 5579",
>> +     .matches = {
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
>> +                  DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0885]"),
>> +             },
>> +     .driver_data = "Linux-Dell-Video",
>> +     },
>> +     {}
>> +};
>
> G5 5779 and G5 5579 appear twice each, are these copy-and-paste errors?
>
> Choosing a sort rule and sticking to it would make it easier to add
> entries later with not risk of duplicates.

I was just as surprised, but they are indeed two different systems, as
pointed out by Mario.
>
>> +
>>  static __init void acpi_osi_dmi_blacklisted(void)
>>  {
>>       dmi_check_system(acpi_osi_dmi_table);
>> @@ -496,6 +602,7 @@ int __init early_acpi_osi_init(void)
>>  int __init acpi_osi_init(void)
>>  {
>>       acpi_install_interface_handler(acpi_osi_handler);
>> +     dmi_check_system(acpi_oem_osi_dmi_table);
>>       acpi_osi_setup_late();
>>
>>       return 0;
>
>
> --
> Jean Delvare
> SUSE L3 Support



-- 
Cheers,
Alex Hung
