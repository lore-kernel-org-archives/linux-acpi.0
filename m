From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] Fix lock up when switching off discrete graphics card in
 Dell XPS 9560 https://bugzilla.kernel.org/show_bug.cgi?id=156341
Date: Tue, 21 Feb 2017 10:41:33 +0100
Message-ID: <20170221094133.7qfs6p7uwatlj3rp@lenoch>
References: <20170221003625.17551-1-tobe.schumacher@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:42994 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdBUJlj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Feb 2017 04:41:39 -0500
Content-Disposition: inline
In-Reply-To: <20170221003625.17551-1-tobe.schumacher@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tobias Schumacher <tobe.schumacher@gmail.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tobias,

On Tue, Feb 21, 2017 at 01:36:25AM +0100, Tobias Schumacher wrote:
> Signed-off-by: Tobias Schumacher <tobe.schumacher@gmail.com>
> ---
>  drivers/acpi/blacklist.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index 4421f7c..7945f2f 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -188,6 +188,20 @@ static struct dmi_system_id acpi_rev_dmi_table[] __initdata = {
>  		      DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3350"),
>  		},
>  	},
> +	/*
> +	 * Resolves issues that cause the system to lock up
> +	 * under certain conditions when the discrete graphics
> +	 * card is turned off
> +	 */
> +	{
> +	 .callback = dmi_enable_rev_override,
> +	 .ident = "DELL XPS 15 (2017)",
> +	 .matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9560"),
> +		},
> +	},
> +
>  #endif
>  	{}
>  };

I thought conclusion was _not_ adding any new devices into this evergrowing
list. Or am I mistaken? As otherwise I'll sent similar patch for my
laptop ;-)

	ladis
