From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] acpi-video: change acpi-video brightness_switch_enabled default to 0
Date: Thu, 08 May 2014 01:46:55 +0200
Message-ID: <1465986.ilGBN51rxC@vostro.rjw.lan>
References: <1399380383-29685-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62106 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751318AbaEGXaP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2014 19:30:15 -0400
In-Reply-To: <1399380383-29685-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, May 06, 2014 02:46:23 PM Hans de Goede wrote:
> acpi-video is unique in that it not only generates brightness up/down
> keypresses, but also (sometimes) actively changes the brightness itself.
> 
> This presents an inconsistent kernel interface to userspace, basically there
> are 2 different scenarios, depending on the laptop model:
> 
> 1) On some laptops a brightness up/down keypress means: show a brightness osd
> with the current brightness, iow it is a brightness has changed notification.
> 
> 2) Where as on (a lot of) other laptops it means a brightness up/down key was
> pressed, deal with it.
> 
> Most of the desktop environments interpret any press as in scenario 2, and
> change the brightness up / down as a response to the key events, causing it
> to be changed twice, once by acpi-video and once by the DE.
> 
> With the new default for video.use_native_backlight we will be moving even
> more laptops over to behaving as in scenario 2. Making the remaining laptops
> even more of a weird exception. Also note that it is hard to detect scenario
> 1 properly in userspace, and AFAIK none of the DE-s deals with it.
> 
> Therefor this commit changes the default of brightness_switch_enabled to 0
> making its behavior consistent with all the other backlight drivers.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Aaron Lu <aaron.lu@intel.com>

I've queued this up for 3.16, thanks!

> --
> 
> Changes in v2:
> Also update Documentation/kernel-parameters.txt for the new default.
> ---
>  Documentation/kernel-parameters.txt | 2 +-
>  drivers/acpi/video.c                | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 4384217..cc2c243 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -3461,7 +3461,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			the allocated input device; If set to 0, video driver
>  			will only send out the event without touching backlight
>  			brightness level.
> -			default: 1
> +			default: 0
>  
>  	virtio_mmio.device=
>  			[VMMIO] Memory mapped virtio (platform) device.
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index cebc74d..34198b2 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -68,7 +68,7 @@ MODULE_AUTHOR("Bruno Ducrot");
>  MODULE_DESCRIPTION("ACPI Video Driver");
>  MODULE_LICENSE("GPL");
>  
> -static bool brightness_switch_enabled = 1;
> +static bool brightness_switch_enabled;
>  module_param(brightness_switch_enabled, bool, 0644);
>  
>  /*
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
