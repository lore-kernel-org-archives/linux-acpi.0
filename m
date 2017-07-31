From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] platform/x86: intel-hid: Wake up Dell Latitude 7275 from suspend-to-idle
Date: Tue, 1 Aug 2017 02:21:45 +0300
Message-ID: <CAHp75VfouHVbj0X3PJfRHy2uSziq-P__N5ezbmsuUNYDwDxYKg@mail.gmail.com>
References: <7313224.XbtxUoJtXM@aspire.rjw.lan> <3172146.dPhkKZoKtx@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36388 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbdGaXVq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jul 2017 19:21:46 -0400
In-Reply-To: <3172146.dPhkKZoKtx@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, Mario Limonciello <mario.limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>

On Tue, Aug 1, 2017 at 12:46 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrot=
e:
> On Friday, July 28, 2017 02:06:36 AM Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> On Dell Latitude 7275 the 5-button array is not exposed in the
>> ACPI tables, but still notifies are sent to the Intel HID device
>> object (device ID INT33D5) in response to power button actions while
>> suspended to idle.  However, they are currently ignored as the
>> intel-hid driver is not prepared to take care of them.
>>
>> As a result, power button wakeup from suspend-to-idle doesn't work
>> on this platform, but suspend-to-idle is the only reliable suspend
>> variant on it (the S3 implementation in the platform firmware turns
>> out to be broken), so it would be good to handle it properly.
>>
>> For this reason, add an upfront check against the power button press
>> event (0xCE) to notify_handler() in the wakeup mode which allows it
>> to catch the power button wakeup notification on the affected
>> platform (even though priv->array is NULL on it) and should not
>> change the behavior on platforms with priv->array present (because
>> priv->array contains the event in question in those cases).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D196115
>> Tested-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Please note that this change is requisite for
>
> https://patchwork.kernel.org/patch/9873159/
>
> so are there any objections or concerns?

Not from my side,

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
>> ---
>>  drivers/platform/x86/intel-hid.c |   17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> Index: linux-pm/drivers/platform/x86/intel-hid.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-pm.orig/drivers/platform/x86/intel-hid.c
>> +++ linux-pm/drivers/platform/x86/intel-hid.c
>> @@ -203,15 +203,26 @@ static void notify_handler(acpi_handle h
>>       acpi_status status;
>>
>>       if (priv->wakeup_mode) {
>> +             /*
>> +              * Needed for wakeup from suspend-to-idle to work on some
>> +              * platforms that don't expose the 5-button array, but sti=
ll
>> +              * send notifies with the power button event code to this
>> +              * device object on power button actions while suspended.
>> +              */
>> +             if (event =3D=3D 0xce)
>> +                     goto wakeup;
>> +
>>               /* Wake up on 5-button array events only. */
>>               if (event =3D=3D 0xc0 || !priv->array)
>>                       return;
>>
>> -             if (sparse_keymap_entry_from_scancode(priv->array, event))
>> -                     pm_wakeup_hard_event(&device->dev);
>> -             else
>> +             if (!sparse_keymap_entry_from_scancode(priv->array, event)=
) {
>>                       dev_info(&device->dev, "unknown event 0x%x\n", eve=
nt);
>> +                     return;
>> +             }
>>
>> +wakeup:
>> +             pm_wakeup_hard_event(&device->dev);
>>               return;
>>       }
>>
>>
>



--=20
With Best Regards,
Andy Shevchenko
