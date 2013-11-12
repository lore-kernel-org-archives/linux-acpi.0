From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI video: ignore BIOS initial backlight value for HP
 m4
Date: Tue, 12 Nov 2013 10:05:10 +0800
Message-ID: <52818CD6.7000704@intel.com>
References: <1369706709-9189-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28427 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745Ab3KLCE1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Nov 2013 21:04:27 -0500
In-Reply-To: <1369706709-9189-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>, rui.zhang@intel.com, lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On 05/28/2013 10:05 AM, Alex Hung wrote:
> On HP m4 lapops, BIOS reports minimum backlight on boot and
> causes backlight to dim completely. This ignores the initial backlight
> values and set to max brightness.
> 
> Buglink: https://bugs.launchpad.net/bugs/1184501

Same here, but since there is no acpidump attached, I'm not that sure.

Thanks,
Aaron

> 
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/acpi/video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 5b32e15..d0937ab 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -464,6 +464,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "HP 1000 Notebook PC"),
>  		},
>  	},
> +	{
> +	 .callback = video_ignore_initial_backlight,
> +	 .ident = "HP Pavilion m4",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion m4 Notebook PC"),
> +		},
> +	},
>  	{}
>  };
>  
> 

