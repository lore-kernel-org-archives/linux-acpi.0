From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] hook ACPI _PSx method to IDE power on/off
Date: Sat, 4 Aug 2007 21:55:24 +0200
Message-ID: <200708042155.24843.bzolnier@gmail.com>
References: <1186035248.29979.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:51446 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104AbXHDUQB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Aug 2007 16:16:01 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1014326fkz
        for <linux-acpi@vger.kernel.org>; Sat, 04 Aug 2007 13:15:59 -0700 (PDT)
In-Reply-To: <1186035248.29979.5.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thursday 02 August 2007, Shaohua Li wrote:
> ACPI spec defines the sequence of IDE power on/off:
> Powering down:
> 	Call _GTM.
> 	Power down drive (calls _PS3 method and turns off power planes).
> Powering up:
> 	Power up drive (calls _PS0 method if present and turns on power planes).
> 	Call _STM passing info from _GTM (possibly modified), with ID data from
> 	each drive.
> 	Initialize the channel.
> 	May modify the results of _GTF.
> 	For each drive:
> 		Call _GTF.
> 		Execute task file (possibly modified).
> This patch adds the missed _PS0/_PS3 methods call.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

applied, thanks

Len, are you OK with the ACPI part of the patch (below)?

> Index: linux/drivers/acpi/bus.c
> ===================================================================
> --- linux.orig/drivers/acpi/bus.c	2007-08-02 13:35:06.000000000 +0800
> +++ linux/drivers/acpi/bus.c	2007-08-02 13:56:56.000000000 +0800
> @@ -262,10 +262,12 @@ int acpi_bus_set_power(acpi_handle handl
>  		printk(KERN_WARNING PREFIX
>  			      "Transitioning device [%s] to D%d\n",
>  			      device->pnp.bus_id, state);
> -	else
> +	else {
> +		device->power.state = state;
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Device [%s] transitioned to D%d\n",
>  				  device->pnp.bus_id, state));
> +	}
>  
>  	return result;
>  }
