From: Michael Notforyou <sqfreak-goaWJWIt5zpWk0Htik3J/w@public.gmane.org>
Subject: Lockup at boottime on Compaq Presario 730US -- Please help!!
Date: Wed, 21 Aug 2002 19:48:55 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.0.20020821193844.030509b0@pop-server.triad.rr.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====================_1815291851==_.ALT"
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

--=====================_1815291851==_.ALT
Content-Type: text/plain; charset="us-ascii"; format=flowed

I'm using the patch for kernel 2.4.19 and kernel 2.4.19. I've compiled the 
kernel with ACPI (all options except CPU Enumeration Only) and no APM. When 
I boot, it locks up immediately after loading ACPI. Here's everything 
that's on the screen:

CPU0: AMD mobile AMD Duron(tm) Processor stepping 01
per-CPU timeslice cutoff: 182.92 useca
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 996.5772 MHz
..... host bus clock speed is 199.3155 MHz
cpu: 0, clocks: 1993155, slice: 996577
CPU0<T0:19993152,T1:996560,D:15,S:996577,C:1993155
Waiting on wait_init_idle (map=0x0)
All processors have done init_idle
ACPI: Subsystem revision 20020815
PCI: PCI BIOS revision 2.10 entry at 0xfd7ae, last bus=1
PCI: Using configuration type 1
  tbxface-0099 [03] Acpi_load_tables       : ACPI Tables successfully loaded
Parsing 
methods:................................................................
..............................
Table [DSDT] - 441 Objects with 45 Devices 109 Methods 15 Regions
Parsing Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c0577b7c


The system locks up here.

What's wrong? Please help; the laptop overheats so fast it's almost 
unusable except if I put it on ice.

*Michael Notforyou*

"My God, I'm full of stars!"
Darmok and Jalad at Tanagra!
--=====================_1815291851==_.ALT
Content-Type: text/html; charset="us-ascii"

<html>
I'm using the patch for kernel 2.4.19 and kernel 2.4.19. I've compiled
the kernel with ACPI (all options except CPU Enumeration Only) and
<b>no</b> APM. When I boot, it locks up immediately after loading ACPI.
Here's everything that's on the screen:<br><br>
CPU0: AMD mobile AMD Duron(tm) Processor stepping 01<br>
per-CPU timeslice cutoff: 182.92 useca<br>
SMP motherboard not detected.<br>
enabled ExtINT on CPU#0<br>
ESR value before enabling vector: 00000000<br>
ESR value after enabling vector: 00000000<br>
Using local APIC timer interrupts.<br>
calibrating APIC timer ...<br>
..... CPU clock speed is 996.5772 MHz<br>
..... host bus clock speed is 199.3155 MHz<br>
cpu: 0, clocks: 1993155, slice: 996577<br>
CPU0&lt;T0:19993152,T1:996560,D:15,S:996577,C:1993155<br>
Waiting on wait_init_idle (map=0x0)<br>
All processors have done init_idle<br>
ACPI: Subsystem revision 20020815<br>
PCI: PCI BIOS revision 2.10 entry at 0xfd7ae, last bus=1<br>
PCI: Using configuration type 1<br>
&nbsp;tbxface-0099 [03]
Acpi_load_tables&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : ACPI Tables
successfully loaded<br>
Parsing
methods:................................................................<br>
..............................<br>
Table [DSDT] - 441 Objects with 45 Devices 109 Methods 15 Regions<br>
Parsing Methods:<br>
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions<br>
ACPI Namespace successfully loaded at root c0577b7c<br><br>
<br>
The system locks up here.<br><br>
What's wrong? Please help; the laptop overheats so fast it's almost
unusable except if I put it on ice.<br>
<x-sigsep><p></x-sigsep>
*Michael Notforyou*<br><br>
&quot;My God, I'm full of stars!&quot;<br>
Darmok and Jalad at Tanagra!</html>

--=====================_1815291851==_.ALT--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
