From: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>
Subject: Re: kacpid respawning under linux-2.4.20 on Toshiba Satellite 5105
Date: Mon, 30 Dec 2002 07:51:17 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021230155117.GA562@budgie.we1.client2.attbi.com>
References: <20021217202142.GB1012@poup.poupinou.org> <20021221120101.GA1371@zaurus>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021221120101.GA1371-XqDnSF8rrUM@public.gmane.org>; from pavel-AlSwsSmVLrQ@public.gmane.org on Sat, Dec 21, 2002 at 04:01:02 -0800
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


A follow-up to my last post:

I traced my problem to this code in drivers/acpi/osl.c in 
acpi_os_derive_pci_id():

        /* any nicer way to get bus number of bridge ? */
        status = acpi_os_read_pci_configuration(pci_id, 0x0e, &tu8, 8);
       if (ACPI_SUCCESS(status) && (tu8 & 0x7f) == 1) {
                status = acpi_os_read_pci_configuration(pci_id,0x19, 
&tu8, 8);
                if (ACPI_SUCCESS(status))
                        pci_id->bus = tu8;

If I replace the assignment to pci_id->bus with a printk, the zombie 
kacpidpc
processes go away.  The value shown for tu8 is 2.  pci_id->device is 
0x1e and
pci_id->function is 0 at this point.

I don't know if it's related, but I also see the following messages 
earlier
via dmesg:


PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:0a.00 not 
present in PCI namespace
pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:0a.01 not 
present in PCI namespace
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]

Here's my lspci output:

29 budgie: lspci 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) 
Chipset Host Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP 
Bridge (rev 04)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 
Audio (rev 02)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 
440 Go] (rev a3)
02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22 1394a-2000 
Controller
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset 
Ethernet Controller (rev 42)
02:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support (rev 32)
02:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support (rev 32)
02:0c.0 System peripheral: Toshiba America Info Systems: Unknown device 
0804 (rev 03)
02:0d.0 System peripheral: Toshiba America Info Systems: Unknown device 
0805 (rev 03)

Any ideas?

Ken


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
