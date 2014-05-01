From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-video: Add 4 new models to the use_native_backlight dmi list
Date: Thu, 01 May 2014 22:16:25 +0200
Message-ID: <1940276.byRRIda2Hg@vostro.rjw.lan>
References: <1398940879-6455-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1398940879-6455-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, May 01, 2014 12:41:19 PM Hans de Goede wrote:
> Acer Aspire V5-171
> https://bugzilla.redhat.com/show_bug.cgi?id=983342
> 
> Acer Aspire V5-471G
> Lenovo Yoga 2 11
> Reported-and-tested-by: Vincent Gerris <vgerris@gmail.com>
> 
> HP EliteBook 8470p
> https://bugzilla.redhat.com/show_bug.cgi?id=1093120
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

OK, I'll take this and drop commit 170269a9d3c0 for now.

Thanks!

> ---
>  drivers/acpi/video.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 8b6990e..48146fc 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -488,6 +488,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		},
>  	},
>  	{
> +	 .callback = video_set_use_native_backlight,
> +	 .ident = "Lenovo Yoga 2 11",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Yoga 2 11"),
> +		},
> +	},
> +	{
>  	.callback = video_set_use_native_backlight,
>  	.ident = "Thinkpad Helix",
>  	.matches = {
> @@ -513,6 +521,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  	},
>  	{
>  	 .callback = video_set_use_native_backlight,
> +	 .ident = "Acer Aspire V5-171",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "V5-171"),
> +		},
> +	},
> +	{
> +	 .callback = video_set_use_native_backlight,
>  	 .ident = "Acer Aspire V5-431",
>  	 .matches = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> @@ -520,6 +536,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		},
>  	},
>  	{
> +	 .callback = video_set_use_native_backlight,
> +	 .ident = "Acer Aspire V5-471G",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-471G"),
> +		},
> +	},
> +	{
>  	.callback = video_set_use_native_backlight,
>  	.ident = "HP ProBook 4340s",
>  	.matches = {
> @@ -571,6 +595,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  	},
>  	{
>  	.callback = video_set_use_native_backlight,
> +	.ident = "HP EliteBook 8470p",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8470p"),
> +		},
> +	},
> +	{
> +	.callback = video_set_use_native_backlight,
>  	.ident = "HP EliteBook 8780w",
>  	.matches = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
