From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [Nouveau] [PATCH] acpi: video: Move ACPI_VIDEO_NOTIFY_* defines
 to acpi/video.h
Date: Thu, 10 Nov 2016 11:11:25 +0100
Message-ID: <20161110101125.GA13197@al>
References: <20161109171556.4003-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:33630 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754788AbcKJKLj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Nov 2016 05:11:39 -0500
Content-Disposition: inline
In-Reply-To: <20161109171556.4003-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Dave Airlie <airlied@redhat.com>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org

On Wed, Nov 09, 2016 at 06:15:56PM +0100, Hans de Goede wrote:
> acpi_video.c passed the ACPI_VIDEO_NOTIFY_* defines as type code to
> acpi_notifier_call_chain(). Move these defines to acpi/video.h so
> that acpi_notifier listeners can check the type code using these
> defines.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Peter Wu <peter@lekensteyn.nl>

> ---
>  drivers/acpi/acpi_video.c | 11 -----------
>  include/acpi/video.h      | 11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index c5557d0..201292e 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -43,17 +43,6 @@
>  
>  #define ACPI_VIDEO_BUS_NAME		"Video Bus"
>  #define ACPI_VIDEO_DEVICE_NAME		"Video Device"
> -#define ACPI_VIDEO_NOTIFY_SWITCH	0x80
> -#define ACPI_VIDEO_NOTIFY_PROBE		0x81
> -#define ACPI_VIDEO_NOTIFY_CYCLE		0x82
> -#define ACPI_VIDEO_NOTIFY_NEXT_OUTPUT	0x83
> -#define ACPI_VIDEO_NOTIFY_PREV_OUTPUT	0x84
> -
> -#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS	0x85
> -#define	ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x86
> -#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x87
> -#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x88
> -#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x89
>  
>  #define MAX_NAME_LEN	20
>  
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index 4536bd3..bfe484d 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -30,6 +30,17 @@ struct acpi_device;
>  #define ACPI_VIDEO_DISPLAY_LEGACY_PANEL   0x0110
>  #define ACPI_VIDEO_DISPLAY_LEGACY_TV      0x0200
>  
> +#define ACPI_VIDEO_NOTIFY_SWITCH		0x80
> +#define ACPI_VIDEO_NOTIFY_PROBE			0x81
> +#define ACPI_VIDEO_NOTIFY_CYCLE			0x82
> +#define ACPI_VIDEO_NOTIFY_NEXT_OUTPUT		0x83
> +#define ACPI_VIDEO_NOTIFY_PREV_OUTPUT		0x84
> +#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS	0x85
> +#define ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x86
> +#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x87
> +#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x88
> +#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x89
> +
>  enum acpi_backlight_type {
>  	acpi_backlight_undef = -1,
>  	acpi_backlight_none = 0,
> -- 
> 2.9.3
> 
