From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH] acpi: indicate to platform when hot remove returns busy
Date: Sat, 3 Jun 2017 20:37:51 +0300
Message-ID: <CAHp75VcBd8e7Ce8KbyqtnoBKv7c5W9qb9o70-oViz6iCoRMShw@mail.gmail.com>
References: <20170603172036.7645-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35654 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdFCRhx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Jun 2017 13:37:53 -0400
In-Reply-To: <20170603172036.7645-1-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>

On Sat, Jun 3, 2017 at 8:20 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> In hotplug logic, it always indicates non-specific failure to
> platform through _OST when handing acpi hot-remove event failed. Then
> platform terminates the hot-remove process but it can not identify
> the reason.
>
> Base on current hot-remove code, there have two situations that it
> returns busy:
>  - OSPM try to offline an individual device, but the device offline
>    function returns busy.
>  - When the ejection event is applied to an "not offlined yet" container.
>    OSPM send kobject change event to userspace and returns busy.
>
> Both of them will returns -EBUSY to acpi device hotplug function then
> hotplug function indicates non-specific failure to platform just like
> any other error, e.g. -ENODEV or -EIO.
>
> The benefit to platform for identifying the OS busy state is that
> platform can be applied different approach to handle the busy but
> not just terminate the hot-remove process by unknow reason. For
> example, platform can wait for a while then triggers hot-remove
> again.
>
> This RFC patch adds one more parameter to the handler function of
> acpi generic hotplug event to give the function a chance to propose
> the return code of _OST. In this case, it sets ost return code to
> ACPI_OST_SC_DEVICE_BUSY when the acpi hot remove function returns
> -EBUSY.

> -static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
> +static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type,
> +                                     u32 *ost_code)
>  {
> +       int error = -EINVAL;
> +
>         switch (type) {
>         case ACPI_NOTIFY_BUS_CHECK:
>                 return acpi_scan_bus_check(adev);
> @@ -389,9 +392,11 @@ static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
>                 }
>                 acpi_evaluate_ost(adev->handle, ACPI_NOTIFY_EJECT_REQUEST,
>                                   ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
> -               return acpi_scan_hot_remove(adev);
> +               error = acpi_scan_hot_remove(adev);
> +               if (error == -EBUSY && ost_code)
> +                       *ost_code = ACPI_OST_SC_DEVICE_BUSY;
>         }
> -       return -EINVAL;
> +       return error;
>  }

Wit this change you spear a logic on two functions...

>
>  void acpi_device_hotplug(struct acpi_device *adev, u32 src)
> @@ -413,7 +418,7 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
>         if (adev->flags.is_dock_station) {
>                 error = dock_notify(adev, src);
>         } else if (adev->flags.hotplug_notify) {
> -               error = acpi_generic_hotplug_event(adev, src);
> +               error = acpi_generic_hotplug_event(adev, src, &ost_code);
>                 if (error == -EPERM) {
>                         ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
>                         goto err_out;

...instead (since the first one is defined as static) I would propose
to change only here like

switch (error) {
case -EPERM:
ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
break;
case -EBUSY:
ost_code = ACPI_OST_SC_DEVICE_BUSY;
break;
}
if (error)
 goto err_out;

This is less intrusive and more flexible to modifications in the
future (might be split to a helper, might be easily extended, etc).

-- 
With Best Regards,
Andy Shevchenko
