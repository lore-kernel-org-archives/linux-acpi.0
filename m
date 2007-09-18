From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi_video: kernel build error if !INPUT
Date: Tue, 18 Sep 2007 12:53:54 -0400
Message-ID: <200709181253.54227.lenb@kernel.org>
References: <20070917214105.GC22458@devil>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50166 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759935AbXIRQyN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 12:54:13 -0400
In-Reply-To: <20070917214105.GC22458@devil>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Herrmann <aherrman@arcor.de>
Cc: Yu Luming <luming.yu@intel.com>, linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Monday 17 September 2007 17:41, Andreas Herrmann wrote:
> Commit e9dab1960ac9746fa34eff726b81635147615a79 exports ACPI
> video hotkey events via input layer. But this breaks kernel
> build if ACPI_VIDEO && !INPUT:
> 
>  LD      .tmp_vmlinux1
> drivers/built-in.o: In function `acpi_video_bus_remove':
> drivers/acpi/video.c:2007: undefined reference to `input_unregister_device'
>     ...
> 
> Add dependency to INPUT for ACPI_VIDEO to prevent this error.
> 
> Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
> ---
>  drivers/acpi/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 4875f01..9685b75 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -117,6 +117,7 @@ config ACPI_BUTTON
>  config ACPI_VIDEO
>  	tristate "Video"
>  	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
> +	depends on INPUT
>  	help
>  	  This driver implement the ACPI Extensions For Display Adapters
>  	  for integrated graphics devices on motherboard, as specified in
