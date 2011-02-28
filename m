From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH upstream build breakage] acpi: several drivers depend on NET
Date: Mon, 28 Feb 2011 21:37:15 +0100
Message-ID: <201102282137.15390.rjw@sisk.pl>
References: <20101220200013.df8fbc88.sfr@canb.auug.org.au> <20110201120323.GA6714@elte.hu> <20110228090332.9ffe2087.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110228090332.9ffe2087.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Luming Yu <luming.yu@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, February 28, 2011, Randy Dunlap wrote:
> On Tue, 1 Feb 2011 13:03:23 +0100 Ingo Molnar wrote:
> 
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > * Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > > 
> > > > On Mon, 20 Dec 2010 20:00:13 +1100 Stephen Rothwell wrote:
> > > > 
> > > > > Hi all,
> > > > > 
> > > > > [The mirroring on kernel.org is running slowly]
> > > > > 
> > > > > Changes since 20101217:
> > > > 
> > > > ERROR: "thermal_cooling_device_register" [drivers/acpi/video.ko] undefined!
> > > > ERROR: "thermal_cooling_device_unregister" [drivers/acpi/video.ko] undefined!
> > > 
> > > This bug has been reported two months ago, one month ago, it has been ignored twice 
> > > and now the bug has been pushed upstream and it's triggering there as well.
> > > 
> > > What's going on?
> > 
> > *Tap*, *tap*, is this thing on? :)
> > 
> > acpi-video is still build-broken upstream, as of .38-rc3:
> > 
> >    MODPOST 651 modules
> >  ERROR: "thermal_cooling_device_register" [drivers/acpi/video.ko] undefined!
> >  ERROR: "thermal_cooling_device_unregister" [drivers/acpi/video.ko] undefined!
> >  WARNING: modpost: Found 37 section mismatch(es).
> >  To see full details build your kernel with:
> >  'make CONFIG_DEBUG_SECTION_MISMATCH=y'
> >  make[1]: *** [__modpost] Error 1
> >  make: *** [modules] Error 2
> > 
> > Triggers in about 10% of all randconfig builds. Config attached.
> 
> 
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Several ACPI drivers select THERMAL, but THERMAL depends on NET
> (for netlink).  Fix build breakage by making the ACPI drivers
> also depend on NET.

Well, making ACPI_FAN depend on NET seems to be a kind of an overstretch to me.
A proper fix would be to disable the netlink interface in THERMAL when
NET is unset, I guess.  I'll see what can be done to that end (although I had
hoped that the people who introduced the breakage would handle it).

Thanks,
Rafael


> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/acpi/Kconfig |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> This is what is needed to fix the breakage, but it seems
> that Len does not care.
> It would be better just to eliminate the netlink dependency.
> 
> 
> --- linux-next-20110228.orig/drivers/acpi/Kconfig
> +++ linux-next-20110228/drivers/acpi/Kconfig
> @@ -163,7 +163,7 @@ config ACPI_BUTTON
>  config ACPI_VIDEO
>  	tristate "Video"
>  	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
> -	depends on INPUT
> +	depends on INPUT && NET
>  	select THERMAL
>  	help
>  	  This driver implements the ACPI Extensions For Display Adapters
> @@ -177,6 +177,7 @@ config ACPI_VIDEO
>  
>  config ACPI_FAN
>  	tristate "Fan"
> +	depends on NET
>  	select THERMAL
>  	default y
>  	help
> @@ -195,6 +196,7 @@ config ACPI_DOCK
>  
>  config ACPI_PROCESSOR
>  	tristate "Processor"
> +	depends on NET
>  	select THERMAL
>  	select CPU_IDLE
>  	default y
> @@ -238,7 +240,7 @@ config ACPI_PROCESSOR_AGGREGATOR
>  
>  config ACPI_THERMAL
>  	tristate "Thermal Zone"
> -	depends on ACPI_PROCESSOR
> +	depends on ACPI_PROCESSOR && NET
>  	select THERMAL
>  	default y
>  	help
> 
> 
