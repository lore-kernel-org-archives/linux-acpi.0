From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Do not save/restore NVS on Asus K54C/K54HR
Date: Fri, 2 Dec 2011 00:12:02 +0100
Message-ID: <201112020012.02213.rjw@sisk.pl>
References: <1322727152-4084-1-git-send-email-kengyu@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38260 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754502Ab1LAXJI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Dec 2011 18:09:08 -0500
In-Reply-To: <1322727152-4084-1-git-send-email-kengyu@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Keng-Yu Lin <kengyu@canonical.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, December 01, 2011, Keng-Yu Lin wrote:
> The models do not resume correctly without acpi_sleep=nonvs.
> 
> Signed-off-by: Keng-Yu Lin <kengyu@canonical.com>

Applied to linux-pm/linux-next.

Thanks,
Rafael


> ---
>  drivers/acpi/sleep.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 6d9a3ab..0a7ed69 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -476,6 +476,22 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FW520F"),
>  		},
>  	},
> +	{
> +	.callback = init_nvs_nosave,
> +	.ident = "Asus K54C",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "K54C"),
> +		},
> +	},
> +	{
> +	.callback = init_nvs_nosave,
> +	.ident = "Asus K54HR",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "K54HR"),
> +		},
> +	},
>  	{},
>  };
>  #endif /* CONFIG_SUSPEND */
> 

