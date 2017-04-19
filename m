From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 1/3] ACPI / bus: Introduce a list of ids for "always
 present" devices
Date: Wed, 19 Apr 2017 21:55:59 +0200
Message-ID: <CAJZ5v0huARFoMbYyiM3wQ0ah4gkvm6EJLRNZdng0P33sGqjxrA@mail.gmail.com>
References: <20170418115425.16068-1-hdegoede@redhat.com> <CAJZ5v0gL6+sNwcJpz+F_BgPUq6Qu5uCBeA_5zQHX3QO359yzbQ@mail.gmail.com>
 <2929a1e8-c471-ad05-8226-c680dfb35632@redhat.com> <CAJZ5v0gt1Vd7-eZZeDo3V9gyGp=cF6sqvwS6wQFie+7oi-hTLw@mail.gmail.com>
 <20170419161744.GA8262@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35797 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935996AbdDST4A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2017 15:56:00 -0400
Received: by mail-yw0-f194.google.com with SMTP id k13so3368549ywk.2
        for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2017 12:56:00 -0700 (PDT)
In-Reply-To: <20170419161744.GA8262@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Len Brown <lenb@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>

On Wed, Apr 19, 2017 at 6:17 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Wed, Apr 19, 2017 at 12:28:50PM +0200, Rafael J. Wysocki wrote:
>> On Wed, Apr 19, 2017 at 10:59 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> > On 18-04-17 15:34, Rafael J. Wysocki wrote:
>> >> On Tue, Apr 18, 2017 at 1:54 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> >>>
>> >>> Several Cherry Trail devices (all of which ship with Windows 10) hide the
>> >>> LPSS PWM controller in ACPI, typically the _STA method looks like this:
>> >>>
>> >>>     Method (_STA, 0, NotSerialized)  // _STA: Status
>> >>>     {
>> >>>         If (OSID == One)
>> >>>         {
>> >>>             Return (Zero)
>> >>>         }
>> >>>
>> >>>         Return (0x0F)
>> >>>     }
>> >>>
>> >>> Where OSID is some dark magic seen in all Cherry Trail ACPI tables making
>> >>> the machine behave differently depending on which OS it *thinks* it is
>> >>> booting, this gets set in a number of ways which we cannot control, on
>> >>> some newer machines it simple hardcoded to "One" aka win10.
>> >>>
>> >>> This causes the PWM controller to get hidden, which means Linux cannot
>> >>> control the backlight level on cht based tablets / laptops.
>> >>>
>> >>> Since loading the driver for this does no harm (the only in kernel user
>> >>> of it is the i915 driver, which will only use it when it needs it), this
>> >>> commit makes acpi_bus_get_status() always set status to ACPI_STA_DEFAULT
>> >>> for the 80862288 device, fixing the lack of backlight control.
>> >>>
>> >>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> >>> ---
>> >>>  drivers/acpi/bus.c      | 65
>> >>> +++++++++++++++++++++++++++++++++++++++++++++++++
>> >>>  include/acpi/acpi_bus.h |  6 +----
>> >>>  2 files changed, 66 insertions(+), 5 deletions(-)
>> >>>
>> >>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> >>> index 34fbe02..eb30630 100644
>> >>> --- a/drivers/acpi/bus.c
>> >>> +++ b/drivers/acpi/bus.c
>> >>> @@ -34,6 +34,8 @@
>> >>>  #include <linux/reboot.h>
>> >>>  #include <linux/delay.h>
>> >>>  #ifdef CONFIG_X86
>> >>> +#include <asm/cpu_device_id.h>
>> >>> +#include <asm/intel-family.h>
>> >>>  #include <asm/mpspec.h>
>> >>>  #endif
>> >>>  #include <linux/acpi_iort.h>
>> >>> @@ -132,6 +134,69 @@ int acpi_bus_get_status(struct acpi_device *device)
>> >>>  }
>> >>>  EXPORT_SYMBOL(acpi_bus_get_status);
>> >>>
>> >>> +#ifdef CONFIG_X86
>> >>> +/*
>> >>> + * Some ACPI devices are hidden (status == 0x0) in recent BIOS-es
>> >>> because
>> >>> + * some recent Windows drivers bind to one device but poke at multiple
>> >>> + * devices at the same time, so the others get hidden.
>> >>> + * We work around this by always reporting ACPI_STA_DEFAULT for these
>> >>> + * devices. Note this MUST only be done for devices where this is safe.
>> >>> + *
>> >>> + * This forcing of devices to be present is limited to specific CPU
>> >>> (SoC)
>> >>> + * models both to avoid potentially causing trouble on other models and
>> >>> + * because some HIDs are re-used on different SoCs for completely
>> >>> + * different devices.
>> >>> + */
>> >>> +struct always_present_device_id {
>> >>> +       struct acpi_device_id hid[2];
>> >>> +       struct x86_cpu_id cpu_ids[2];
>> >>
>> >> This really is x86-specific, so it should go into somewhere like
>> >> arch/x86/kernel/acpi/ or drivers/acpi/x86/ (not present yet).
>> >
>> > Ok, but then how do you want to hook this up, before you said
>> > that you wanted to deal with this in acpi_set_device_status(),
>> > which belongs in drivers/acpi/bus.c, do you want the x86
>> > code to provide something like a
>> >
>> > bool acpi_device_always_present(struct acpi_device *adev) {
>> > }
>> >
>> > Helper function and use that in the drivers/acpi/bus.c
>> > acpi_set_device_status() implementation ?
>>
>> Yes, something like that.
>>
>> In a header file you can make it depend on CONFIG_X86 and provide and
>> empty static inline stub for the "not defined" case.
>
> The PCI subsystem uses __weak stubs such as pcibios_add_bus() for arch-
> specific behaviour, or quirks which can be declared in arch/x86 to
> constrain them to this specific platform.
>
> Perhaps it makes sense to introduce ACPI quirks which can be declared
> the same way as PCI quirks to avoid cluttering the generic code with
> arch- or device-specific special cases.  So in this case we'd have
> something like:
>
> DECLARE_ACPI_FIXUP_STATUS(const char *hid, const char *uid, hook);
>
> And before calling _STA we'd check for presence of a fixup for the
> device in question.  Any additional stuff such as _HRV, CPU ID,
> DMI data could be checked in the fixup hook.  Thoughts?

Why don't we do that later if need be?

BTW, I'm not a big fan of __weak declarations as they result in dead
code being added to binaries.

> By the way:
>
>> >>> +void acpi_set_device_status(struct acpi_device *adev, u32 sta)
>> >>> +{
>> >>> +       u32 *status = (u32 *)&adev->status;
>> >>> +#ifdef CONFIG_X86
>> >>> +       u32 old_status = *status;
>> >>> +       int i;
>> >>> +
>> >>> +       /* acpi_match_device_ids checks status, so start with default */
>> >>> +       *status = ACPI_STA_DEFAULT;
>> >>> +       for (i = 0; i < ARRAY_SIZE(always_present_device_ids); i++) {
>> >>> +               if (acpi_match_device_ids(adev,
>> >>> +                       always_present_device_ids[i].hid) == 0 &&
>> >>> +                   adev->pnp.unique_id &&
>> >>> +                   strcmp(adev->pnp.unique_id,
>> >>> +                          always_present_device_ids[i].uid) == 0 &&
>> >>> +                   x86_match_cpu(always_present_device_ids[i].cpu_ids))
>> >>> {
>
> Why is this added to acpi_set_device_status(), rather than
> acpi_bus_get_status_handle() ?  That way you're gratuitously calling
> _STA even though you ignore its return value afterwards.

Because it doesn't make much sense for power resources.

Thanks,
Rafael
