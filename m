From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI video hotkey: set _DOS to 0 by default
Date: Tue, 18 Sep 2007 13:38:07 -0400
Message-ID: <200709181338.08032.lenb@kernel.org>
References: <1189741582.10428.34.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54888 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759343AbXIRRi0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 13:38:26 -0400
In-Reply-To: <1189741582.10428.34.camel@acpi-hp.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Thursday 13 September 2007 23:46, Zhang Rui wrote:
> Subject: set _DOS to 0 by default
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Many ACPI machines currently reprogram the active display output
> automatically when the user presses the display toggle switch on
> the keyboard. However, this behavior violates the ACPI spec,
> because the system modifies some graphics device registers.
> 
> "_DOS = 1" means that BIOS will switch the display, and ACPI is
> not aware of the display switch hotkey pressing.
> 
> And "_DOS = 0" means that BIOS will not switch the display
> but just notify ACPI instead.
> 
> We set _DOS to 0 by default from now on because ACPI video driver
> has the mechanism to notify the user space when the display toggle
> switch is pressed, i.e. ACPI video driver can send the hotkey events
> via the input layer.
> And X can/should get this event and call the native video device
> driver to do the actual display switch work.
> 
> Note: formerly we set _DOS to 1 to let BIOS handle the display switch,
>       but this doesn't always work on all platforms even in console mode.
>       http://bugzilla.kernel.org/show_bug.cgi?id=6001
> 
> Note: with this patch applied, in console mode, hotkey pressing may not
>       work because ACPI only export the hotkey events to user space while
>       X is not running, so no action is taken for this event.
>       users may need to "echo 1 >/proc/acpi/video/xxx/DOS" so that they
>       can switch the display with the help of BIOS.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c
> +++ linux-2.6/drivers/acpi/video.c
> @@ -1754,7 +1754,7 @@ static int acpi_video_bus_put_devices(st
>  
>  static int acpi_video_bus_start_devices(struct acpi_video_bus *video)
>  {
> -	return acpi_video_bus_DOS(video, 1, 0);
> +	return acpi_video_bus_DOS(video, 0, 0);
>  }
>  
>  static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
> 
