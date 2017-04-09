From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] ACPI / bus: Introduce a list of ids for "always
 present" devices
Date: Sun, 9 Apr 2017 09:26:27 +0200
Message-ID: <20170409072627.GA3911@wunner.de>
References: <20170408150511.21013-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:41239 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdDIH0c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Apr 2017 03:26:32 -0400
Content-Disposition: inline
In-Reply-To: <20170408150511.21013-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

On Sat, Apr 08, 2017 at 05:05:11PM +0200, Hans de Goede wrote:
> Several cherrytrail devices (all of which ship with windows 10) hide the
> lpss pwm controller in ACPI, typically the _STA method looks like this:
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
> Where OSID is some dark magic seen in all cherrytrail ACPI tables making
> the machine behave differently depending on which OS it *thinks* it is
> booting, this gets set in a number of ways which we cannot control, on
> some newer machines it simple hardcoded to "One" aka win10.

Would it be a viable alternative to respond differently to _OSI queries
for these devices by amending acpi_osi_dmi_table[] in drivers/acpi/osi.c?


> +		pr_debug("Device [%s] is in always present list setting status [%08x]\n",
> +			 adev->pnp.bus_id, ACPI_STA_DEFAULT);

In a lot of places in drivers/acpi/, dev_warn(&adev->dev, ...) is used.

Otherwise LGTM.

Thanks,

Lukas
