From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/33] acpi4asus updates for 2.6.33
Date: Wed, 09 Dec 2009 16:04:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912091603290.24891@localhost.localdomain>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:34868 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083AbZLIVEJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 16:04:09 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUE002OHL6QD4LJ@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 15:04:03 -0600 (CST)
In-reply-to: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org

all but #32 applied to acpi-test

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 3 Dec 2009, Corentin Chary wrote:

> Hi Len,
> Here patchs from acpi4asus for 2.6.33.
> You'll find a major rewrite of eeepc-laptop by Alan Jenkins which really
> cleans the code. I'm working one something similar for asus-laptop, this should
> be ready for 2.6.34.
> There is also some fix and updates for asus-laptop and asus-acpi.
> asus-laptop now support Lenovo SL laptop (yep this is strange, but this is the
> same acpi interface).
> 
> There is two smalls style issues in Alan's patchs, but I made a patch to fix that
> in the serie, it was easier than reworking the whole serie, but I'll try to
> avoid that next time.
> 
> The last two patchs may be controversial.
> 
> The first one add the KEY_WIRELESS_CYCLE. This keycode could be used when
> the key is not only for wlan, but could also be used for bluetooth and wimax.
> 
> The last schedule some asus-laptop features for removale, because they are
> not defined in a standard way in the acpi interface.
> Thanks,
> 
> Alan Jenkins (25):
>   eeepc-laptop: disp attribute should be write-only
>   asus-laptop: Remove redundant NULL checks
>   asus-acpi: Remove redundant NULL checks
>   asus-laptop: Remove uneccesary acpi_disabled check
>   asus-acpi: Remove uneccesary acpi_disabled checks
>   asus-acpi: set acpi_driver.owner
>   asus-laptop: set acpi_driver.owner
>   eeepc-laptop: Remove redundant NULL checks
>   eeepc-laptop: Remove uneccesary acpi_disabled check
>   eeepc-laptop: set acpi_driver.owner
>   eeepc-laptop: fix value of pwm1_enable to match documentation
>   eeepc-laptop: fix led initialization order
>   eeepc-laptop: fix potential leak (led_init() failure)
>   eeepc-laptop: fix set_acpi() to return non-zero on failure
>   eeepc-laptop: remove redundant NULL checks
>   eeepc-laptop: no need to check argument of set_brightness()
>   eeepc-laptop: simplify acpi initialization
>   eeepc-laptop: simplify how the hwmon device reads values from the EC
>   eeepc-laptop: refactor notifications
>   eeepc-laptop: move platform driver registration out of
>     eeepc_hotk_add()
>   eeepc-laptop: move platform device initialisation to a separate
>     function
>   eeepc-laptop: code movement
>   eeepc-laptop: revise names
>   eeepc-laptop: callbacks should use "driver data" parameter or field
>   eeepc-laptop: re-add check for eeepc->backlight == NULL
> 
> Corentin Chary (7):
>   eeepc-laptop: add touchpad led
>   asus-laptop: use KEY_F13 to map "Disable Touchpad" event
>   asus-laptop: Add wlan switch found on V6V
>   eeepc-laptop: map keys found on newer eeepc
>   eeepc-laptop: fix coding style
>   input: add KEY_WIRELESS_CYCLE
>   asus-laptop: schedule display_get and lcd_switch for removal
> 
> Ike Panhc (1):
>   asus-laptop: add Lenovo SL hotkey support
> 
>  Documentation/feature-removal-schedule.txt |   20 +
>  drivers/platform/x86/Kconfig               |    2 +
>  drivers/platform/x86/asus-laptop.c         |   21 +-
>  drivers/platform/x86/asus_acpi.c           |   19 +-
>  drivers/platform/x86/eeepc-laptop.c        | 1415 +++++++++++++++------------
>  include/linux/input.h                      |    1 +
>  6 files changed, 825 insertions(+), 653 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
