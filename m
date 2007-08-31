From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI video: introduce module parameter auto_handle
Date: Fri, 31 Aug 2007 16:53:27 -0400
Message-ID: <200708311653.27228.lenb@kernel.org>
References: <1188380370.3082.121.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39408 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933451AbXHaUxr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Aug 2007 16:53:47 -0400
In-Reply-To: <1188380370.3082.121.camel@acpi-hp.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Arjan van de Ven <arjan@infradead.org>

This is a step in the right direction,
but the reason that I'm not going to apply this patch is because
this functionality should be handled by drivers/video/output.c
in a generic way.  (For that matter, output.c needs a few more things,
starting with a rename, say to "display_switch.c"?:-)

Also, brightness and display switching should be independent.

thanks,
-Len

On Wednesday 29 August 2007 05:39, Zhang Rui wrote:
> Introduce a new module parameter "auto_handle" to enable/disable
> handling hotkey events in ACPI video driver.
> 
> Now X can get the hotkey events via input layer and handle them
> all by itself, e.g brightness up/down, video output switch, etc.
> 
> With this patch applied,
> ACPI video driver can either handle the events itself or
> do nothing but export them to userspace.
> eg. the X people surely want to
> "echo 0 > /sys/module/video/parameters/auto_handle" so that
> they can take full charge of the video switch thing. :P
> 
> Note: auto_handle is disabled by default.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |   35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c
> +++ linux-2.6/drivers/acpi/video.c
> @@ -71,6 +71,9 @@ MODULE_AUTHOR("Bruno Ducrot");
>  MODULE_DESCRIPTION("ACPI Video Driver");
>  MODULE_LICENSE("GPL");
>  
> +static unsigned int auto_handle;
> +module_param(auto_handle, uint, 0644);
> +
>  static int acpi_video_bus_add(struct acpi_device *device);
>  static int acpi_video_bus_remove(struct acpi_device *device, int type);
>  
> @@ -1781,31 +1784,39 @@ static void acpi_video_bus_notify(acpi_h
>  	switch (event) {
>  	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
>  					 * most likely via hotkey. */
> +		if (auto_handle)
> +			acpi_video_switch_output(video, event);
>  		acpi_bus_generate_proc_event(device, event, 0);
>  		keycode = KEY_SWITCHVIDEOMODE;
>  		break;
>  
>  	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
>  					 * connector. */
> -		acpi_video_device_enumerate(video);
> -		acpi_video_device_rebind(video);
> -		acpi_video_switch_output(video, event);
> +
> +		if (auto_handle) {
> +			acpi_video_device_enumerate(video);
> +			acpi_video_device_rebind(video);
> +			acpi_video_switch_output(video, event);
> +		}
>  		acpi_bus_generate_proc_event(device, event, 0);
>  		keycode = KEY_SWITCHVIDEOMODE;
>  		break;
>  
>  	case ACPI_VIDEO_NOTIFY_CYCLE:	/* Cycle Display output hotkey pressed. */
> -		acpi_video_switch_output(video, event);
> +		if (auto_handle)
> +			acpi_video_switch_output(video, event);
>  		acpi_bus_generate_proc_event(device, event, 0);
>  		keycode = KEY_SWITCHVIDEOMODE;
>  		break;
>  	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:	/* Next Display output hotkey pressed. */
> -		acpi_video_switch_output(video, event);
> +		if (auto_handle)
> +			acpi_video_switch_output(video, event);
>  		acpi_bus_generate_proc_event(device, event, 0);
>  		keycode = KEY_VIDEO_NEXT;
>  		break;
>  	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:	/* previous Display output hotkey pressed. */
> -		acpi_video_switch_output(video, event);
> +		if (auto_handle)
> +			acpi_video_switch_output(video, event);
>  		acpi_bus_generate_proc_event(device, event, 0);
>  		keycode = KEY_VIDEO_PREV;
>  		break;
> @@ -1842,22 +1853,26 @@ static void acpi_video_device_notify(acp
>  
>  	switch (event) {
>  	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
> -		acpi_video_switch_brightness(video_device, event);
> +		if (auto_handle)
> +			acpi_video_switch_brightness(video_device, event);
>  		acpi_bus_generate_proc_event(device, event, 0);
>  		keycode = KEY_BRIGHTNESS_CYCLE;
>  		break;
>  	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
> -		acpi_video_switch_brightness(video_device, event);
> +		if (auto_handle)
> +			acpi_video_switch_brightness(video_device, event);
>  		acpi_bus_generate_proc_event(device, event, 0);
>  		keycode = KEY_BRIGHTNESSUP;
>  		break;
>  	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
> -		acpi_video_switch_brightness(video_device, event);
> +		if (auto_handle)
> +			acpi_video_switch_brightness(video_device, event);
>  		acpi_bus_generate_proc_event(device, event, 0);
>  		keycode = KEY_BRIGHTNESSDOWN;
>  		break;
>  	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:	/* zero brightnesss */
> -		acpi_video_switch_brightness(video_device, event);
> +		if (auto_handle)
> +			acpi_video_switch_brightness(video_device, event);
>  		acpi_bus_generate_proc_event(device, event, 0);
>  		keycode = KEY_BRIGHTNESS_ZERO;
>  		break;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
