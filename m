From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Subject: Re: [PATCH] platform/x86: intel-hid: Power button suspend on Dell
 Latitude 7275
Date: Tue, 19 Sep 2017 00:40:48 +0200
Message-ID: <CA+kEDGGv3twZP4od16bPHjW8-S3PHs=SpQZEF1tqr5M4cBpzFQ@mail.gmail.com>
References: <20170917225712.12136-1-jerome.debretagne@gmail.com> <4b5c673c2858470a8b6d0af43a2cd250@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4b5c673c2858470a8b6d0af43a2cd250@ausx13mpc120.AMER.DELL.COM>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alex Hung <alex.hung@canonical.com>
List-Id: linux-acpi@vger.kernel.org

2017-09-18 23:29 GMT+02:00  <Mario.Limonciello@dell.com>:
>> -----Original Message-----
>> From: J=C3=A9r=C3=B4me de Bretagne [mailto:jerome.debretagne@gmail.com]
>> Sent: Sunday, September 17, 2017 5:57 PM
>> To: platform-driver-x86@vger.kernel.org
>> Cc: Darren Hart <dvhart@infradead.org>; LKML <linux-kernel@vger.kernel.o=
rg>;
>> Linux ACPI <linux-acpi@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysock=
i.net>;
>> Andy Shevchenko <andy.shevchenko@gmail.com>; Limonciello, Mario
>> <Mario_Limonciello@Dell.com>; Alex Hung <alex.hung@canonical.com>
>> Subject: [PATCH] platform/x86: intel-hid: Power button suspend on Dell L=
atitude
>> 7275
>>
>> From: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
>>
>> On Dell Latitude 7275 the 5-button array is not exposed in the
>> ACPI tables, but still notifies are sent to the Intel HID device
>> object (device ID INT33D5) in response to power button actions.
>> They were ignored as the intel-hid driver was not prepared to
>> take care of them until recently.
>>
>> Power button wakeup from suspend-to-idle was added in:
>> 635173a17b03 ("intel-hid: Wake up Dell Latitude 7275 from
>> suspend-to-idle"). However power button suspend doesn't work
>> yet on this platform so it would be good to add it also.
>>
>> On the affected platform (for which priv->array is NULL), add
>> a new upfront check against the power button press notification
>> (0xCE) to notify_handler(), outside the wakeup mode this time,
>> which allows to report the power button press event and
>> trigger the suspend. Also catch and ignore the corresponding
>> power button release notification (0xCF) to stop it from being
>> reported as an "unknown event" in the logs.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D196115
>> Tested-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
>> Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com=
>
>> ---
>>  drivers/platform/x86/intel-hid.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/int=
el-hid.c
>> index a782c78e7c63..b19f8dcf9d8c 100644
>> --- a/drivers/platform/x86/intel-hid.c
>> +++ b/drivers/platform/x86/intel-hid.c
>> @@ -226,6 +226,22 @@ static void notify_handler(acpi_handle handle, u32 =
event,
>> void *context)
>>               return;
>>       }
>>
>> +     /*
>> +      * Needed for suspend to work on some platforms that don't expose
>> +      * the 5-button array, but still send notifies with power button
>> +      * event code to this device object on power button actions.
>> +      *
>> +      * Report the power button press; catch and ignore the button rele=
ase.
>> +      */
>> +     if (!priv->array) {
>> +             if (event =3D=3D 0xce) {
>> +                     input_report_key(priv->input_dev, KEY_POWER, 1);
>> +                     input_sync(priv->input_dev);
>> +                     return;
>> +             } else if (event =3D=3D 0xcf)
>> +                     return;
>> +     }
>> +
>>       /* 0xC0 is for HID events, other values are for 5 button array */
>>       if (event !=3D 0xc0) {
>>               if (!priv->array ||
>
> LGTM, it's improved from what you posted to that bug already.
>
> Acked-By: Mario Limonciello <mario.limonciello@dell.com>

Thanks Mario.

In fact, I updated my initial fix proposal on the 12th in [1] and
this patch matches exactly the updated version. You didn't receive
the update notification from Bugzilla?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D196115#c12
