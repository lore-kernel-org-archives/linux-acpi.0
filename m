From: "J.A. Magallon" <jamagallon-cer70A47DaU@public.gmane.org>
Subject: ACPI vs ServerWorksLE in 2.4.23-pre
Date: Tue, 21 Oct 2003 01:59:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031020235905.GE7429@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all...

I have discovered a little proble with ACPI. If I enable ACPI in a SuperMicro
P3TDLE the kernel does not see the 64 bit PCI bus (bus number 1).

It looks the same in -pre5 and -pre7.
The dmesg+lspci info that I have collected is at
http://giga.cps.unizar.es/~magallon/linux/acpi/
They are dmesg's for pre5 and pre7, just with HT_ONLY (and ACPI disabled in
-pre7, so as it is an SMP kernel I just get ACPI_BOOT), and with ACPI
enabled. There is also the diff between -pre7 and -pre7-acpi.

Some things:
- Without full ACPI, I see the pci 1 bus:
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:04.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/6326 (rev 0b)
00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:02.0 Ethernet controller: Intel Corp. 82543GC Gigabit Ethernet Controller (Copper) (rev 02)

- With ACPI, I do not see it.

- If try to boot with pci=noacpì, both kernels fail to initialize interrupts for
  the network cards (and perhaps more things), ifup takes an eon to timeout
  and the net cards do not work. This is cured by the patch posted by
  Thomas Schlichter <schlicht-F4SpVhQLQb4JuJQ2pkvNbQ@public.gmane.org>:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=106616752330476&w=2
  With this, pci=noacpi works and the system is fine.

In the diff from -pre7 to -pre7-acpi I can see things like:
...
 IRQ7 -> 0:7
 IRQ8 -> 0:8
 IRQ9 -> 0:9
+IRQ10 -> 0:10
+IRQ11 -> 0:11
 IRQ12 -> 0:12
 IRQ13 -> 0:13
 IRQ14 -> 0:14
 IRQ15 -> 0:15
-IRQ26 -> 1:10
-IRQ31 -> 1:15
...
+PCI: Probing PCI hardware
+    ACPI-1120: *** Error: Method execution failed [\_SB_.LNUS._SRS] (Node f7a11860), AE_AML_BUFFER_LIMIT
+ACPI: Retrying with extended IRQ descriptor
+ACPI: Unable to set IRQ for PCI Interrupt Link [LNUS] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
...
+ACPI: Retrying with extended IRQ descriptor
+ACPI: Unable to set IRQ for PCI Interrupt Link [LNUS] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off

One other chipset to blacklist ?

This rises one other problem. For all people who upgrade from .22 to .23,
and have HT_ONLY, they will end with full ACPI active, and perhaps hit a buggy
BIOS. And their boxes will be unusable.
Would not be useful to maintain something like this for sometime:

-  if [ "$CONFIG_ACPI" = "y" ]; then
+  if [ "$CONFIG_ACPI" = "y" -a "$CONFIG_ACPI_HT_ONLY" != "y" ]; then

even if HT_ONLY is not a configurable option, just for the case it is read
from an old .config ?

TIA

(For people in the acpi list, please CC me, I am not subscribed)

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre7-jam2 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
