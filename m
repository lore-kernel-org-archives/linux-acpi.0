From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3] ACPI / bus: Introduce a list of ids for "always
 present" devices
Date: Sun, 9 Apr 2017 11:46:41 +0200
Message-ID: <2bd27aa3-1fc7-3c29-a1a8-a4aca53ca911@redhat.com>
References: <20170408150511.21013-1-hdegoede@redhat.com>
 <20170409072627.GA3911@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751886AbdDIJqp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 9 Apr 2017 05:46:45 -0400
In-Reply-To: <20170409072627.GA3911@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

Hi,

On 09-04-17 09:26, Lukas Wunner wrote:
> On Sat, Apr 08, 2017 at 05:05:11PM +0200, Hans de Goede wrote:
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
>
> Would it be a viable alternative to respond differently to _OSI queries
> for these devices by amending acpi_osi_dmi_table[] in drivers/acpi/osi.c?

Nope, _OSI influences OSYS not OSID, OSID is some quite bad Cherry Trail
hack where the BIOS behaves differently based on whether it thinks the
OS it is booting is going to be Android or Windows and there is nothing
one can do to influence OSID (other then hardcoding special handling
of that variable name in ACPICA I guess).

But even if we could influence OSID we really don't want to, for all
the same reasons our ACPI implementation always claims to be the
latest windows.

>> +		pr_debug("Device [%s] is in always present list setting status [%08x]\n",
>> +			 adev->pnp.bus_id, ACPI_STA_DEFAULT);
>
> In a lot of places in drivers/acpi/, dev_warn(&adev->dev, ...) is used.

Rafael asked me to use pr_debug here. But I agree that maybe always
logging something when this trigger might be a good idea, although
warning is too high a loglevel IMHO. So I would got with dev_info.

Rafael, what is your take on this ?

Regards,

Hans
