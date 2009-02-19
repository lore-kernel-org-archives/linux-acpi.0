From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 2/2 v2] ACPI: update Kconfig help texts (no functional changes)
Date: Thu, 19 Feb 2009 14:45:47 -0700
Message-ID: <200902191445.48064.bjorn.helgaas@hp.com>
References: <20090219195548.20757.53184.stgit@bob.kio> <20090219195621.20757.83135.stgit@bob.kio> <alpine.LFD.2.00.0902191532090.16661@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:13273 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbZBSVpy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Feb 2009 16:45:54 -0500
In-Reply-To: <alpine.LFD.2.00.0902191532090.16661@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Use "help" (not "---help---") consistently throughout.
    
ACPI can't be a module, so if both ACPI & APM are configured,
we use ACPI.
    
Update pointers to ACPI CA and Linux ACPI projects.
    
Replace "Compaq" with "Hewlett-Packard" in the spec developer list.
  
Fix typo in /sys/module path.
   
The user-space daemon is "acpid", not "acpi".
    
Add standard "To compile this driver as a module ..." help text.
    
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 8a851d0..431f8b4 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -11,9 +11,9 @@ menuconfig ACPI
 	select PNP
 	select CPU_IDLE
 	default y
-	---help---
+	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
-	  Linux requires an ACPI compliant platform (hardware/firmware),
+	  Linux requires an ACPI-compliant platform (hardware/firmware),
 	  and assumes the presence of OS-directed configuration and power
 	  management (OSPM) software.  This option will enlarge your 
 	  kernel by about 70K.
@@ -23,20 +23,19 @@ menuconfig ACPI
 	  the Plug-and-Play BIOS specification (PnP BIOS), the 
 	  MultiProcessor Specification (MPS), and the Advanced Power 
 	  Management (APM) specification.  If both ACPI and APM support 
-	  are configured, whichever is loaded first shall be used.
+	  are configured, ACPI is used.
 
-	  The ACPI SourceForge project contains the latest source code, 
-	  documentation, tools, mailing list subscription, and other 
-	  information.  This project is available at:
-	  <http://sourceforge.net/projects/acpi>
+	  The project home page for the Linux ACPI subsystem is here:
+	  <http://www.lesswatts.org/projects/acpi/>
 
 	  Linux support for ACPI is based on Intel Corporation's ACPI
-	  Component Architecture (ACPI CA).  For more information see:
-	  <http://developer.intel.com/technology/iapc/acpi>
+	  Component Architecture (ACPI CA).  For more information on the
+	  ACPI CA, see:
+	  <http://acpica.org/>
 
-	  ACPI is an open industry specification co-developed by Compaq, 
-	  Intel, Microsoft, Phoenix, and Toshiba.  The specification is 
-	  available at:
+	  ACPI is an open industry specification co-developed by
+	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.
+	  The specification is available at:
 	  <http://www.acpi.info>
 
 if ACPI
@@ -49,14 +48,14 @@ config ACPI_SLEEP
 config ACPI_PROCFS
 	bool "Deprecated /proc/acpi files"
 	depends on PROC_FS
-	---help---
+	help
 	  For backwards compatibility, this option allows
 	  deprecated /proc/acpi/ files to exist, even when
 	  they have been replaced by functions in /sys.
 	  The deprecated files (and their replacements) include:
 
 	  /proc/acpi/sleep (/sys/power/state)
-	  /proc/acpi/info (/sys/modules/acpi/parameters/acpica_version)
+	  /proc/acpi/info (/sys/module/acpi/parameters/acpica_version)
 	  /proc/acpi/dsdt (/sys/firmware/acpi/tables/DSDT)
 	  /proc/acpi/fadt (/sys/firmware/acpi/tables/FACP)
 	  /proc/acpi/debug_layer (/sys/module/acpi/parameters/debug_layer)
@@ -66,11 +65,12 @@ config ACPI_PROCFS
 	  and functions which do not yet exist in /sys.
 
 	  Say N to delete /proc/acpi/ files that have moved to /sys/
+
 config ACPI_PROCFS_POWER
 	bool "Deprecated power /proc/acpi directories"
 	depends on PROC_FS
 	default y
-	---help---
+	help
 	  For backwards compatibility, this option allows
           deprecated power /proc/acpi/ directories to exist, even when
           they have been replaced by functions in /sys.
@@ -86,19 +86,19 @@ config ACPI_SYSFS_POWER
 	bool "Future power /sys interface"
 	select POWER_SUPPLY
 	default y
-	---help---
+	help
 	  Say N to disable power /sys interface
 
 config ACPI_PROC_EVENT
 	bool "Deprecated /proc/acpi/event support"
 	depends on PROC_FS
 	default y
-	---help---
-	  A user-space daemon, acpi, typically read /proc/acpi/event
-	  and handled all ACPI sub-system generated events.
+	help
+	  A user-space daemon, acpid, typically reads /proc/acpi/event
+	  and handles all ACPI-generated events.
 
-	  These events are now delivered to user-space via
-	  either the input layer, or as netlink events.
+	  These events are now delivered to user-space either
+	  via the input layer or as netlink events.
 
 	  This build option enables the old code for legacy
 	  user-space implementation.  After some time, this will
@@ -112,10 +112,13 @@ config ACPI_AC
 	depends on X86
 	default y
 	help
-	  This driver adds support for the AC Adapter object, which indicates
-	  whether a system is on AC, or not. If you have a system that can
+	  This driver supports the AC Adapter object, which indicates
+	  whether a system is on AC or not.  If you have a system that can
 	  switch between A/C and battery, say Y.
 
+	  To compile this driver as a module, choose M here:
+	  the module will be called ac.
+
 config ACPI_BATTERY
 	tristate "Battery"
 	depends on X86
@@ -125,15 +128,21 @@ config ACPI_BATTERY
 	  /proc/acpi/battery. If you have a mobile system with a battery, 
 	  say Y.
 
+	  To compile this driver as a module, choose M here:
+	  the module will be called battery.
+
 config ACPI_BUTTON
 	tristate "Button"
 	depends on INPUT
 	default y
 	help
-	  This driver handles events on the power, sleep and lid buttons.
+	  This driver handles events on the power, sleep, and lid buttons.
 	  A daemon reads /proc/acpi/event and perform user-defined actions
 	  such as shutting down the system.  This is necessary for
-	  software controlled poweroff.
+	  software-controlled poweroff.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called button.
 
 config ACPI_VIDEO
 	tristate "Video"
@@ -141,38 +150,45 @@ config ACPI_VIDEO
 	depends on INPUT
 	select THERMAL
 	help
-	  This driver implement the ACPI Extensions For Display Adapters
+	  This driver implements the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
-	  ACPI 2.0 Specification, Appendix B, allowing to perform some basic
-	  control like defining the video POST device, retrieving EDID information
-	  or to setup a video output, etc.
-	  Note that this is an ref. implementation only.  It may or may not work
-	  for your integrated video device.
+	  ACPI 2.0 Specification, Appendix B.  This supports basic operations
+	  such as defining the video POST device, retrieving EDID information,
+	  and setting up a video output.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called video.
 
 config ACPI_FAN
 	tristate "Fan"
 	select THERMAL
 	default y
 	help
-	  This driver adds support for ACPI fan devices, allowing user-mode 
+	  This driver supports ACPI fan devices, allowing user-mode
 	  applications to perform basic fan control (on, off, status).
 
+	  To compile this driver as a module, choose M here:
+	  the module will be called fan.
+
 config ACPI_DOCK
 	bool "Dock"
 	depends on EXPERIMENTAL
 	help
-	  This driver adds support for ACPI controlled docking stations and removable
-	  drive bays such as the IBM ultrabay or the Dell Module Bay.
+	  This driver supports ACPI-controlled docking stations and removable
+	  drive bays such as the IBM Ultrabay and the Dell Module Bay.
 
 config ACPI_PROCESSOR
 	tristate "Processor"
 	select THERMAL
 	default y
 	help
-	  This driver installs ACPI as the idle handler for Linux, and uses
-	  ACPI C2 and C3 processor states to save power, on systems that
+	  This driver installs ACPI as the idle handler for Linux and uses
+	  ACPI C2 and C3 processor states to save power on systems that
 	  support it.  It is required by several flavors of cpufreq
-	  Performance-state drivers.
+	  performance-state drivers.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called processor.
 
 config ACPI_HOTPLUG_CPU
 	bool
@@ -186,11 +202,14 @@ config ACPI_THERMAL
 	select THERMAL
 	default y
 	help
-	  This driver adds support for ACPI thermal zones.  Most mobile and
+	  This driver supports ACPI thermal zones.  Most mobile and
 	  some desktop systems support ACPI thermal zones.  It is HIGHLY
 	  recommended that this option be enabled, as your processor(s)
 	  may be damaged without it.
 
+	  To compile this driver as a module, choose M here:
+	  the module will be called thermal.
+
 config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
@@ -218,7 +237,7 @@ config ACPI_BLACKLIST_YEAR
 	int "Disable ACPI for systems before Jan 1st this year" if X86_32
 	default 0
 	help
-	  enter a 4-digit year, eg. 2001 to disable ACPI by default
+	  Enter a 4-digit year, e.g., 2001, to disable ACPI by default
 	  on platforms with DMI BIOS date before January 1st that year.
 	  "acpi=force" can be used to override this mechanism.
 
@@ -249,10 +268,13 @@ config ACPI_PCI_SLOT
 	tristate "PCI slot detection driver"
 	default n
 	help
-	  This driver will attempt to discover all PCI slots in your system,
-	  and creates entries in /sys/bus/pci/slots/. This feature can
-	  help you correlate PCI bus addresses with the physical geography
-	  of your slots. If you are unsure, say N.
+	  This driver creates entries in /sys/bus/pci/slots/ for all PCI
+	  slots in the system.  This can help correlate PCI bus addresses,
+	  i.e., segment/bus/device/function tuples, with physical slots in
+	  the system.  If you are unsure, say N.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called pci_slot.
 
 config X86_PM_TIMER
 	bool "Power Management Timer Support" if EMBEDDED
@@ -271,43 +293,43 @@ config X86_PM_TIMER
 	  systems require this timer. 
 
 config ACPI_CONTAINER
-	tristate "ACPI0004,PNP0A05 and PNP0A06 Container Driver (EXPERIMENTAL)"
+	tristate "Container and Module Devices (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU || ACPI_HOTPLUG_IO)
-	 ---help---
-	  This allows _physical_ insertion and removal of CPUs and memory.
-	  This can be useful, for example, on NUMA machines that support
-	  ACPI based physical hotplug of nodes, or non-NUMA machines that
-	  support physical cpu/memory hot-plug.
+	help
+	  This driver supports ACPI Container and Module devices (IDs
+	  ACPI0004, PNP0A05, and PNP0A06).
 
-	  If one selects "m", this driver can be loaded with
-	  "modprobe container".
+	  This helps support hotplug of nodes, CPUs, and memory.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called container.
 
 config ACPI_HOTPLUG_MEMORY
 	tristate "Memory Hotplug"
 	depends on MEMORY_HOTPLUG
 	default n
 	help
-	  This driver adds supports for ACPI Memory Hotplug.  This driver
-	  provides support for fielding notifications on ACPI memory
-	  devices (PNP0C80) which represent memory ranges that may be
-	  onlined or offlined during runtime.  
+	  This driver supports ACPI memory hotplug.  The driver
+	  fields notifications on ACPI memory devices (PNP0C80),
+	  which represent memory ranges that may be onlined or
+	  offlined during runtime.
 
-	  Enabling this driver assumes that your platform hardware
-	  and firmware have support for hot-plugging physical memory. If
-	  your system does not support physically adding or ripping out 
-	  memory DIMMs at some platform defined granularity (individually 
-	  or as a bank) at runtime, then you need not enable this driver.
+	  If your hardware and firmware do not support adding or
+	  removing memory devices at runtime, you need not enable
+	  this driver.
 
-	  If one selects "m," this driver can be loaded using the following
-	  command: 
-		$>modprobe acpi_memhotplug 
+	  To compile this driver as a module, choose M here:
+	  the module will be called acpi_memhotplug.
 
 config ACPI_SBS
 	tristate "Smart Battery System"
 	depends on X86
 	help
-	  This driver adds support for the Smart Battery System, another
+	  This driver supports the Smart Battery System, another
 	  type of access to battery information, found on some laptops.
 
+	  To compile this driver as a module, choose M here:
+	  the modules will be called sbs and sbshc.
+
 endif	# ACPI
