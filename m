From: margitsw-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org (Margit Schubert-While)
Subject: ACPI 20021118
Date: Wed, 27 Nov 2002 11:48:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4.3.2.7.2.20021127114745.00b62100@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Why does ACPI 20021118 think my P4 is a XEON ?
And what's with Processor #129 ?

Margit

Inspecting /boot/System.map-2.4.20
Loaded 16848 symbols from /boot/System.map-2.4.20.
Symbols match kernel version 2.4.20.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.20 (root@roglinux) (gcc version 3.2) #1 Sat Nov 23 
17:15:36 CET 2002
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
<4> BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
<4> BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
<5>511MB LOWMEM available.
<7>ACPI: have wakeup address 0xc0001000
<4>On node 0 totalpages: 130880
<4>zone(0): 4096 pages.
<4>zone(1): 126784 pages.
<4>zone(2): 0 pages.
<6>ACPI: RSDP (v000 ACPIAM                     ) @ 0x000f70d0
<6>ACPI: RSDT (v001 INTEL  D845PESV 08194.04144) @ 0x1ff40000
<6>ACPI: FADT (v002 INTEL  D845PESV 08194.04144) @ 0x1ff40200
<6>ACPI: MADT (v001 INTEL  D845PESV 08194.04144) @ 0x1ff40300
<6>ACPI: ASF! (v016 AMIASF I845GASF 00000.00001) @ 0x1ff44390
<6>ACPI: DSDT (v001 INTEL  D845PESV 00000.00266) @ 0x00000000
<5>ACPI: BIOS passes blacklist
<6>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
<4>Processor #0 Pentium 4(tm) XEON(tm) APIC version 16
<6>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
<4>Processor #129 invalid (max 16)
<6>ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x0] trigger[0x0] lint[0x1])
<6>ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
<6>IOAPIC[0]: Assigned apic_id 1
<4>IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, IRQ 0-23
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] 
trigger[0x0])
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] 
trigger[0x3])
<6>Using ACPI (MADT) for SMP configuration information 



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
