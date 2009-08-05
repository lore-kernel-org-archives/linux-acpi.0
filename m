From: Thomas Renninger <trenn@suse.de>
Subject: Re: a backlight issue
Date: Wed, 5 Aug 2009 14:50:27 +0200
Message-ID: <200908051450.27970.trenn@suse.de>
References: <1245895749.7266.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36239 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933733AbZHEMua (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Aug 2009 08:50:30 -0400
In-Reply-To: <1245895749.7266.70.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, rpurdie@linux.intel.com, jbarnes@virtuousgeek.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

Hi,

while looking out for latest work in this area:
ACPI vs vendor vs KMS kernel backlight concurrency
I saw this one and even late, it looks like the appropriate mail to
answer as Yakui nicely describes the problem here...

On Thursday 25 June 2009 04:09:09 yakui_zhao wrote:
> Hi, Len
>     
>     On some boxes there is neither generic ACPI backlight I/F nor
> platform backlight I/F. That means that the backlight brightness can't
> be changed by using sys backlight I/F. But the backlight brightness can
> be changed by using the driver backlight I/F. For example: on the box
> based on intel-integrated graphics card the backlight brightness can
> also be changed by using the LBB register in pci device. 
>     Can the graphics driver register the sys backlight I/F so that we
> can change the backlight by using sys I/F? 
>     
>     If the graphics driver can also register the backlight I/F, it seems
> that we can register three types of backlight I/F.
>     a. generic ACPI backlight I/F. This is registered by acpi video
> driver.
>     b. platform backlight I/F. This is registered by the platform driver
>     c. graphics backlight I/F. This can be registered by the graphics
> driver.
> 
>     As there exist three types of backlight I/F, how can we make the
> coordination among the three backlight I/F? In fact only one backlight
> I/f is enough for user to change the brightness.
> 
> Rui provides a propose that use the backlight manager to choose the
> appropriate the backlight I/F. 
>     backlight manager only exports one single I/F to users, like:
> ----|
>     |----brightness
>     |----actual_brightness
>     |----max_brightness
>     |----...
>     |----mode
> and it supports multiple modes, e.g.
> 1. generic ---ACPI
> 2. platform---platform drivers
> 3. legacy-----i915
> 
> The sysfs backlight manager always chooses the mode with highest
> priority (generic > platform > legacy), and call the respective
> callbacks when backlight is changed.
> For example, the backlight manager switches to the "generic" mode from
> "legacy" mode automatically when ACPI video driver is loaded at runtime.
>   
>    How about the above propose?
If I understand this right every machine/BIOS does either provide:
  - generic ACPI funcs
  - vendor specific BIOS interface (served by oem-laptop.ko drivers)

It's just that for some vendors the latter is not implemented (due to lack
of specifications), is that right?

In any case, what about this solution:

If in KMS drivers backlight switching method is implemented
and can register for the generic backlight driver, it should always be
disabled by default. Instead, KMS drivers should export a simple
"backlight_enable" file somewhere in sysfs. If userspace doesn't
find a sysfs backlight interface, it can do:
echo 1 >/sys/path_to_graphics_card/backlight_enable
and a backlight sysfs interface should pop up on success.

That would be similar to current xorg driver approach which do try
to take over if no backlight sysfs interface found.

     Thomas

BTW: Which mailinglist would be appropriate to reach KMS developers?

> BTW: now in the video driver only one of acpi generic backlight I/F and
> platform backlight I/F is registered. That means that the acpi generic
> backlight I/F is preferred if it exists. Of course we can switch to the
> platform backlight I/F by adding the boot option of
> "acpi_backlight=vendor".  In summary, the platform driver will check
> whether the acpi generic backlight is supported before registering the
> platform backlight I/F.
> 
> 
> Thanks.
> 
>    
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


