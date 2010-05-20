From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] acpi: video: fix acpi_backlight=video
Date: Thu, 20 May 2010 11:11:52 +0800
Message-ID: <1274325112.22924.2951.camel@rzhang1-desktop>
References: <1272740989-4027-1-git-send-email-kamal@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28905 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964Ab0ETDLR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 May 2010 23:11:17 -0400
In-Reply-To: <1272740989-4027-1-git-send-email-kamal@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jiri Kosina <jkosina@suse.cz>, "stable@kernel.org" <stable@kernel.org>

On Sun, 2010-05-02 at 03:09 +0800, Kamal Mostafa wrote:
> Make "acpi_backlight=video" param enable ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO
> as intended, instead of incorrectly enabling video output switching.
> 
> BugLink: http://bugs.launchpad.net/bugs/573120
> 
Acked-by: Zhang Rui <rui.zhang@intel.com>

> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: <stable@kernel.org>
> ---
>  drivers/acpi/video_detect.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index fc2f26b..c5fef01 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -250,7 +250,7 @@ static int __init acpi_backlight(char *str)
>  				ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR;
>  		if (!strcmp("video", str))
>  			acpi_video_support |=
> -				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO;
> +				ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO;
>  	}
>  	return 1;
>  }


