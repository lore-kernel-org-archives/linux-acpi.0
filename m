From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/4] acer-wmi: Rename mail LED correctly & remove hardcoded colour
Date: Tue, 11 Mar 2008 17:59:26 -0400
Message-ID: <200803111759.26511.lenb@kernel.org>
References: <20080224133412.2317.5802.stgit@pacifica> <20080224133418.2317.15994.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57296 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514AbYCKV7l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 17:59:41 -0400
In-Reply-To: <20080224133418.2317.15994.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

applied..
-thanks,
len

On Sunday 24 February 2008, Carlos Corbacho wrote:
> The mail LED name for acer-wmi currently hardcodes in the colour as green.
> This is wrong, since many of the newer laptops now come with an orange
> LED, and we have no way of telling what colour is used on a given system.
> 
> Also, rename the mail LED to be inline with the current recommendations of
> the LED class documentation.
> 
> Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
> ---
> 
>  Documentation/laptops/acer-wmi.txt |    2 +-
>  drivers/misc/acer-wmi.c            |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/Documentation/laptops/acer-wmi.txt b/Documentation/laptops/acer-wmi.txt
> index b066963..a346c86 100644
> --- a/Documentation/laptops/acer-wmi.txt
> +++ b/Documentation/laptops/acer-wmi.txt
> @@ -169,7 +169,7 @@ can be added to acer-wmi.
>  
>  The LED is exposed through the LED subsystem, and can be found in:
>  
> -/sys/devices/platform/acer-wmi/leds/acer-mail:green/
> +/sys/devices/platform/acer-wmi/leds/acer-wmi::mail/
>  
>  The mail LED is autodetected, so if you don't have one, the LED device won't
>  be registered.
> diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
> index cf71e31..d1d64db 100644
> --- a/drivers/misc/acer-wmi.c
> +++ b/drivers/misc/acer-wmi.c
> @@ -761,7 +761,7 @@ enum led_brightness value)
>  }
>  
>  static struct led_classdev mail_led = {
> -	.name = "acer-mail:green",
> +	.name = "acer-wmi::mail",
>  	.brightness_set = mail_led_set,
>  };
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


