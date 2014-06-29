From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH] Fix backlight control for Acer TravelMate B113
Date: Sun, 29 Jun 2014 10:42:21 +0200
Message-ID: <53AFD16D.10209@posteo.de>
References: <1403555446-16863-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403555446-16863-1-git-send-email-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Am 2014-06-23 22:30, schrieb Martin Kepplinger:
> Fix backlight control for Acer TravelMate B113 Laptop by adding
> it to the video_dmi_table.
> 
> A workaround before that was to use acpi_osi=Linux or
> acpi_backlight=vendor on boot but even then, only the function-
> keys worked.
> 
> With this change there is no need for boot parameters and DE's
> controls work as well.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> Tested-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/acpi/video.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index f8bc5a7..acb0670 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -528,6 +528,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		},
>  	},
>  	{
> +	 .callback = video_set_use_native_backlight,
> +	 .ident = "Acer TravelMate B113",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate B113"),
> +		},
> +	},
> +	{
>  	.callback = video_set_use_native_backlight,
>  	.ident = "HP ProBook 4340s",
>  	.matches = {
> 

are there objections or advice on this? this would be really good to
have, even if for 3.17.

thanks.
                                martin
