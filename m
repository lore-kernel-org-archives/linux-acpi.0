From: Carsten Aulbert <carsten-Be4aT198J/+M0n/1+vlPsQ@public.gmane.org>
Subject: Problems after waking up from S3 (mainly network related)
Date: Sat, 27 Mar 2004 20:51:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4065DB4E.6070402@welcomes-you.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

sorry for bothering and for this lengthy email, but quite a few days 
searching the web and usenet has not helped a lot in solving this issue:

On my Asus A7V Motherboard (BIOS 1011) I'm running 2.6.4 with the 
according acpi4linux patches. Everything is quite ok, I can suspend to 
RAM and wake the box back up via /proc/acpi/alarm or the power button.

However, after waking up the onboard Promise IDE Controller PDC20... as 
well as the SIS900 based network card did not work, e.g.

Mar 22 21:32:34 daisy kernel: Stopping tasks: 
==========================================|
Mar 22 21:32:34 daisy kernel: hde: start_power_step(step: 0)
Mar 22 21:32:34 daisy kernel: hde: start_power_step(step: 1)
Mar 22 21:32:34 daisy kernel: hde: complete_power_step(step: 1, stat: 
50, err: 0)
Mar 22 21:32:34 daisy kernel: hde: completing PM request, suspend
Mar 22 21:32:34 daisy kernel: hdd: start_power_step(step: 0)
Mar 22 21:32:34 daisy kernel: hdd: completing PM request, suspend
Mar 22 21:32:34 daisy kernel: hda: start_power_step(step: 0)
Mar 22 21:32:34 daisy kernel: hda: start_power_step(step: 1)
Mar 22 21:32:34 daisy kernel: hda: complete_power_step(step: 1, stat: 
50, err: 0)
Mar 22 21:32:34 daisy kernel: hda: completing PM request, suspend
Mar 22 21:32:34 daisy kernel:  hwsleep-0300 [18] acpi_enter_sleep_state: 
Entering sleep state [S3]
Mar 22 21:32:34 daisy kernel: eth0: Media Link Off
Mar 22 21:32:34 daisy kernel: hda: Wakeup request inited, waiting for 
!BSY...
Mar 22 21:32:34 daisy kernel: hda: start_power_step(step: 1000)
Mar 22 21:32:34 daisy kernel: blk: queue c7ef3c00, I/O limit 4095Mb 
(mask 0xffffffff)
Mar 22 21:32:34 daisy kernel: hda: completing PM request, resume
Mar 22 21:32:34 daisy kernel: hdd: Wakeup request inited, waiting for 
!BSY...
Mar 22 21:32:34 daisy kernel: hdd: start_power_step(step: 1000)
Mar 22 21:32:34 daisy kernel: hdd: completing PM request, resume
Mar 22 21:32:34 daisy kernel: hde: Wakeup request inited, waiting for 
!BSY...
Mar 22 21:32:34 daisy kernel: hde: start_power_step(step: 1000)
Mar 22 21:32:34 daisy kernel: blk: queue c7ee1c00, I/O limit 4095Mb 
(mask 0xffffffff)
Mar 22 21:32:34 daisy kernel: hde: completing PM request, resume
Mar 22 21:32:34 daisy kernel: Restarting tasks... done
Mar 22 21:32:42 daisy kernel: MCE: The hardware reports a non fatal, 
correctable incident occurred on CPU 0.
Mar 22 21:32:42 daisy kernel: Bank 1: ddd1ffdd220010b5
Mar 22 21:32:42 daisy kernel: MCE: The hardware reports a non fatal, 
correctable incident occurred on CPU 0.
Mar 22 21:32:42 daisy kernel: Bank 2: b0006000000210ae
Mar 22 21:33:23 daisy kernel: hde: dma_timer_expiry: dma status == 0x24
Mar 22 21:33:33 daisy kernel: PDC202XX: Primary channel reset.
Mar 22 21:33:33 daisy kernel: PDC202XX: Secondary channel reset.
Mar 22 21:33:33 daisy kernel: hde: DMA interrupt recovery
Mar 22 21:33:33 daisy kernel: hde: lost interrupt
Mar 22 21:33:33 daisy kernel: hde: dma_intr: status=0x50 { DriveReady 
SeekComplete }
Mar 22 21:33:33 daisy kernel:
Mar 22 21:33:33 daisy kernel: hde: status error: status=0x51 { 
DriveReady SeekComplete Error }
Mar 22 21:33:33 daisy kernel: hde: status error: error=0x04 { 
DriveStatusError }
...
as well as
...
Mar 23 19:46:23 daisy kernel: eth0: Media Link On 100mbps full-duplex
Mar 23 19:46:38 daisy kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 23 19:46:38 daisy kernel: eth0: Transmit timeout, status 00000004 
00000240


I tested it with and without apic support (with and without io-apic), 
but nothing changed.

Finally I changed my approach slightly, connecting the single hard drive 
  to the second IDE channel (VIA KT), which got me rid off the nasty hde 
problem. Additionally I tried to disable the network completely 
(ifconfig eth0 down), unloading the sis900.ko before going to S3.

After waking the box up, I re-inserted the sis900 module (which was 
answered by
Mar 24 12:44:23 daisy kernel: sis900.c: v1.08.07 11/02/2003
Mar 24 12:44:23 daisy kernel: eth0: SiS 900 Internal MII PHY transceiver 
found at address 1.
Mar 24 12:44:23 daisy kernel: eth0: Using transceiver found at address 1 
as default
Mar 24 12:44:23 daisy kernel: eth0: SiS 900 PCI Fast Ethernet at 0xa400, 
IRQ 12, 00:30:ab:01:7b:6e.
) and re-enabling the network settings via ifconfig (answer: eth0: Media 
Link On 100mbps full-duplex), I still had no network, i.e. trying to 
ping the interface itself or any other external box had no result except 
new Transmit timeouts as before without the unloading/loading hassle.

Unfortunately, the very same happened when using a 3c905TXM (with the 
appropriate module of course ;-)).

Anyone here on the devel list, who can give me a clue (or need more 
input from my side (i.e. full ACPI tables, etc) how to get around this?

Thanks a lot in advance
Carsten

PS: Please Cc me for a fast reply, but I will monitor the list-archive 
closely as well.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
