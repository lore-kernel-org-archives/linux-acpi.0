From: Ben Slusky <sluskyb@paranoiacs.org>
Subject: Re: [PATCH] Add generic backlight support to toshiba_acpi driver
Date: Thu, 9 Feb 2006 12:51:08 -0500
Message-ID: <20060209175107.GC9810@paranoiacs.org>
References: <20060207133456.GA2452@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lizards-lair.paranoiacs.org ([216.158.28.252]:13516 "EHLO
	lizards-lair.paranoiacs.org") by vger.kernel.org with ESMTP
	id S1422929AbWBIRvP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Feb 2006 12:51:15 -0500
Content-Disposition: inline
In-Reply-To: <20060207133456.GA2452@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: john@neggie.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 07 Feb 2006 13:34:56 +0000, Matthew Garrett wrote:
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -215,7 +215,7 @@ config ACPI_IBM
>  
>  config ACPI_TOSHIBA
>  	tristate "Toshiba Laptop Extras"
> -	depends on X86
> +	depends on X86 && BACKLIGHT_DEVICE
>  	default y
>  	---help---
>  	  This driver adds support for access to certain system settings

Might this work better:

	config ACPI_TOSHIBA
		depends on X86
		select BACKLIGHT_DEVICE

-
-Ben


-- 
Ben Slusky                  | It was only after their population
sluskyb@paranoiacs.org      | of 50 mysteriously shrank to eight
sluskyb@stwing.org          | that the other seven dwarfs began
PGP keyID ADA44B3B          | to suspect Hungry.
