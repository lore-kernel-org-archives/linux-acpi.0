From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/6] thermal: add the support for building the generic
	thermal as a module
Date: Mon, 21 Apr 2008 16:07:13 +0800
Message-ID: <1208765233.3550.6.camel@rzhang-1.sh.intel.com>
References: <1207815114.27304.32.camel@acpi-hp-zz.sh.intel.com>
	 <20080416095931.7855a9e8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62654 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794AbYDUIId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Apr 2008 04:08:33 -0400
In-Reply-To: <20080416095931.7855a9e8@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi <linux-acpi@vger.kernel.org>


On Wed, 2008-04-16 at 15:59 +0800, Jean Delvare wrote:
> Hi Rui,
> 
> On Thu, 10 Apr 2008 16:11:54 +0800, Zhang, Rui wrote:
> > Build the generic thermal driver as module "thermal_sys".
> >
> > Make ACPI thermal, video, processor and fan SELECT the generic
> > thermal driver, as these drivers rely on it to build the sysfs I/F.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/Kconfig      |    4 +++-
> >  drivers/thermal/Kconfig   |    4 ++--
> >  drivers/thermal/Makefile  |    3 ++-
> >  drivers/thermal/thermal.c |    2 +-
> >  include/linux/thermal.h   |   14 --------------
> >  5 files changed, 8 insertions(+), 19 deletions(-)
> >
> > Index: linux-2.6/drivers/thermal/Kconfig
> > ===================================================================
> > --- linux-2.6.orig/drivers/thermal/Kconfig
> > +++ linux-2.6/drivers/thermal/Kconfig
> > @@ -3,7 +3,7 @@
> >  #
> > 
> >  menuconfig THERMAL
> > -     bool "Generic Thermal sysfs driver"
> > +     tristate "Generic Thermal sysfs driver"
> >       help
> >         Generic Thermal Sysfs driver offers a generic mechanism for
> >         thermal management. Usually it's made up of one or more
> thermal
> > @@ -11,4 +11,4 @@ menuconfig THERMAL
> >         Each thermal zone contains its own temperature, trip points,
> >         cooling devices.
> >         All platforms with ACPI thermal support can use this driver.
> > -       If you want this support, you should say Y here.
> > +       If you want this support, you should say Y or M here.
> > Index: linux-2.6/drivers/thermal/thermal.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/thermal/thermal.c
> > +++ linux-2.6/drivers/thermal/thermal.c
> > @@ -31,7 +31,7 @@
> >  #include <linux/thermal.h>
> >  #include <linux/spinlock.h>
> > 
> > -MODULE_AUTHOR("Zhang Rui")
> > +MODULE_AUTHOR("Zhang Rui");
> >  MODULE_DESCRIPTION("Generic thermal management sysfs support");
> >  MODULE_LICENSE("GPL");
> > 
> > Index: linux-2.6/drivers/thermal/Makefile
> > ===================================================================
> > --- linux-2.6.orig/drivers/thermal/Makefile
> > +++ linux-2.6/drivers/thermal/Makefile
> > @@ -2,4 +2,5 @@
> >  # Makefile for sensor chip drivers.
> >  #
> > 
> > -obj-$(CONFIG_THERMAL)                += thermal.o
> > +thermal_sys-objs     += thermal.o
> > +obj-$(CONFIG_THERMAL)                += thermal_sys.o
> > Index: linux-2.6/drivers/acpi/Kconfig
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/Kconfig
> > +++ linux-2.6/drivers/acpi/Kconfig
> > @@ -140,6 +140,7 @@ config ACPI_VIDEO
> >       tristate "Video"
> >       depends on X86 && BACKLIGHT_CLASS_DEVICE &&
> VIDEO_OUTPUT_CONTROL
> >       depends on INPUT
> > +     select THERMAL
> >       help
> >         This driver implement the ACPI Extensions For Display
> Adapters
> >         for integrated graphics devices on motherboard, as specified
> in
> > @@ -151,6 +152,7 @@ config ACPI_VIDEO
> > 
> >  config ACPI_FAN
> >       tristate "Fan"
> > +     select THERMAL
> >       default y
> >       help
> >         This driver adds support for ACPI fan devices, allowing
> user-mode
> > @@ -172,6 +174,7 @@ config ACPI_BAY
> > 
> >  config ACPI_PROCESSOR
> >       tristate "Processor"
> > +     select THERMAL
> >       default y
> >       help
> >         This driver installs ACPI as the idle handler for Linux, and
> uses
> > @@ -188,7 +191,6 @@ config ACPI_HOTPLUG_CPU
> >  config ACPI_THERMAL
> >       tristate "Thermal Zone"
> >       depends on ACPI_PROCESSOR
> > -     select THERMAL
> >       default y
> >       help
> >         This driver adds support for ACPI thermal zones.  Most
> mobile and
> 
> I wouldn't remove this select. I agree it's not strictly needed right
> now because ACPI_THERMAL depends on ACPI_PROCESSOR and ACPI_PROCESSOR
> now selects THERMAL, but relying on "inherited" selects that way could
> break in the future, and is also not obvious for people not familiar
> with the code.
> 
> Likewise, I am a little worried that drivers/misc/intel_menlow.c needs
> THERMAL but doesn't select it. It works because it depends on
> ACPI_THERMAL which depends on ACPI_PROCESSOR which itself selects
> THERMAL, but that's again a (2nd order) indirect select which isn't
> obvious to the newcomer and could break in the future if dependencies
> change. I'd rather have each driver select what it needs regardless of
> inherited selects.
Build the generic thermal driver as module "thermal_sys".

Make ACPI thermal, video, processor and fan SELECT the generic
thermal driver, as these drivers rely on it to build the sysfs I/F.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig      |    3 +++
 drivers/misc/Kconfig      |    1 +
 drivers/thermal/Kconfig   |    4 ++--
 drivers/thermal/Makefile  |    3 ++-
 drivers/thermal/thermal.c |    2 +-
 include/linux/thermal.h   |   14 --------------
 6 files changed, 9 insertions(+), 18 deletions(-)

Index: old-git/drivers/thermal/Kconfig
===================================================================
--- old-git.orig/drivers/thermal/Kconfig	2008-04-11 17:10:02.000000000 +0800
+++ old-git/drivers/thermal/Kconfig	2008-04-21 15:03:51.000000000 +0800
@@ -3,7 +3,7 @@
 #
 
 menuconfig THERMAL
-	bool "Generic Thermal sysfs driver"
+	tristate "Generic Thermal sysfs driver"
 	help
 	  Generic Thermal Sysfs driver offers a generic mechanism for
 	  thermal management. Usually it's made up of one or more thermal
@@ -11,4 +11,4 @@
 	  Each thermal zone contains its own temperature, trip points,
 	  cooling devices.
 	  All platforms with ACPI thermal support can use this driver.
-	  If you want this support, you should say Y here.
+	  If you want this support, you should say Y or M here.
Index: old-git/drivers/thermal/thermal.c
===================================================================
--- old-git.orig/drivers/thermal/thermal.c	2008-04-11 17:10:02.000000000 +0800
+++ old-git/drivers/thermal/thermal.c	2008-04-21 15:06:41.000000000 +0800
@@ -31,7 +31,7 @@
 #include <linux/thermal.h>
 #include <linux/spinlock.h>
 
-MODULE_AUTHOR("Zhang Rui")
+MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL");
 
Index: old-git/drivers/thermal/Makefile
===================================================================
--- old-git.orig/drivers/thermal/Makefile	2008-04-11 17:10:02.000000000 +0800
+++ old-git/drivers/thermal/Makefile	2008-04-21 15:03:51.000000000 +0800
@@ -2,4 +2,5 @@
 # Makefile for sensor chip drivers.
 #
 
-obj-$(CONFIG_THERMAL)		+= thermal.o
+thermal_sys-objs	+= thermal.o
+obj-$(CONFIG_THERMAL)		+= thermal_sys.o
Index: old-git/drivers/acpi/Kconfig
===================================================================
--- old-git.orig/drivers/acpi/Kconfig	2008-04-11 17:09:47.000000000 +0800
+++ old-git/drivers/acpi/Kconfig	2008-04-21 15:07:03.000000000 +0800
@@ -140,6 +140,7 @@
 	tristate "Video"
 	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
 	depends on INPUT
+	select THERMAL
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
@@ -151,6 +152,7 @@
 
 config ACPI_FAN
 	tristate "Fan"
+	select THERMAL
 	default y
 	help
 	  This driver adds support for ACPI fan devices, allowing user-mode 
@@ -172,6 +174,7 @@
 
 config ACPI_PROCESSOR
 	tristate "Processor"
+	select THERMAL
 	default y
 	help
 	  This driver installs ACPI as the idle handler for Linux, and uses
Index: old-git/include/linux/thermal.h
===================================================================
--- old-git.orig/include/linux/thermal.h	2008-04-11 17:10:10.000000000 +0800
+++ old-git/include/linux/thermal.h	2008-04-21 15:06:42.000000000 +0800
@@ -88,24 +88,10 @@
 				     struct thermal_cooling_device *);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
-
-#ifdef	CONFIG_THERMAL
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 							       struct
 							       thermal_cooling_device_ops
 							       *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
-#else
-static inline struct thermal_cooling_device
-*thermal_cooling_device_register(char *c, void *v,
-				 struct thermal_cooling_device_ops *t)
-{
-	return NULL;
-}
-static inline
-    void thermal_cooling_device_unregister(struct thermal_cooling_device *t)
-{
-};
-#endif
 
 #endif /* __THERMAL_H__ */
Index: old-git/drivers/misc/Kconfig
===================================================================
--- old-git.orig/drivers/misc/Kconfig	2008-04-11 17:09:55.000000000 +0800
+++ old-git/drivers/misc/Kconfig	2008-04-21 15:07:30.000000000 +0800
@@ -311,6 +311,7 @@
 config INTEL_MENLOW
 	tristate "Thermal Management driver for Intel menlow platform"
 	depends on ACPI_THERMAL
+	select THERMAL
 	depends on X86
 	---help---
 	  ACPI thermal management enhancement driver on


