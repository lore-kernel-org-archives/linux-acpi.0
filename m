From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] acpi: indicate to platform when hot remove returns busy
Date: Fri, 9 Jun 2017 18:36:32 +0300
Message-ID: <CAHp75VeA9d5HWD_vyxMvoAG7PWR9nwTi4DL=Vdb9GxLsKzjY-w@mail.gmail.com>
References: <20170609105451.461-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609105451.461-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 9, 2017 at 1:54 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
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

Below looks better for my taste.
See also comments.

> +static int acpi_ost_status_code(u32 src, int error)
> +{
> +       switch (src) {
> +       case ACPI_NOTIFY_EJECT_REQUEST:
> +       case ACPI_OST_EC_OSPM_EJECT:

> +               if (error == -EPERM)
> +                       return ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> +               else if (error == -EBUSY)

Redundant else...

> +                       return ACPI_OST_SC_DEVICE_BUSY;

Perhaps switch case here as well?
switch (error) {
 case -EPERM;
   return X;
 case -EBUSY:
   return Y;
}

> +               break;
> +       }
> +       return error ? ACPI_OST_SC_NON_SPECIFIC_FAILURE : ACPI_OST_SC_SUCCESS;
> +}


> +       ost_code = acpi_ost_status_code(src, error);
>   err_out:

I guess you need to swap those lines.

>         acpi_evaluate_ost(adev->handle, src, ost_code, NULL);

-- 
With Best Regards,
Andy Shevchenko
