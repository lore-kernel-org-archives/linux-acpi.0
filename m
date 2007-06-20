From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/12] acpi: select ACPI_EC for THINKPAD_ACPI
Date: Tue, 19 Jun 2007 21:57:44 -0300
Message-ID: <20070620005744.GA15080@khazad-dum.debian.net>
References: <20070619224836.GD5193@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759641AbXFTA6B@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070619224836.GD5193@alberich.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Herrmann <andreas.herrmann3@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 20 Jun 2007, Andreas Herrmann wrote:
> Fix kernel build problem:
> 
>  thinkpad_acpi.c:(.text+0x7486a): undefined reference to `ec_write'
> 
> (as THINKPAD_ACPI depends on ACPI_EC)
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  drivers/misc/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 2f2fbff..72774c9 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -139,6 +139,7 @@ config SONYPI_COMPAT
>  config THINKPAD_ACPI
>  	tristate "ThinkPad ACPI Laptop Extras"
>  	depends on X86 && ACPI
> +	select ACPI_EC
>  	select BACKLIGHT_CLASS_DEVICE
>  	select HWMON
>  	---help---

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
