From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: bay: use IS_ERR for return of register_platform_device_simple
Date: Wed, 14 Feb 2007 16:14:31 -0500
Message-ID: <200702141614.32024.lenb@kernel.org>
References: <20070214125459.GB4447@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51022 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932619AbXBNVPw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Feb 2007 16:15:52 -0500
In-Reply-To: <20070214125459.GB4447@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Applied,

thanks,
-Len

On Wednesday 14 February 2007 07:55, Henrique de Moraes Holschuh wrote:
> register_platform_device_simple returns ERR_PTR(foo), so test it with
> IS_ERR(foo).
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> 
> ---
> 
> I wonder how many of these are in the kernel?  An annotation for this would be
> a good idea.  It doesn't help that people, as usual, do not see fit to document
> how the heck they return errors, so you have to track down the source of every
> function you are not intimately familiar with before using it.
> ---
>  drivers/acpi/bay.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
> index dcf5f42..fb3f31b 100644
> --- a/drivers/acpi/bay.c
> +++ b/drivers/acpi/bay.c
> @@ -281,7 +281,7 @@ static int bay_add(acpi_handle handle, int id)
>  
>  	/* initialize platform device stuff */
>  	pdev = platform_device_register_simple(ACPI_BAY_CLASS, id, NULL, 0);
> -	if (pdev == NULL) {
> +	if (IS_ERR(pdev)) {
>  		printk(KERN_ERR PREFIX "Error registering bay device\n");
>  		goto bay_add_err;
>  	}
> -- 
> 1.4.4.4
> 
