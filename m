From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch for 2.6.34? 1/1] acpi: video: fix acpi_backlight=video
Date: Sat, 15 May 2010 15:29:26 +0200
Message-ID: <201005151529.27170.trenn@suse.de>
References: <201005122233.o4CMXvi7024758@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:58116 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897Ab0EON3S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 May 2010 09:29:18 -0400
In-Reply-To: <201005122233.o4CMXvi7024758@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, kamal@canonical.com, bjorn.helgaas@hp.com, jkosina@suse.cz, rui.zhang@intel.com, stable@kernel.org

On Thursday 13 May 2010 12:33:57 am akpm@linux-foundation.org wrote:
> From: Kamal Mostafa <kamal@canonical.com>
>
> Make "acpi_backlight=video" param enable ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO
> as intended, instead of incorrectly enabling video output switching.
IIRC the only native driver which takes over backlight switching is panasonic,
because Len saw 2 brightness steps missing.
This one should have been solved by a "compatibility" patch from Rui and
this one could also use video.ko by default.

Still, this one is a safe fix.
Just in case someone wants to avoid the use of this boot param and get
things done right by default (and likes to send a patch for it :)).

      Thomas

> Addresses http://bugs.launchpad.net/bugs/573120
>
> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: <stable@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  drivers/acpi/video_detect.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN drivers/acpi/video_detect.c~acpi-video-fix-acpi_backlight=video
> drivers/acpi/video_detect.c ---
> a/drivers/acpi/video_detect.c~acpi-video-fix-acpi_backlight=video +++
> a/drivers/acpi/video_detect.c
> @@ -250,7 +250,7 @@ static int __init acpi_backlight(char *s
>  				ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR;
>  		if (!strcmp("video", str))
>  			acpi_video_support |=
> -				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO;
> +				ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO;
>  	}
>  	return 1;
>  }
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


