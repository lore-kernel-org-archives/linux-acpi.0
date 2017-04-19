From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 1/2] ACPI / bus: Introduce a list of ids for "always
 present" devices
Date: Wed, 19 Apr 2017 22:14:43 +0200
Message-ID: <CAJZ5v0jkE0DWBewfzJGM5i92FQrKv_=EKR5hu28NR=hw4Kv2jw@mail.gmail.com>
References: <20170419120408.25037-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35161 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765361AbdDSUOp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2017 16:14:45 -0400
Received: by mail-yb0-f194.google.com with SMTP id 19so2235578ybl.2
        for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2017 13:14:44 -0700 (PDT)
In-Reply-To: <20170419120408.25037-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Apr 19, 2017 at 2:04 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Several Bay / Cherry Trail devices (all of which ship with Windows 10) hide
> the LPSS PWM controller in ACPI, typically the _STA method looks like this:
>
>     Method (_STA, 0, NotSerialized)  // _STA: Status
>     {
>         If (OSID == One)
>         {
>             Return (Zero)
>         }
>
>         Return (0x0F)
>     }
>
> Where OSID is some dark magic seen in all Cherry Trail ACPI tables making
> the machine behave differently depending on which OS it *thinks* it is
> booting, this gets set in a number of ways which we cannot control, on
> some newer machines it simple hardcoded to "One" aka win10.
>
> This causes the PWM controller to get hidden, which means Linux cannot
> control the backlight level on cht based tablets / laptops.
>
> Since loading the driver for this does no harm (the only in kernel user
> of it is the i915 driver, which will only uses it when it needs it), this
> commit makes acpi_bus_get_status() always set status to ACPI_STA_DEFAULT
> for the LPSS PWM device, fixing the lack of backlight control.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use pr_debug instead of ACPI_DEBUG_PRINT
> Changes in v3:
> -Un-inline acpi_set_device_status and do the always_present_device_ids
>  table check inside the un-inlined version of it
> Changes in v4:
> -Use dev_info instead of pr_debug
> -Not only check for ACPI HID but also for CPU (SoC) model so as to not
>  for devices present on other models then for which the quirk is intended and
>  to avoid enabling unrelated ACPI devices which happen to use the same HID
> Changes in v5:
> -Only do the dev_info once per device (acpi_set_device_status gets called
>  multiple times per device during boot)
> Changes in v6:
> -Allow specifying more then one CPU-model for a single HID
> -Not only match the HID but also the UID, like on Cherry Trail, on some Bay
>  Trail Windows 10 tablets we need to enable the PWM controller to get working
>  backlight even though _STA returns 0. The Bay Trail SoC has 2 PWM controllers
>  and we only need the first one. UID matching will allows adding an entry for
>  Bay Trail which only enables the first PWM controller
> Changes in v7:
> -Put the actual x86 specific matching code and table with always present
>  device HID + UID + CPU model entries in a new x86/x86_utils.c file which
>  provides an acpi_device_always_present() helper function on x86, on
>  non x86 a stub which always returns false is provided
> -Squash in the addition of the Bay Trail PWM entry in the table as it
>  is there for the same reasons as the Cherry Trail entry is there
> ---
>  drivers/acpi/Makefile        |  1 +
>  drivers/acpi/bus.c           | 10 ++++++
>  drivers/acpi/x86/x86_utils.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h      | 15 +++++---
>  4 files changed, 106 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/acpi/x86/x86_utils.c
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d78065c..f3940ac 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -50,6 +50,7 @@ acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) += evged.o
>  acpi-y                         += sysfs.o
>  acpi-y                         += property.o
>  acpi-$(CONFIG_X86)             += acpi_cmos_rtc.o
> +acpi-$(CONFIG_X86)             += x86/x86_utils.o
>  acpi-$(CONFIG_DEBUG_FS)                += debugfs.o
>  acpi-$(CONFIG_ACPI_NUMA)       += numa.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 34fbe02..4d952cc 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -132,6 +132,16 @@ int acpi_bus_get_status(struct acpi_device *device)
>  }
>  EXPORT_SYMBOL(acpi_bus_get_status);
>
> +void acpi_set_device_status(struct acpi_device *adev, u32 sta)
> +{
> +       u32 *status = (u32 *)&adev->status;
> +
> +       if (acpi_device_always_present(adev))
> +               *status = ACPI_STA_DEFAULT;
> +       else
> +               *status = sta;

*((u32 *)&adev->status) = acpi_device_always_present(adev) ?
ACPI_STA_DEFAULT : sta;

and I guess it could still be static inline?

But that said, evaluating _STA for the always present devices is
pointless (as Lukas noticed), so why not to modify
acpi_bus_get_status() to do something like:

    if (acpi_device_always_present(adev)) {
        acpi_set_device_status(adev, ACPI_STA_DEFAULT);
        return 0;
    }

upfront and modify the other path invoking acpi_set_device_status() accordingly.

And in that path, which I seem to have overlooked before, the
acpi_set_device_status() call is too early for invoking
acpi_device_always_present(adev), so the latter should be called
directly from acpi_add_single_object() like

    acpi_init_device_object(device, handle, type, sta);
    if (acpi_device_always_present(adev))
        acpi_set_device_status(adev, ACPI_STA_DEFAULT);

Thanks,
Rafael
