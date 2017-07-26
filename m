From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3] ACPI/DRM: rework ACPI_VIDEO Kconfig dependencies
Date: Wed, 26 Jul 2017 20:23:25 +0200
Message-ID: <14179844.x9VpZbiLx4@aspire.rjw.lan>
References: <20170726135312.2214309-1-arnd@arndb.de> <20170726135312.2214309-3-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170726135312.2214309-3-arnd@arndb.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org, Len Brown <lenb@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@linux.ie>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jens Frederich <jfrederich@gmail.com>, Daniel Drake <dsd@laptop.org>, Jon Nettleton <jon.nettleton@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, nouveau@li
List-Id: linux-acpi@vger.kernel.org

On Wednesday, July 26, 2017 03:53:11 PM Arnd Bergmann wrote:
> ACPI_VIDEO keeps causing problems with circular Kconfig dependencies,
> as it depends on a couple of other symbols, and it gets selected by
> drivers that may end up being depending on others.
> 
> This is an attempt to simplify this by changing all drivers that
> currently 'select ACPI_VIDEO' to use 'depends on'. This by itself
> simplifies the dependency lists for the other drivers. We make
> ACPI_VIDEO 'default y' to avoid having it turned off for 'make
> oldconfig' users. This should again be fine as x86 users will
> normally want this enabled and the option is not available elsewhere.
> 
> I'm moving the 'select BACKLIGHT_CLASS_DEVICE/BACKLIGHT_LCD_SUPPORT'
> into ACPI_VIDEO as a further simplification, those were already
> selected by anything that selected ACPI_VIDEO before.
> 
> Changing the INPUT dependency in ACPI_CMPC is necessary to avoid a
> circular dependency with X86_PLATFORM_DEVICES/NOUVEAU.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/Kconfig            |  5 ++++-
>  drivers/gpu/drm/gma500/Kconfig  |  6 +-----
>  drivers/gpu/drm/i915/Kconfig    |  7 +------
>  drivers/gpu/drm/nouveau/Kconfig | 10 ++--------
>  drivers/platform/x86/Kconfig    |  6 ++----
>  5 files changed, 10 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1ce52f84dc23..a8f5a40e2914 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -182,9 +182,12 @@ config ACPI_BUTTON
>  
>  config ACPI_VIDEO
>  	tristate "Video"
> -	depends on X86 && BACKLIGHT_CLASS_DEVICE
> +	depends on X86
>  	depends on INPUT
>  	select THERMAL
> +	select BACKLIGHT_CLASS_DEVICE
> +	select BACKLIGHT_LCD_SUPPORT
> +	default y
>  	help
>  	  This driver implements the ACPI Extensions For Display Adapters
>  	  for integrated graphics devices on motherboard, as specified in

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the ACPI_VIDEO changes.

Thanks,
Rafael
