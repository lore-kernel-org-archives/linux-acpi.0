From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH upstream build breakage] acpi: several drivers depend on NET
Date: Mon, 28 Feb 2011 09:03:32 -0800
Message-ID: <20110228090332.9ffe2087.randy.dunlap@oracle.com>
References: <20101220200013.df8fbc88.sfr@canb.auug.org.au>
	<20101220085340.7ba098b9.randy.dunlap@oracle.com>
	<20110126114203.GA16754@elte.hu>
	<20110201120323.GA6714@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110201120323.GA6714@elte.hu>
Sender: linux-next-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Luming Yu <luming.yu@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

On Tue, 1 Feb 2011 13:03:23 +0100 Ingo Molnar wrote:

> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > * Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > 
> > > On Mon, 20 Dec 2010 20:00:13 +1100 Stephen Rothwell wrote:
> > > 
> > > > Hi all,
> > > > 
> > > > [The mirroring on kernel.org is running slowly]
> > > > 
> > > > Changes since 20101217:
> > > 
> > > ERROR: "thermal_cooling_device_register" [drivers/acpi/video.ko] undefined!
> > > ERROR: "thermal_cooling_device_unregister" [drivers/acpi/video.ko] undefined!
> > 
> > This bug has been reported two months ago, one month ago, it has been ignored twice 
> > and now the bug has been pushed upstream and it's triggering there as well.
> > 
> > What's going on?
> 
> *Tap*, *tap*, is this thing on? :)
> 
> acpi-video is still build-broken upstream, as of .38-rc3:
> 
>    MODPOST 651 modules
>  ERROR: "thermal_cooling_device_register" [drivers/acpi/video.ko] undefined!
>  ERROR: "thermal_cooling_device_unregister" [drivers/acpi/video.ko] undefined!
>  WARNING: modpost: Found 37 section mismatch(es).
>  To see full details build your kernel with:
>  'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>  make[1]: *** [__modpost] Error 1
>  make: *** [modules] Error 2
> 
> Triggers in about 10% of all randconfig builds. Config attached.


From: Randy Dunlap <randy.dunlap@oracle.com>

Several ACPI drivers select THERMAL, but THERMAL depends on NET
(for netlink).  Fix build breakage by making the ACPI drivers
also depend on NET.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/Kconfig |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

This is what is needed to fix the breakage, but it seems
that Len does not care.
It would be better just to eliminate the netlink dependency.


--- linux-next-20110228.orig/drivers/acpi/Kconfig
+++ linux-next-20110228/drivers/acpi/Kconfig
@@ -163,7 +163,7 @@ config ACPI_BUTTON
 config ACPI_VIDEO
 	tristate "Video"
 	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
-	depends on INPUT
+	depends on INPUT && NET
 	select THERMAL
 	help
 	  This driver implements the ACPI Extensions For Display Adapters
@@ -177,6 +177,7 @@ config ACPI_VIDEO
 
 config ACPI_FAN
 	tristate "Fan"
+	depends on NET
 	select THERMAL
 	default y
 	help
@@ -195,6 +196,7 @@ config ACPI_DOCK
 
 config ACPI_PROCESSOR
 	tristate "Processor"
+	depends on NET
 	select THERMAL
 	select CPU_IDLE
 	default y
@@ -238,7 +240,7 @@ config ACPI_PROCESSOR_AGGREGATOR
 
 config ACPI_THERMAL
 	tristate "Thermal Zone"
-	depends on ACPI_PROCESSOR
+	depends on ACPI_PROCESSOR && NET
 	select THERMAL
 	default y
 	help
