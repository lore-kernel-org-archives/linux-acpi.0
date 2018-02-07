From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH 1/2] firmware: dmi_scan: add DMI_OEM_STRING support to dmi_matches
Date: Tue, 6 Feb 2018 21:25:53 -0800
Message-ID: <CAJ=jquZhiZow2eAQmkAScm+UVYXRPZ_+LRJykHb4MEQ=26iXAQ@mail.gmail.com>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com> <20180205112625.2e451bce@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33990 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBGFZ4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2018 00:25:56 -0500
Received: from mail-qt0-f198.google.com ([209.85.216.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <alex.hung@canonical.com>)
        id 1ejIF1-00015M-CK
        for linux-acpi@vger.kernel.org; Wed, 07 Feb 2018 05:25:55 +0000
Received: by mail-qt0-f198.google.com with SMTP id z13so3405337qth.22
        for <linux-acpi@vger.kernel.org>; Tue, 06 Feb 2018 21:25:55 -0800 (PST)
In-Reply-To: <20180205112625.2e451bce@endymion>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, f.fainelli@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kishon@ti.com, karniksayli1995@gmail.com, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>, Mario.Limonciello@dell.com

On Mon, Feb 5, 2018 at 2:26 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Alex,
>
> On Wed, 31 Jan 2018 00:40:04 -0800, Alex Hung wrote:
>> OEM strings are defined by each OEM and they contain customized and
>> useful OEM information. Supporting it provides more flexible uses of
>> the dmi_matches function.
>>
>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>> ---
>>  drivers/firmware/dmi_scan.c     | 8 ++++++++
>>  include/linux/mod_devicetable.h | 1 +
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
>> index 7830419..e534d1b 100644
>> --- a/drivers/firmware/dmi_scan.c
>> +++ b/drivers/firmware/dmi_scan.c
>> @@ -797,11 +797,19 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
>>                       else if (dmi->matches[i].exact_match &&
>>                                !strcmp(dmi_ident[s], dmi->matches[i].substr))
>>                               continue;
>> +             } else if (s == DMI_OEM_STRING) {
>> +                     const struct dmi_device *valid;
>> +
>> +                     valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
>> +                                             dmi->matches[i].substr, NULL);
>> +                     if (valid)
>> +                             continue;
>>               }
>>
>>               /* No match */
>>               return false;
>>       }
>> +
>>       return true;
>>  }
>>
>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
>> index abb6dc2..5739c4c 100644
>> --- a/include/linux/mod_devicetable.h
>> +++ b/include/linux/mod_devicetable.h
>> @@ -482,6 +482,7 @@ enum dmi_field {
>>       DMI_CHASSIS_VERSION,
>>       DMI_CHASSIS_SERIAL,
>>       DMI_CHASSIS_ASSET_TAG,
>> +     DMI_OEM_STRING,
>>       DMI_STRING_MAX,
>>  };
>>
>
> This is kind of a hack, because there are more than one OEM string, so
> they don't fit in dmi_ident[], but I see the value. However, reserving
> one entry for them in dmi_ident[], which you will never use, is
> potentially confusing, so it would have to be documented.
>
> Did you consider adding DMI_OEM_STRING after DMI_STRING_MAX? It would
> avoid the memory waste (small but still) and shouldn't be a problem if
> you test this specific case early enough in dmi_matches()?
>
> It should also be documented that only exact matches are supported for
> DMI_OEM_STRING (dmi_strmatch.exact_match is ignored and considered true
> always.)

It is a good idea. I will refine, test and submit a V2.

>
> Lastly you will have to rebase your patch on top of Linus' latest tree
> and in particular:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8cf4e6a04f734e831c2ac7f405071d1cde690ba8

Will do

>
> Thanks,
> --
> Jean Delvare
> SUSE L3 Support
