From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/5] ACPI / bus: Do not traverse through non-existed
 device table
Date: Thu, 8 Feb 2018 17:01:29 +0100
Message-ID: <CAJZ5v0hdA4AHwcJLp9JoWKTjJwz2CHGfHnkSQ=xgOv-k93if-g@mail.gmail.com>
References: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com>
 <20180207145610.88434-2-andriy.shevchenko@linux.intel.com> <CAJZ5v0iEB74dPUN400pfB4+AV--NZj7hs6aZGiSoSiz5cTS37g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45849 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHQBa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Feb 2018 11:01:30 -0500
In-Reply-To: <CAJZ5v0iEB74dPUN400pfB4+AV--NZj7hs6aZGiSoSiz5cTS37g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, Feb 8, 2018 at 4:59 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Feb 7, 2018 at 3:56 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> When __acpi_match_device() is called it would be possible to have
>> ACPI ID table a MULL pointer. To avoid potential dereference,
>> check for this before traverse.
>>
>> While here, remove redundant 'else'.
>>
>> Cc: Sinan Kaya <okaya@codeaurora.org>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/acpi/bus.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 761286e50067..da7e9cf770a6 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -752,11 +752,13 @@ static const struct acpi_device_id *__acpi_match_device(
>>
>>         list_for_each_entry(hwid, &device->pnp.ids, list) {
>>                 /* First, check the ACPI/PNP IDs provided by the caller. */
>> -               for (id = ids; id->id[0] || id->cls; id++) {
>> -                       if (id->id[0] && !strcmp((char *) id->id, hwid->id))
>> -                               return id;
>> -                       else if (id->cls && __acpi_match_device_cls(id, hwid))
>> -                               return id;
>> +               if (ids) {
>> +                       for (id = ids; id->id[0] || id->cls; id++) {
>> +                               if (id->id[0] && !strcmp((char *)id->id, hwid->id))
>> +                                       return id;
>> +                               if (id->cls && __acpi_match_device_cls(id, hwid))
>> +                                       return id;
>> +                       }
>>                 }
>>
>>                 /*
>> --
>
> The return value below should be updated in *this* patch, because this
> is what allows ids to be NULL in the first place.
>
> And as far as I'm concerned you can do:
>
> if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)

Missing paren, sorry.

>         return (const struct acpi_device_id
> *)acpi_of_match_device(device, of_ids);
>
> and update the comment accordingly.
