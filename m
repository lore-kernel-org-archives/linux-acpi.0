From: Carlos Morgado <chbm-acpi-NoC/J83UA1I@public.gmane.org>
Subject: Re: 2.6.0-test4 acpi problems
Date: Sun, 31 Aug 2003 01:35:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030831003536.GG14307@sal.chbm.nu>
References: <20030830215116.GA1444@rootdir.de> <200308310219.41304.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200308310219.41304.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>; from adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org on Sun, Aug 31, 2003 at 02:19:41 +0100
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


On Sun, 31 Aug 2003 02:19:41, Andrew de Quincey wrote:

> Aha, this is a known problem with the KT400 chipset. All BIOSes I've
> encountered for the KT400 have a nasty bug in the AML code which breaks  
> ACPI IRQ routing.
>

As far as I can tell my asus a7v8x only doesn't enumerate the ide irqs.


PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
 pci_irq-0297 [15] acpi_pci_irq_derive   : Unable to derive IRQ for device  
00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
PCI: Using ACPI for IRQ routing

--
Carlos Morgado - chbm(a)ma.ssive.net - http://chbm.net/
0x1FC57F0A FP:0A27 35D3 C448 3641 0573 6876 2A37 4BB2 1FC5 7F0A


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
