From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] acpi: handle the acpi hotplug schedule error
Date: Fri, 9 Jun 2017 12:40:29 +0300
Message-ID: <CAHp75VewHLZ_R17_onFa=QAvmoNzSjmiyiB+0qsKaoXT7UW4wg@mail.gmail.com>
References: <20170609043345.14561-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36360 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdFIJka (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jun 2017 05:40:30 -0400
In-Reply-To: <20170609043345.14561-1-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>

On Fri, Jun 9, 2017 at 7:33 AM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> Kernel should decrements the reference count of acpi device
> when the scheduling of acpi hotplug work is failed, and
> evaluates _OST to notify BIOS the failure.
>
> v2:
> To simplify the code. (Andy Shevchenko)
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  drivers/acpi/bus.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 34fbe02..91adb71 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -427,12 +427,17 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
>             (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
>                 driver->ops.notify(adev, type);
>
> -       if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> -               return;
> +       if (hotplug_event) {
> +               if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> +                       return;
> +               goto err_put_device;
> +       }
>
>         acpi_bus_put_acpi_device(adev);
>         return;
>
> + err_put_device:
> +       acpi_bus_put_acpi_device(adev);
>   err:
>         acpi_evaluate_ost(handle, type, ost_code, NULL);
>  }
> --
> 2.10.2
>



-- 
With Best Regards,
Andy Shevchenko
