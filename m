From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI suspend: Always use the 32-bit waking vector
Date: Wed, 24 Sep 2008 03:17:45 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809240316550.20067@localhost.localdomain>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com>
 <1220577437.4007.148.camel@yakui_zhao.sh.intel.com>
 <76780B19A496DC4B80439008DAD7076C01803B89F1@PDSMSX501.ccr.corp.intel.com>
 <200809061313.02088.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:57088 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbYIXHRv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Sep 2008 03:17:51 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K7O00DACUXQ4MI1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 24 Sep 2008 02:17:51 -0500 (CDT)
In-reply-to: <200809061313.02088.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "andi@firstfloor.org" <andi@firstfloor.org>




> Well, I read this part of the spec (2.0c, 3.0b) more carefully and it matches
> what you're saying.  Moreover, my understanding of it is that we should
> actually _clear_ the 64-bit vector on systems that support it, because
> otherwise the BIOS is supposed to use it and call the wake-up code in protected
> mode.
> 
> The appended patch is based on this observation.
> 
> Thanks,
> Rafael

applied to acpi-test.

thanks,
-Len

> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI suspend: Always use the 32-bit waking vector
> 
> According to the ACPI specification 2.0c and later, the 64-bit waking vector
> should be cleared and the 32-bit waking vector should be used, unless we want
> the wake-up code to be called by the BIOS in Protected Mode.  Moreover, some
> systems (for example HP dv5-1004nr) are known to fail to resume if the 64-bit
> waking vector is used.  Therefore, modify the code to clear the 64-bit waking
> vector, for FACS version 1 or greater, and set the 32-bit one before suspend.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/hardware/hwsleep.c |   37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
> +++ linux-2.6/drivers/acpi/hardware/hwsleep.c
> @@ -78,19 +78,17 @@ acpi_set_firmware_waking_vector(acpi_phy
>  		return_ACPI_STATUS(status);
>  	}
>  
> -	/* Set the vector */
> +	/*
> +	 * According to the ACPI specification 2.0c and later, the 64-bit
> +	 * waking vector should be cleared and the 32-bit waking vector should
> +	 * be used, unless we want the wake-up code to be called by the BIOS in
> +	 * Protected Mode.  Some systems (for example HP dv5-1004nr) are known
> +	 * to fail to resume if the 64-bit vector is used.
> +	 */
> +	if (facs->version >= 1)
> +		facs->xfirmware_waking_vector = 0;
>  
> -	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
> -		/*
> -		 * ACPI 1.0 FACS or short table or optional X_ field is zero
> -		 */
> -		facs->firmware_waking_vector = (u32) physical_address;
> -	} else {
> -		/*
> -		 * ACPI 2.0 FACS with valid X_ field
> -		 */
> -		facs->xfirmware_waking_vector = physical_address;
> -	}
> +	facs->firmware_waking_vector = (u32)physical_address;
>  
>  	return_ACPI_STATUS(AE_OK);
>  }
> @@ -134,20 +132,7 @@ acpi_get_firmware_waking_vector(acpi_phy
>  	}
>  
>  	/* Get the vector */
> -
> -	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
> -		/*
> -		 * ACPI 1.0 FACS or short table or optional X_ field is zero
> -		 */
> -		*physical_address =
> -		    (acpi_physical_address) facs->firmware_waking_vector;
> -	} else {
> -		/*
> -		 * ACPI 2.0 FACS with valid X_ field
> -		 */
> -		*physical_address =
> -		    (acpi_physical_address) facs->xfirmware_waking_vector;
> -	}
> +	*physical_address = (acpi_physical_address)facs->firmware_waking_vector;
>  
>  	return_ACPI_STATUS(AE_OK);
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
