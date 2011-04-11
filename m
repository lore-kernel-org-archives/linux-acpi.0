From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: asus-wmi for Asus G73SW
Date: Mon, 11 Apr 2011 11:11:39 +0200
Message-ID: <BANLkTik36UznNKUWHQNBcMBvQa96BsVGgg@mail.gmail.com>
References: <4D99038A.8080105@gmx.net>
	<BANLkTimNYTFmywWsUJNfo3XtGcVwc8jBbA@mail.gmail.com>
	<4D9A58BD.1030401@gmx.net>
	<BANLkTinMbinPt9qL630+NwuCxGXrxehK+A@mail.gmail.com>
	<BANLkTikUUVW=AmAXUsirxj7hVQWkjoFbBw@mail.gmail.com>
	<4D9E4F65.8050307@gmx.net>
	<BANLkTik9PXsEehunFEkVK2LtOxZdagbd+g@mail.gmail.com>
	<4DA1D998.9090501@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4DA1D998.9090501@gmx.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Carsten Juttner <carjay@gmx.net>
Cc: Zhang Rui <rui.zhang@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> By default the brightness values are set to 10 (max_brightness) but changing any of them does not do anything (display stays at maximum brightness level).
>
> Do you have an idea what could be missing?
[...]
> I used acpi_backlight=vendor and /sys/class/backlight/asus-nb-wmi shows up
> as expected.
>
> Also the kernel code that sets the brightness value in the asus-nb-wmi
> driver works (no error is returned, also the changed values show up in
> sysfs).
> It just does not seem to get applied.
>
> I found out that if after I switch to the console (alt+F1) changing the
> brightness in sysfs suddenly does have an effect.
>
> Since I use the proprietary nvidia driver (for full OpenGL 3D support) I
> suspect that it has something to do with it.
> I tried the Kubuntu Live installer CD which uses nouveau and changing the
> brightness works for Xorg there, too (even using the generic acpi_backlight
> code and the brightness value in acpi_video1).
>
> I guess the Nvidia driver or something related to it is doing something
> nasty here which keeps the brightness from being applied.
> Switching back to Xorg from the console resets the value to 10 (I added some
> debug output to update_bl_status) so that's not a workaround unfortunately.
>
> Since I have no idea what actual piece of hardware controls the backlight I
> wonder if it is part of the NVidia hardware and as soon as the nvidia driver
> takes over it will no longer accept updates from the BIOS?

Unfortunatly I didn't found anything in the DSDT.
CCing Zhang Rui, maybe he can help us here.

-- 
Corentin Chary
http://xf.iksaif.net
