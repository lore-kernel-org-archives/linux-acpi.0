From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH]: ACPI : Set 32bit and 64bit waking vector in FCAS table
Date: Thu, 4 Sep 2008 10:10:06 +0200
Message-ID: <200809041010.07058.rjw@sisk.pl>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52108 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757069AbYIDIGA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Sep 2008 04:06:00 -0400
In-Reply-To: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org

On Thursday, 4 of September 2008, Zhao Yakui wrote:
> Subject: ACPI : Set 32bit and 64bit waking vector in FCAS table
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
>     On some laptops only the 64bit waking vecotr is set for ACPI 2.0 FACS.
> But when the system is resumed, BIOS will transfer control directly to 
> 32bit waking vector. In such case the system can't be resumed correctly.
>     Maybe it will be more appropriate that both the 32bit and 64bit waking 
> vector will be set for the ACPI 2.0 FACS when the system enters the S3 
> sleeping state.
> 
>  http://bugzilla.kernel.org/show_bug.cgi?id=11368

Well, the spec (2.0c) says we should use facs->firmware_waking_vector only
if facs->xfirmware_waking_vector is zero, so I'm afraid this change may cause
regressions to happen.

Moreover, both 1.0b and 2.0c say that facs->length should be at least 64 bytes,
so the (facs->length >= 32) check is actually redundant (unless there is a
quirk setting this value below 32 for some broken systems I'm not aware of).

So, the question is what happens if we ignore the facs->length check on systems
this patch is supposed to fix.  If they _still_ require
facs->firmware_waking_vector to be set even if
facs->xfirmware_waking_vector is non-zero, I'd prefer to add quirks for them
instead of affecting everybody else.

> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/hardware/hwsleep.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
> +++ linux-2.6/drivers/acpi/hardware/hwsleep.c
> @@ -80,14 +80,14 @@ acpi_set_firmware_waking_vector(acpi_phy
>  
>  	/* Set the vector */
>  
> -	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
> -		/*
> -		 * ACPI 1.0 FACS or short table or optional X_ field is zero
> -		 */
> -		facs->firmware_waking_vector = (u32) physical_address;
> -	} else {
> +	/* 32 Bit wakeing vector is always set */
> +	facs->firmware_waking_vector = (u32) physical_address;
> +
> +	if (facs->length >= 32) {
>  		/*
> -		 * ACPI 2.0 FACS with valid X_ field
> +		 * ACPI 2.0 FACS with the valid X_filed. Its length
> +		 * will be more than 32 bytes. In such case the 64 bit
> +		 * waking vector is also set.
>  		 */
>  		facs->xfirmware_waking_vector = physical_address;
>  	}
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


