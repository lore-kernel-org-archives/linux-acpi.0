From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH v4] acpi: indicate to platform when hot remove returns busy
Date: Mon, 3 Jul 2017 20:08:51 +0300
Message-ID: <CAHp75Vcyyp2m70mCy6DJi=N4HuC8CVf=3RyRoT3yZK9j3Ue0aw@mail.gmail.com>
References: <20170703132610.21719-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33935 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754744AbdGCRIw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2017 13:08:52 -0400
In-Reply-To: <20170703132610.21719-1-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Michal Hocko <mhocko@suse.cz>

On Mon, Jul 3, 2017 at 4:26 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
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
> not just terminate the hot-remove process by unknown reason. For
> example, platform can wait for a while then triggers hot-remove
> again.
>
> This RFC patch adds one more parameter to the handler function of
> acpi generic hotplug event to give the function a chance to propose
> the return code of _OST. In this case, it sets ost return code to
> ACPI_OST_SC_DEVICE_BUSY when the acpi hot remove function returns
> -EBUSY.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> v4:
> Use switch-case statements to simplify code. (Andy Shevchenko, Rafael J. Wysocki)
>
> v3:
> Removed redundant 'else' in acpi_ost_status_code(). (Andy Shevchenko)
>
> v2:
> Do not overwrite ost code in acpi_generic_hotplug_event(). Move
> the "error code to ost code" logic to a help function. (Andy Shevchenko)
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Michal Hocko <mhocko@suse.cz>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  drivers/acpi/scan.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index d531629..ce88175 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -404,10 +404,6 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
>                 error = dock_notify(adev, src);
>         } else if (adev->flags.hotplug_notify) {
>                 error = acpi_generic_hotplug_event(adev, src);
> -               if (error == -EPERM) {
> -                       ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> -                       goto err_out;
> -               }
>         } else {
>                 int (*notify)(struct acpi_device *, u32);
>
> @@ -423,8 +419,20 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
>                 else
>                         goto out;
>         }
> -       if (!error)
> +       switch (error) {
> +       case 0:
>                 ost_code = ACPI_OST_SC_SUCCESS;
> +               break;
> +       case -EPERM:
> +               ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> +               break;
> +       case -EBUSY:
> +               ost_code = ACPI_OST_SC_DEVICE_BUSY;
> +               break;
> +       default:
> +               ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
> +               break;
> +       }
>
>   err_out:
>         acpi_evaluate_ost(adev->handle, src, ost_code, NULL);
> --
> 2.10.2
>



-- 
With Best Regards,
Andy Shevchenko
