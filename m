From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH] report acpi video hot key event through input device
Date: Mon, 30 Jul 2007 01:50:50 +0100
Message-ID: <20070730005050.GB27398@srcf.ucam.org>
References: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 78-32-9-130.no-dns-yet.enta.net ([78.32.9.130]:40341 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1761933AbXG3AvB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 20:51:01 -0400
Content-Disposition: inline
In-Reply-To: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sun, Jul 29, 2007 at 12:40:16PM -0400, Luming Yu wrote:
>  	switch (event) {
>  	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
>  					 * most likely via hotkey. */
>  		acpi_bus_generate_event(device, event, 0);
> +		keycode = KEY_UNKNOWN;

KEY_SWITCHVIDEOMODE ?

> 
>  	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
> @@ -1734,21 +1741,37 @@ static void acpi_video_bus_notify(acpi_h
>  		acpi_video_device_rebind(video);
>  		acpi_video_switch_output(video, event);
>  		acpi_bus_generate_event(device, event, 0);
> +		keycode = KEY_UNKNOWN;
>  		break;

Here too.

>  	case ACPI_VIDEO_NOTIFY_SWITCH:	/* change in status (cycle output device) */
>  	case ACPI_VIDEO_NOTIFY_PROBE:	/* change in status (output device status) */
>  		acpi_bus_generate_event(device, event, 0);
> +		keycode = KEY_UNKNOWN;
>  		break;

And these? I'm not sure in this case, though.

> +#define KEY_VIDEO_NEXT		0x1f9
> +#define KEY_VIDEO_PREV		0x1fa
> +#define KEY_BRIGHTNESS_UP	0x1fb
> +#define KEY_BRIGHTNESS_DOWN	0x1fc

What's wrong with the existing KEY_BRIGHTNESSDOWN and KEY_BRIGHTNESSUP?

> +#define KEY_BRIGHTNESS_ZERO	0x1fd
> +#define KEY_BRIGHTNESS_OFF	0x1fe

You almost certainly want to go via linux-input if you're adding new 
keycodes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
