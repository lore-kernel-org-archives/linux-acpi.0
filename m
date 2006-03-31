From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [patch 12/26] ACPI: simplify scan.c coding
Date: Fri, 31 Mar 2006 23:00:59 +0200
Message-ID: <20060331210059.GB30044@electric-eye.fr.zoreil.com>
References: <200603282203.k2SM3iIk027683@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:16256 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932239AbWCaVEr
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Mar 2006 16:04:47 -0500
Content-Disposition: inline
In-Reply-To: <200603282203.k2SM3iIk027683@shell0.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com

akpm@osdl.org <akpm@osdl.org> :
[...]
> diff -puN drivers/acpi/scan.c~acpi-simplify-scanc-coding drivers/acpi/scan.c
> --- devel/drivers/acpi/scan.c~acpi-simplify-scanc-coding	2006-03-28 14:03:04.000000000 -0800
> +++ devel-akpm/drivers/acpi/scan.c	2006-03-28 14:03:04.000000000 -0800
[...]
> @@ -639,21 +631,19 @@ EXPORT_SYMBOL(acpi_bus_register_driver);
>   */
>  int acpi_bus_unregister_driver(struct acpi_driver *driver)
>  {
> -	int error = 0;
> -
>  	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
>  
> -	if (driver) {
> -		acpi_driver_detach(driver);
> +	if (!driver)
> +		return_VALUE(-EINVAL);

Afaiks driver can not be NULL and no one checks the return
code of acpi_bus_unregister_driver. More cleanup in sight ?

-- 
Ueimor
