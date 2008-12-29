From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: backlight regression on ASUS F6S: inverted brightness control
Date: Mon, 29 Dec 2008 09:07:32 +0800
Message-ID: <1230512852.562.228.camel@rzhang-dt>
References: <200812280611.18320.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53814 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbYL2BJx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Dec 2008 20:09:53 -0500
In-Reply-To: <200812280611.18320.kel@otaku42.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kel Modderman <kel@otaku42.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

hi,

This is a duplicate of bug
http://bugzilla.kernel.org/show_bug.cgi?id=12302
please try the patch at
http://bugzilla.kernel.org/show_bug.cgi?id=12037#c5

thanks,
rui

On Sun, 2008-12-28 at 04:11 +0800, Kel Modderman wrote:
> Hi,
> 
> After booting Linux 2.6.28 the backlight control actions have now reversed,
> ie: attempting to make backlight brighter makes it dimmer and vice versa.
> 
> The recent backlight changes (video vs. vendor) seem to have the result of
> allowing the ASUS F6S backlight hardware be driven via the acpi/video driver
> rather than the vendor/asus_laptop driver as per printk:
> 
> asus-laptop: Brightness ignored, must be controlled by ACPI video driver
> 
> Linux < 2.6.28
> --------------
> # cat /sys/class/backlight/asus-laptop/max_brightness
> 15
> 
> # Makes backlight brightest
> # echo 15 > /sys/class/backlight/asus-laptop/brightness
> 
> # Makes backlight dimmest
> # echo 0 > /sys/class/backlight/asus-laptop/brightness
> 
> Linux = 2.6.28
> --------------
> # cat /sys/class/backlight/acpi_video0/max_brightness
> 13
> 
> # Makes backlight brightest
> # echo 0 > /sys/class/backlight/acpi_video0/brightness
> 
> # Makes backlight dimmest
> # echo 13 > /sys/class/backlight/acpi_video0/brightness
> 
> 
> A search for "linux 2.6.28 backlight" led to an Ubuntu bug report [1] which
> describes an ASUS notebook user with the same situation.
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/305935
> 
> Is it possible to have the ACPI video driver to behave correctly on this
> hardware?
> 
> I'd like to provide any further required information. I've attached a bzip
> tarball containing:
>   /sys/devices/platform/asus-laptop/infos
>   /proc/acpi/dsdt
>   dmesg output
>   dmidecode output
> 
> Thanks, Kel.

