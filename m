From: Herman Sheremetyev <herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: Re: dell inspiron 8600 not working
Date: Fri, 16 Jul 2004 09:16:29 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1089983789.2169.41.camel@camel>
References: <20040716110537.GA4398@localhost>
Reply-To: herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040716110537.GA4398-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Spike,

As far as I know the 2.4 kernels don't support ACPI suspend, you'll need
to upgrade to the latest 2.6.

-Herman

On Fri, 2004-07-16 at 07:05, Spike Spiegel wrote:
> Hi all,
> 
> I've got n inspiron 8600 and can't get sleep/susped to disk/ram
> working. well can't control fans too, but I don't care that much atm.
> 
> I've googled for more than a week now, tryed everything I found (but for
> kernel upgrade to 2.6). Info I got was generally outdated or incomplete, or
> about different bios/kernel version, and I haven't been able to find the
> "working combo" (if it exists). I read about DSDT patching too, but
> didn't understand if I need that or not, than DSDT available are for
> bios A03. should I downgrade?
> I've also read about possible problems between nvidia cards and ACPI,
> but here too didn't fully understand the question and what I should
> do/check.
> 
> Hope you can help me out with this thing,
> 
> tia.
> 
> Spike
> 
> --- SYSTEM DETAILS -----
> 
> BIOS: A06
> 
> kernel: 2.4.26 (from kernel.org, no patch applyed)
> 
> dmesg | grep -i acpi:
> ACPI: RSDP (v000 DELL                                      ) @ 0x000fdf00
> ACPI: RSDT (v001 DELL    CPi R   0x27d4031f ASL  0x00000061) @ 0x1fff0000
> ACPI: FADT (v001 DELL    CPi R   0x27d4031f ASL  0x00000061) @ 0x1fff0400
> ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
> ACPI: Subsystem revision 20040326
> ACPI: IRQ9 SCI: Edge set to Level Trigger.
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: System [ACPI] (supports S0 S1 S3 S4bios S4 S5)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
> PCI: Using ACPI for IRQ routing
> PCI: if you experience problems, try using option 'pci=noacpi' or even
> 'acpi=off'
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Battery Slot [BAT1] (battery absent)
> ACPI: Lid Switch [LID]
> ACPI: Power Button (CM) [PBTN]
> ACPI: Sleep Button (CM) [SBTN]
> ACPI: Processor [CPU0] (supports C1 C2 C3, 7 performance states, 8
> throttling states)
> ACPI: Thermal Zone [THM] (30 C)
> 
> cat /proc/acpi/info 
> version:                 20040326
> states:                  S0 S1 S3 S4 S4Bios S5
> 
> lspci:
> 0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
> 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03)
> 0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01)
> 0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01)
> 0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01)
> 0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 01)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
> 0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 01)
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 01)
> 0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01)
> 0000:01:00.0 VGA compatible controller: nVidia Corporation NV34M [GeForce FX Go 5200] (rev a1)
> 0000:02:00.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
> 0000:02:01.0 CardBus bridge: Texas Instruments PCI4510 PC card Cardbus Controller (rev 02)
> 0000:02:01.1 FireWire (IEEE 1394): Texas Instruments PCI4510 IEEE-1394 Controller
> 0000:02:03.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
> 
> nvidia packages
> ii  nvidia-glx     1.0.5336-9     NVIDIA binary XFree86 4.x driver
> ii  nvidia-kernel- 1.0.5336-9+spi NVIDIA binary kernel module for Linux 2.4.26
> ii  nvidia-kernel- 1.0.5336-1     NVIDIA binary kernel module common files
> 
> from lilo.conf
> append="acpi=on"



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
