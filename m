From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 12/12] acpi: select ACPI_EC for SONY_LAPTOP
Date: Wed, 20 Jun 2007 13:30:12 +0900
Message-ID: <20070620043011.GA4214@inferi.kami.home>
References: <20070619225225.GN5193@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:65144 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434AbXFTEaU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jun 2007 00:30:20 -0400
Content-Disposition: inline
In-Reply-To: <20070619225225.GN5193@alberich.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Herrmann <andreas.herrmann3@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Jun 20, 2007 at 12:52:25AM +0200, Andreas Herrmann wrote:
> Fix kernel build problem as SONY_LAPTOP depends on ACPI_EC.

The same questions about ACPI_SYSTEM and ACPI_POWER surviving oldconfig
hold here.
See also http://lkml.org/lkml/2007/5/15/168 and following for a previous
report.

In any case, Len if you're going apply such fixes feel free to add my
Acked-By on this one.

> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  drivers/misc/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 0d6f369..463fa41 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -119,6 +119,7 @@ config MSI_LAPTOP
>  config SONY_LAPTOP
>  	tristate "Sony Laptop Extras"
>  	depends on X86 && ACPI
> +	select ACPI_EC
>  	select BACKLIGHT_CLASS_DEVICE
>  	  ---help---
>  	  This mini-driver drives the SNC and SPIC devices present in the ACPI
> -- 
> 1.5.0.7
-- 
mattia
:wq!
