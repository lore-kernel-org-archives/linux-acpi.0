From: Thomas Meyer <thomas.mey-S0/GAf8tV78@public.gmane.org>
Subject: RE: AE_AML_BUFFER_LIMIT with handmade dsdt file
Date: Wed, 16 Nov 2005 22:56:54 +0100
Message-ID: <2008884853@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



I'm using
*  sys-power/iasl
      Latest version available: 20050513
      Latest version installed: 20050513
      Size of downloaded files: 686 kB
      Homepage:    http://www.intel.com/technology/iapc/acpi/
      Description: Intel ACPI Source Language (ASL) compiler
      License:     iASL

The change, that you describes, was exactly the problem i had while compiling, so i removed all "optional"(?) (in the spec they call it "nothing") parameters, so the ResourceIndex byte, too (were all set to 0x00, in functions WordBusNumber, DWordIO, DWordMemory).

[snip]
            Name (CRES, ResourceTemplate ()
[snip]
            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (CRES, 0x0182, TCMN)
                CreateDWordField (CRES, 0x0186, TCMX)
[snip]

Thanks & regards
Thomas


"Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> schrieb am 16.11.05 22:33:14:

What version of iASL did you use to disassemble the original DSDT and
recompile it?

We made a recent change to ensure that a disassemble/recompile sequence
works correctly for resource descriptors:

21 October 2005. Summary of changes for version 20051021:

Relaxed a compiler restriction that disallowed a ResourceIndex byte if
the corresponding ResourceSource string was not also present in a
resource descriptor declaration. This restriction caused problems with
existing AML/ASL code that includes the Index byte without the string.
When such AML was disassembled, it could not be compiled without
modification. Further, the modified code created a resource template
with a different size than the original, breaking code that used fixed
offsets into the resource template buffer.


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Thomas Meyer
> Sent: Wednesday, November 16, 2005 1:28 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] AE_AML_BUFFER_LIMIT with handmade dsdt file
> 
> 
> Hi.
> 
> On one window the acpi spec on the other window the dsdl.dsl file, i
> *thoughed* i fixed my dsdt file but now i get this errors:
> 
> [17179570.604000]     ACPI-0508: *** Error: Method execution failed
> [\_SB_.PCI0._CRS] (Node ebec4b00), AE_AML_BUFFER_LIMIT
> [17179570.604000]     ACPI-0156: *** Error: Method execution failed
> [\_SB_.PCI0._CRS] (Node ebec4b00), AE_AML_BUFFER_LIMIT
> 
> the method _CRS for the given object is a larger one in the dsdt file.
is
> this some kind of violation of the maximum buffer length (code length
in
> AML?) or something like that?
> 
> should i care about this error?
> 
> Thanks & regards
> Thomas
> 
> dmesg:
> 
> "
> [17179569.184000] Linux version 2.6.15-rc1-g0db169f9
(thomas@hotzenplotz)
> (gcc-Version 3.4.4 (Gentoo Hardened 3.4.4-r1, ssp-3.4.4-1.0,
pie-8.7.8))
> #69 Wed Nov 16 21:41:01 CET 2005
> [17179569.184000] BIOS-provided physical RAM map:
> [17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f800
(usable)
> [17179569.184000]  BIOS-e820: 000000000009f800 - 00000000000a0000
> (reserved)
> [17179569.184000]  BIOS-e820: 00000000000d8000 - 0000000000100000
> (reserved)
> [17179569.184000]  BIOS-e820: 0000000000100000 - 000000002bef0000
(usable)
> [17179569.184000]  BIOS-e820: 000000002bef0000 - 000000002befb000
(ACPI
> data)
> [17179569.184000]  BIOS-e820: 000000002befb000 - 000000002bf00000
(ACPI
> NVS)
> [17179569.184000]  BIOS-e820: 000000002bf00000 - 0000000030000000
> (reserved)
> [17179569.184000]  BIOS-e820: 00000000fffe0000 - 0000000100000000
> (reserved)
> [17179569.184000] 702MB LOWMEM available.
> [17179569.184000] On node 0 totalpages: 179952
> [17179569.184000]   DMA zone: 4096 pages, LIFO batch:2
> [17179569.184000]   DMA32 zone: 0 pages, LIFO batch:2
> [17179569.184000]   Normal zone: 175856 pages, LIFO batch:64
> [17179569.184000]   HighMem zone: 0 pages, LIFO batch:2
> [17179569.184000] DMI 2.3 present.
> [17179569.184000] ACPI: RSDP (v000 PTLTD
)
> @ 0x000f6890
> [17179569.184000] ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP
> 0x00000000) @ 0x2bef5b5f
> [17179569.184000] ACPI: FADT (v001 KN400  PTLTW    0x06040000 PTL_
> 0x000f4240) @ 0x2befae95
> [17179569.184000] ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP
> 0x00000001) @ 0x2befaf09
> [17179569.184000] ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT
> 0x0100000e) @ 0x00000000
> [17179569.184000] ACPI: PM-Timer IO Port: 0x4008
> [17179569.184000] Allocating PCI resources starting at 40000000 (gap:
> 30000000:cffe0000)
> [17179569.184000] Built 1 zonelists
> [17179569.184000] Kernel command line: root=/dev/hda3 resume=/dev/hda4
> log_buf_len=4M kstack=300
> [17179569.184000] log_buf_len: 4194304
> [17179569.184000] Local APIC disabled by BIOS -- you can enable it
with
> "lapic"
> [17179569.184000] mapped APIC to ffffd000 (01985000)
> [17179569.184000] Initializing CPU#0
> [17179569.184000] PID hash table entries: 4096 (order: 12, 65536
bytes)
> [17179569.184000] Detected 796.218 MHz processor.
> [17179569.184000] Using pmtmr for high-res timesource
> [17179569.184000] Console: colour VGA+ 80x25
> [17179570.432000] Dentry cache hash table entries: 131072 (order: 7,
> 524288 bytes)
> [17179570.432000] Inode-cache hash table entries: 65536 (order: 6,
262144
> bytes)
> [17179570.472000] Memory: 705808k/719808k available (1879k kernel
code,
> 13476k reserved, 589k data, 184k init, 0k highmem)
> [17179570.472000] Checking if this processor honours the WP bit even
in
> supervisor mode... Ok.
> [17179570.552000] Calibrating delay using timer specific routine..
1594.34
> BogoMIPS (lpj=3188696)
> [17179570.552000] Mount-cache hash table entries: 512
> [17179570.552000] CPU: After generic identify, caps: 0383f9ff c1cbf9ff
> 00000000 00000000 00000000 00000000 00000000
> [17179570.552000] CPU: After vendor identify, caps: 0383f9ff c1cbf9ff
> 00000000 00000000 00000000 00000000 00000000
> [17179570.552000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K
(64
> bytes/line)
> [17179570.552000] CPU: L2 Cache: 512K (64 bytes/line)
> [17179570.552000] CPU: After all inits, caps: 0383f9ff c1cbf9ff
00000000
> 00000020 00000000 00000000 00000000
> [17179570.552000] Intel machine check architecture supported.
> [17179570.552000] Intel machine check reporting enabled on CPU#0.
> [17179570.552000] mtrr: v2.0 (20020519)
> [17179570.552000] CPU: AMD Mobile AMD Athlon(tm) XP 2400+ stepping 00
> [17179570.552000] Enabling fast FPU save and restore... done.
> [17179570.552000] Enabling unmasked SIMD FPU exception support...
done.
> [17179570.552000] Checking 'hlt' instruction... OK.
> [17179570.568000]     ACPI-0284: *** Info: Table [DSDT] replaced by
host
> OS
> [17179570.588000] ACPI: setting ELCR to 0400 (from 0a30)
> [17179570.592000] NET: Registered protocol family 16
> [17179570.592000] ACPI: bus type pci registered
> [17179570.592000] PCI: PCI BIOS revision 2.10 entry at 0xfd65c, last
bus=1
> [17179570.592000] PCI: Using configuration type 1
> 
> [interessting part begins here!]
> [17179570.592000] ACPI: Subsystem revision 20050902
> [17179570.600000] ACPI: Interpreter enabled
> [17179570.600000] ACPI: Using PIC for interrupt routing
> [17179570.604000] ACPI: PCI Root Bridge [PCI0] (0000:00)
> [17179570.604000] PCI: Probing PCI hardware (bus 00)
> 
> [17179570.604000]     ACPI-0508: *** Error: Method execution failed
> [\_SB_.PCI0._CRS] (Node ebec4b00), AE_AML_BUFFER_LIMIT
> [17179570.604000]     ACPI-0156: *** Error: Method execution failed
> [\_SB_.PCI0._CRS] (Node ebec4b00), AE_AML_BUFFER_LIMIT
> 
> [17179570.608000] PCI quirk: region 4000-407f claimed by vt8235 PM
> [17179570.608000] PCI quirk: region 8100-810f claimed by vt8235 SMB
> [17179570.612000] Boot video device is 0000:01:00.0
> [17179570.612000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> [17179570.624000] ACPI: PCI Interrupt Link [LNKA] (IRQs *4)
> [17179570.624000] ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
> [17179570.624000] ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
> [17179570.624000] ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
> [17179570.632000] ACPI: Embedded Controller [EC0] (gpe 1)
> [17179570.636000] Linux Plug and Play Support v0.97 (c) Adam Belay
> [17179570.636000] pnp: PnP ACPI init
> [17179570.644000] pnp: PnP ACPI: found 11 devices
> [17179570.648000] PnPBIOS: Disabled by ACPI PNP
> [17179570.648000] PCI: Using ACPI for IRQ routing
> [17179570.648000] PCI: If a device doesn't work, try "pci=routeirq".
If
> it helps, post a report
> [17179570.648000] pnp: 00:05: ioport range 0x4d0-0x4d1 has been
reserved
> [17179570.648000] pnp: 00:05: ioport range 0xfe10-0xfe11 has been
reserved
> [17179570.648000] pnp: 00:05: ioport range 0x600-0x60f has been
reserved
> [17179570.648000] pnp: 00:05: ioport range 0xfe00-0xfe00 has been
reserved
> [17179570.648000] pnp: 00:05: ioport range 0x4000-0x407f could not be
> reserved
> [17179570.652000] PCI: Failed to allocate mem resource
#6:10000@f4000000
> for 0000:01:00.0
> [17179570.652000] PCI: Bridge: 0000:00:01.0
> [17179570.652000]   IO window: disabled.
> [17179570.652000]   MEM window: d1000000-d1ffffff
> [17179570.652000]   PREFETCH window: f0000000-f3ffffff
> [17179570.652000] PCI: Bus 2, cardbus bridge: 0000:00:07.0
> [17179570.652000]   IO window: 00002000-000020ff
> [17179570.652000]   IO window: 00002400-000024ff
> [17179570.652000]   PREFETCH window: 40000000-41ffffff
> [17179570.652000]   MEM window: 42000000-43ffffff
> [17179570.652000] PCI: Setting latency timer of device 0000:00:01.0 to
64
> [17179570.652000] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
> [17179570.652000] PCI: setting IRQ 5 as level-triggered
> [17179570.652000] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LNKB]
->
> GSI 5 (level, low) -> IRQ 5
> [17179570.652000] PCI: Setting latency timer of device 0000:00:07.0 to
64
> [17179570.652000] Machine check exception polling timer started.
> [17179570.652000] VFS: Disk quotas dquot_6.5.1
> [17179570.652000] Dquot-cache hash table entries: 1024 (order 0, 4096
> bytes)
> [17179570.652000] Initializing Cryptographic API
> [17179570.652000] io scheduler noop registered
> [17179570.652000] io scheduler anticipatory registered
> [17179570.656000] isapnp: Scanning for PnP cards...
> 
> ______________________________________________________________
> Verschicken Sie romantische, coole und witzige Bilder per SMS!
> Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
