From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: linux-acpi@vger.kernel.org
Date: Sat, 14 Feb 2009 08:52:35 +0000
Message-ID: <200902140852.36282.carlos@strangeworlds.co.uk>
References: <87r623cz5i.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:52017 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZBNIwq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Feb 2009 03:52:46 -0500
In-Reply-To: <87r623cz5i.fsf@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

[CC'ing linux-acpi]

Len, can you pick this up please?

On Thursday 12 February 2009 18:01:45 Robert Jarzmik wrote:
> Would you please consider the following patch for the 2.6.29-rc trivial
> fixes please ?
>
> --
> Robert
>
> From f2bb541e2e0925d3dede3be5fd2fe618fb40a404 Mon Sep 17 00:00:00 2001
> From: Robert Jarzmik <rjarzmik@free.fr>
> Date: Thu, 12 Feb 2009 18:55:51 +0100
> Subject: [PATCH] acer-wmi: Fix acpi video detection
>
> Acer WMI video driver can be used if _no_ acpi video
> driver is found, not the opposite.
>
> Signed-off-by: Robert Jarzmik <rjarzmik@free.fr>

Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

> ---
>  drivers/platform/x86/acer-wmi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/platform/x86/acer-wmi.c
> b/drivers/platform/x86/acer-wmi.c index 94c9f91..6bcca61 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1297,7 +1297,7 @@ static int __init acer_wmi_init(void)
>
>  	set_quirks();
>
> -	if (!acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
> +	if (acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
>  		interface->capability &= ~ACER_CAP_BRIGHTNESS;
>  		printk(ACER_INFO "Brightness must be controlled by "
>  		       "generic video driver\n");

-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
