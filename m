From: Phil Short <justswitch-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: DSDT changes for Toshiba 1005-S157
Date: Thu, 15 Aug 2002 17:52:10 -0500 (CDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020815173544.W51277-100000@Grayswandir.cygnet_hq>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks, everyone, for the help.  The patch for my DSDT is given below,
although I am quite uncertain about the "Windows 2001" deletion.  The
DSDT now compiles without any error or warning messages, and the ac
adaptor sub-tree is now present in /proc/acpi.

However, I have some more issues to follow up on.

First, I cannot access the patch at clara.net/~faye.

Second, my dmesg still has some (error?) messages that may be due
to further acpi conditions.  Here are some excerpts that raise
questions in my mind:

Linux version 2.4.18 (root-vaMWjHiOTZx8gPQs3r+Vhu5xAlW/YhjH@public.gmane.org) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #9 Thu Aug 15 16:27:28 GMT-5 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
 BIOS-e820: 000000000f6f0000 - 000000000f6ff000 (ACPI data)
 BIOS-e820: 000000000f6ff000 - 000000000f700000 (ACPI NVS)
 BIOS-e820: 000000000f700000 - 000000000f780000 (usable)
 BIOS-e820: 000000000f780000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 63360
zone(0): 4096 pages.
zone(1): 59264 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 TOSCPL                     ) @ 0x000f7080
ACPI: RSDT (v001 TOSCPL   RSDT   01540.00000) @ 0x0f6f95e9
ACPI: FADT (v001 TOSCPL ATW02    01540.00000) @ 0x0f6fef8c

[snip]

 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:.............................................................................................................................................................................................
Table [DSDT] - 594 Objects with 57 Devices 189 Methods 17 Regions
ACPI Namespace successfully loaded at root c03145fc
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:.........................................................
57 Devices found containing: 57 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:...........................................................
Initialized 11/17 Regions 0/0 Fields 33/33 Buffers 15/15 Packages (594 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
pci_bind-0191 [05] acpi_pci_bind         : Device 00:02:01.00 not present in PCI namespace
pci_bind-0191 [05] acpi_pci_bind         : Device 00:02:00.00 not present in PCI namespace
pci_bind-0191 [05] acpi_pci_bind         : Device 00:02:00.01 not present in PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 28)

[snip]

Specifically, I wonder if the message about 11/17 regions being
initialized has any significance, and if the acpi_pci_bind messages
should raise any concerns.

In any case, the battery and event functions seem to be working fine,
although the event messages did not exactly correlate with the example
files in /etc/acpi/event from (presumably) acpid-1.0.1.  At this time
I haven't been able to find anything in /proc/acpi that relates to the
fan or thermal functions.  Should I expect anything there?

Thanks,

--

Phil

DSDT patch
----------------

--- dsdt.asl	Wed Aug 14 22:51:45 2002
+++ dsdt.asl.new	Thu Aug 15 15:19:54 2002
@@ -156,8 +156,9 @@
         Notify(\_SB_.PCI0.IDEC.SECD, 0x0)
         Notify(\_SB_.PCI0.IDEC.SECD.S_D0, 0x1)
     }
+    Return(0x0)
 }
-Scope(_GPE) {
+Scope(\_GPE) {
     Method(_L03) {
         Notify(\_SB_.PCI0.USB0, 0x2)
     }
@@ -185,7 +186,11 @@
         Notify(\_SB_.LID_, 0x80)
     }
 }
-Scope(_SB_) {
+
+Scope(\_SB_) {
+    External(\_OSI)
+    External(_OSI)
+
     Device(LID_) {
         Name(_HID, 0x0d0cd041)
         Method(_LID) {
@@ -279,7 +284,6 @@
         Method(_INI) {
             If(CondRefOf(_OSI, Local0)) {
                 If(\_OSI) {
-                    "Windows 2001"
                     Store(0x3, OSTP)
                 }
                 Else {
@@ -595,6 +599,7 @@
                         0x00010200,
                     })
                 }
+	        Return(0x0)
             }
             Device(LFP_) {
                 Name(_ADR, 0x0400)
@@ -818,7 +823,7 @@
                 PMEE,	1,
                 US3E,	1
             }
-            OperationRegion(GPIO, SystemIO, 0x1180, 0x3b)
+            OperationRegion(GPIO, SystemIO, 0x1180, 0x3c)
             Field(GPIO, WordAcc, Lock, Preserve) {
                 AccessAs(DWordAcc, 0),
                 Offset(0xf),
@@ -2234,7 +2239,7 @@
                     }
                 }
                 OperationRegion(ERAM, EmbeddedControl, 0x0, 0xff)
-                Field(ERAM, AnyAcc, Lock, Preserve) {
+                Field(ERAM, ByteAcc, Lock, Preserve) {
                     Offset(0x2e),
                     RSMT,	16,
                     Offset(0x40),



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
