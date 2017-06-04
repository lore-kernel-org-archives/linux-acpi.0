From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH] acpi: indicate to platform when hot remove returns busy
Date: Sun, 4 Jun 2017 22:02:20 +0300
Message-ID: <CAHp75Vf92MYFG9xGmjw4YbOQzqTEHOXk-YzgzTzoksC4rfo9ew@mail.gmail.com>
References: <20170603172036.7645-1-jlee@suse.com> <CAHp75VcBd8e7Ce8KbyqtnoBKv7c5W9qb9o70-oViz6iCoRMShw@mail.gmail.com>
 <20170604100453.GK30622@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34176 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdFDTCW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jun 2017 15:02:22 -0400
In-Reply-To: <20170604100453.GK30622@linux-l9pv.suse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Sun, Jun 4, 2017 at 1:04 PM, joeyli <jlee@suse.com> wrote:
> On Sat, Jun 03, 2017 at 08:37:51PM +0300, Andy Shevchenko wrote:
>> On Sat, Jun 3, 2017 at 8:20 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:

>> > -static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
>> > +static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type,
>> > +                                     u32 *ost_code)
>> >  {
>> > +       int error = -EINVAL;
>> > +
>> >         switch (type) {
>> >         case ACPI_NOTIFY_BUS_CHECK:
>> >                 return acpi_scan_bus_check(adev);
>> > @@ -389,9 +392,11 @@ static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
>> >                 }
>> >                 acpi_evaluate_ost(adev->handle, ACPI_NOTIFY_EJECT_REQUEST,
>> >                                   ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
>> > -               return acpi_scan_hot_remove(adev);
>> > +               error = acpi_scan_hot_remove(adev);
>> > +               if (error == -EBUSY && ost_code)
>> > +                       *ost_code = ACPI_OST_SC_DEVICE_BUSY;
>> >         }
>> > -       return -EINVAL;
>> > +       return error;
>> >  }
>>
>> Wit this change you spear a logic on two functions...
>>
>
> You are right.
>
> I want to give a chance to acpi_generic_hotplug_event()
> to propose a _OST code. But acpi_device_hotplug() can
> overwrite it. Not good...

...

>> This is less intrusive and more flexible to modifications in the
>> future (might be split to a helper, might be easily extended, etc).
>>
>
> this RFC patch changed the _OST code for BIOS that it may affects
> the behavior of shipped machines. And, I am not sure that the
> ACPI_OST_SC_DEVICE_BUSY approach is also useful for other hotplug
> event, like ACPI_NOTIFY_BUS_CHECK or ACPI_NOTIFY_DEVICE_CHECK.
>
> So, I prefer to apply this change only on the code path of
> ACPI_NOTIFY_EJECT_REQUEST/ACPI_OST_EC_OSPM_EJECT.
>
> Here is my first version, that it just simply put if-else logic:
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 2433569..b105087 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -414,10 +414,14 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
>                 error = dock_notify(adev, src);
>         } else if (adev->flags.hotplug_notify) {
>                 error = acpi_generic_hotplug_event(adev, src);
> -               if (error == -EPERM) {
> +               if (error == -EPERM)
>                         ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> +               else if ((error == -EBUSY) &&
> +                        (src == ACPI_NOTIFY_EJECT_REQUEST ||
> +                         src == ACPI_OST_EC_OSPM_EJECT))
> +                       ost_code = ACPI_OST_SC_DEVICE_BUSY;
> +               if (error)
>                         goto err_out;
> -               }
>         } else {
>                 int (*notify)(struct acpi_device *, u32);
>
> Because it checks the event source that the logic is duplicate
> with the switch code in acpi_generic_hotplug_event(). So I
> reuse the switch code in acpi_generic_hotplug_event().

I see. Then I leave this to Rafael to decide.

-- 
With Best Regards,
Andy Shevchenko
