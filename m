From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Patch against kernels 2.4.x and some questions
Date: 21 Sep 2002 15:30:04 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032636606.2215.49.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2002-09-19 at 16:09, Grover, Andrew wrote:
>=20
> If someone does a patch against 2.4.19 we can put it on sf.net, but
I'm not
> going to spend my time doing it.
>=20
> -- Andy

I already done the patches for kernels 2.4.19 and 2.4.18,
and I have 3 questions :
1- Configure.help what your version still have incorrect help for
options when configure kernel, if I should include help from the version
(i think) 0709 .

diff -Nura linux-2.4.19orig/Documentation/Configure.help linux-2.4.19acpi/D=
ocumentation/Configure.help
--- linux-2.4.19orig/Documentation/Configure.help	Fri Aug  2 20:39:42 2002
+++ linux-2.4.19acpi/Documentation/Configure.help	Sat Sep 21 01:00:07 2002
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


2- is the black list I will suggest one small patch:

--- linux-2.4.19acpi/drivers/acpi/blacklist.c.orig	Sat Sep 21 15:16:51 2002
+++ linux-2.4.19acpi/drivers/acpi/blacklist.c	Sat Sep 21 15:17:04 2002
@@ -97,7 +97,7 @@
=20
 	while (acpi_blacklist[i].oem_id[0] !=3D '\0')
 	{
-		if (!acpi_get_table_header_early(acpi_blacklist[i].table, &table_header)=
) {
+		if (acpi_get_table_header_early(acpi_blacklist[i].table, &table_header))=
 {
 			i++;
 			continue;
 		}

this patch is one that I don't have idea, if it correct or not but since
acpi_get_table_header_early return always OK, my computer doesn't enter
in black list, well i think, my computer is to be enter in black list
and with this patch it give the warning that is in blacklist=20

3 - this are missing in _my_ kernel patches but is correct isn't?
--- linux-2.4.19new/./include/linux/acpi.h	Fri Sep 20 21:49:14 2002
+++ linux-2.4.20-pre7acpi/./include/linux/acpi.h	Fri Sep 20 00:39:40 2002
@@ -345,12 +345,22 @@
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 unsigned long acpi_find_rsdp (void);
 int acpi_boot_init (char *cmdline);
+int acpi_numa_init (void);
=20
 int acpi_table_init (char *cmdline);
-int acpi_table_parse (enum acpi_table_id, acpi_table_handler);
-int acpi_table_parse_madt (enum acpi_table_id, acpi_madt_entry_handler);
-void acpi_table_print (struct acpi_table_header *, unsigned long);
-void acpi_table_print_madt_entry (acpi_table_entry_header *);
+int acpi_table_parse (enum acpi_table_id id, acpi_table_handler handler);
+int acpi_get_table_header_early (enum acpi_table_id id, struct acpi_table_=
header **header);
+int acpi_table_parse_madt (enum acpi_madt_entry_id id, acpi_madt_entry_han=
dler handler);
+int acpi_table_parse_srat (enum acpi_srat_entry_id id, acpi_madt_entry_han=
dler handler);
+void acpi_table_print (struct acpi_table_header *header, unsigned long phy=
s_addr);
+void acpi_table_print_madt_entry (acpi_table_entry_header *madt);
+void acpi_table_print_srat_entry (acpi_table_entry_header *srat);
+
+/* the following four functions are architecture-dependent */
+void acpi_numa_slit_init (struct acpi_table_slit *slit);
+void acpi_numa_processor_affinity_init (struct acpi_table_processor_affini=
ty *pa);
+void acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma=
);
+void acpi_numa_arch_fixup(void);
=20
 #endif /*CONFIG_ACPI_BOOT*/
=20
to night I will update my web site and I will inform you.=20
ok?

thanks
S=E9rgioMB



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
