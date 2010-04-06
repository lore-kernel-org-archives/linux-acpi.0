From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 02/12] ACPI / PM: Move ACPI video resume to a PM notifier
Date: Tue, 06 Apr 2010 17:07:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004061707410.4168@localhost.localdomain>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
 <c8cf3a14a6615e06504664cd50ca90baa5f2ef7d.1270537380.git.len.brown@intel.com>
 <201004062055.43290.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1887698679-1270588080=:4168"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:45807 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756438Ab0DFVIC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 17:08:02 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0H00HTA41DPLZ3@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 16:08:01 -0500 (CDT)
In-reply-to: <201004062055.43290.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1887698679-1270588080=:4168
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

patch refreshed -- i'll send a new pull request now.

thanks,
Len Brown, Intel Open Source Technology Center

On Tue, 6 Apr 2010, Rafael J. Wysocki wrote:

> On Tuesday 06 April 2010, Len Brown wrote:
> > From: Rafael Wysocki <rjw@sisk.pl>
> > 
> > There is a problem with the ACPI video resume routine that it's
> > executed before the GPU that may be accessed by it.  To fix this
> > issue, move the ACPI video resume to a power management notifier,
> > so that it's executed after resuming all devices, including the GPU.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=15096
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Acked-by: Matthew Garrett <mjg@redhat.com>
> > Tested-by: Rafał Miłecki <zajec5@gmail.com>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> 
> Thanks, but this requires the appended patch on top.
> 
> I sent a replacement version yesterday,
> https://patchwork.kernel.org/patch/90593/, but you haven't received it,
> apparently.
> 
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: ACPI / video: Save initial backlight brightness in props
> 
> The initial backlight brightness has to be written to
> device->backlight->props in case it has to be restored before
> there's a chance to call acpi_video_device_lcd_set_level().
> 
> Something like this happens during boot, when the kernel checks if
> a hibernation image is present and executes power management
> notifiers (in either case).  One of these notifiers tries to restore
> the previous brightness level, but this won't work if the initial
> brightness is not saved by acpi_video_device_find_cap().
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/video.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c
> +++ linux-2.6/drivers/acpi/video.c
> @@ -1020,6 +1020,13 @@ static void acpi_video_device_find_cap(s
>  		if (IS_ERR(device->backlight))
>  			return;
>  
> +		/*
> +		 * Save current brightness level in case we have to restore it
> +		 * before acpi_video_device_lcd_set_level() is called next time.
> +		 */
> +		device->backlight->props.brightness =
> +				acpi_video_get_brightness(device->backlight);
> +
>  		result = sysfs_create_link(&device->backlight->dev.kobj,
>  					   &device->dev->dev.kobj, "device");
>  		if (result)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--8323328-1887698679-1270588080=:4168--
