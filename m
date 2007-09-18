From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop/thinkpad-acpi: fix build error
Date: Tue, 18 Sep 2007 20:03:20 +0900
Message-ID: <20070918110320.GA32218@inferi.kami.home>
References: <20070917205434.GA22458@devil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi11.ns.itscom.net ([219.110.2.181]:50068 "EHLO
	mtoichi11.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbXIRLDb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Sep 2007 07:03:31 -0400
Content-Disposition: inline
In-Reply-To: <20070917205434.GA22458@devil>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Herrmann <aherrman@arcor.de>
Cc: Len Brown <len.brown@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Mon, Sep 17, 2007 at 10:54:34PM +0200, Andreas Herrmann wrote:
> sony-laptop and thinkpad-acpi make use of input-core functions.
> Hence you get link errors if those drivers are built but CONFIG_INPUT
> is not set. Attached patch fixes this minor issue.
...
> Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
> ---
>  drivers/misc/Kconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 73e248f..c077df8 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -134,6 +134,7 @@ config SONY_LAPTOP
>  	tristate "Sony Laptop Extras"
>  	depends on X86 && ACPI
>  	select BACKLIGHT_CLASS_DEVICE
> +	select INPUT
>  	  ---help---
>  	  This mini-driver drives the SNC and SPIC devices present in the ACPI
>  	  BIOS of the Sony Vaio laptops.

Acked-by: Mattia Dongili <malattia@linux.it>

Thanks
-- 
mattia
:wq!
