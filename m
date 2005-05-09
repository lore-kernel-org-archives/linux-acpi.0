From: Dean Townsley <dean-5NrKhQnM7FRWk0Htik3J/w@public.gmane.org>
Subject: Re: Something seems to be wrong with my RSDP
Date: Mon, 09 May 2005 12:16:39 -0500
Message-ID: <E1DVBrz-0004I1-8U@variable.uchicago.edu>
References: <427CB470.4060700@heiko-gerstung.de> <E1DUujy-0003sP-Om@variable.uchicago.edu>  <427F4AC7.4090109@heiko-gerstung.de>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from Heiko Gerstung <hg-Zwoj8m1Se4ooLuGpnUaJU7NAH6kLmebB@public.gmane.org>
   of "Mon, 09 May 2005 13:34:31 +0200." <427F4AC7.4090109-Zwoj8m1Se4ooLuGpnUaJU7NAH6kLmebB@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Heiko Gerstung <hg-Zwoj8m1Se4ooLuGpnUaJU7NAH6kLmebB@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Heiko,


On Mon, 09 May 2005 13:34:31 +0200 Heiko Gerstung wrote:
> you made my day. It works, great job!
I'm glad it worked for you too.  (You're not the first person who's
asked about ACPI in 2.6 on the Acer, but this is the first time I've
gotten it to work.)

> But even with using my fixed DSDT I get this checksum error ...
Yes, my patch just ignores the error so it's not a "real" fix, just a
hack.  The checksum is for the RSDP (Root system description POINTER)
which is supposed to point to a table that then points to the DSDT.
More below...

> Please find the DSDT file attached.
Thanks :)  -- I'll try it when I get a chance.

> I'd propose to use a kernel boot parameter like acpi_ignore_chksum=yes 
> which prevents the kernel from disabling ACPI due to a checksum error... 
> Do you know who I need to contact in order to ask for this?

It seems like a boot parameter would be the right thing.  But I'm sure
any true ACPI person reading this (I hope someone is) is wondering why
on earth this thing works at all...

Doing some digging I found that there are two entirely separate
functions for finding the RSDP, which appear to be intended to do
exactly the same thing.  These are
acpi_find_rsdp() in arch/i386/kernel/acpi/boot.c
and
acpi_tb_find_rsdp(&return,flags) in drivers/acpi/tables/tbxfroot.c

It appears that the first one is run when the kernel wants to know if
ACPI is needed to set up APICs and things, and the second one is
actually used by the ACPI code (tbxface).  As evidenced by the demg
portion I've included below, the first one finds an invalid RSDP (I
put in some debug code to print out the contents of the RSDP at this
point) but the second one must find a valid one because no error is
generated and it follows it right through to the DSDT (note the below
is without your DSDT, so it is finding it in memory.)

So my current guess is that there is an invalid RSDP floating around
in addition to the real one, and the first code (which appears less
sophisticated) is finding it instead of the real thing.  The main
differences between the functions appear to have to do with memory
addressing but I don't know enough about the kernel to interpret them
properly.  It could also be some sort of delay in bios filling in the
RSDP, though that doesn't make sense to me.  Seems like this should be
static data by the time the kernel is booting.

My basic question is why are there two functions that do exactly the
same thing?  My first inclination would be to just replace the call to
acpi_find_rsdp() with acpi_tb_find_rsdp(...) but without understanding
the differences in memory addressing, I'm not sure if this is a good
idea.

In any case, I'm glad it's working for you now.

Cheers,
-Dean


Linux version 2.6.11 (dean@odysseus) (gcc version 2.95.4 20011002 (Debian prerelease)) #4 Sun May 8 23:54:49 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
 BIOS-e820: 000000000ffc0000 - 000000000ffe0000 (reserved)
 BIOS-e820: 000000000ffe0000 - 000000000ffe8000 (ACPI data)
 BIOS-e820: 000000000ffe8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65472
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61376 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 Acer                                  ) @ 0x000ec2d0
ACPI: RSDP contents signature="RSD PTR " checksum=0x00 oem_id="Acer  " revision=0x00 rsdt_addr=0x00000000
ACPI: RSDP checksum=0xda
  >>> ERROR: Invalid checksum
Allocating PCI resources starting at 10000000 (gap: 10000000:efff0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=test26 ro root=306 acpi=force
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Initializing CPU#0
CPU 0 irqstacks, hard=c04f0000 soft=c04ef000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 798.592 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254696k/261888k available (2566k kernel code, 6684k reserved, 1267k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1576.96 BogoMIPS (lpj=788480)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Mobile Intel(R) Pentium(R) III CPU - M   800MHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0120 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................................................................
Table [DSDT](id F004) - 436 Objects with 35 Devices 120 Methods 34 Regions
ACPI Namespace successfully loaded at root c0505b40
ACPI: setting ELCR to 0200 (from 0c00)
evxfevnt-0096 [03] acpi_enable           : Transition to ACPI mode successful
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050408
evgpeblk-1016 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-1024 [06] ev_create_gpe_block   : Found 3 Wake, Enabled 1 Runtime GPEs in this block
evgpeblk-1016 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on int 0x9
evgpeblk-1024 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:.................................................................................................
Initialized 34/34 Regions 21/21 Fields 31/31 Buffers 11/15 Packages (445 nodes)
Executing all Device _STA and_INI methods:........................................
40 Devices found containing: 40 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [PILA] (IRQs *10 15)
ACPI: PCI Interrupt Link [PILB] (IRQs *11 15)
ACPI: PCI Interrupt Link [PILD] (IRQs *10 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 24)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
pnp: 00:00: ioport range 0xf000-0xf03f could not be reserved
pnp: 00:00: ioport range 0xf100-0xf10f has been reserved
pnp: 00:00: ioport range 0xf050-0xf057 has been reserved
pnp: 00:00: ioport range 0x3bd-0x3be has been reserved
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1115614675.059:0): initialized
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [THR1] (56 C)
ACPI: Thermal Zone [THR2] (51 C)
ibm_acpi: ec object not found
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
.......


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
