From: Hans de Goede <j.w.r.degoede@gmail.com>
Subject: Re: [PATCH v7 1/2] ACPI / bus: Introduce a list of ids for "always
 present" devices
Date: Fri, 21 Apr 2017 11:59:34 +0200
Message-ID: <1c429ce0-8637-b749-2c9b-de7d6a722962@gmail.com>
References: <20170419120408.25037-1-hdegoede@redhat.com>
 <CAJZ5v0jkE0DWBewfzJGM5i92FQrKv_=EKR5hu28NR=hw4Kv2jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34301 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037544AbdDUJ7i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2017 05:59:38 -0400
Received: by mail-wr0-f196.google.com with SMTP id 6so7250877wra.1
        for <linux-acpi@vger.kernel.org>; Fri, 21 Apr 2017 02:59:37 -0700 (PDT)
In-Reply-To: <CAJZ5v0jkE0DWBewfzJGM5i92FQrKv_=EKR5hu28NR=hw4Kv2jw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

On 19-04-17 22:14, Rafael J. Wysocki wrote:
> On Wed, Apr 19, 2017 at 2:04 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Several Bay / Cherry Trail devices (all of which ship with Windows 10) hide
>> the LPSS PWM controller in ACPI, typically the _STA method looks like this:
>>
>>      Method (_STA, 0, NotSerialized)  // _STA: Status
>>      {
>>          If (OSID == One)
>>          {
>>              Return (Zero)
>>          }
>>
>>          Return (0x0F)
>>      }
>>
>> Where OSID is some dark magic seen in all Cherry Trail ACPI tables making
>> the machine behave differently depending on which OS it *thinks* it is
>> booting, this gets set in a number of ways which we cannot control, on
>> some newer machines it simple hardcoded to "One" aka win10.
>>
>> This causes the PWM controller to get hidden, which means Linux cannot
>> control the backlight level on cht based tablets / laptops.
>>
>> Since loading the driver for this does no harm (the only in kernel user
>> of it is the i915 driver, which will only uses it when it needs it), this
>> commit makes acpi_bus_get_status() always set status to ACPI_STA_DEFAULT
>> for the LPSS PWM device, fixing the lack of backlight control.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Use pr_debug instead of ACPI_DEBUG_PRINT
>> Changes in v3:
>> -Un-inline acpi_set_device_status and do the always_present_device_ids
>>   table check inside the un-inlined version of it
>> Changes in v4:
>> -Use dev_info instead of pr_debug
>> -Not only check for ACPI HID but also for CPU (SoC) model so as to not
>>   for devices present on other models then for which the quirk is intended and
>>   to avoid enabling unrelated ACPI devices which happen to use the same HID
>> Changes in v5:
>> -Only do the dev_info once per device (acpi_set_device_status gets called
>>   multiple times per device during boot)
>> Changes in v6:
>> -Allow specifying more then one CPU-model for a single HID
>> -Not only match the HID but also the UID, like on Cherry Trail, on some Bay
>>   Trail Windows 10 tablets we need to enable the PWM controller to get working
>>   backlight even though _STA returns 0. The Bay Trail SoC has 2 PWM controllers
>>   and we only need the first one. UID matching will allows adding an entry for
>>   Bay Trail which only enables the first PWM controller
>> Changes in v7:
>> -Put the actual x86 specific matching code and table with always present
>>   device HID + UID + CPU model entries in a new x86/x86_utils.c file which
>>   provides an acpi_device_always_present() helper function on x86, on
>>   non x86 a stub which always returns false is provided
>> -Squash in the addition of the Bay Trail PWM entry in the table as it
>>   is there for the same reasons as the Cherry Trail entry is there

<snip>

>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 34fbe02..4d952cc 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -132,6 +132,16 @@ int acpi_bus_get_status(struct acpi_device *device)
>>   }
>>   EXPORT_SYMBOL(acpi_bus_get_status);
>>
>> +void acpi_set_device_status(struct acpi_device *adev, u32 sta)
>> +{
>> +       u32 *status = (u32 *)&adev->status;
>> +
>> +       if (acpi_device_always_present(adev))
>> +               *status = ACPI_STA_DEFAULT;
>> +       else
>> +               *status = sta;
> 
> *((u32 *)&adev->status) = acpi_device_always_present(adev) ?
> ACPI_STA_DEFAULT : sta;
> 
> and I guess it could still be static inline?
> 
> But that said, evaluating _STA for the always present devices is
> pointless (as Lukas noticed), so why not to modify
> acpi_bus_get_status() to do something like:
> 
>      if (acpi_device_always_present(adev)) {
>          acpi_set_device_status(adev, ACPI_STA_DEFAULT);
>          return 0;
>      }
> 
> upfront

Hehe, my v1 of this patch actually did the check in acpi_bus_get_status()
I moved it to acpi_set_device_status() on your request. Moving it back
is fine with me and indeed seems cleaner.

> and modify the other path invoking acpi_set_device_status() accordingly.
> 
> And in that path, which I seem to have overlooked before, the
> acpi_set_device_status() call is too early for invoking
> acpi_device_always_present(adev), so the latter should be called
> directly from acpi_add_single_object() like
> 
>      acpi_init_device_object(device, handle, type, sta);
>      if (acpi_device_always_present(adev))
>          acpi_set_device_status(adev, ACPI_STA_DEFAULT);

That is not necessary, the place(s) where we care about status being
fixed-up for always-present devices, so that they get scanned / their
platform device initiated, is in acpi_bus_attach() which
already calls acpi_bus_get_status() and thus gets the
acpi_device_always_present() check applied before checking.

For hotplugged devices there are acpi_scan_bus_check and
acpi_scan_device_check but those both also already call
acpi_bus_get_status() before checking adev->status.

So just adding the check to acpi_bus_get_status(), as I did in
v1 is sufficient.

Note that the end result is still significantly cleaner then v1
as we're now using the acpi_device_always_present() which makes
the drivers/acpi/bus.c changes a lot cleaner.

I'll go and test this and then send a v8.

Regards,

Hans



