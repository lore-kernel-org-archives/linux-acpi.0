From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI video: ignore BIOS initial backlight value for HP 1000
Date: Wed, 08 May 2013 01:59:52 +0200
Message-ID: <1983140.7MMd11dlXl@vostro.rjw.lan>
References: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:37712 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755804Ab3EGXv2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 May 2013 19:51:28 -0400
In-Reply-To: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday, May 06, 2013 04:23:43 PM Alex Hung wrote:
> On HP 1000 lapops, BIOS reports minimum backlight on boot and
> causes backlight to dim completely. This ignores the initial backlight
> values and set to max brightness.
> 
> Buglink: https://bugs.launchpad.net/bugs/1167760
> 
> Signed-off-by: Alex Hung <alex.hung@canonical.com>

Queued up for a post-3.10-rc1 push as 3.10 material.

Thanks,
Rafael


> ---
>  drivers/acpi/video.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index c3932d0..5b32e15 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -456,6 +456,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dm4 Notebook PC"),
>  		},
>  	},
> +	{
> +	 .callback = video_ignore_initial_backlight,
> +	 .ident = "HP 1000 Notebook PC",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP 1000 Notebook PC"),
> +		},
> +	},
>  	{}
>  };
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
