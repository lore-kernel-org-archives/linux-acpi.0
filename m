From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi_video: Add enable_native_backlight quirk for MacbookPro12,1
Date: Tue, 16 Jun 2015 01:20:24 +0200
Message-ID: <2540098.7H53aJ403b@vostro.rjw.lan>
References: <1432830588-12635-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62456 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752977AbbFOWy1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2015 18:54:27 -0400
In-Reply-To: <1432830588-12635-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Christopher Beland <beland@alum.mit.edu>

On Thursday, May 28, 2015 06:29:48 PM Hans de Goede wrote:
> It seems that the latest generation of MacbookPro needs to use the
> native backlight driver, just like most modern laptops do, but it does
> not automatically get enabled as the Apple BIOS does not advertise
> Windows 8 compatibility. So add a quirk for this.
> 
> Cc: Christopher Beland <beland@alum.mit.edu>
> Reported-by: Christopher Beland <beland@alum.mit.edu>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued up for 4.2, thanks!

> ---
>  drivers/acpi/video.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index cc79d3f..518f0e1 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -583,6 +583,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
>  		},
>  	},
> +	{
> +	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
> +	 .callback = video_enable_native_backlight,
> +	 .ident = "Apple MacBook Pro 12,1",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
> +		},
> +	},
>  	{}
>  };
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
