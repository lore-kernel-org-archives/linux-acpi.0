From: Jan Dittmer <jdi@l4x.org>
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support, fifth try
Date: Wed, 04 Oct 2006 08:10:10 +0200
Message-ID: <45235042.4090201@l4x.org>
References: <20061004024927.GA27716@ecstasy.ring2.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.portrix.net ([212.202.157.208]:41636 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S1030381AbWJDGLL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Oct 2006 02:11:11 -0400
In-Reply-To: <20061004024927.GA27716@ecstasy.ring2.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dtor@insightbb.com, akpm@osdl.org

Lennart Poettering wrote:
> This is the fifth version of this driver. Changes to the previous
> version are mostly cosmetics: on request of Andrew Morton I replaced
> indentation with spaces by tabs (by passing it through "unexpand"). 

> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -384,6 +384,8 @@ extern int ec_transaction(u8 command,
>  				   wdata_len, rdata, rdata_len);
>  }
>  
> +EXPORT_SYMBOL(ec_transaction);
> +
>  static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
>  {
>  	int result;
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 7fc692a..d25b0db 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -28,5 +28,24 @@ config IBM_ASM
>  
>  	  If unsure, say N.
>  
> +config MSI_LAPTOP
> +        tristate "MSI Laptop Extras"
> +        depends on X86
> +        depends on ACPI_EC
> +        depends on BACKLIGHT_CLASS_DEVICE
> +        ---help---
> +          This is a driver for laptops built by MSI (MICRO-STAR 
> +	  INTERNATIONAL):
> +	      
> +	      MSI MegaBook S270 (MS-1013)
> +	      Cytron/TCM/Medion/Tchibo MD96100/SAM2000
> +	   
> +	  It adds support for Bluetooth, WLAN and LCD brightness control.
> +
> +          More information about this driver is available at
> +          <http://0pointer.de/lennart/tchibo.html>.
> +
> +          If you have an MSI S270 laptop, say Y or M here.
> +
>  endmenu

This part is still spaces only. The help text should be indented
by tab + 2 spaces.

Jan
