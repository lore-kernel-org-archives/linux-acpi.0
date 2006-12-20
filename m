From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 05/19] make drivers/acpi/ec.c:ec_ecdt static
Date: Wed, 20 Dec 2006 00:45:04 -0500
Message-ID: <200612200045.04972.lenb@kernel.org>
References: <200612192056.kBJKuCfo010020@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55457 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964901AbWLTFwA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 00:52:00 -0500
In-Reply-To: <200612192056.kBJKuCfo010020@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bunk@stusta.de

Applied.

thanks,
-Len

On Tuesday 19 December 2006 15:56, akpm@osdl.org wrote:
> From: Adrian Bunk <bunk@stusta.de>
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/ec.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/ec.c~make-drivers-acpi-eccec_ecdt-static drivers/acpi/ec.c
> --- a/drivers/acpi/ec.c~make-drivers-acpi-eccec_ecdt-static
> +++ a/drivers/acpi/ec.c
> @@ -92,7 +92,7 @@ static struct acpi_driver acpi_ec_driver
>  };
>  
>  /* If we find an EC via the ECDT, we need to keep a ptr to its context */
> -struct acpi_ec {
> +static struct acpi_ec {
>  	acpi_handle handle;
>  	unsigned long uid;
>  	unsigned long gpe;
> _
> 
