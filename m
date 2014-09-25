From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: force vendor backlight on Lenovo Ideapad Z570
Date: Fri, 26 Sep 2014 01:49:11 +0200
Message-ID: <1616866.vGbjHjdjvK@vostro.rjw.lan>
References: <1410363883-6327-1-git-send-email-stepanbujnak@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50038 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753086AbaIYX3V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2014 19:29:21 -0400
In-Reply-To: <1410363883-6327-1-git-send-email-stepanbujnak@fastmail.fm>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stepan Bujnak <stepanbujnak@fastmail.fm>
Cc: linux-acpi@vger.kernel.org

On Wednesday, September 10, 2014 05:44:43 PM Stepan Bujnak wrote:
> Lenovo Ideapad 570 is a pre-win8 laptop where not using vendor backlight causes the backlight controls not to work.
> 
> Signed-off-by: Stepan Bujnak <stepanbujnak@fastmail.fm>

Queued up for 3.18, thanks!

> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index c42feb2..27c4349 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -174,6 +174,14 @@ static struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5737"),
>  		},
>  	},
> +	{
> +	.callback = video_detect_force_vendor,
> +	.ident = "Lenovo IdeaPad Z570",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "Ideapad Z570"),
> +		},
> +	},
>  	{ },
>  };
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
