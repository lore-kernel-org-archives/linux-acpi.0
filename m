From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / bus: Introduce a list of ids for "always present"
 devices
Date: Mon, 27 Feb 2017 15:25:32 +0100
Message-ID: <ccbbaa31-9140-f976-bdcd-7e5ad23a47c8@redhat.com>
References: <20170225182328.26644-1-hdegoede@redhat.com>
 <3161510.WQnmWnCBb0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbdB0OZg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Feb 2017 09:25:36 -0500
In-Reply-To: <3161510.WQnmWnCBb0@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Len Brown <lenb@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi,

On 27-02-17 14:30, Rafael J. Wysocki wrote:
> +Mika & Andy
>
> On Saturday, February 25, 2017 07:23:28 PM Hans de Goede wrote:
>> Several cherrytrail devices (all of which ship with windows 10) hide the
>> lpss pwm controller in ACPI, typically the _STA method looks like this:
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
>> Where OSID is some dark magic seen in all cherrytrail ACPI tables making
>> the machine behave differently depending on which OS it *thinks* it is
>> booting, this gets set in a number of ways which we cannot control, on
>> some newer machines it simple hardcoded to "One" aka win10.
>>
>> This causes the PWM controller to get hidden, which means Linux cannot
>> control the backlight level on cht based tablets / laptops.
>>
>> Since loading the driver for this does no harm (the only in kernel user
>> of it is the i915 driver, which will only use it when it needs it), this
>> commit makes acpi_bus_get_status() always set status to ACPI_STA_DEFAULT
>> for the 80862288 device, fixing the lack of backlight control.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/bus.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 95855cb..483d4d0 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -109,11 +109,36 @@ acpi_status acpi_bus_get_status_handle(acpi_handle handle,
>>  	return status;
>>  }
>>
>> +/*
>> + * Some ACPI devices are hidden (status == 0x0) in recent BIOS-es because
>> + * some recent windows drivers bind to one device but poke at multiple
>> + * devices at the same time, so the others get hidden.
>> + * We work around this by always reporting ACPI_STA_DEFAULT for these
>> + * devices. Note this MUST only be done for devices where this is safe.
>> + */
>> +static const struct acpi_device_id always_present_device_ids[] = {
>> +	/*
>> +	 * Cherrytrail pwm directly poked by GPU driver in win10,
>> +	 * but Linux uses a separate pwm driver, harmless if not used.
>> +	 */
>> +	{ "80862288", },
>> +	{ }
>> +};
>> +
>>  int acpi_bus_get_status(struct acpi_device *device)
>>  {
>>  	acpi_status status;
>>  	unsigned long long sta;
>>
>> +	/* acpi_match_device_ids checks status, so start with default */
>> +	acpi_set_device_status(device, ACPI_STA_DEFAULT);
>
> This shouldn't be done in a "get" routine.

With this you mean the acpi_match_device_ids() check I assume ?
(acpi_bus_get_status already calls acpi_set_device_status())

> Ideally, a scan handler should do that or similar.

The problem is that drivers/acpi/scan.c: acpi_bus_attach()
calls acpi_bus_get_status() and if it does not set
the status to present acpi_bus_attach() exits without bothering
with attaching scan handlers, which is why I ended up doing this
here.

>> +	if (acpi_match_device_ids(device, always_present_device_ids) == 0) {
>> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] is in always present list setting status [%08x]\n",
>> +				  device->pnp.bus_id, ACPI_STA_DEFAULT));
>
> pr_debug() please.  The ACPI_DEBUG_PRINT() stuff is basically for ACPICA
> (yes, I know it is used elsewhere and no, it is not a good idea to do that).

Ok, that is easy to fix :)


>> +		return 0;
>> +	}
>> +	acpi_set_device_status(device, 0);
>> +
>>  	status = acpi_bus_get_status_handle(device->handle, &sta);
>>  	if (ACPI_FAILURE(status))
>>  		return -ENODEV;
>>
>
> Thanks,
> Rafael

Regards,

Hans

