From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [patch 09/26] ACPI: update asus_acpi driver registration
Date: Fri, 31 Mar 2006 22:47:49 +0200
Message-ID: <20060331204749.GA30044@electric-eye.fr.zoreil.com>
References: <200603282203.k2SM3gKA027674@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:9133 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932149AbWCaUsu
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Mar 2006 15:48:50 -0500
Content-Disposition: inline
In-Reply-To: <200603282203.k2SM3gKA027674@shell0.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com

akpm@osdl.org <akpm@osdl.org> :
[...]
> diff -puN drivers/acpi/asus_acpi.c~acpi-update-asus_acpi-driver-registration drivers/acpi/asus_acpi.c
> --- devel/drivers/acpi/asus_acpi.c~acpi-update-asus_acpi-driver-registration	2006-03-28 14:03:03.000000000 -0800
> +++ devel-akpm/drivers/acpi/asus_acpi.c	2006-03-28 14:03:03.000000000 -0800
[...]
> @@ -1226,7 +1230,19 @@ static int __init asus_acpi_init(void)
>  	asus_proc_dir->owner = THIS_MODULE;
>  
>  	result = acpi_bus_register_driver(&asus_hotk_driver);
> -	if (result < 1) {
> +	if (result < 0) {
> +		remove_proc_entry(PROC_ASUS, acpi_root_dir);
> +		return -ENODEV;
> +	}

acpi_bus_register_driver() returns a licit < 0 status code. Why should
it be overwritten ?

-- 
Ueimor
