From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: [Patch] patchacpi_Configure.help for last acpi 2.4x kernels
Date: 22 Aug 2002 19:52:34 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1030060357.2692.6.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-im/QS9KboDqxVh0gqlGv"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-im/QS9KboDqxVh0gqlGv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This Configure.help seems more recent.

I think configure.help in drivers/acpi/ is the place where should be the
last help to be integrated.
 


--=-im/QS9KboDqxVh0gqlGv
Content-Disposition: attachment; filename=patchacpi_Configure.help.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patchacpi_Configure.help.txt; charset=ISO-8859-1

diff -Nura -x '*.orig' linux-2.4.19.orig/Documentation/Configure.help linux=
-2.4.19acpi2/Documentation/Configure.help
--- linux-2.4.19.orig/Documentation/Configure.help	Fri Aug  2 20:39:42 2002
+++ linux-2.4.19acpi2/Documentation/Configure.help	Thu Aug 22 19:29:04 2002
@@ -17586,70 +17586,64 @@
   will issue the hlt instruction if nothing is to be done, thereby
   sending the processor to sleep and saving power.
=20
-ACPI support
+ACPI Support
 CONFIG_ACPI
-  ACPI/OSPM support for Linux is currently under development. As such,
-  this support is preliminary and EXPERIMENTAL.  Configuring ACPI
-  support enables kernel interfaces that allow higher level software
-  (OSPM) to manipulate ACPI defined hardware and software interfaces,
-  including the evaluation of ACPI control methods.  If unsure, choose
-  N here.  Note, this option will enlarge your kernel by about 120K.
-
-  This support requires an ACPI compliant platform (hardware/firmware).
-  If both ACPI and Advanced Power Management (APM) support are
-  configured, whichever is loaded first shall be used.
-
-  This code DOES NOT currently provide a complete OSPM implementation
-  -- it has not yet reached APM's level of functionality.  When fully
-  implemented, Linux ACPI/OSPM will provide a more robust functional
-  replacement for legacy configuration and power management
-  interfaces, including the Plug-and-Play BIOS specification (PnP
-  BIOS), the Multi-Processor Specification (MPS), and the Advanced
-  Power Management specification (APM).
-
-  Linux support for ACPI/OSPM is based on Intel Corporation's ACPI
-  Component Architecture (ACPI CA). The latest ACPI CA source code,
-  documentation, debug builds, and implementation status information
-  can be downloaded from:
-  <http://developer.intel.com/technology/iapc/acpi/downloads.htm>.
-
-  The ACPI Sourceforge project may also be of interest:
-  <http://sf.net/projects/acpi/>
-
-Enable ACPI 2.0 with errata 1.3
-CONFIG_ACPI20
-  Enable support for the 2.0 version of the ACPI interpreter.  See the
-  help for ACPI for caveats and discussion.
-
-ACPI kernel configuration manager
-CONFIG_ACPI_KERNEL_CONFIG
-  If you say `Y' here, Linux's ACPI support will use the
-  hardware-level system descriptions found on IA64 machines.
+  Advanced Configuration and Power Interface (ACPI) support for=20
+  Linux requires an ACPI compliant platform (hardware/firmware),
+  and assumes the presence of OS-directed configuration and power
+  management (OSPM) software.  This option will enlarge your=20
+  kernel by about 70K.
+
+  Linux ACPI provides a robust functional replacement for several=20
+  legacy configuration and power management intefaces, including=20
+  the Plug-and-Play BIOS specification (PnP BIOS), the=20
+  MultiProcessor Specification (MPS), and the Advanced Power=20
+  Management (APM) specification.  If both ACPI and APM support=20
+  are configured, whichever is loaded first shall be used.
+ =20
+  Add "acpi=3Doff" to the kernel command line to disable this feature.
+  (Try "man bootparam" or see the documentation of your boot loader=20
+  about how to pass options to the kernel at boot time.)
+
+  Add "acpi=3Dht-only" to the kernel command line to limit ACPI=20
+  support to processor enumeration only (see CONFIG_ACPI_HT_ONLY).=20
+
+  ----------
+
+  The ACPI SourceForge project contains the latest source code,=20
+  documentation, tools, mailing list subscription, and other=20
+  information.  This project is available at:
+    <http://sourceforge.net/projects/acpi>
+
+  Linux support for ACPI is based on Intel Corporation's ACPI
+  Component Architecture (ACPI CA).  For more information see:
+    <http://developer.intel.com/technology/iapc/acpi>
+
+  ACPI is an open industry specification co-developed by Compaq,=20
+  Intel, Microsoft, Phoenix, and Toshiba.  The specification is=20
+  available at:
+    <http://www.acpi.info>
+
+CONFIG_ACPI_HT_ONLY
+  This option enables limited ACPI support -- just enough to=20
+  enumerate processors from the ACPI Multiple APIC Description=20
+  Table (MADT).  Note that ACPI supports both logical (e.g. Hyper-
+  Threading) and physical processors, where the MultiProcessor=20
+  Specification (MPS) table only supports physical processors.
=20
-ACPI Debug Statements
-CONFIG_ACPI_DEBUG
-  The ACPI driver can optionally report errors with a great deal
-  of verbosity. Saying Y enables these statements. This will increase
-  your kernel size by around 50K.
+  Full ACPI support (CONFIG_ACPI) is preferred.  Use this option=20
+  only if you wish to limit ACPI's role to processor enumeration.
=20
-ACPI Bus Manager
-CONFIG_ACPI_BUSMGR
-  The ACPI Bus Manager enumerates devices in the ACPI namespace, and
-  handles PnP messages.  All ACPI devices use its services, so using
-  them requires saying Y here.
-
-ACPI System Driver
-CONFIG_ACPI_SYS
-  This driver will enable your system to shut down using ACPI, and
-  dump your ACPI DSDT table using /proc/acpi/dsdt.
+CONFIG_ACPI_AC
+  This driver adds support for the AC Adapter object, which indicates
+  whether a system is on AC, or not.  Typically, only mobile systems=20
+  have this object, since desktops are always on AC.
=20
-ACPI Processor Driver
-CONFIG_ACPI_CPU
-  This driver installs ACPI as the idle handler for Linux, and uses
-  ACPI C2 and C3 processor states to save power, on systems that
-  support it.
+CONFIG_ACPI_BATTERY
+  This driver adds support for battery information through
+  /proc/acpi/battery. If you have a mobile system with a battery,=20
+  say Y.
=20
-ACPI Button
 CONFIG_ACPI_BUTTON
   This driver registers for events based on buttons, such as the
   power, sleep, and lid switch.  In the future, a daemon will read
@@ -17657,27 +17651,34 @@
   down the system.  Until then, you can cat it, and see output when
   a button is pressed.
=20
-ACPI AC Adapter
-CONFIG_ACPI_AC
-  This driver adds support for the AC Adapter object, which indicates
-  whether a system is on AC, or not.  Typically, only laptops have
-  this object, since desktops are always on AC.
-
-ACPI Embedded Controller
 CONFIG_ACPI_EC
   This driver is required on some systems for the proper operation of
-  the battery and thermal drivers.  If you are compiling for a laptop,
-  say Y.
+  the battery and thermal drivers.  If you are compiling for a=20
+  mobile system, say Y.
=20
-ACPI Control Method Battery
-CONFIG_ACPI_CMBATT
-  This driver adds support for battery information through
-  /proc/acpi/battery. If you have a laptop with a battery, say Y.
+CONFIG_ACPI_PROCESSOR
+  This driver installs ACPI as the idle handler for Linux, and uses
+  ACPI C2 and C3 processor states to save power, on systems that
+  support it.
=20
-ACPI Thermal
 CONFIG_ACPI_THERMAL
-  This driver handles overheating conditions on laptops. It is HIGHLY
-  recommended, as your laptop CPU may be damaged without it.
+  This driver adds support for ACPI thermal zones.  Most mobile and
+  some desktop systems support ACPI thermal zones.  It is HIGHLY
+  recommended that this option be enabled, as your processor(s)
+  may be damaged without it.
+
+CONFIG_ACPI_FAN
+  This driver adds support for ACPI fan devices, allowing user-mode=20
+  applications to perform basic fan control (on, off, status).
+
+CONFIG_ACPI_SYSTEM
+  This driver will enable your system to shut down using ACPI, and
+  dump your ACPI DSDT table using /proc/acpi/dsdt.
+
+CONFIG_ACPI_DEBUG
+  The ACPI driver can optionally report errors with a great deal
+  of verbosity. Saying Y enables these statements. This will increase
+  your kernel size by around 50K.
=20
 Advanced Power Management BIOS support
 CONFIG_APM
diff -Nura -x '*.orig' linux-2.4.19.orig/drivers/acpi/Config.help linux-2.4=
.19acpi2/drivers/acpi/Config.help
--- linux-2.4.19.orig/drivers/acpi/Config.help	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19acpi2/drivers/acpi/Config.help	Thu Aug 22 19:28:35 2002
@@ -0,0 +1,93 @@
+CONFIG_ACPI
+  Advanced Configuration and Power Interface (ACPI) support for=20
+  Linux requires an ACPI compliant platform (hardware/firmware),
+  and assumes the presence of OS-directed configuration and power
+  management (OSPM) software.  This option will enlarge your=20
+  kernel by about 70K.
+
+  Linux ACPI provides a robust functional replacement for several=20
+  legacy configuration and power management intefaces, including=20
+  the Plug-and-Play BIOS specification (PnP BIOS), the=20
+  MultiProcessor Specification (MPS), and the Advanced Power=20
+  Management (APM) specification.  If both ACPI and APM support=20
+  are configured, whichever is loaded first shall be used.
+ =20
+  Add "acpi=3Doff" to the kernel command line to disable this feature.
+  (Try "man bootparam" or see the documentation of your boot loader=20
+  about how to pass options to the kernel at boot time.)
+
+  ----------
+
+  The ACPI SourceForge project contains the latest source code,=20
+  documentation, tools, mailing list subscription, and other=20
+  information.  This project is available at:
+    <http://sourceforge.net/projects/acpi>
+
+  Linux support for ACPI is based on Intel Corporation's ACPI
+  Component Architecture (ACPI CA).  For more information see:
+    <http://developer.intel.com/technology/iapc/acpi>
+
+  ACPI is an open industry specification co-developed by Compaq,=20
+  Intel, Microsoft, Phoenix, and Toshiba.  The specification is=20
+  available at:
+    <http://www.acpi.info>
+
+CONFIG_ACPI_HT_ONLY
+  This option enables limited ACPI support -- just enough to=20
+  enumerate processors from the ACPI Multiple APIC Description=20
+  Table (MADT).  Note that ACPI supports both logical (e.g. Hyper-
+  Threading) and physical processors, where the MultiProcessor=20
+  Specification (MPS) table only supports physical processors.
+
+  Full ACPI support (CONFIG_ACPI) is preferred.  Use this option=20
+  only if you wish to limit ACPI's role to processor enumeration.
+
+  There is no command-line option to disable this, but the kernel
+  will fall back to the MPS table if the MADT is not present.
+
+CONFIG_ACPI_AC
+  This driver adds support for the AC Adapter object, which indicates
+  whether a system is on AC, or not.  Typically, only mobile systems=20
+  have this object, since desktops are always on AC.
+
+CONFIG_ACPI_BATTERY
+  This driver adds support for battery information through
+  /proc/acpi/battery. If you have a mobile system with a battery,=20
+  say Y.
+
+CONFIG_ACPI_BUTTON
+  This driver registers for events based on buttons, such as the
+  power, sleep, and lid switch.  In the future, a daemon will read
+  /proc/acpi/event and perform user-defined actions such as shutting
+  down the system.  Until then, you can cat it, and see output when
+  a button is pressed.
+
+CONFIG_ACPI_EC
+  This driver is required on some systems for the proper operation of
+  the battery and thermal drivers.  If you are compiling for a=20
+  mobile system, say Y.
+
+CONFIG_ACPI_PROCESSOR
+  This driver installs ACPI as the idle handler for Linux, and uses
+  ACPI C2 and C3 processor states to save power, on systems that
+  support it.
+
+CONFIG_ACPI_THERMAL
+  This driver adds support for ACPI thermal zones.  Most mobile and
+  some desktop systems support ACPI thermal zones.  It is HIGHLY
+  recommended that this option be enabled, as your processor(s)
+  may be damaged without it.
+
+CONFIG_ACPI_FAN
+  This driver adds support for ACPI fan devices, allowing user-mode=20
+  applications to perform basic fan control (on, off, status).
+
+CONFIG_ACPI_SYSTEM
+  This driver will enable your system to shut down using ACPI, and
+  dump your ACPI DSDT table using /proc/acpi/dsdt.
+
+CONFIG_ACPI_DEBUG
+  The ACPI driver can optionally report errors with a great deal
+  of verbosity. Saying Y enables these statements. This will increase
+  your kernel size by around 50K.
+

--=-im/QS9KboDqxVh0gqlGv--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
