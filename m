From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] platform/x86: intel-hid: Wake up Dell Latitude 7275 from suspend-to-idle
Date: Tue, 1 Aug 2017 13:56:35 +0200
Message-ID: <CAJZ5v0jimcsL3+BfyfjSxjZRjWVFXunPRDquCp-V1SHi32f+=w@mail.gmail.com>
References: <7313224.XbtxUoJtXM@aspire.rjw.lan> <3172146.dPhkKZoKtx@aspire.rjw.lan>
 <CAHp75VfouHVbj0X3PJfRHy2uSziq-P__N5ezbmsuUNYDwDxYKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:37736 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdHAL4h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2017 07:56:37 -0400
In-Reply-To: <CAHp75VfouHVbj0X3PJfRHy2uSziq-P__N5ezbmsuUNYDwDxYKg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Platform Driver <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, Mario Limonciello <mario.limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>

On Tue, Aug 1, 2017 at 1:21 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Aug 1, 2017 at 12:46 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wr=
ote:
>> On Friday, July 28, 2017 02:06:36 AM Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> On Dell Latitude 7275 the 5-button array is not exposed in the
>>> ACPI tables, but still notifies are sent to the Intel HID device
>>> object (device ID INT33D5) in response to power button actions while
>>> suspended to idle.  However, they are currently ignored as the
>>> intel-hid driver is not prepared to take care of them.
>>>
>>> As a result, power button wakeup from suspend-to-idle doesn't work
>>> on this platform, but suspend-to-idle is the only reliable suspend
>>> variant on it (the S3 implementation in the platform firmware turns
>>> out to be broken), so it would be good to handle it properly.
>>>
>>> For this reason, add an upfront check against the power button press
>>> event (0xCE) to notify_handler() in the wakeup mode which allows it
>>> to catch the power button wakeup notification on the affected
>>> platform (even though priv->array is NULL on it) and should not
>>> change the behavior on platforms with priv->array present (because
>>> priv->array contains the event in question in those cases).
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D196115
>>> Tested-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Please note that this change is requisite for
>>
>> https://patchwork.kernel.org/patch/9873159/
>>
>> so are there any objections or concerns?
>
> Not from my side,
>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

OK, thanks!

I'm going to route it through the PM tree then if that's not a problem.

Thanks,
Rafael
