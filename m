From: Prabhakar Reddy Gudla Venkata Siva <reddyg-3+M4TpyeDAP2fBVCVOL8/A@public.gmane.org>
Subject: IRQ-Problem on Compaq 1720US, 2.4.18+acpi-7,24 - Help
Date: Wed, 14 Aug 2002 08:08:16 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.21.0208140752500.14026-100000@sediment.umd.edu>
References: <20020813120946.GE2605@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020813120946.GE2605-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
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

Hi list,

I compiled the kernel with the suggested osl.c patch and my corrected
dsdt.hex.

On bootup I get the following error (it is not the complete log):
**************************************************************************
pci_bind_0191 [22] acpi_pci_bind: Device 00:00.1d.02 not present in PCI
namespace
.....
.....
schedule_task(): keventd has not started
schedule_task(): keventd has not started
.....
.....

and that's all abt it.
**************************************************************************

However, when I did check the output of lspci on a working kernel (w/o
ACPI) there is no device on 00:00:1d.02. The o/p of lspci is below. I have
also checked it on my Windoze and there is not dev with that PCI ID.

*********************************lspci on working kernel******************
[reddyg@localhost ~]# lspci
00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 41)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio
(rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6
LY
02:04.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
02:05.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023
02:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset Ethernet
Controller (rev 41)
*****************************end lspci**********************************

For the "curious minds", the links to some system information files
can be found here:

http://www.glue.umd.edu/~reddyg/linux/dsdt_info.html



---

P Reddy



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
