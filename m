From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI video: ignore BIOS initial backlight value for HP
 1000
Date: Tue, 12 Nov 2013 10:03:51 +0800
Message-ID: <52818C87.8080606@intel.com>
References: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21478 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab3KLCDL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Nov 2013 21:03:11 -0500
In-Reply-To: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>, rui.zhang@intel.com, lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On 05/06/2013 04:23 PM, Alex Hung wrote:
> On HP 1000 lapops, BIOS reports minimum backlight on boot and
> causes backlight to dim completely. This ignores the initial backlight
> values and set to max brightness.
> 
> Buglink: https://bugs.launchpad.net/bugs/1167760

I've checked the acpi dump from the bug page, it should be the same
firmware problem which the following patch is meant to solve:
http://www.spinics.net/lists/linux-acpi/msg47212.html

commit 2c62333a408f5badd2d2ffd7177f95deeccc5ca4
Author: Aaron Lu <aaron.lu@intel.com>
Date:   Wed Nov 6 09:07:10 2013 +0800

    ACPI / video: Quirk initial backlight level 0

Possible to give it a test? It's in Rafael's linux-next branch:
http://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

If confirmed, we can save an entry in the DMI table.

Thanks,
Aaron

> 
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
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
> +		DMI_MATCH(Drjw@sisk.plMI_PRODUCT_NAME, "HP 1000 Notebook PC"),
> +		},
> +	},
>  	{}
>  };
>  
> 

