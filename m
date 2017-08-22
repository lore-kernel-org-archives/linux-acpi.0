From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI _DSD sub-node parsing broken in linux-next?
Date: Tue, 22 Aug 2017 22:16:57 +0200
Message-ID: <CAJZ5v0hgbM5EK6O+SN5Gve2JM-ME3X41+5aDjrNaraLU2pokQw@mail.gmail.com>
References: <7A4F467111FEF64486F40DFE7DF3500A03EE8B36@ORSMSX111.amr.corp.intel.com>
 <7A4F467111FEF64486F40DFE7DF3500A03EE8F49@ORSMSX111.amr.corp.intel.com>
 <8ae7a257-2461-0f9f-b272-95dc08b8647c@intel.com> <3017279.6rhHp0hW77@aspire.rjw.lan>
 <7A4F467111FEF64486F40DFE7DF3500A03EE996A@ORSMSX111.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:38805 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdHVUQ6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Aug 2017 16:16:58 -0400
Received: by mail-io0-f195.google.com with SMTP id g71so117080ioe.5
        for <linux-acpi@vger.kernel.org>; Tue, 22 Aug 2017 13:16:58 -0700 (PDT)
In-Reply-To: <7A4F467111FEF64486F40DFE7DF3500A03EE996A@ORSMSX111.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yang, Hyungwoo" <hyungwoo.yang@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Ailus, Sakari" <sakari.ailus@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Aug 22, 2017 at 7:57 PM, Yang, Hyungwoo <hyungwoo.yang@intel.com> wrote:
>
> Hi Rafael,
>
> The problem was found while testing my code and the code is working fine with this patch.

OK, thanks for the confirmation!

I will apply it here, but Bob and Lv, please make the equivalent
change upstream.

Thanks,
Rafael


> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Monday, August 21, 2017 4:42 PM
>> To: Ailus, Sakari <sakari.ailus@intel.com>
>> Cc: Moore, Robert <robert.moore@intel.com>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Yang, Hyungwoo <hyungwoo.yang@intel.com>; Zheng, Lv <lv.zheng@intel.com>
>> Subject: Re: ACPI _DSD sub-node parsing broken in linux-next?
>>
>> On Monday, August 21, 2017 2:56:44 PM CEST Sakari Ailus wrote:
>> > Hi Bob, Rafael, others,
>> >
>> > There seem to be a problem with this patch recently merged to linux-pm
>> > tree for v4.13:
>> >
>> > <URL:https://git.linuxtv.org/media_tree.git/patch/drivers/acpi/acpica/
>> > nsxfeval.c?id=2d2a954375a0405fc721928f0dcc5ad1418996bc>
>> >
>> > Some callers and acpi_nonsubnode_data_ok() in particular call
>> > acpi_evaluate_object_typed() with NULL pathname argument which I
>> > understand was fine before that patch. After that patch, pathname is
>> > mandatory.
>> >
>> >
>>
>> Does the patch below help (untested here)?
>>
>> ---
>>  drivers/acpi/acpica/nsxfeval.c |   10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/acpica/nsxfeval.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/acpica/nsxfeval.c
>> +++ linux-pm/drivers/acpi/acpica/nsxfeval.c
>> @@ -100,9 +100,13 @@ acpi_evaluate_object_typed(acpi_handle h
>>               free_buffer_on_error = TRUE;
>>       }
>>
>> -     status = acpi_get_handle(handle, pathname, &target_handle);
>> -     if (ACPI_FAILURE(status)) {
>> -             return_ACPI_STATUS(status);
>> +     if (pathname) {
>> +             status = acpi_get_handle(handle, pathname, &target_handle);
>> +             if (ACPI_FAILURE(status)) {
>> +                     return_ACPI_STATUS(status);
>> +             }
>> +     } else {
>> +             target_handle = handle;
>>       }
>>
>>       full_pathname = acpi_ns_get_external_pathname(target_handle);
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
