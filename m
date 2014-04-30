From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-video: Put the Acer Aspire V5-471G on the use_native_backlight dmi list
Date: Wed, 30 Apr 2014 21:52:49 +0200
Message-ID: <27454870.5RW4VWSjWN@vostro.rjw.lan>
References: <1398865041-12071-1-git-send-email-hdegoede@redhat.com> <1398865041-12071-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1398865041-12071-2-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, April 30, 2014 03:37:21 PM Hans de Goede wrote:
> This fixes the backlight control not working.
> 
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Vincent Gerris <vgerris@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Sorry, this conflicts with commit 170269a9d3c0 (ACPI / video: Default to using
native backlight control on Windows 8 systems) in linux-next, so I'm not going
to apply it.

If you wanted to have this stuff in 3.15, there was a plenty of time to submit
it earlier.

Thanks!

> ---
>  drivers/acpi/video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 8b6990e..c688b77 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -520,6 +520,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
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
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
