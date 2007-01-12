From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 11/11] initialize the brighness value at device registration
Date: Fri, 12 Jan 2007 18:04:09 +0100
Message-ID: <20070112170409.GA5989@inferi.kami.home>
References: <1168192483207-git-send-email-malattia@linux.it> <11681924833947-git-send-email-malattia@linux.it> <11681924832264-git-send-email-malattia@linux.it> <11681924831582-git-send-email-malattia@linux.it> <11681924831482-git-send-email-malattia@linux.it> <11681924833473-git-send-email-malattia@linux.it> <11681924833091-git-send-email-malattia@linux.it> <11681924831019-git-send-email-malattia@linux.it> <11681924832600-git-send-email-malattia@linux.it> <11681924831516-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:38245 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332AbXALRFe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jan 2007 12:05:34 -0500
Content-Disposition: inline
In-Reply-To: <11681924831516-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

On Sun, Jan 07, 2007 at 06:54:43PM +0100, malattia@linux.it wrote:
> From: Mattia Dongili <malattia@linux.it>
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> ---
>  drivers/acpi/sony_acpi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
> index c65f589..8c69282 100644
> --- a/drivers/acpi/sony_acpi.c
> +++ b/drivers/acpi/sony_acpi.c
> @@ -357,6 +357,8 @@ static int sony_acpi_add(struct acpi_device *device)
>  	        if (IS_ERR(sony_backlight_device)) {
>          	        printk(LOG_PFX "unable to register backlight device\n");
>  		}
> +		sony_backlight_properties.brightness =
> +			sony_backlight_get_brightness(sony_backlight_device);

Ok, this one is at wrong and incomplete (the error exit path is missing
the backlight device unregistration).

Will resend a correct patch later.

-- 
mattia
:wq!
