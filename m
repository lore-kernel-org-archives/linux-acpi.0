From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Suspend-to-RAM on ThinkPad R51
Date: Sat, 26 Mar 2005 15:34:44 -0500
Message-ID: <200503261534.44710.barr.156@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I cannot suspend my ThinkPad R51 to RAM. It seems to freeze at least partially 
either on resume or shortly before suspend (based on the blinking cursor, or 
lack thereof). The display powers up okay, and the contents of the console 
before suspend ("stopping tasks") is displayed, but the keyboard and mouse 
are unresponsive. I can, however, log in via ssh (indicating the machine is 
not completely frozen and the ethernet card works), and I retrieved this from 
the system logs:

Mar 26 15:04:15 ibm Stopping tasks: 
=========================================================================================|
Mar 26 15:04:15 ibm Back to C!
Mar 26 15:04:15 ibm cpufreq: resume failed to assert current frequency is what 
timing core thinks it is.
Mar 26 15:04:15 ibm hub 3-0:1.0: resubmit --> -108
Mar 26 15:04:15 ibm hub 1-0:1.0: resubmit --> -108
Mar 26 15:04:15 ibm hub 2-0:1.0: resubmit --> -108
Mar 26 15:04:15 ibm PCI: Setting latency timer of device 0000:00:1d.0 to 64
Mar 26 15:04:15 ibm PCI: Setting latency timer of device 0000:00:1d.1 to 64
Mar 26 15:04:15 ibm PCI: Setting latency timer of device 0000:00:1d.2 to 64
Mar 26 15:04:15 ibm PCI: cache line size of 32 is not supported by device 
0000:00:1d.7
Mar 26 15:04:15 ibm ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00, 
driver 10 Dec 2004
Mar 26 15:04:15 ibm ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) 
-> IRQ 11
Mar 26 15:04:15 ibm ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) 
-> IRQ 11
Mar 26 15:04:15 ibm PCI: Setting latency timer of device 0000:00:1f.5 to 64
Mar 26 15:04:15 ibm ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) 
-> IRQ 11
Mar 26 15:04:15 ibm PCI: Setting latency timer of device 0000:00:1f.6 to 64
Mar 26 15:04:15 ibm e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Mar 26 15:04:15 ibm psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at 
byte 1
Mar 26 15:04:15 ibm Restarting tasks...<6>usb 2-1: USB disconnect, address 3
Mar 26 15:04:15 ibm done
Mar 26 15:04:16 ibm hal.hotplug[18047]: DEVPATH is not set
Mar 26 15:04:16 ibm hal.hotplug[18074]: DEVPATH is not set
Mar 26 15:04:36 ibm sshd[18164]: Accepted keyboard-interactive/pam for root 
from 192.168.0.105 port 1994 ssh2

Nothing that stands out, at least to me. I have tried disabling the APIC both 
at compile time and run time on the command line. I have also tried disabling 
agpgart, I read somewhere that that might be a problem. Note, though, that 
this notebook has a Intel 82855GM graphics controller, not the Radeon chip 
that has caused others so much grief. Nothing changes the behavior of the 
system. I run a custom patched kernel, it has:

- based on kernel.org 2.6.11.6
- Suspend2 2.1.8.2 (which works fine)
- bk-cpufreq.patch from an -mm kernel for Dothan SpeedStep support (don't 
remember which; also tried disabling CPUFreq support)
- TrackPoint psmouse patch
- IBM-ACPI extras 0.11
- ipw2200 1.0.1
- ThinkPad modules from tpctl 5.8
- FUSE 2.2.1

I tried a "stock" distro kernel from my distributor, Gentoo. It was 
2.6.11-gentoo-r4. The thing that stands out among all these changes is no 
matter what kernel or what configuration I've used, so far, it has made *no* 
difference in the behavior of the machine on resume. The BIOS and Embedded 
Controller programs are the latest available from IBM, 1.21 and 1.04, 
respectively.

Now, some formalities:
Output of lspci:

0000:00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV 
Processor to I/O Controller (rev 02)
0000:00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV 
Processor to I/O Controller (rev 02)
0000:00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV 
Processor to I/O Controller (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corporation 82852/855GM 
Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corporation 82852/855GM Integrated 
Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 
EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface 
Bridge (rev 01)
0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller 
(rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
SMBus Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
AC'97 Modem Controller (rev 01)
0000:02:00.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus 
Controller
0000:02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 
05)
0000:02:08.0 Ethernet controller: Intel Corporation 82801DB PRO/100 VE (MOB) 
Ethernet Controller (rev 81)

disassembled DSDT straight from the BIOS (no patches) is available at:

http://home.columbus.rr.com/andrewbarr/r51_2883elu.dsl.gz


Thanks for any help,
Andrew Barr


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
