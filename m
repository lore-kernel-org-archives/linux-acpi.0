From: Klaus Muth <muth-5lHx5lHeYlQ@public.gmane.org>
Subject: ACPI: RSDP - ERROR: Invalid checksum
Date: Tue, 7 Jun 2005 15:46:56 +0200
Message-ID: <200506071546.57120.muth@hagos.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi!
I've got here a brand new IBM xServer 236 and try to install debian sarge with 
kernel 2.6 and I'm now at the end of my knowledge. *sigh*. 

When I had a test machine, all went fine, both SMT Processors were detected 
and the system was stable with 4 Processors. Now, that I have the production 
machine (newer BIOS), the thing drives me crazy...

Kernel 2.6.11-mm4 dmesg:

Linux version 2.6.11-mm4-ibm1 (root@alderaan) (gcc-Version 3.3.5 (Debian 
1:3.3.5-12)) #1 SMP PREEMPT Fri Jun 3 10:29:57 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c000 (usable)
 BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bffcae80 (usable)
 BIOS-e820: 00000000bffcae80 - 00000000bffcf800 (ACPI data)
 BIOS-e820: 00000000bffcf800 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
2175MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009c140
On node 0 totalpages: 786378
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 557002 pages, LIFO batch:16
DMI 2.3 present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000fdfb0
  >>> ERROR: Invalid checksum
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM ENSW Product ID: REDWOOD SMP  APIC at: 0xFEE00000
Processor #0 15:4 APIC version 20
....

2.6.11 kernel with Zhenyu Z Wang's brute force searching for sane rsdp patch:

Linux version 2.6.11-ibm6 (root@alderaan) (gcc-Version 3.3.5 (Debian 
1:3.3.5-12)
) #1 SMP Tue Jun 7 15:08:26 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c000 (usable)
 BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bffcae80 (usable)
 BIOS-e820: 00000000bffcae80 - 00000000bffcf800 (ACPI data)
 BIOS-e820: 00000000bffcf800 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
2175MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009c140
On node 0 totalpages: 786378
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 557002 pages, LIFO batch:16
DMI 2.3 present.
Wrong RSDP!! 0xbffcf780
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
... yadda, yadda...

The RSDP found by acpidmp:
RSDP "IBM" @ 0x000fdfb0
  0000: 52 53 44 20 50 54 52 20 75 49 42 4d 20 20 20 02  RSD PTR uIBM   .
  0010: 80 f7 fc bf                                      ....

Problems: No SMT, PCI devices complaining in dmesg about invalid IRQ, probably 
buggy MP table, sometimes losing timer ticks on boot and kernel panic.

I also tried to correct the DSDT (sorry, I didn't know better), but the iasl 
did not find any errors, so what...

The intresting fact is, that the Redhat Enterprise Linux 3 Kernel (2.4.21 with 
380 patches/1,6x10^6 lines of patch) has no problems with the RSDP. I could 
not identify the patch, which made the RSDP work....

Please help me! Make my 236 work with a minimum of patches...
-- 
Klaus Muth
HAGOS eG                      Industriestr. 62      fon: (+49) 711 78805-86
EDV-Programmierung            70565  Stuttgart      fax: (+49) 711 78805-35
http://www.hagos.de               Germany              mailto:muth-5lHx5lHeYlQ@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
