From: Hans de Goede <j.w.r.degoede@gmail.com>
Subject: Re: [PATCH v4] ACPI / bus: Introduce a list of ids for "always
 present" devices
Date: Tue, 18 Apr 2017 13:13:31 +0200
Message-ID: <d7eafc0c-ddcc-73e6-cf6f-ceefed076f58@gmail.com>
References: <20170410154936.15330-1-hdegoede@redhat.com>
 <1492504269.24567.49.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33954 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdDRLNe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2017 07:13:34 -0400
Received: by mail-wr0-f194.google.com with SMTP id u18so24314832wrc.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2017 04:13:33 -0700 (PDT)
In-Reply-To: <1492504269.24567.49.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

Hi,

On 18-04-17 10:31, Andy Shevchenko wrote:
> On Mon, 2017-04-10 at 17:49 +0200, Hans de Goede wrote:
>> Several cherrytrail devices (all of which ship with windows 10) hide
>> the
>> lpss pwm controller in ACPI, typically the _STA method looks like
>> this:
>
> CherryTrail
> PWM
> LPSS

All fixed.

>
>>
>>     Method (_STA, 0, NotSerialized)  // _STA: Status
>>     {
>>         If (OSID == One)
>>         {
>>             Return (Zero)
>>         }
>>
>>         Return (0x0F)
>>     }
>>
>> Where OSID is some dark magic seen in all cherrytrail ACPI tables
>> making
>> the machine behave differently depending on which OS it *thinks* it is
>> booting, this gets set in a number of ways which we cannot control, on
>> some newer machines it simple hardcoded to "One" aka win10.
>>
>> This causes the PWM controller to get hidden, which means Linux cannot
>> control the backlight level on cht based tablets / laptops.
>>
>> Since loading the driver for this does no harm (the only in kernel
>> user
>> of it is the i915 driver, which will only use it when it needs it),
>> this
>> commit makes acpi_bus_get_status() always set status to
>> ACPI_STA_DEFAULT
>> for the 80862288 device, fixing the lack of backlight control.
>
>> +#ifdef CONFIG_X86
>> +/*
>> + * Some ACPI devices are hidden (status == 0x0) in recent BIOS-es
>> because
>> + * some recent windows drivers bind to one device but poke at
>> multiple
>
> Windows

Fixed for v6.

>> + * devices at the same time, so the others get hidden.
>> + * We work around this by always reporting ACPI_STA_DEFAULT for these
>> + * devices. Note this MUST only be done for devices where this is
>> safe.
>> + *
>> + * This forcing of devices to be present is limited to specific CPU
>> (SoC)
>> + * models both to avoid potentially causing trouble on other models
>> and
>> + * because some HIDs are re-used on different SoCs for completely
>> + * different devices.
>> + */
>> +struct always_present_device_id {
>> +	struct acpi_device_id hid[2];
>> +	struct x86_cpu_id cpu_id[2];
>> +};
>> +
>
>> +#define ENTRY(hid, cpu_model) {					
>
>> 	\
>> +	{ { hid, }, {} },						
>> \
>
>> +	{ { X86_VENDOR_INTEL, 6, cpu_model, X86_FEATURE_ANY, }, {} },
>> 	\
>
> Can we use separate macro for this. i.e. ICPU() ?

Fixed for v5.

> Perhaps at some point we might switch to set of generic ICPU()-like
> macros.

Yes if something like a generic form of the ICPU macro ever becomes
available then switching to it would be a good idea.

> Moreover, it seems you may change it to use only one existing structure
>
> ICPU(model, hid)
>
>> +}
>> +
>> +static const struct always_present_device_id
>> always_present_device_ids[] = {
>> +	/*
>> +	 * Cherrytrail pwm directly poked by GPU driver in win10,
>> +	 * but Linux uses a separate pwm driver, harmless if not
>> used.
>> +	 */
>> +	ENTRY("80862288", INTEL_FAM6_ATOM_AIRMONT),
>> +};
>> +#endif
>> +
>> +void acpi_set_device_status(struct acpi_device *adev, u32 sta)
>> +{
>> +	u32 *status = (u32 *)&adev->status;
>> +#ifdef CONFIG_X86
>> +	int i;
>> +
>> +	/* acpi_match_device_ids checks status, so start with default
>> */
>> +	*status = ACPI_STA_DEFAULT;
>
>> +	for (i = 0; i < ARRAY_SIZE(always_present_device_ids); i++) {
>> +		if (acpi_match_device_ids(adev,
>> +			always_present_device_ids[i].hid) == 0 &&
>> +		    x86_match_cpu(always_present_device_ids[i].cpu_id
>> )) {
>
> I don't like this. It looks a bit hackish. If we need more, than one hid
> per CPU, we might just supply an array

Note this started with just HID matching, later the cpu-id match
got added for 2 reasons:
-Extra safety check to not force enable devices on other models then for
  which the quirk is intended
-Some HIDs get re-used (by Intel) on different platforms for completely
  different devices. E.g. the INT0002 HID is used on both Intel Menlow
  for the Menlow thermal management extension and on Bay Trail / Cherry
  Trail for a "virtual gpio" controller which is involved in wakeup
  from suspend

Basically the HID is leading, as we want to have a quirk for a
specific HID to get enabled even if its _STA returns 0 and the CPU-ID
check is an extra check, so for v6 I've modified it to take an array
of cpu-ids, so that we do not need duplicate table entries for when
we want to check the same HID on 2 CPU models.

Regards,

Hans




>
> ICPU(model, hids)
>
>> +			dev_info(&adev->dev, "Device [%s] is in
>> always present list setting status [%08x]\n",
>> +				 adev->pnp.bus_id, ACPI_STA_DEFAULT);
>> +			return;
>> +		}
>> +	}
>> +#endif
>
