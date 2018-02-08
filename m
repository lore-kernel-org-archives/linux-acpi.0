From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/5] ACPI / bus: Return error code from
 __acpi_match_device() in one case
Date: Thu, 8 Feb 2018 16:45:58 +0100
Message-ID: <CAJZ5v0jzxFA4PSigPST4gtpYOMeT_8rkuYsgJeOUcXLq0BPWbg@mail.gmail.com>
References: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0gkn4keNLA4jyCDOjSB4EGhya0d7ecwo-4zDQ=+E9PnJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41001 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752285AbeBHPqA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Feb 2018 10:46:00 -0500
In-Reply-To: <CAJZ5v0gkn4keNLA4jyCDOjSB4EGhya0d7ecwo-4zDQ=+E9PnJA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, Feb 8, 2018 at 4:14 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Feb 7, 2018 at 3:56 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> Instead of playing tricks with last invalid entry,
>> return simple -ENODATA error code cast to pointer.
>>
>> It would be good for future in case caller passes NULL pointer for
>> ID table. Moreover, caller can check the code to be sure what happened
>> inside callee.
>>
>> Fixes: 2b9c698efa58 ("ACPI / scan: Take the PRP0001 position in the list of IDs into account")
>
> I still don't think the Fixes: tag here is valid (the code works as is
> AFAICS), but I could drop it when applying the patch just fine. :-)
>
> That said, see below.
>
>> Cc: Sinan Kaya <okaya@codeaurora.org>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/acpi/bus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 58239abb0a72..761286e50067 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -769,7 +769,7 @@ static const struct acpi_device_id *__acpi_match_device(
>>                  */
>>                 if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)
>>                     && acpi_of_match_device(device, of_ids))
>> -                       return id;
>> +                       return ERR_PTR(-ENODATA);
>
> Doesn't the comment above need to be updated?
>
> Also the return value here means "success", so why is an error the right choice?

Moreover, if ids is NULL, then dereferencing it in the loop above
won't work already, so if we get here, there is at least one entry in
it.
