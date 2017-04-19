From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 1/3] ACPI / bus: Introduce a list of ids for "always
 present" devices
Date: Wed, 19 Apr 2017 12:28:50 +0200
Message-ID: <CAJZ5v0gt1Vd7-eZZeDo3V9gyGp=cF6sqvwS6wQFie+7oi-hTLw@mail.gmail.com>
References: <20170418115425.16068-1-hdegoede@redhat.com> <CAJZ5v0gL6+sNwcJpz+F_BgPUq6Qu5uCBeA_5zQHX3QO359yzbQ@mail.gmail.com>
 <2929a1e8-c471-ad05-8226-c680dfb35632@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35588 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762201AbdDSK2v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2017 06:28:51 -0400
Received: by mail-oi0-f65.google.com with SMTP id g11so3727585oib.2
        for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2017 03:28:51 -0700 (PDT)
In-Reply-To: <2929a1e8-c471-ad05-8226-c680dfb35632@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>

On Wed, Apr 19, 2017 at 10:59 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 18-04-17 15:34, Rafael J. Wysocki wrote:
>>
>> On Tue, Apr 18, 2017 at 1:54 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Several Cherry Trail devices (all of which ship with Windows 10) hide the
>>> LPSS PWM controller in ACPI, typically the _STA method looks like this:
>>>
>>>     Method (_STA, 0, NotSerialized)  // _STA: Status
>>>     {
>>>         If (OSID == One)
>>>         {
>>>             Return (Zero)
>>>         }
>>>
>>>         Return (0x0F)
>>>     }
>>>
>>> Where OSID is some dark magic seen in all Cherry Trail ACPI tables making
>>> the machine behave differently depending on which OS it *thinks* it is
>>> booting, this gets set in a number of ways which we cannot control, on
>>> some newer machines it simple hardcoded to "One" aka win10.
>>>
>>> This causes the PWM controller to get hidden, which means Linux cannot
>>> control the backlight level on cht based tablets / laptops.
>>>
>>> Since loading the driver for this does no harm (the only in kernel user
>>> of it is the i915 driver, which will only use it when it needs it), this
>>> commit makes acpi_bus_get_status() always set status to ACPI_STA_DEFAULT
>>> for the 80862288 device, fixing the lack of backlight control.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> -Use pr_debug instead of ACPI_DEBUG_PRINT
>>> Changes in v3:
>>> -Un-inline acpi_set_device_status and do the always_present_device_ids
>>>  table check inside the un-inlined version of it
>>> Changes in v4:
>>> -Use dev_info instead of pr_debug
>>> -Not only check for ACPI HID but also for CPU (SoC) model so as to not
>>>  for devices present on other models then for which the quirk is intended
>>> and
>>>  to avoid enabling unrelated ACPI devices which happen to use the same
>>> HID
>>> Changes in v5:
>>> -Only do the dev_info once per device (acpi_set_device_status gets called
>>>  multiple times per device during boot)
>>> Changes in v6:
>>> -Allow specifying more then one CPU-model for a single HID
>>> -Not only match the HID but also the UID, like on Cherry Trail, on some
>>> Bay
>>>  Trail Windows 10 tablets we need to enable the PWM controller to get
>>> working
>>>  backlight even though _STA returns 0. The Bay Trail SoC has 2 PWM
>>> controllers
>>>  and we only need the first one. UID matching will allows adding an entry
>>> for
>>>  Bay Trail which only enables the first PWM controller
>>> ---
>>>  drivers/acpi/bus.c      | 65
>>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>>  include/acpi/acpi_bus.h |  6 +----
>>>  2 files changed, 66 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>>> index 34fbe02..eb30630 100644
>>> --- a/drivers/acpi/bus.c
>>> +++ b/drivers/acpi/bus.c
>>> @@ -34,6 +34,8 @@
>>>  #include <linux/reboot.h>
>>>  #include <linux/delay.h>
>>>  #ifdef CONFIG_X86
>>> +#include <asm/cpu_device_id.h>
>>> +#include <asm/intel-family.h>
>>>  #include <asm/mpspec.h>
>>>  #endif
>>>  #include <linux/acpi_iort.h>
>>> @@ -132,6 +134,69 @@ int acpi_bus_get_status(struct acpi_device *device)
>>>  }
>>>  EXPORT_SYMBOL(acpi_bus_get_status);
>>>
>>> +#ifdef CONFIG_X86
>>> +/*
>>> + * Some ACPI devices are hidden (status == 0x0) in recent BIOS-es
>>> because
>>> + * some recent Windows drivers bind to one device but poke at multiple
>>> + * devices at the same time, so the others get hidden.
>>> + * We work around this by always reporting ACPI_STA_DEFAULT for these
>>> + * devices. Note this MUST only be done for devices where this is safe.
>>> + *
>>> + * This forcing of devices to be present is limited to specific CPU
>>> (SoC)
>>> + * models both to avoid potentially causing trouble on other models and
>>> + * because some HIDs are re-used on different SoCs for completely
>>> + * different devices.
>>> + */
>>> +struct always_present_device_id {
>>> +       struct acpi_device_id hid[2];
>>> +       struct x86_cpu_id cpu_ids[2];
>>
>>
>> This really is x86-specific, so it should go into somewhere like
>> arch/x86/kernel/acpi/ or drivers/acpi/x86/ (not present yet).
>
>
> Ok, but then how do you want to hook this up, before you said
> that you wanted to deal with this in acpi_set_device_status(),
> which belongs in drivers/acpi/bus.c, do you want the x86
> code to provide something like a
>
> bool acpi_device_always_present(struct acpi_device *adev) {
> }
>
> Helper function and use that in the drivers/acpi/bus.c
> acpi_set_device_status() implementation ?

Yes, something like that.

In a header file you can make it depend on CONFIG_X86 and provide and
empty static inline stub for the "not defined" case.

>>
>>> +       const char *uid;
>>> +};
>>> +
>>> +#define ICPU(model)    { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
>>> +
>>> +#define ENTRY(hid, uid, cpu_models) {                                  \
>>> +       { { hid, }, {} },                                               \
>>> +       { cpu_models, {} },                                             \
>>> +       uid,                                                            \
>>> +}
>>> +
>>> +static const struct always_present_device_id always_present_device_ids[]
>>> = {
>>> +       /*
>>> +        * Cherry Trail PWM directly poked by GPU driver in win10,
>>> +        * but Linux uses a separate PWM driver, harmless if not used.
>>> +        */
>>> +       ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT)),
>>> +};
>>> +#endif
>>> +
>>> +void acpi_set_device_status(struct acpi_device *adev, u32 sta)
>>> +{
>>> +       u32 *status = (u32 *)&adev->status;
>>> +#ifdef CONFIG_X86
>>> +       u32 old_status = *status;
>>> +       int i;
>>> +
>>> +       /* acpi_match_device_ids checks status, so start with default */
>>> +       *status = ACPI_STA_DEFAULT;
>>> +       for (i = 0; i < ARRAY_SIZE(always_present_device_ids); i++) {
>>> +               if (acpi_match_device_ids(adev,
>>> +                       always_present_device_ids[i].hid) == 0 &&
>>> +                   adev->pnp.unique_id &&
>>> +                   strcmp(adev->pnp.unique_id,
>>> +                          always_present_device_ids[i].uid) == 0 &&
>>> +                   x86_match_cpu(always_present_device_ids[i].cpu_ids))
>>> {
>>
>>
>> Split this condition please.  It is almost unreadable as is.
>
>
> Not sure what you want me to do here ? Use multiple if's with "continue"
> if the check fails, or add whitespace (empty lines) between the conditions,
> or ... ?

I would do the multiple if()s variant.

The compiler should coalesce them anyway if it is smart enough.

Thanks,
Rafael
