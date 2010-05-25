From: Len Brown <lenb@kernel.org>
Subject: Re: [patch for 2.6.35? 1/1] acpi: video: fix acpi_backlight=video
Date: Mon, 24 May 2010 20:53:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005242053140.4059@localhost.localdomain>
References: <201005241910.o4OJAwdh010716@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:54364 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758142Ab0EYAyK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2010 20:54:10 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2Y00B5YAHU1FP5@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 24 May 2010 19:54:08 -0500 (CDT)
In-reply-to: <201005241910.o4OJAwdh010716@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, kamal@canonical.com, bjorn.helgaas@hp.com, jkosina@suse.cz, rui.zhang@intel.com, stable@kernel.org, trenn@suse.de

yes, it is in acpi-test and linux-next, do you pull those into mm still?

thanks,
Len Brown, Intel Open Source Technology Center

On Mon, 24 May 2010, akpm@linux-foundation.org wrote:

> From: Kamal Mostafa <kamal@canonical.com>
> 
> Make "acpi_backlight=video" param enable ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO
> as intended, instead of incorrectly enabling video output switching.
> 
> Addresses http://bugs.launchpad.net/bugs/573120
> 
> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Acked-by: Thomas Renninger <trenn@suse.de>
> Cc: Thomas Renninger <trenn@suse.de>
> Cc: <stable@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/video_detect.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/video_detect.c~acpi-video-fix-acpi_backlight=video drivers/acpi/video_detect.c
> --- a/drivers/acpi/video_detect.c~acpi-video-fix-acpi_backlight=video
> +++ a/drivers/acpi/video_detect.c
> @@ -266,7 +266,7 @@ static int __init acpi_display_output(ch
>  				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR;
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
> 
