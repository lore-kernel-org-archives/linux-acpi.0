From: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Subject: Re: _PTS call hangs system
Date: Mon, 20 Sep 2004 14:30:06 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409201430.06459.andre@eisenbach.com>
References: <6EDC9204B3704C4C8522539D5C1185E52449B7@mssmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1530638.aGhObgOZEB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6EDC9204B3704C4C8522539D5C1185E52449B7-g/v8ENnfjb4gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--nextPart1530638.aGhObgOZEB
Content-Type: multipart/mixed;
  boundary="Boundary-01=_ev0TBhFDs+CoON0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_ev0TBhFDs+CoON0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 20 September 2004 01:05 schrieb Starikovskiy, Alexey Y:
> Could you post your whole DSDT and dmesg?

Attached.

> BTW, if you enable debug in ACPI and do "Store ("BLA-BLA-BLA", Debug)"
> in any method of DSDT, ACPI will print it to console (even from _PTS and
> _GTS).

Thats exactly what I am wondering - this _used to_ work. But now those=20
messages seem to go to the log instead of the console. Which is of course=20
useless since the log daemon shuts down befoe _PTS is called...

Thanks for your continued help!

Cheers,
   Andre

--Boundary-01=_ev0TBhFDs+CoON0
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.out"

Linux version 2.6.9-rc2-mm1 (root@2100z) (gcc version 3.4.1 20040803 (Gento=
o Linux 3.4.1-r2, ssp-3.4-2, pie-8.7.6.5)) #7 Fri Sep 17 14:50:18 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
 BIOS-e820: 000000001bef0000 - 000000001beff000 (ACPI data)
 BIOS-e820: 000000001beff000 - 000000001bf00000 (ACPI NVS)
 BIOS-e820: 000000001bf00000 - 000000001c000000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
446MB LOWMEM available.
On node 0 totalpages: 114416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 110320 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7290
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1bef8b67
ACPI: FADT (v001 ATI    Raptor   0x06040000 ATI  0x000f4240) @ 0x1befee2b
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1befee9f
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x1befeec7
ACPI: DSDT (v001    ATI U1_M1535 0x06040000 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=3DGentoo ro root=3D305 elevator=3Dcfq
CPU 0 irqstacks, hard=3Dc048c000 soft=3Dc048b000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1788.914 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449316k/457664k available (2528k kernel code, 7796k reserved, 915k =
data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3538.94 BogoMIPS (lpj=3D1769472)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: After vendor identify, caps:  0383f9ff c1cbf9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP2400+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
   tbget-0291: *** Info: Table [DSDT] replaced by host OS
ACPI: IRQ9 SCI: Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd87b, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 10) *9
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 7 11) *10
ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 6 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 6 10) *9
ACPI: Embedded Controller [EC0] (gpe 24)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=3Drouteirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
Activating ISA DMA hang workarounds.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 10 (level, low) -> IRQ 10
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=3D191.86 MHz (RefDiv=3D426) Memory=3D160.00 Mhz, System=
=3D133.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: Samsung LTN150P1-L02   =20
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
Console: switching to colour frame buffer device 175x65
radeonfb: ATI Radeon C6  SDR SGRAM 64 MB
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (58 C)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Ati IGP320/M chipset
agpgart: Maximum main memory to use for agp memory: 379M
agpgart: AGP aperture is 64M @ 0xd4000000
i8042: ACPI  [KBC0] at I/O 0x60, 0x64, irq 1
i8042: ACPI  [MSE0] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 3
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 3 (level, low) -> IRQ 3
ttyS1 at I/O 0x8828 (irq =3D 3) is a 8250
ttyS2 at I/O 0x8840 (irq =3D 3) is a 8250
ttyS3 at I/O 0x8850 (irq =3D 3) is a 8250
ttyS4 at I/O 0x8860 (irq =3D 3) is a 8250
ttyS5 at I/O 0x8870 (irq =3D 3) is a 8250
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker-H7y4myexbJEAvxtiuMwx3w@public.gmane.org>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11 (level, low) -> IRQ 11
natsemi eth0: NatSemi DP8381[56] at 0xdc838000 (0000:00:12.0), 00:0d:9d:5a:=
41:46, IRQ 11, port TP.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
Warning: ATI Radeon IGP Northbridge is not yet fully tested.
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: PCI interrupt 0000:00:10.0[A]: no GSI - using IRQ 0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HTS726060M9AT00, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG CDRW/DVD SN-324F, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=3D16383/255/63, UDMA=
(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 35
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53=
 2004 UTC).
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
ALSA device list:
  #0: ALI 5451 at 0x8400, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (3575 buckets, 28600 max) - 332 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost-vhD3WmCyG/PR7s880joybQ@public.gmane.org>.  http://snowman.net/=
projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: No PST tables match this cpuid (0x7a0)
powernow: This is indicative of a broken BIOS.
powernow: Trying ACPI perflib
powernow: Minimum speed 530 MHz. Maximum speed 1788 MHz.
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices:=20
PCI0 MDEM  LAN  LID=20
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
=46reeing unused kernel memory: 160k freed
Adding 1004052k swap on /dev/hda3.  Priority:-1 extents:1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:02.0: ALi Corporation USB 1.1 Controller
ohci_hcd 0000:00:02.0: irq 10, pci mem 0xd0004000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: init err (00002edf 0000)
ohci_hcd 0000:00:02.0: can't start
ohci_hcd 0000:00:02.0: init error -75
ohci_hcd 0000:00:02.0: remove, state 0
ohci_hcd 0000:00:02.0: USB bus 1 deregistered
ohci_hcd: probe of 0000:00:02.0 failed with error -75
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [0000:0000]
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000007
eth0: DSPCFG accepted after 0 usec.
eth0: link up.
eth0: Setting full-duplex based on negotiated link capability.
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc R=
adeon Mobility U1
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode

--Boundary-01=_ev0TBhFDs+CoON0
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="DSDT.dsl"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="DSDT.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20040715
 *
 * Disassembly of org.dsdt, Wed Sep  1 01:31:22 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "ATI", "U1_M1535", 100925440)
{
    OperationRegion (DBG, SystemIO, 0x80, 0x01)
    Field (DBG, ByteAcc, NoLock, Preserve)
    {
        P80H,   8
    }

    OperationRegion (PMIO, SystemIO, 0x8000, 0x30)
    Field (PMIO, ByteAcc, NoLock, Preserve)
    {
        PMS1,   16,=20
        PME1,   16,=20
        PMC1,   16,=20
        Offset (0x08),=20
        ATMR,   32,=20
        Offset (0x10),=20
            ,   1,=20
        TRDC,   3,=20
        TREN,   1
    }

    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00008010, 0x06) {}
    }

    Name (_S0, Package (0x04)
    {
        0x00,=20
        0x00,=20
        0x00,=20
        0x00
    })
    Name (_S3, Package (0x04)
    {
        0x03,=20
        0x03,=20
        0x00,=20
        0x00
    })
    Name (_S4, Package (0x04)
    {
        0x04,=20
        0x04,=20
        0x00,=20
        0x00
    })
    Name (_S5, Package (0x04)
    {
        0x05,=20
        0x05,=20
        0x00,=20
        0x00
    })
    Method (VTOB, 1, NotSerialized)
    {
        Store (0x01, Local0)
        ShiftLeft (Local0, Arg0, Local0)
        Return (Local0)
    }

    Method (BTOV, 1, NotSerialized)
    {
        ShiftRight (Arg0, 0x01, Local0)
        Store (0x00, Local1)
        While (Local0)
        {
            Increment (Local1)
            ShiftRight (Local0, 0x01, Local0)
        }

        Return (Local1)
    }

    Method (MKWD, 2, NotSerialized)
    {
        If (And (Arg1, 0x80))
        {
            Store (0xFFFF0000, Local0)
        }
        Else
        {
            Store (Zero, Local0)
        }

        Or (Local0, Arg0, Local0)
        Or (Local0, ShiftLeft (Arg1, 0x08), Local0)
        Return (Local0)
    }

    Method (GBFE, 3, NotSerialized)
    {
        CreateByteField (Arg0, Arg1, TIDX)
        Store (TIDX, Arg2)
    }

    Method (PBFE, 3, NotSerialized)
    {
        CreateByteField (Arg0, Arg1, TIDX)
        Store (Arg2, TIDX)
    }

    Method (ITOS, 1, NotSerialized)
    {
        Store (Buffer (0x09)
            {
                0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,=20
                0x00
            }, Local0)
        Store (Buffer (0x11)
            {
                "0123456789ABCDEF"
            }, Local7)
        Store (0x08, Local1)
        Store (0x00, Local2)
        Store (0x00, Local3)
        While (Local1)
        {
            Decrement (Local1)
            And (ShiftRight (Arg0, ShiftLeft (Local1, 0x02)), 0x0F, Local4)
            If (Local4)
            {
                Store (Ones, Local3)
            }

            If (Local3)
            {
                GBFE (Local7, Local4, RefOf (Local5))
                PBFE (Local0, Local2, Local5)
                Increment (Local2)
            }
        }

        Return (Local0)
    }

    Scope (\_SB)
    {
        Name (ECEN, 0x00)
        Name (ACCG, 0x00)
        Name (PRCT, 0x00)
        Name (S4WF, 0x00)
        Method (ECOK, 0, NotSerialized)
        {
            If (LAnd (ECEN, 0x01))
            {
                Return (0x01)
            }
            Else
            {
                Return (0x00)
            }
        }

        Device (PCI0)
        {
            Name (_PRW, Package (0x02)
            {
                0x09,=20
                0x05
            })
            Name (_PRT, Package (0x0B)
            {
                Package (0x04)
                {
                    0x0001FFFF,=20
                    0x00,=20
                    \_SB.PCI0.ISA.LNKA,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x0002FFFF,=20
                    0x00,=20
                    \_SB.PCI0.ISA.LNKU,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x000FFFFF,=20
                    0x00,=20
                    \_SB.PCI0.ISA.LNKE,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x0008FFFF,=20
                    0x00,=20
                    \_SB.PCI0.ISA.LNKG,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x0006FFFF,=20
                    0x00,=20
                    \_SB.PCI0.ISA.LNKH,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x0012FFFF,=20
                    0x00,=20
                    \_SB.PCI0.ISA.LNKB,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x0009FFFF,=20
                    0x00,=20
                    \_SB.PCI0.ISA.LNKD,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x0009FFFF,=20
                    0x01,=20
                    \_SB.PCI0.ISA.LNKC,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x000CFFFF,=20
                    0x00,=20
                    \_SB.PCI0.ISA.LNKC,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x000AFFFF,=20
                    0x00,=20
                    \_SB.PCI0.ISA.LNKF,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x000AFFFF,=20
                    0x01,=20
                    \_SB.PCI0.ISA.LNKF,=20
                    0x00
                }
            })
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            OperationRegion (MREG, PCI_Config, 0xB8, 0x14)
            Field (MREG, ByteAcc, NoLock, Preserve)
            {
                CS0,    8,=20
                CS1,    8,=20
                CS2,    8,=20
                CS3,    8,=20
                Offset (0x10),=20
                FBSL,   8,=20
                FBSM,   8
            }

            Method (TOM, 0, NotSerialized)
            {
                Multiply (FBSL, 0x00010000, Local0)
                Multiply (FBSM, 0x01000000, Local1)
                Add (Local0, Local1, Local0)
                Return (Local0)
            }

            OperationRegion (VGAM, SystemMemory, 0x000C0002, 0x01)
            Field (VGAM, ByteAcc, Lock, Preserve)
            {
                VSIZ,   8
            }

            OperationRegion (REGS, PCI_Config, 0x90, 0x70)
            Field (REGS, ByteAcc, NoLock, Preserve)
            {
                SR90,   8,=20
                SR91,   8,=20
                SR92,   8,=20
                SR93,   8,=20
                Offset (0x6E),=20
                SRFE,   8,=20
                SRFF,   8
            }

            Name (RSRC, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, SubDec=
ode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixe=
d, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixe=
d, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000C0000,
                    0x000C3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixe=
d, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000C4000,
                    0x000C7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixe=
d, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000C8000,
                    0x000CBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixe=
d, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000CC000,
                    0x000CFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixe=
d, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D0000,
                    0x000D7FFF,
                    0x00000000,
                    0x00008000)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixe=
d, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixe=
d, NonCacheable, ReadWrite,
                    0x00000000,
                    0x00100000,
                    0xFFFDFFFF,
                    0x00000000,
                    0xFFEE0000, 0x00)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, En=
tireRange,
                    0x0000,
                    0x0000,
                    0x0CF7,
                    0x0000,
                    0x0CF8, 0x00)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, En=
tireRange,
                    0x0000,
                    0x0D00,
                    0xFFFF,
                    0x0000,
                    0xF300, 0x00)
            })
            Method (_CRS, 0, Serialized)
            {
                CreateDWordField (RSRC, 0xC0, VMAX)
                CreateDWordField (RSRC, 0xC8, VLEN)
                ShiftLeft (VSIZ, 0x09, Local0)
                Add (Local0, 0x000BFFFF, VMAX)
                Add (Local0, 0x00020000, VLEN)
                CreateDWordField (RSRC, 0xD7, BTMN)
                CreateDWordField (RSRC, 0xDB, BTMX)
                CreateDWordField (RSRC, 0xE3, BTLN)
                Store (\_SB.PCI0.TOM (), BTMN)
                Subtract (0xFFF80000, BTMN, BTLN)
                Subtract (Add (BTMN, BTLN), 0x01, BTMX)
                Return (RSRC)
            }

            Device (AGPB)
            {
                Name (_ADR, 0x00010000)
                Device (VGA)
                {
                    Name (_ADR, 0x00050000)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS1, 0, NotSerialized)
                    {
                        Store (0x01, _PSC)
                    }

                    Method (_PS2, 0, NotSerialized)
                    {
                        Store (0x02, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Name (DISW, 0x01)
                    Name (NDSP, 0x00)
                    Name (VRSM, 0x00)
                    Name (TGLT, Package (0x04)
                    {
                        Package (0x08)
                        {
                            0x01,=20
                            0x01,=20
                            0x01,=20
                            0x01,=20
                            0x01,=20
                            0x01,=20
                            0x01,=20
                            0x01
                        },=20

                        Package (0x08)
                        {
                            0x01,=20
                            0x02,=20
                            0x03,=20
                            0x01,=20
                            0x01,=20
                            0x01,=20
                            0x01,=20
                            0x01
                        },=20

                        Package (0x08)
                        {
                            0x01,=20
                            0x04,=20
                            0x04,=20
                            0x04,=20
                            0x05,=20
                            0x01,=20
                            0x01,=20
                            0x01
                        },=20

                        Package (0x08)
                        {
                            0x01,=20
                            0x02,=20
                            0x03,=20
                            0x05,=20
                            0x01,=20
                            0x01,=20
                            0x01,=20
                            0x01
                        }
                    })
                    Name (TGLP, 0x00)
                    Method (NDGS, 0, NotSerialized)
                    {
                        ShiftRight (And (^LCD._DCS, 0x02), 0x01, Local0)
                        Or (Local0, And (^CRT._DCS, 0x02), Local0)
                        Or (Local0, ShiftLeft (And (^TV._DCS, 0x02), 0x01),=
 Local0)
                        Store (DerefOf (Index (DerefOf (Index (TGLT, TGLP))=
, Local0)), Local1)
                        And (Local1, 0x01, ^LCD._DGS)
                        ShiftRight (And (Local1, 0x02), 0x01, ^CRT._DGS)
                        ShiftRight (And (Local1, 0x04), 0x02, ^TV._DGS)
                    }

                    Method (USTS, 1, NotSerialized)
                    {
                        Store (\_SB.PCI0.ISA.HPSS (0x0F, 0x00), Local0)
                        And (Local0, 0x0F, Local1)
                        If (LEqual (Local1, 0x03))
                        {
                            Store (0x01, TGLP)
                        }
                        Else
                        {
                            If (LEqual (Local1, 0x05))
                            {
                                Store (0x02, TGLP)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x07))
                                {
                                    Store (0x03, TGLP)
                                }
                                Else
                                {
                                    Store (0x00, TGLP)
                                }
                            }
                        }

                        Or (ShiftRight (And (Local0, 0x10), 0x03), And (^LC=
D._DCS, 0xFD), ^LCD._DCS)
                        Or (Or (ShiftLeft (And (Local0, 0x02), 0x03), Shift=
Right (And (Local0, 0x20), 0x04)), And (^CRT._DCS, 0xED), ^CRT._DCS)
                        Or (Or (ShiftLeft (And (Local0, 0x04), 0x02), Shift=
Right (And (Local0, 0x40), 0x05)), And (^TV._DCS, 0xED), ^TV._DCS)
                        Return (Local0)
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Store (USTS (0x00), Local1)
                        Or (ShiftRight (And (Local1, 0x10), 0x03), 0x1D, ^L=
CD._DCS)
                        Or (Or (ShiftLeft (And (Local1, 0x02), 0x03), Shift=
Right (And (Local1, 0x20), 0x04)), 0x0D, ^CRT._DCS)
                        Or (Or (ShiftLeft (And (Local1, 0x04), 0x02), Shift=
Right (And (Local1, 0x40), 0x05)), 0x0D, ^TV._DCS)
                        ShiftRight (Local1, 0x04, NDSP)
                        Store (ShiftRight (And (^LCD._DCS, 0x02), 0x01), ^L=
CD._DGS)
                        Store (ShiftRight (And (^CRT._DCS, 0x02), 0x01), ^C=
RT._DGS)
                        Store (ShiftRight (And (^TV._DCS, 0x02), 0x01), ^TV=
=2E_DGS)
                        NDGS ()
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        If (LAnd (LEqual (And (Arg0, 0x03), 0x00), LEqual (=
And (DISW, 0x03), 0x02)))
                        {
                            Notify (\_SB.PCI0.ISA.HPCI, 0x89)
                        }

                        Store (Arg0, DISW)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x03)
                        {
                            0x00010100,=20
                            0x00010110,=20
                            0x00010200
                        })
                    }

                    Method (DRUL, 1, NotSerialized)
                    {
                        Store (^CRT._DCS, Local1)
                        If (LEqual (Arg0, 0x01))
                        {
                            Store (USTS (0x01), Local2)
                        }
                        Else
                        {
                            Store (USTS (0x00), Local2)
                        }

                        If (LEqual (Arg0, 0x01))
                        {
                            NDGS ()
                            If (LOr (LAnd (^CRT._DGS, LNot (And (^CRT._DCS,=
 0x10))), LAnd (^TV._DGS, LNot (And (^TV._DCS, 0x10)))))
                            {
                                NDGS ()
                                Return (0x00)
                            }
                            Else
                            {
                                Notify (VGA, 0x80)
                                Return (0x00)
                            }
                        }

                        If (LEqual (Arg0, 0x02))
                        {
                            If (And (Local2, 0x02))
                            {
                                Store (0x01, ^CRT._DGS)
                                If (\_SB.PCI0.ISA.DISB)
                                {
                                    Store (0x01, ^LCD._DGS)
                                }
                                Else
                                {
                                    Store (0x00, ^LCD._DGS)
                                }

                                Store ("CRT Connected VGA.DRUL(2) called", =
Debug)
                            }
                            Else
                            {
                                Store (0x00, ^CRT._DGS)
                                Store (0x01, ^LCD._DGS)
                                Store ("CRT DisConnected VGA.DRUL(2) called=
", Debug)
                            }

                            Notify (VGA, 0x80)
                        }

                        If (LEqual (Arg0, 0x04))
                        {
                            Store (0x00, ^CRT._DGS)
                            Store (0x01, ^LCD._DGS)
                            Notify (VGA, 0x80)
                        }

                        If (LEqual (Arg0, 0x03))
                        {
                            If (LNot (LEqual (ShiftRight (And (Local1, 0x10=
), 0x03), And (Local2, 0x02))))
                            {
                                If (And (Local2, 0x02))
                                {
                                    Store (0x01, ^CRT._DGS)
                                    If (\_SB.PCI0.ISA.DISB)
                                    {
                                        Store (0x01, ^LCD._DGS)
                                    }
                                    Else
                                    {
                                        Store (0x00, ^LCD._DGS)
                                    }
                                }
                                Else
                                {
                                    Store (0x00, ^CRT._DGS)
                                    Store (0x01, ^LCD._DGS)
                                }

                                Store ("Resume VGA.DRUL(3) called", Debug)
                                Notify (VGA, 0x80)
                            }
                        }

                        If (LEqual (Arg0, 0x05))
                        {
                            Notify (VGA, 0x80)
                            Return (0x00)
                        }

                        Return (0x00)
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Name (_PSC, 0x00)
                        Name (_S3D, 0x03)
                        Method (_PS0, 0, NotSerialized)
                        {
                            If (LAnd (LAnd (VRSM, LNot (^^CRT._PSC)), LNot =
(^^TV._PSC)))
                            {
                                If (_PSC)
                                {
                                    DRUL (0x03)
                                }

                                Store (0x00, VRSM)
                            }

                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("LCD._DSS(1) called", Debug)
                                Or (NDSP, 0x01, NDSP)
                            }
                            Else
                            {
                                Store ("LCD._DSS(0) called", Debug)
                                And (NDSP, 0xFE, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            If (LEqual (Local0, 0x80000000))
                            {
                                Store ("LCD._DSS(8000000x) called", Debug)
                                \_SB.PCI0.ISA.HPSS (0x01, NDSP)
                            }

                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("LCD._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And =
(NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02=
), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And =
(NDSP, 0x04), 0x01), ^^TV._DCS)
                            }
                        }

                        Name (_DGS, 0x00)
                    }

                    Device (CRT)
                    {
                        Name (_ADR, 0x0100)
                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            If (LAnd (LAnd (VRSM, LNot (^^LCD._PSC)), LNot =
(^^TV._PSC)))
                            {
                                If (_PSC)
                                {
                                    DRUL (0x03)
                                }

                                Store (0x00, VRSM)
                            }

                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("CRT._DSS(1) called", Debug)
                                Or (NDSP, 0x02, NDSP)
                            }
                            Else
                            {
                                Store ("CRT._DSS(0) called", Debug)
                                And (NDSP, 0xFD, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            If (LEqual (Local0, 0x80000000))
                            {
                                Store ("CRT._DSS(8000000x) called", Debug)
                                \_SB.PCI0.ISA.HPSS (0x01, NDSP)
                            }

                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("CRT._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And =
(NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02=
), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And =
(NDSP, 0x04), 0x01), ^^TV._DCS)
                            }
                        }

                        Name (_DGS, 0x00)
                    }

                    Device (TV)
                    {
                        Name (_ADR, 0x0200)
                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            If (LAnd (LAnd (VRSM, LNot (^^CRT._PSC)), LNot =
(^^LCD._PSC)))
                            {
                                If (_PSC)
                                {
                                    DRUL (0x03)
                                }

                                Store (0x00, VRSM)
                            }

                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("TV_._DSS(1) called", Debug)
                                Or (NDSP, 0x04, NDSP)
                            }
                            Else
                            {
                                Store ("TV_._DSS(0) called", Debug)
                                And (NDSP, 0xFB, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            If (LEqual (Local0, 0x80000000))
                            {
                                Store ("TV_._DSS(8000000x) called", Debug)
                                \_SB.PCI0.ISA.HPSS (0x01, NDSP)
                            }

                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("TV_._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And =
(NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02=
), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And =
(NDSP, 0x04), 0x01), ^^TV._DCS)
                            }
                        }

                        Name (_DGS, 0x00)
                    }
                }

                Name (_PRT, Package (0x01)
                {
                    Package (0x04)
                    {
                        0x0005FFFF,=20
                        0x00,=20
                        \_SB.PCI0.ISA.LNKC,=20
                        0x00
                    }
                })
            }

            Device (IDE)
            {
                Name (_ADR, 0x00100000)
                Name (UDMT, Package (0x08)
                {
                    0x1E,=20
                    0x2D,=20
                    0x3C,=20
                    0x5A,=20
                    0x78,=20
                    0x78,=20
                    0x78,=20
                    0x14
                })
                Name (PIOT, Package (0x05)
                {
                    0x78,=20
                    0xB4,=20
                    0xF0,=20
                    0x017F,=20
                    0x0258
                })
                Name (PIOC, Package (0x05)
                {
                    0x04,=20
                    0x06,=20
                    0x08,=20
                    0x0D,=20
                    0x10
                })
                Name (CBCT, Package (0x05)
                {
                    0x31,=20
                    0x33,=20
                    0x01,=20
                    0x03,=20
                    0x0A
                })
                Name (DACT, Package (0x05)
                {
                    0x03,=20
                    0x03,=20
                    0x04,=20
                    0x05,=20
                    0x08
                })
                Name (DRCT, Package (0x05)
                {
                    0x01,=20
                    0x03,=20
                    0x04,=20
                    0x08,=20
                    0x08
                })
                Name (PXLM, Package (0x05)
                {
                    0x02,=20
                    0x01,=20
                    0x00,=20
                    0x00,=20
                    0x00
                })
                OperationRegion (PCI, PCI_Config, 0x00, 0x60)
                Field (PCI, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x09),=20
                        ,   4,=20
                    SCHE,   1,=20
                    PCHE,   1,=20
                    Offset (0x0A),=20
                    Offset (0x0D),=20
                    Offset (0x4B),=20
                    U66E,   1,=20
                    Offset (0x4C),=20
                    Offset (0x53),=20
                    CDFI,   1,=20
                    CDUD,   1,=20
                    Offset (0x54),=20
                    PFTH,   8,=20
                    SFTH,   8,=20
                    PUDC,   8,=20
                    SUDC,   8,=20
                    PAST,   8,=20
                    PCBT,   8,=20
                    PTM0,   8,=20
                    PTM1,   8,=20
                    SAST,   8,=20
                    SCBT,   8,=20
                    STM0,   8,=20
                    STM1,   8
                }

                Method (STM, 3, NotSerialized)
                {
                    Name (A100, 0x00)
                    Store (Buffer (0x06)
                        {
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        }, Local7)
                    CreateByteField (Local7, 0x00, TM0)
                    CreateByteField (Local7, 0x01, TM1)
                    CreateByteField (Local7, 0x02, UDC)
                    CreateByteField (Local7, 0x03, AST)
                    CreateByteField (Local7, 0x04, CBT)
                    CreateByteField (Local7, 0x05, U66)
                    CreateDWordField (Arg0, 0x00, PIO0)
                    CreateDWordField (Arg0, 0x04, DMA0)
                    CreateDWordField (Arg0, 0x08, PIO1)
                    CreateDWordField (Arg0, 0x0C, DMA1)
                    CreateDWordField (Arg0, 0x10, FLAG)
                    Store (FLAG, Local6)
                    Name (W49M, 0x00)
                    Name (W53M, 0x00)
                    Name (W62M, 0x00)
                    Name (W64M, 0x00)
                    Name (W88M, 0x00)
                    If (LEqual (SizeOf (Arg1), 0x0200))
                    {
                        CreateDWordField (Arg1, 0x62, W49A)
                        CreateDWordField (Arg1, 0x6A, W53A)
                        CreateDWordField (Arg1, 0x7C, W62A)
                        CreateDWordField (Arg1, 0x80, W64A)
                        CreateDWordField (Arg1, 0xB0, W88A)
                        Store (W49A, W49M)
                        Store (W53A, W53M)
                        Store (W62A, W62M)
                        Store (W64A, W64M)
                        Store (W88A, W88M)
                    }
                    Else
                    {
                        Store (0x00, W49M)
                        Store (0x00, W53M)
                        Store (0x00, W62M)
                        Store (0x00, W64M)
                        Store (0x00, W88M)
                    }

                    If (LAnd (And (0x38, W88M), Ones))
                    {
                        Or (0x01, Local6, Local6)
                        If (And (0x20, W88M))
                        {
                            Store (0x08, DMA0)
                            Or (A100, 0x00100010, A100)
                        }
                        Else
                        {
                            If (And (0x10, W88M))
                            {
                                Store (0x1E, DMA0)
                                Or (A100, 0x10, A100)
                            }
                            Else
                            {
                                Store (0x2D, DMA0)
                            }
                        }
                    }
                    Else
                    {
                        If (And (0x07, W88M))
                        {
                            Or (0x0100, A100, A100)
                            If (And (0x04, W88M))
                            {
                                Store (0x3C, DMA0)
                            }
                            Else
                            {
                                If (And (0x02, W88M))
                                {
                                    Store (0x5A, DMA0)
                                }
                                Else
                                {
                                    Store (0x78, DMA0)
                                }
                            }
                        }
                    }

                    Store (Ones, Local4)
                    If (LOr (DMA0, PIO0))
                    {
                        If (LAnd (DMA0, LNot (PIO0)))
                        {
                            If (And (Local6, 0x01))
                            {
                                If (LLess (DMA0, 0x1E))
                                {
                                    Store (0x07, Local0)
                                }
                                Else
                                {
                                    Store (Match (^UDMT, MGE, DMA0, MTR, 0x=
00, 0x00), Local0)
                                }

                                Or (Local0, 0x08, UDC)
                                If (LLess (DMA0, 0x3C))
                                {
                                    Store (One, U66)
                                }
                            }

                            Store (Match (^PIOT, MGE, DMA0, MTR, 0x00, 0x00=
), Local0)
                            Store (DerefOf (Index (^DACT, Local0)), Local2)
                            Store (DerefOf (Index (^DRCT, Local0)), Local3)
                            Add (Local3, ShiftLeft (Local2, 0x04), TM0)
                            Store (Local0, Local4)
                        }

                        If (LAnd (LNot (DMA0), PIO0))
                        {
                            Store (Match (^PIOT, MGE, PIO0, MTR, 0x00, 0x00=
), Local0)
                            Store (DerefOf (Index (^DACT, Local0)), Local2)
                            Store (DerefOf (Index (^DRCT, Local0)), Local3)
                            Add (Local3, ShiftLeft (Local2, 0x04), TM0)
                            Store (Local0, Local4)
                        }

                        If (LAnd (DMA0, PIO0))
                        {
                            If (And (Local6, 0x01))
                            {
                                If (LLess (DMA0, 0x1E))
                                {
                                    Store (0x07, Local0)
                                }
                                Else
                                {
                                    Store (Match (^UDMT, MGE, DMA0, MTR, 0x=
00, 0x00), Local0)
                                }

                                Or (Local0, 0x08, UDC)
                                If (LLess (DMA0, 0x3C))
                                {
                                    Store (One, U66)
                                }
                            }

                            If (LNot (LLess (PIO0, DMA0)))
                            {
                                Store (Match (^PIOT, MGE, PIO0, MTR, 0x00, =
0x00), Local0)
                                Store (Local0, Local4)
                            }
                            Else
                            {
                                Store (Match (^PIOT, MGE, DMA0, MTR, 0x00, =
0x00), Local0)
                                Store (Local0, Local4)
                            }

                            Store (DerefOf (Index (^DACT, Local0)), Local2)
                            Store (DerefOf (Index (^DRCT, Local0)), Local3)
                            Add (Local3, ShiftLeft (Local2, 0x04), TM0)
                        }
                    }

                    Store (Ones, Local5)
                    If (LEqual (Local4, Ones))
                    {
                        If (LEqual (Local5, Ones))
                        {
                            Store (Zero, CBT)
                        }
                        Else
                        {
                            Store (DerefOf (Index (^CBCT, Local5)), CBT)
                        }
                    }
                    Else
                    {
                        If (LEqual (Local5, Ones))
                        {
                            Store (DerefOf (Index (^CBCT, Local4)), CBT)
                        }
                        Else
                        {
                            If (LNot (LLess (Local4, Local5)))
                            {
                                Store (DerefOf (Index (^CBCT, Local4)), CBT)
                            }
                            Else
                            {
                                Store (DerefOf (Index (^CBCT, Local5)), CBT)
                            }
                        }
                    }

                    Store (0x02, AST)
                    Return (Local7)
                }

                Method (GTF0, 3, NotSerialized)
                {
                    Store (Buffer (0x07)
                        {
                            0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                        }, Local7)
                    CreateByteField (Local7, 0x01, MODE)
                    If (And (Arg1, 0x08))
                    {
                        And (Arg1, 0x07, Local0)
                        If (LEqual (Local0, 0x07))
                        {
                            Store (0x05, MODE)
                        }
                        Else
                        {
                            Subtract (0x04, Local0, MODE)
                        }

                        Or (MODE, 0x40, MODE)
                    }
                    Else
                    {
                        And (Arg2, 0x0F, Local0)
                        Store (Match (^DRCT, MEQ, Local0, MTR, 0x00, 0x00),=
 Local1)
                        Store (DerefOf (Index (^PXLM, Local1)), MODE)
                        Or (MODE, 0x20, MODE)
                    }

                    Concatenate (Local7, Local7, Local6)
                    And (Arg2, 0x0F, Local0)
                    Store (Match (^DRCT, MEQ, Local0, MTR, 0x00, 0x00), Loc=
al1)
                    Subtract (0x04, Local1, MODE)
                    Or (MODE, 0x08, MODE)
                    Concatenate (Local6, Local7, Local5)
                    Return (Local5)
                }

                Device (PRIM)
                {
                    Name (_ADR, 0x00)
                    Name (_PSC, 0x00)
                    OperationRegion (HDIO, SystemIO, 0x01F0, 0x08)
                    Field (HDIO, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x01),=20
                        Offset (0x02),=20
                        Offset (0x03),=20
                        Offset (0x04),=20
                        Offset (0x05),=20
                        Offset (0x06),=20
                        HDSL,   8,=20
                        HDCM,   8
                    }

                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Method (_GTM, 0, NotSerialized)
                    {
                        Store ("GTM - Primary Controller", Debug)
                        Return (Buffer (0x14)
                        {
                            0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,=
=20
                            0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,=
=20
                            0x1F, 0x00, 0x00, 0x00
                        })
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store ("STM - Primary Controller", Debug)
                        Store (^^STM (Arg0, Arg1, Arg2), Local0)
                        CreateByteField (Local0, 0x00, TM0)
                        CreateByteField (Local0, 0x01, TM1)
                        CreateByteField (Local0, 0x02, UDC)
                        CreateByteField (Local0, 0x03, AST)
                        CreateByteField (Local0, 0x04, CBT)
                        CreateByteField (Local0, 0x05, U66)
                        Store (TM0, ^^PTM0)
                        Store (TM1, ^^PTM1)
                        Store (UDC, ^^PUDC)
                        Store (AST, ^^PAST)
                        Store (CBT, ^^PCBT)
                        If (U66)
                        {
                            Store (U66, ^^U66E)
                        }

                        Store (0x55, ^^PFTH)
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Primary Master", Debug)
                            Store (^^^GTF0 (^^^PCHE, ^^^PUDC, ^^^PTM0), Loc=
al0)
                            Return (Local0)
                        }

                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            \_SB.PCI0.ISA.HPSS (0x02, 0x00)
                            Sleep (0x03E8)
                            Store (0x03, _PSC)
                        }
                    }
                }

                Device (SECN)
                {
                    Name (_ADR, 0x01)
                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Method (_GTM, 0, NotSerialized)
                    {
                        Store ("GTM - Secondary Controller", Debug)
                        Return (Buffer (0x14)
                        {
                            0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,=
=20
                            0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,=
=20
                            0x1F, 0x00, 0x00, 0x00
                        })
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store ("STM - Secondary Controller", Debug)
                        Store (^^STM (Arg0, Arg1, Arg2), Local0)
                        CreateByteField (Local0, 0x00, TM0)
                        CreateByteField (Local0, 0x01, TM1)
                        CreateByteField (Local0, 0x02, UDC)
                        CreateByteField (Local0, 0x03, AST)
                        CreateByteField (Local0, 0x04, CBT)
                        CreateByteField (Local0, 0x05, U66)
                        Store (TM0, ^^STM0)
                        Store (TM1, ^^STM1)
                        Store (UDC, ^^SUDC)
                        Store (AST, ^^SAST)
                        Store (CBT, ^^SCBT)
                        If (U66)
                        {
                            Store (U66, ^^U66E)
                        }

                        Store (0x55, ^^SFTH)
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Secondary Master", Debug)
                            Store (^^^GTF0 (^^^SCHE, ^^^SUDC, ^^^STM0), Loc=
al0)
                            Return (Local0)
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_PSC, 0x00)
                    }
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x00020000)
                Name (_S3D, 0x02)
            }

            Device (USB2)
            {
                Name (_ADR, 0x000F0000)
                Name (_S3D, 0x02)
                Method (_STA, 0, NotSerialized)
                {
                    If (\_SB.PCI0.ISA.USB2)
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (0x00)
                    }
                }
            }

            Device (MDEM)
            {
                Name (_ADR, 0x00080000)
                Name (_PRW, Package (0x02)
                {
                    0x09,=20
                    0x04
                })
            }

            Device (AUDI)
            {
                Name (_ADR, 0x00060000)
            }

            Device (LAN)
            {
                Name (_ADR, 0x00120000)
                Name (_PRW, Package (0x02)
                {
                    0x09,=20
                    0x05
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (\_SB.ECOK ())
                    {
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        If (Arg0)
                        {
                            Store (0x01, \_SB.PCI0.ISA.EC0.WOLE)
                        }
                        Else
                        {
                            Store (0x00, \_SB.PCI0.ISA.EC0.WOLE)
                        }

                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                    }
                }
            }

            Device (IEEE)
            {
                Name (_ADR, 0x000C0000)
            }

            Device (CBUS)
            {
                Name (_ADR, 0x000A0000)
            }

            Device (MINI)
            {
                Name (_ADR, 0x00090000)
            }

            Device (ISA)
            {
                Name (_ADR, 0x00070000)
                OperationRegion (ISAR, PCI_Config, 0x00, 0x9F)
                Field (ISAR, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x77),=20
                        ,   6,=20
                    MDNE,   1,=20
                    Offset (0x7E),=20
                        ,   7,=20
                    USB2,   1
                }

                Name (_CRS, ResourceTemplate ()
                {
                    IO (Decode16, 0x8004, 0x8004, 0x01, 0x02)
                })
                OperationRegion (MNVS, SystemMemory, 0x1BEFFE1D, 0x10)
                Field (MNVS, AnyAcc, Lock, Preserve)
                {
                    TOOS,   8,=20
                    LIDS,   8,=20
                    ACST,   8,=20
                    TV,     1,=20
                    FIR,    1,=20
                    COMM,   1,=20
                    LPT,    1
                }

                OperationRegion (SMI0, SystemIO, 0x0000FE00, 0x00000002)
                Field (SMI0, AnyAcc, NoLock, Preserve)
                {
                    SMIC,   8
                }

                OperationRegion (SMI1, SystemMemory, 0x1BEFFE2D, 0x00000120)
                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    BCMD,   8,=20
                    DID,    32,=20
                    INFO,   2048
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00),=20
                    Offset (0x05),=20
                    INF,    8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00),=20
                    Offset (0x05),=20
                    STSB,   8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x05),=20
                    PNLR,   32
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x105),=20
                    BDST,   8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x106),=20
                    DKSN,   32
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x10A),=20
                    DKTP,   8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x10B),=20
                    VGAB,   32
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x10F),=20
                    WOLE,   1,=20
                    DISB,   1,=20
                    CPTY,   1,=20
                    FDDS,   1
                }

                Mutex (PSMX, 0x00)
                Method (HPSS, 2, NotSerialized)
                {
                    Acquire (\_SB.PCI0.ISA.PSMX, 0xFFFF)
                    Store (Arg1, STSB)
                    Store (0x80, BCMD)
                    Store (Arg0, DID)
                    Store (Zero, SMIC)
                    Store (STSB, Local0)
                    Release (\_SB.PCI0.ISA.PSMX)
                    Return (Local0)
                }

                Method (QCSS, 1, NotSerialized)
                {
                    Acquire (\_SB.PCI0.ISA.PSMX, 0xFFFF)
                    Store (0x90, BCMD)
                    Store (Arg0, DID)
                    Store (Zero, SMIC)
                    Release (\_SB.PCI0.ISA.PSMX)
                }

                OperationRegion (PUSB, PCI_Config, 0x74, 0x01)
                Field (PUSB, ByteAcc, NoLock, Preserve)
                {
                    PIRU,   4,=20
                    Offset (0x01)
                }

                OperationRegion (PIRX, PCI_Config, 0x48, 0x04)
                Field (PIRX, ByteAcc, NoLock, Preserve)
                {
                    PIRA,   4,=20
                    PIRB,   4,=20
                    PIRC,   4,=20
                    PIRD,   4,=20
                    PIRE,   4,=20
                    PIRF,   4,=20
                    PIRG,   4,=20
                    PIRH,   4
                }

                Name (IPRS, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {3,4,6,10}
                })
                Name (Z000, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {5,7}
                })
                Name (Z001, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {7,11}
                })
                Name (IXLT, Package (0x10)
                {
                    0x00,=20
                    0x0200,=20
                    0x08,=20
                    0x0400,=20
                    0x10,=20
                    0x20,=20
                    0x80,=20
                    0x40,=20
                    0x02,=20
                    0x0800,=20
                    0x00,=20
                    0x1000,=20
                    0x00,=20
                    0x4000,=20
                    0x00,=20
                    0x8000
                })
                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRA)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRA)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIRA, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PI=
RA)
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRB)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z001)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRB)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z001, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIRB, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PI=
RB)
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRC)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRC)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIRC, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PI=
RC)
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRD)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRD)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIRD, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PI=
RD)
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRE)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRE)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIRE, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PI=
RE)
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRF)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z001)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRF)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z001, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIRF, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PI=
RF)
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRG)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRG)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIRG, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PI=
RG)
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRH)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z000)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRH)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z000, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIRH, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PI=
RH)
                    }
                }

                Device (LNKU)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x09)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRU)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRU)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIRU, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PI=
RU)
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        DMA (Compatibility, NotBusMaster, Transfer8_16) {4}
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
                        IRQ (Edge, ActiveHigh, Exclusive) {2}
                    })
                }

                Device (TIME)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IRQ (Edge, ActiveHigh, Exclusive) {0}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x04)
                        IRQ (Edge, ActiveHigh, Exclusive) {8}
                    })
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x0F)
                        IRQ (Edge, ActiveHigh, Exclusive) {13}
                    })
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                    })
                }

                Device (KBC0)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQ (Edge, ActiveHigh, Exclusive) {1}
                    })
                    Name (KBS3, 0x00)
                    Name (_PSC, 0x00)
                    Name (PS2D, 0x044C)
                }

                Device (MSE0)
                {
                    Name (_HID, "SYN0104")
                    Name (_CID, Package (0x03)
                    {
                        0x00012E4F,=20
                        0x02002E4F,=20
                        0x130FD041
                    })
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive) {12}
                    })
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x00B0, 0x00B0, 0x01, 0x04)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x040B, 0x040B, 0x01, 0x01)
                        IO (Decode16, 0x0480, 0x0480, 0x01, 0x10)
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IO (Decode16, 0x04D6, 0x04D6, 0x01, 0x01)
                        IO (Decode16, 0x8000, 0x8000, 0x01, 0x80)
                        IO (Decode16, 0xFF00, 0xFF00, 0x01, 0x02)
                        IO (Decode16, 0x8004, 0x8004, 0x01, 0x02)
                        IO (Decode16, 0xFE00, 0xFE00, 0x01, 0xFF)
                        Memory32Fixed (ReadWrite, 0xD0400000, 0x00001000)
                    })
                }

                Device (MEM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (MSRC, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly, 0x000DC000, 0x00004000)
                        Memory32Fixed (ReadOnly, 0x000EC000, 0x00014000)
                        Memory32Fixed (ReadOnly, 0xFFF80000, 0x00080000)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                Device (SIOD)
                {
                    Name (_HID, EisaId ("PNP0A05"))
                    OperationRegion (SIIO, SystemIO, 0x03F0, 0x02)
                    Field (SIIO, ByteAcc, NoLock, Preserve)
                    {
                        INDX,   8,=20
                        DATA,   8
                    }

                    IndexField (INDX, DATA, ByteAcc, Lock, Preserve)
                    {
                        Offset (0x22),=20
                        CR22,   8,=20
                        Offset (0x30),=20
                        CR30,   8,=20
                        Offset (0x60),=20
                        CR60,   8,=20
                        CR61,   8,=20
                        Offset (0x70),=20
                        CR70,   8,=20
                        Offset (0x74),=20
                        CR74,   8,=20
                        Offset (0xF0),=20
                        CRF0,   8,=20
                        CRF1,   8,=20
                        CRF2,   8,=20
                        Offset (0xF4),=20
                        CRF4,   8,=20
                        CRF5,   8
                    }

                    Mutex (MTIO, 0x00)
                    Method (ENFG, 1, NotSerialized)
                    {
                        Acquire (MTIO, 0xFFFF)
                        Store (0x51, INDX)
                        Store (0x23, INDX)
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                        Store (0x22, INDX)
                        ShiftLeft (0x01, Arg0, Local0)
                        Return (And (DATA, Local0))
                    }

                    Method (EXFG, 0, NotSerialized)
                    {
                        Store (0xBB, INDX)
                        Release (MTIO)
                    }

                    Method (STAX, 1, NotSerialized)
                    {
                        Store (^ENFG (Arg0), Local0)
                        ^EXFG ()
                        If (Local0)
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            If (And (CR30, 0x01))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x0D)
                            }
                        }
                    }

                    Method (DISX, 1, NotSerialized)
                    {
                        ^ENFG (Arg0)
                        And (CR30, 0xFE, CR30)
                        ^EXFG ()
                    }

                    Method (PSCX, 1, NotSerialized)
                    {
                        Store (LAnd (^ENFG (Arg0), And (CR30, 0x01)), Local=
0)
                        ^EXFG ()
                        If (Local0)
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            Return (0x03)
                        }
                    }

                    Method (PS0X, 1, NotSerialized)
                    {
                        Store (^ENFG (Arg0), Local0)
                        And (CR22, Not (Local0), CR22)
                        Or (CR30, 0x01, CR30)
                        ^EXFG ()
                    }

                    Method (PS3X, 1, NotSerialized)
                    {
                        Store (^ENFG (Arg0), Local0)
                        And (CR30, 0xFE, CR30)
                        Or (CR22, Local0, CR22)
                        ^EXFG ()
                    }

                    Name (RSRA, ResourceTemplate ()
                    {
                        IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                        IRQNoFlags () {4}
                    })
                    Method (CRSA, 1, NotSerialized)
                    {
                        CreateWordField (RSRA, 0x02, IOAL)
                        CreateWordField (RSRA, 0x04, IOAH)
                        CreateByteField (RSRA, 0x07, LENA)
                        CreateWordField (RSRA, 0x09, INTX)
                        ^ENFG (Arg0)
                        Store (Add (ShiftLeft (CR60, 0x08), CR61), Local0)
                        Store (Local0, IOAL)
                        Store (Local0, IOAH)
                        If (And (Local0, 0x04))
                        {
                            Store (0x04, Local1)
                        }
                        Else
                        {
                            Store (0x08, Local1)
                        }

                        Store (Local1, LENA)
                        Store (ShiftLeft (0x01, CR70), INTX)
                        ^EXFG ()
                        Return (RSRA)
                    }

                    Method (SRSA, 2, NotSerialized)
                    {
                        Store (Arg0, RSRA)
                        CreateWordField (RSRA, 0x02, IOAL)
                        CreateWordField (RSRA, 0x09, INTX)
                        ^ENFG (Arg1)
                        And (IOAL, 0xFF, CR61)
                        ShiftRight (IOAL, 0x08, CR60)
                        FindSetRightBit (INTX, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, CR70)
                        ^EXFG ()
                    }

                    Name (RSRB, ResourceTemplate ()
                    {
                        IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                        IRQNoFlags () {4}
                        DMA (Compatibility, NotBusMaster, Transfer8) {2}
                    })
                    Method (CRSB, 1, NotSerialized)
                    {
                        CreateWordField (RSRB, 0x02, IOBL)
                        CreateWordField (RSRB, 0x04, IOBH)
                        CreateByteField (RSRB, 0x07, LENB)
                        CreateWordField (RSRB, 0x09, INTY)
                        CreateByteField (RSRB, 0x0C, DMAY)
                        ^ENFG (Arg0)
                        Store (Add (ShiftLeft (CR60, 0x08), CR61), Local0)
                        Store (Local0, IOBL)
                        Store (Local0, IOBH)
                        If (And (Local0, 0x04))
                        {
                            Store (0x04, Local1)
                        }
                        Else
                        {
                            Store (0x08, Local1)
                        }

                        Store (Local1, LENB)
                        Store (ShiftLeft (0x01, CR70), INTY)
                        Store (ShiftLeft (0x01, CR74), DMAY)
                        ^EXFG ()
                        Return (RSRB)
                    }

                    Method (SRSB, 2, NotSerialized)
                    {
                        Store (Arg0, RSRB)
                        CreateWordField (RSRB, 0x02, IOBL)
                        CreateWordField (RSRB, 0x09, INTY)
                        CreateByteField (RSRB, 0x0C, DMAY)
                        ^ENFG (Arg1)
                        And (IOBL, 0xFF, CR61)
                        ShiftRight (IOBL, 0x08, CR60)
                        FindSetRightBit (INTY, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, CR70)
                        FindSetRightBit (DMAY, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, CR74)
                        ^EXFG ()
                    }

                    Name (RSRC, ResourceTemplate ()
                    {
                        IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                        IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                        IRQNoFlags () {6}
                        DMA (Compatibility, NotBusMaster, Transfer8) {2}
                    })
                    Method (CRSC, 1, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x02, IO1L)
                        CreateWordField (RSRC, 0x04, IO1H)
                        CreateByteField (RSRC, 0x07, LEN1)
                        CreateWordField (RSRC, 0x0A, IO2L)
                        CreateWordField (RSRC, 0x0C, IO2H)
                        CreateByteField (RSRC, 0x0F, LEN2)
                        CreateWordField (RSRC, 0x11, IRQX)
                        CreateByteField (RSRC, 0x14, DMAX)
                        ^ENFG (Arg0)
                        Store (Add (ShiftLeft (CR60, 0x08), CR61), Local0)
                        Store (Local0, IO1L)
                        Store (Local0, IO1H)
                        Store (0x0400, Local1)
                        If (And (Local0, 0x04))
                        {
                            Store (0x04, Local2)
                        }
                        Else
                        {
                            If (And (Local0, 0x08))
                            {
                                Store (0x08, Local2)
                            }
                            Else
                            {
                                Store (0x06, Local2)
                                Store (0x07, Local1)
                            }
                        }

                        Add (Local0, Local1, Local1)
                        Store (Local1, IO2L)
                        Store (Local1, IO2H)
                        Store (Local2, LEN1)
                        If (LEqual (Local1, 0x03F7))
                        {
                            Store (0x01, LEN2)
                        }
                        Else
                        {
                            Store (Local2, LEN2)
                        }

                        Store (ShiftLeft (0x01, CR70), IRQX)
                        Store (ShiftLeft (0x01, CR74), DMAX)
                        ^EXFG ()
                        Return (RSRC)
                    }

                    Method (SRSC, 2, NotSerialized)
                    {
                        Store (Arg0, RSRC)
                        CreateWordField (RSRC, 0x02, IO1L)
                        CreateWordField (RSRC, 0x11, IRQX)
                        CreateByteField (RSRC, 0x14, DMAX)
                        ^ENFG (Arg1)
                        And (IO1L, 0xFF, CR61)
                        ShiftRight (IO1L, 0x08, CR60)
                        FindSetRightBit (IRQX, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, CR70)
                        FindSetRightBit (DMAX, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, CR74)
                        ^EXFG ()
                    }

                    Device (FDC)
                    {
                        Name (_HID, EisaId ("PNP0700"))
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (^^STAX (0x00))
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ^^DISX (0x00)
                        }

                        Method (_PSC, 0, NotSerialized)
                        {
                            Return (^^PSCX (0x00))
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            ^^PS0X (0x00)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            ^^PS3X (0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Return (^^CRSC (0x00))
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            ^^SRSC (Arg0, 0x00)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                        })
                    }

                    Device (LPT)
                    {
                        Name (TYPE, 0x00)
                        Method (IECP, 0, NotSerialized)
                        {
                            ENFG (0x03)
                            And (CRF0, 0x07, ^TYPE)
                            EXFG ()
                            Return (And (^TYPE, 0x02))
                        }

                        Method (_HID, 0, NotSerialized)
                        {
                            If (IECP ())
                            {
                                Return (0x0104D041)
                            }
                            Else
                            {
                                Return (0x0004D041)
                            }
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            Return (^^STAX (0x03))
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ^^DISX (0x03)
                        }

                        Method (_PSC, 0, NotSerialized)
                        {
                            Return (^^PSCX (0x03))
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            ^^PS0X (0x03)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            ^^PS3X (0x03)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            If (IECP ())
                            {
                                Return (^^CRSC (0x03))
                            }
                            Else
                            {
                                Return (^^CRSA (0x03))
                            }
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            If (IECP ())
                            {
                                ^^SRSC (Arg0, 0x03)
                            }
                            Else
                            {
                                ^^SRSA (Arg0, 0x03)
                            }
                        }

                        Name (PRSA, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {7}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {5}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {7}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {5}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                            }
                            EndDependentFn ()
                        })
                        Name (PRSB, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {7}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {5}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {7}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {5}
                            }
                            EndDependentFn ()
                        })
                        Name (PRSC, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)
                        {
                            If (IECP ())
                            {
                                Return (^PRSC)
                            }
                            Else
                            {
                                If (LEqual (0x01, ^TYPE))
                                {
                                    Return (^PRSB)
                                }
                                Else
                                {
                                    Return (^PRSA)
                                }
                            }
                        }
                    }

                    Name (CPRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        EndDependentFn ()
                    })
                    Device (COMA)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (^^STAX (0x04))
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ^^DISX (0x04)
                        }

                        Method (_PSC, 0, NotSerialized)
                        {
                            Return (^^PSCX (0x04))
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            ^^PS0X (0x04)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            ^^PS3X (0x04)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Return (^^CRSA (0x04))
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            ^^SRSA (Arg0, 0x04)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (CPRS)
                        }
                    }

                    Method (IFIR, 0, NotSerialized)
                    {
                        ENFG (0x05)
                        And (CR30, 0x80, Local0)
                        EXFG ()
                        Return (Local0)
                    }

                    Device (IRDA)
                    {
                        Name (_HID, EisaId ("PNP0510"))
                        Method (_STA, 0, NotSerialized)
                        {
                            If (^^IFIR ())
                            {
                                Return (0x00)
                            }
                            Else
                            {
                                Return (^^STAX (0x05))
                            }
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ^^DISX (0x05)
                        }

                        Method (_PSC, 0, NotSerialized)
                        {
                            Return (^^PSCX (0x05))
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            ^^PS0X (0x05)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            ^^PS3X (0x05)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Return (^^CRSA (0x05))
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            ^^SRSA (Arg0, 0x05)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (CPRS)
                        }
                    }

                    Device (FIR)
                    {
                        Name (_HID, EisaId ("ALI5123"))
                        Name (_CID, 0x1005D041)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (^^IFIR ())
                            {
                                Return (^^STAX (0x05))
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ^^DISX (0x05)
                        }

                        Method (_PSC, 0, NotSerialized)
                        {
                            Return (^^PSCX (0x05))
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            ^^PS0X (0x05)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            ^^PS3X (0x05)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Return (^^CRSB (0x05))
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            ^^SRSB (Arg0, 0x05)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8=
) {3}
                            }
                            EndDependentFn ()
                        })
                    }
                }

                Device (EC0)
                {
                    Name (TTAC, 0x00)
                    Name (TTDC, 0x06)
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Name (_GPE, 0x18)
                    Name (SEL0, 0xF0)
                    Name (BFLG, 0x00)
                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, ECEN)
                            Acquire (MUT1, 0xFFFF)
                            Store (ADP, Local0)
                            Release (MUT1)
                            If (Local0)
                            {
                                Store (0x00, \_SB.PCI0.PMU.CRUN)
                                If (LNot (LEqual (\_SB.PCI0.ISA.EC0.TTAC, 0=
x00)))
                                {
                                    Store (\_SB.PCI0.ISA.EC0.TTAC, TRDC)
                                    Store (0x01, TREN)
                                }
                                Else
                                {
                                    Store (0x00, TRDC)
                                    Store (0x00, TREN)
                                }
                            }
                            Else
                            {
                                Store (0x01, \_SB.PCI0.PMU.CRUN)
                                If (0x00)
                                {
                                    Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
                                    Store (0x01, TREN)
                                }
                            }
                        }
                    }

                    OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
                    Field (ERAM, ByteAcc, Lock, Preserve)
                    {
                        Offset (0x04),=20
                        CMCM,   8,=20
                        CMD1,   8,=20
                        CMD2,   8,=20
                        CMD3,   8,=20
                        Offset (0x18),=20
                        SMPR,   8,=20
                        SMST,   8,=20
                        SMAD,   8,=20
                        SMCM,   8,=20
                        SMD0,   256,=20
                        BCNT,   8,=20
                        SMAA,   8,=20
                        S1D0,   8,=20
                        S1D1,   8,=20
                        SM2A,   8,=20
                        S2D0,   8,=20
                        S2D1,   8,=20
                        SM3A,   8,=20
                        LIDS,   1,=20
                        DV1S,   1,=20
                        EXFD,   1,=20
                        RFSW,   1,=20
                            ,   1,=20
                        CRTS,   1,=20
                        SLPS,   1,=20
                        DCKS,   1,=20
                        EJBS,   1,=20
                            ,   1,=20
                            ,   1,=20
                            ,   1,=20
                            ,   1,=20
                            ,   1,=20
                        DV2S,   1,=20
                        DV3S,   1,=20
                        WK10,   16,=20
                        EVTP,   16,=20
                        BTM3,   8,=20
                        DCID,   8,=20
                        DPWR,   1,=20
                        UDR0,   1,=20
                        UDR5,   1,=20
                        EQBF,   1,=20
                        LDDS,   1,=20
                        CRST,   1,=20
                        DCWT,   1,=20
                        QVCC,   1,=20
                        HP4D,   8,=20
                        WAKP,   16,=20
                        POLL,   1,=20
                        ADP,    1,=20
                        ALRT,   1,=20
                        B1WE,   1,=20
                        B1WS,   1,=20
                        B2WE,   1,=20
                        B2WS,   1,=20
                        BWAK,   1,=20
                        PWRE,   1,=20
                        ALLB,   1,=20
                        AUXB,   1,=20
                        S2DR,   1,=20
                        F1B4,   1,=20
                        F1B5,   1,=20
                        F1B6,   1,=20
                        RSMA,   1,=20
                        S1LD,   1,=20
                        S2LD,   1,=20
                        ACWR,   1,=20
                        PTSV,   3,=20
                        PMEE,   1,=20
                        ENCB,   1,=20
                        F3B0,   1,=20
                        F3B1,   1,=20
                        RFLD,   1,=20
                        F3B3,   1,=20
                        SW8B,   1,=20
                        WOLE,   1,=20
                        WORE,   1,=20
                        S4FG,   1,=20
                        TMSS,   2,=20
                        OSMD,   1,=20
                        F4B3,   1,=20
                        BANK,   4,=20
                        CTMP,   8,=20
                        S2DC,   8,=20
                        BPD,    8,=20
                        BT1I,   16,=20
                        BT1C,   16,=20
                        BT1V,   16,=20
                        BT1S,   8,=20
                        BT2I,   16,=20
                        BT2C,   16,=20
                        BT2V,   16,=20
                        BT2S,   8,=20
                        Q8CF,   1,=20
                            ,   3,=20
                        KLED,   1,=20
                        Offset (0x67),=20
                        TTMP,   8,=20
                        HPCB,   8,=20
                        R69F,   2,=20
                            ,   1,=20
                        Offset (0x6A),=20
                        BTEC,   8,=20
                        UBDM,   4,=20
                        UBPC,   3,=20
                        Offset (0x6C),=20
                        BTCS,   8,=20
                        BMDL,   8,=20
                        CBDM,   4,=20
                        CBPC,   3,=20
                        Offset (0x6F),=20
                        HP6F,   8,=20
                        HP70,   8,=20
                        TRDV,   8,=20
                        RSMT,   16,=20
                        PWSL,   8,=20
                        PWSM,   8,=20
                            ,   1,=20
                            ,   1,=20
                        PREF,   1,=20
                        UPP1,   1,=20
                        UPP2,   1,=20
                            ,   1,=20
                            ,   1,=20
                        BTOF,   1,=20
                        SUSB,   1,=20
                        SUSC,   1,=20
                        CPWR,   1,=20
                        CBTN,   1,=20
                        FAN,    1,=20
                            ,   1,=20
                            ,   1,=20
                        S4IN,   1,=20
                        FANL,   16,=20
                        QU7A,   8,=20
                        QU7B,   8,=20
                        QU7C,   8,=20
                        QU7D,   8,=20
                        QU7E,   8,=20
                        QU7F,   8
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C),=20
                        SMW0,   16
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C),=20
                        SMB0,   8
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C),=20
                        FLD0,   64
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C),=20
                        FLD1,   128
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C),=20
                        FLD2,   192
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C),=20
                        FLD3,   256
                    }

                    Mutex (CMUT, 0x00)
                    Method (CMC2, 3, NotSerialized)
                    {
                        Acquire (CMUT, 0xFFFF)
                        Store (Arg2, CMD2)
                        Store (Arg1, CMD1)
                        Store (Arg0, CMCM)
                        While (CMCM) {}
                        Release (CMUT)
                    }

                    Mutex (MUT0, 0x00)
                    Mutex (MUT1, 0x00)
                    Method (SMRD, 4, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        If (LNot (LEqual (Arg0, 0x07)))
                        {
                            If (LNot (LEqual (Arg0, 0x09)))
                            {
                                If (LNot (LEqual (Arg0, 0x0B)))
                                {
                                    Return (0x19)
                                }
                            }
                        }

                        Acquire (MUT0, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Decrement (Local0)
                            }
                        }

                        If (Local0)
                        {
                            Store (And (Local1, 0x1F), Local0)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x07))
                            {
                                Store (SMB0, Arg3)
                            }

                            If (LEqual (Arg0, 0x09))
                            {
                                Store (SMW0, Arg3)
                            }

                            If (LEqual (Arg0, 0x0B))
                            {
                                Store (BCNT, Local3)
                                ShiftRight (0x0100, 0x03, Local2)
                                If (LGreater (Local3, Local2))
                                {
                                    Store (Local2, Local3)
                                }

                                If (LLess (Local3, 0x09))
                                {
                                    Store (FLD0, Local2)
                                }
                                Else
                                {
                                    If (LLess (Local3, 0x11))
                                    {
                                        Store (FLD1, Local2)
                                    }
                                    Else
                                    {
                                        If (LLess (Local3, 0x19))
                                        {
                                            Store (FLD2, Local2)
                                        }
                                        Else
                                        {
                                            Store (FLD3, Local2)
                                        }
                                    }
                                }

                                Increment (Local3)
                                Store (Buffer (Local3) {}, Local4)
                                Decrement (Local3)
                                Store (Zero, Local5)
                                While (LGreater (Local3, Local5))
                                {
                                    GBFE (Local2, Local5, RefOf (Local6))
                                    PBFE (Local4, Local5, Local6)
                                    Increment (Local5)
                                }

                                PBFE (Local4, Local5, 0x00)
                                Store (Local4, Arg3)
                            }
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (SMWR, 4, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        If (LNot (LEqual (Arg0, 0x06)))
                        {
                            If (LNot (LEqual (Arg0, 0x08)))
                            {
                                If (LNot (LEqual (Arg0, 0x0A)))
                                {
                                    Return (0x19)
                                }
                            }
                        }

                        Acquire (MUT0, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            If (LEqual (Arg0, 0x06))
                            {
                                Store (Arg3, SMB0)
                            }

                            If (LEqual (Arg0, 0x08))
                            {
                                Store (Arg3, SMW0)
                            }

                            If (LEqual (Arg0, 0x0A))
                            {
                                Store (Arg3, SMD0)
                            }

                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Decrement (Local0)
                            }
                        }

                        If (Local0)
                        {
                            Store (And (Local1, 0x1F), Local0)
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Name (ACFL, 0x00)
                    Method (SMSL, 0, NotSerialized)
                    {
                        Store ("CMBatt - SMSL", Debug)
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x09, 0x14, 0x01,=
 RefOf (Local0))))
                        {
                            Store (Local0, SEL0)
                            Store (SEL0, Debug)
                            If (LEqual (ALRT, 0x01))
                            {
                                \_SB.BAT1.IVBI ()
                                \_SB.BAT1.IVBS ()
                                Store (0x00, ALRT)
                            }

                            Store (\_SB.ACAD.CHAC (SEL0), Local1)
                            Store (\_SB.BAT1.CHBP (SEL0), Local2)
                            Or (SEL0, 0x0FFF, Local0)
                            SMWR (0x08, 0x14, 0x01, Local0)
                            If (LAnd (Local1, \_SB.ACAD.ACP))
                            {
                                Store ("CMBatt - Notify(ACAD,0x80): AC_Inse=
rted", Debug)
                                Store (0x00, \_SB.PCI0.PMU.CRUN)
                                If (LNot (LEqual (\_SB.PCI0.ISA.EC0.TTAC, 0=
x00)))
                                {
                                    Store (\_SB.PCI0.ISA.EC0.TTAC, TRDC)
                                    Store (0x01, TREN)
                                }
                                Else
                                {
                                    Store (0x00, TRDC)
                                    Store (0x00, TREN)
                                }

                                Notify (\_SB.ACAD, 0x80)
                                Store (0x02, ACFL)
                            }

                            If (And (0x04, Local2))
                            {
                                \_SB.BAT1.B1CK ()
                            }

                            If (And (0x02, Local2))
                            {
                                \_SB.BAT1.B1ST ()
                            }

                            If (And (0x01, Local2))
                            {
                                \_SB.BAT1.B1IF ()
                            }

                            If (LAnd (Local1, LNot (\_SB.ACAD.ACP)))
                            {
                                Store ("CMBatt - Notify(ACAD, 0x80): AC_Rem=
oved", Debug)
                                Store (0x01, \_SB.PCI0.PMU.CRUN)
                                If (0x00)
                                {
                                    Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
                                    Store ("AC remove! Set Throttle Duty Cy=
cle ---: ", Debug)
                                    Store (TRDC, Debug)
                                    Store (0x01, TREN)
                                }

                                Notify (\_SB.ACAD, 0x80)
                                Store (0x01, ACFL)
                            }
                        }

                        Store (0x3C, Local4)
                        If (\_SB.BAT1.REPT)
                        {
                            Store (0x02, Local4)
                        }

                        If (BFLG)
                        {
                            Store (0x01, Local5)
                            While (LNot (And (BFLG, 0x01)))
                            {
                                Increment (Local5)
                                ShiftRight (BFLG, 0x01, BFLG)
                            }

                            ShiftRight (BFLG, 0x01, BFLG)
                            If (LGreater (Local4, Local5))
                            {
                                Store (Local5, Local4)
                            }
                        }

                        Store (Local4, BPD)
                        BPOL ()
                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                        If (ACFL)
                        {
                            Decrement (ACFL)
                            Store (\_SB.PCI0.ISA.HPSS (0x12, ACFL), Local0)
                            CMC2 (0xC4, Local0, 0x82)
                            Notify (HPCI, 0x8A)
                            Store (0x00, ACFL)
                            Store (0x01, \_SB.ACCG)
                            Notify (\_TZ.THRM, 0x80)
                        }

                        Return (0x00)
                    }

                    Name (PSTA, 0x00)
                    Method (CPOL, 0, NotSerialized)
                    {
                        If (LEqual (PSTA, 0x00))
                        {
                            If (ECOK ())
                            {
                                BPOL ()
                                Store (0x01, PSTA)
                            }
                        }
                    }

                    Method (BPOL, 0, NotSerialized)
                    {
                        Store (0x01, POLL)
                    }

                    Name (PQ8A, 0x00)
                    Method (_Q09, 0, NotSerialized)
                    {
                        Store ("QUERY_09", Debug)
                        SMSL ()
                        If (\_SB.S4WF)
                        {
                            Store (0x00, \_SB.S4WF)
                            \_SB.PCI0.ISA.EC0._Q8D ()
                        }
                    }

                    Method (_Q10, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0.ISA.HPCI, 0x90)
                    }

                    Method (_Q11, 0, NotSerialized)
                    {
                        If (ACWR)
                        {
                            Notify (\_SB.PCI0.ISA.HPCI, 0x91)
                        }
                        Else
                        {
                            Notify (\_SB.PCI0.ISA.HPCI, 0x93)
                        }
                    }

                    Method (_Q12, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0.ISA.HPCI, 0x92)
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        Store ("QUERY_20", Debug)
                        If (And (SMST, 0x40))
                        {
                            Store (SMAA, Local0)
                            If (LEqual (Local0, 0x14))
                            {
                                And (SMST, 0xBF, SMST)
                                If (PWRE)
                                {
                                    Store ("CMBatt - PwrEvent", Debug)
                                    Store (0x00, PWRE)
                                    Store (0x12, BFLG)
                                    Store (0x00, BPD)
                                    BPOL ()
                                }
                            }
                        }
                    }

                    Method (_Q03, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.AGPB.VGA.DISW, 0x00))
                        {
                            \_SB.PCI0.AGPB.VGA.DRUL (0x01)
                        }
                        Else
                        {
                            If (LEqual (\_SB.PCI0.AGPB.VGA.DISW, 0x01))
                            {
                                \_SB.PCI0.ISA.HPSS (0x01, 0x00)
                            }
                        }
                    }

                    Method (_Q04, 0, NotSerialized)
                    {
                        Store ("Q04 - Fn+F12 Pressed! --- Hibernation ---",=
 Debug)
                        Notify (\_SB.PCI0.ISA.HPCI, 0x86)
                    }

                    Method (_Q0A, 0, NotSerialized)
                    {
                        Store ("Brightness Down: _Q0A", Debug)
                        Store (\_SB.PCI0.ISA.HPSS (0x08, 0x00), Local0)
                        CMC2 (0xC4, Local0, 0x82)
                        Notify (HPCI, 0x8A)
                    }

                    Method (_Q0B, 0, NotSerialized)
                    {
                        Store ("Brightness Up: _Q0B", Debug)
                        Store (\_SB.PCI0.ISA.HPSS (0x08, 0x01), Local0)
                        CMC2 (0xC4, Local0, 0x82)
                        Notify (HPCI, 0x8A)
                    }

                    Method (_Q80, 0, NotSerialized)
                    {
                        Store ("THERM: _Q80 - Thermal Change", Debug)
                        Store ("Notify _TZ.THRM , 0x80", Debug)
                        Notify (\_TZ.THRM, 0x80)
                    }

                    Method (_Q8B, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0.ISA.HPCI, 0x8B)
                    }

                    Method (_Q8C, 0, NotSerialized)
                    {
                        If (ECOK ())
                        {
                            Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                            Store (TRDV, Local0)
                            Store (\_SB.PCI0.ISA.EC0.ADP, Local1)
                            Store (0x00, Q8CF)
                            Release (\_SB.PCI0.ISA.EC0.MUT1)
                            Store ("_Q8C:Throttle Duty Cycle :", Debug)
                            Store (Local0, Debug)
                            Store ("Power Consumption Value :", Debug)
                            DBGS ("_Q8C::Power Consumption Value ")
                            Store (Local1, Debug)
                            If (Local1)
                            {
                                Store (Local0, TTAC)
                            }
                            Else
                            {
                                Store (Local0, TTDC)
                            }

                            Store (Local0, TRDC)
                            If (LNot (Local0))
                            {
                                Store (0x00, TREN)
                            }
                            Else
                            {
                                Store (0x01, TREN)
                            }

                            Store (0x00, Q8CF)
                            Store (0x01, ACCG)
                            Notify (\_TZ.THRM, 0x80)
                        }
                    }

                    Method (_Q8D, 0, NotSerialized)
                    {
                        Store ("_Q8D:Port Replicator Event :", Debug)
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        Store (PREF, Local0)
                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                        If (Not (LEqual (\_SB.PRCT, Local0)))
                        {
                            Store (Local0, \_SB.PRCT)
                            If (LEqual (\_SB.PRCT, 0x01))
                            {
                                Store (">>> Docking Plug In ! <<<", Debug)
                            }
                            Else
                            {
                                Store (">>> Docking Plug Out ! <<<", Debug)
                            }
                        }
                    }

                    Method (_Q8E, 0, NotSerialized)
                    {
                        SMSL ()
                        Notify (\_SB.BAT1, 0x80)
                    }

                    Method (_Q29, 0, NotSerialized)
                    {
                        Store ("QUERY_29", Debug)
                        If (ECOK ())
                        {
                            If (And (PQ8A, 0x01))
                            {
                                And (PQ8A, Not (0x01), PQ8A)
                                Notify (\_SB.PCI0.ISA.HPCI, 0x86)
                            }
                        }
                    }
                }

                Device (HPCI)
                {
                    Name (_HID, EisaId ("HWPC209"))
                    Name (Z002, 0x00)
                    Name (Z003, 0x00)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Method (STAT, 1, NotSerialized)
                    {
                        Store (Arg0, Z002)
                    }

                    Method (GKBL, 0, NotSerialized)
                    {
                        Return (0x1B)
                    }

                    Method (GDCP, 0, NotSerialized)
                    {
                        Return (0x0033000F)
                    }

                    Method (GDBT, 0, NotSerialized)
                    {
                        Return (\_SB.PCI0.ISA.HPSS (0x08, 0x10))
                    }

                    Method (SDBT, 1, NotSerialized)
                    {
                        If (ECOK ())
                        {
                            Store (\_SB.PCI0.ISA.HPSS (0x08, Or (0x20, And =
(Arg0, 0x0F))), Local0)
                            \_SB.PCI0.ISA.EC0.CMC2 (0xC4, Local0, 0x82)
                        }
                    }

                    Method (GADP, 0, NotSerialized)
                    {
                        Return (\_SB.PCI0.ISA.HPSS (0x0F, 0x00))
                    }

                    Method (SADP, 1, NotSerialized)
                    {
                        And (Arg0, 0x01, \_SB.PCI0.AGPB.VGA.LCD._DGS)
                        ShiftRight (And (Arg0, 0x02), 0x01, \_SB.PCI0.AGPB.=
VGA.CRT._DGS)
                        ShiftRight (And (Arg0, 0x04), 0x02, \_SB.PCI0.AGPB.=
VGA.TV._DGS)
                        If (LEqual (\_SB.PCI0.AGPB.VGA.DISW, 0x00))
                        {
                            \_SB.PCI0.AGPB.VGA.DRUL (0x04)
                        }
                        Else
                        {
                            If (LEqual (\_SB.PCI0.AGPB.VGA.DISW, 0x01))
                            {
                                HPSS (0x01, 0x00)
                            }
                        }
                    }

                    Method (TGAD, 0, NotSerialized)
                    {
                        \_SB.PCI0.ISA.EC0._Q03 ()
                    }

                    Method (GFPR, 0, NotSerialized)
                    {
                        Acquire (\_SB.PCI0.ISA.PSMX, 0xFFFF)
                        Store (0x80, \_SB.PCI0.ISA.BCMD)
                        Store (0x14, \_SB.PCI0.ISA.DID)
                        Store (Zero, \_SB.PCI0.ISA.SMIC)
                        Store (\_SB.PCI0.ISA.PNLR, Local0)
                        Release (\_SB.PCI0.ISA.PSMX)
                        Return (Local0)
                    }

                    Method (GTVR, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.ISA.HPSS (0x10, 0x00), Local1)
                        If (Local1)
                        {
                            Store (0x02580320, Local0)
                        }
                        Else
                        {
                            Store (0x01E00280, Local0)
                        }

                        Return (Local0)
                    }

                    Method (SRFL, 1, NotSerialized)
                    {
                        If (Arg0)
                        {
                            Store (One, \_SB.PCI0.ISA.EC0.RFLD)
                        }
                        Else
                        {
                            Store (Zero, \_SB.PCI0.ISA.EC0.RFLD)
                        }
                    }

                    Method (GRFI, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.ISA.HPSS (0x17, 0x00), Local0)
                        If (LEqual (Local0, 0x01))
                        {
                            Return (0x01)
                        }

                        If (LEqual (Local0, 0x02))
                        {
                            Return (0x03)
                        }

                        Return (0x00)
                    }

                    Method (GSBI, 0, NotSerialized)
                    {
                        Store ("USB\\VID_0A12&PID_0001", Local0)
                        Return (Local0)
                    }

                    Method (GSBS, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x00))
                        {
                            Store (\_SB.PCI0.ISA.HPSS (0x17, 0x00), Local1)
                            Store (\_SB.PCI0.ISA.EC0.SW8B, Local0)
                            If (LEqual (Local1, 0x02))
                            {
                                If (Local0)
                                {
                                    Return (0x03)
                                }
                                Else
                                {
                                    Return (0x01)
                                }
                            }
                        }

                        Return (0x00)
                    }

                    Method (SRFP, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x00))
                        {
                            If (LEqual (Arg1, 0x01))
                            {
                                Store (One, \_SB.PCI0.ISA.EC0.SW8B)
                            }
                            Else
                            {
                                Store (Zero, \_SB.PCI0.ISA.EC0.SW8B)
                            }
                        }
                    }

                    Name (MDLS, 0x04)
                    Name (DEVS, Package (0x0C)
                    {
                        "01KT",=20
                        "BQ2060",=20
                        "4x2",=20
                        "02KT",=20
                        "BQ2060",=20
                        "4x2",=20
                        "03KT",=20
                        "BQ2060",=20
                        "8x1",=20
                        "04KT",=20
                        "BQ2060",=20
                        "4x2"
                    })
                    Method (GBID, 1, NotSerialized)
                    {
                        Store (0x00, Local0)
                        While (LGreater (MDLS, Local0))
                        {
                            Add (ShiftLeft (Local0, 0x01), Local0, Local1)
                            Store (S2BF (DerefOf (Index (DEVS, Local1))), L=
ocal2)
                            If (BCMP (Arg0, Local2))
                            {
                                Return (Local0)
                            }

                            Increment (Local0)
                        }

                        Return (0xFF)
                    }

                    Method (BCMP, 2, NotSerialized)
                    {
                        Store (SizeOf (Arg0), Local0)
                        If (LNot (LEqual (SizeOf (Arg1), Local0)))
                        {
                            Return (Zero)
                        }

                        Store (0x00, Local1)
                        While (LGreater (Local0, Local1))
                        {
                            Store (DerefOf (Index (Arg0, Local1)), Local2)
                            Store (DerefOf (Index (Arg1, Local1)), Local3)
                            If (LNot (LEqual (Local2, Local3)))
                            {
                                Return (Zero)
                            }

                            Increment (Local1)
                        }

                        Return (Ones)
                    }

                    Method (SBDN, 1, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Store (0xFF, \_SB.PCI0.ISA.EC0.BMDL)
                            Store (0x06, \_SB.PCI0.ISA.EC0.BTEC)
                        }
                        Else
                        {
                            Store (Arg0, \_SB.PCI0.ISA.EC0.UBDM)
                            Store (DerefOf (Index (\_SB.BAT1.PBIF, 0x09)), =
Local0)
                            Store (\_SB.PCI0.ISA.HPCI.GBID (Local0), Local1)
                            Store (Local1, \_SB.PCI0.ISA.EC0.BMDL)
                            If (LEqual (Local1, 0xFF))
                            {
                                Store (0x06, \_SB.PCI0.ISA.EC0.BTEC)
                            }
                        }
                    }

                    Method (GBDN, 0, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Store (\_SB.PCI0.ISA.EC0.CBDM, Local0)
                        Store (Local0, Debug)
                        Return (Local0)
                    }

                    Method (GBPN, 0, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Store (And (0x0F, \_SB.PCI0.ISA.EC0.SEL0), Local0)
                        Store (Local0, Debug)
                        Return (Local0)
                    }

                    Method (SBPC, 1, NotSerialized)
                    {
                        If (ECOK ())
                        {
                            Store (Arg0, \_SB.PCI0.ISA.EC0.UBPC)
                        }
                    }

                    Method (GBPC, 0, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Store (\_SB.PCI0.ISA.EC0.CBPC, Local0)
                        Store (Local0, Debug)
                        Return (Local0)
                    }

                    Method (GBEC, 0, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Store (\_SB.PCI0.ISA.EC0.BTEC, Local0)
                        Store (0x00, \_SB.PCI0.ISA.EC0.BTEC)
                        Store (Local0, Debug)
                        Return (Local0)
                    }

                    Method (GBCS, 0, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Store (\_SB.PCI0.ISA.EC0.BTCS, Debug)
                        Return (\_SB.PCI0.ISA.EC0.BTCS)
                    }

                    Method (GBSD, 0, NotSerialized)
                    {
                        Name (PBSD, Package (0x08)
                        {
                            "",=20
                            "",=20
                            "",=20
                            "",=20
                            "",=20
                            0xFFFF,=20
                            0xFFFF,=20
                            0xFFFF
                        })
                        If (LNot (ECOK ()))
                        {
                            Return (PBSD)
                        }

                        Store (\_SB.PCI0.ISA.EC0.BMDL, Local0)
                        If (LNot (LLess (Local0, MDLS)))
                        {
                            Return (PBSD)
                        }

                        Add (ShiftLeft (Local0, 0x01), Local0, Local0)
                        Store (\_SB.BAT1.PBIF, Local1)
                        Store (DerefOf (Index (Local1, 0x0C)), Index (PBSD,=
 0x00))
                        Store (DerefOf (Index (DEVS, Add (Local0, 0x01))), =
Local2)
                        Store (Local2, Index (PBSD, 0x01))
                        Store (DerefOf (Index (DEVS, Local0)), Local2)
                        Store (Local2, Index (PBSD, 0x02))
                        Store (DerefOf (Index (Local1, 0x0B)), Index (PBSD,=
 0x03))
                        Store (DerefOf (Index (DEVS, Add (Local0, 0x02))), =
Local2)
                        Store (Local2, Index (PBSD, 0x04))
                        Store (\_SB.BAT1.BATS, Index (PBSD, 0x05))
                        Store (DerefOf (Index (Local1, 0x04)), Index (PBSD,=
 0x06))
                        Store (DerefOf (Index (Local1, 0x01)), Index (PBSD,=
 0x07))
                        Store (PBSD, Debug)
                        Return (PBSD)
                    }

                    Method (GBHD, 0, NotSerialized)
                    {
                        Name (DBHD, Package (0x03)
                        {
                            0xFFFF,=20
                            0xFFFF,=20
                            0xFFFF
                        })
                        If (LNot (ECOK ()))
                        {
                            Return (DBHD)
                        }

                        Store (\_SB.BAT1.PBHD, Local0)
                        Store (Local0, Debug)
                        Return (Local0)
                    }

                    Name (DCNT, 0x00)
                    Method (GBDD, 0, NotSerialized)
                    {
                        Name (PBDD, Package (0x03)
                        {
                            0xFFFF,=20
                            0xFFFF,=20
                            0xFFFF
                        })
                        If (LNot (ECOK ()))
                        {
                            Return (PBDD)
                        }

                        Increment (DCNT)
                        If (LEqual (DCNT, 0x14))
                        {
                            Store (0x00, DCNT)
                        }

                        Store (\_SB.BAT1.BATI, Index (PBDD, 0x00))
                        If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x09, 0x16, 0x0F,=
 RefOf (Local5))))
                        {
                            Store (Local5, Index (PBDD, 0x01))
                        }
                        Else
                        {
                            Store (\_SB.BAT1.BATC, Index (PBDD, 0x01))
                        }

                        Store (\_SB.BAT1.BATV, Index (PBDD, 0x02))
                        If (LEqual (DCNT, 0x00))
                        {
                            Store (0x00, \_SB.BAT1.UBHD)
                        }

                        Store (PBDD, Debug)
                        Return (PBDD)
                    }

                    Method (S2BF, 1, Serialized)
                    {
                        Add (SizeOf (Arg0), One, Local0)
                        Name (BUFF, Buffer (Local0) {})
                        Store (Arg0, BUFF)
                        Return (BUFF)
                    }

                    Name (DDA0, Ones)
                    Name (DDA1, Ones)
                    Name (DDA2, Ones)
                    Name (DDA3, Ones)
                    Name (DDA4, Ones)
                    Name (DDA5, Ones)
                    Name (DDA6, Ones)
                    Name (DDA7, Ones)
                    Name (DDA8, Ones)
                    Name (DDA9, Ones)
                }
            }

            Device (PMU)
            {
                Name (_ADR, 0x00110000)
                OperationRegion (PMUR, PCI_Config, 0x00, 0xFF)
                Field (PMUR, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x85),=20
                        ,   4,=20
                        ,   1,=20
                    LLOW,   1,=20
                    LHGH,   1,=20
                    Offset (0x88),=20
                        ,   3,=20
                    LIDS,   1,=20
                    Offset (0x91),=20
                        ,   1,=20
                    CRTF,   1,=20
                    CRTR,   1,=20
                    Offset (0x97),=20
                        ,   1,=20
                    TVCC,   1,=20
                    FIRC,   1,=20
                    COMC,   1,=20
                    Offset (0x98),=20
                    Z004,   1,=20
                    LPTC,   1,=20
                        ,   2,=20
                    CRTI,   1,=20
                    Offset (0xB1),=20
                        ,   3,=20
                    CRUN,   1,=20
                    Offset (0xB5),=20
                    PDID,   1
                }
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Name (_PRW, Package (0x02)
            {
                0x03,=20
                0x03
            })
            Method (_LID, 0, NotSerialized)
            {
                If (\_SB.ECOK ())
                {
                    If (\_SB.PCI0.PMU.LIDS)
                    {
                        Store (0x00, \_SB.PCI0.PMU.LHGH)
                        Store (0x01, \_SB.PCI0.PMU.LLOW)
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        Store (0x00, \_SB.PCI0.ISA.EC0.KLED)
                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                        Return (0x01)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.PMU.LLOW)
                        Store (0x01, \_SB.PCI0.PMU.LHGH)
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        Store (0x01, \_SB.PCI0.ISA.EC0.KLED)
                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                        Return (0x00)
                    }
                }
                Else
                {
                    Store (0x00, \_SB.PCI0.PMU.LHGH)
                    Store (0x01, \_SB.PCI0.PMU.LLOW)
                    Return (0x01)
                }
            }
        }

        Device (ACAD)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (ACP, Ones)
            Method (_PSR, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                Store ("CMBatt - _PSR", Debug)
                \_SB.PCI0.ISA.EC0.CPOL ()
                Store (ACP, Local0)
                If (Local0)
                {
                    Store (0x01, Local1)
                }
                Else
                {
                    Store (0x00, Local1)
                }

                Release (\_SB.PCI0.ISA.EC0.MUT1)
                Store (Local1, \_SB.PCI0.ISA.ACST)
                Return (Local1)
            }

            Method (CHAC, 1, NotSerialized)
            {
                Store (LGreater (And (Arg0, 0xF0), 0x80), Local0)
                If (LNot (LEqual (Local0, ACP)))
                {
                    Store (Local0, ACP)
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }

        Scope (\_TZ)
        {
            Name (TPC, 0x0E94)
            Name (TPTM, 0x0CA0)
            Name (TBSE, 0x0AAC)
            Name (PLCY, 0x00)
            Name (TPA0, 0x0DCC)
            Name (TPA1, 0x0E08)
            Name (TPA2, 0x0E30)
            Name (TPA3, 0x0E4E)
            Name (TPAC, 0x0E62)
            Name (TPAS, 0x0E76)
            Name (K3TA, 0x06)
            Name (K3TB, 0x03)
            Name (TRSG, 0x00)
            ThermalZone (THRM)
            {
                Name (_TSP, 0x28)
                Method (_TZP, 0, NotSerialized)
                {
                    If (TREN)
                    {
                        Return (0x012C)
                    }
                    Else
                    {
                        Return (0x00)
                    }
                }

                Method (_CRT, 0, NotSerialized)
                {
                    Return (TPC)
                }

                Name (INBT, 0x00)
                Method (_TMP, 0, NotSerialized)
                {
                    If (\_SB.ECOK ())
                    {
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        Store (\_SB.PCI0.ISA.EC0.CTMP, Local0)
                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                        Store ("Current Temperature C is ----------- ", Deb=
ug)
                        Store (Local0, Debug)
                        Store (Local0, Local2)
                        Multiply (Local0, 0x0A, Local1)
                        Add (Local1, TBSE, Local0)
                        CHTL (Local0)
                        Return (Local0)
                    }
                    Else
                    {
                        Return (TPTM)
                    }
                }

                Method (CHTL, 1, NotSerialized)
                {
                    Store (Arg0, Local0)
                    If (LNot (LGreater (Local0, TPA0)))
                    {
                        If (LGreater (TRSG, 0x00))
                        {
                            If (\_SB.ACAD.ACP)
                            {
                                If (LNot (LEqual (\_SB.PCI0.ISA.EC0.TTAC, 0=
x00)))
                                {
                                    Store (\_SB.PCI0.ISA.EC0.TTAC, TRDC)
                                    Store (0x01, TREN)
                                }
                                Else
                                {
                                    Store (0x00, TRDC)
                                    Store (0x00, TREN)
                                }
                            }
                            Else
                            {
                                Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
                                Store (0x01, TREN)
                            }

                            Store (0x00, TRSG)
                        }
                    }
                    Else
                    {
                        Store (K3TB, Local1)
                        If (\_SB.ACAD.ACP)
                        {
                            Store (K3TA, Local1)
                        }

                        If (LNot (LLess (Local0, TPA1)))
                        {
                            If (LNot (LLess (Local0, TPA3)))
                            {
                                Subtract (Local1, 0x02, Local1)
                                Store (Local1, TRDC)
                                Store (0x01, TREN)
                                Store (0x03, TRSG)
                                Store ("Throttle Stage is >=3D Stage3 ", De=
bug)
                                Store (TRSG, Debug)
                                Store (Local1, Debug)
                            }
                            Else
                            {
                                If (LNot (LLess (Local0, TPA2)))
                                {
                                    If (LOr (LNot (LGreater (TRSG, 0x01)), =
\_SB.ACCG))
                                    {
                                        Subtract (Local1, 0x01, Local1)
                                        Store (Local1, TRDC)
                                        Store (0x01, TREN)
                                        Store (0x02, TRSG)
                                    }

                                    Store ("Throttle Stage is >=3D Stage2 "=
, Debug)
                                    Store (TRSG, Debug)
                                    Store (Local1, Debug)
                                }
                                Else
                                {
                                    If (LOr (LEqual (TRSG, 0x00), \_SB.ACCG=
))
                                    {
                                        Store (Local1, TRDC)
                                        Store (0x01, TREN)
                                        Store (0x01, TRSG)
                                    }

                                    Store ("Throttle Stage is >=3D Stage1 "=
, Debug)
                                    Store (TRSG, Debug)
                                    Store (Local1, Debug)
                                }
                            }
                        }
                    }

                    Store (0x00, \_SB.ACCG)
                }

                Method (_PSV, 0, NotSerialized)
                {
                    Return (TPAS)
                }

                Name (_PSL, Package (0x01)
                {
                    \_PR.CPU0
                })
                Name (_TC1, 0x04)
                Name (_TC2, 0x03)
                Method (_SCP, 1, NotSerialized)
                {
                    Store (Arg0, PLCY)
                }
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x01)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (UBHD, 0x00)
            Name (BATL, 0x00)
            Name (BATT, 0x00)
            Name (PBHD, Package (0x03)
            {
                0xFFFF,=20
                0xFFFF,=20
                0xFFFF
            })
            Name (BATI, 0xFFFF)
            Name (BATC, 0xFFFF)
            Name (BATV, 0xFFFF)
            Name (BATS, 0xFFFF)
            Name (PBIF, Package (0x0D)
            {
                0x01,=20
                0x0B40,=20
                0x0B40,=20
                0x01,=20
                0x39D0,=20
                0x012C,=20
                0xC8,=20
                0x20,=20
                0x20,=20
                "BAT1",=20
                " ",=20
                " ",=20
                " "
            })
            Name (PBST, Package (0x04)
            {
                0x00,=20
                0xFFFFFFFF,=20
                0xFFFFFFFF,=20
                0x2710
            })
            Name (UBIF, 0x01E9)
            Name (BP, 0x00)
            Name (REPT, 0x00)
            Name (ERRC, 0x00)
            Method (_STA, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                Store ("CMBatt - _STA.BAT1", Debug)
                \_SB.PCI0.ISA.EC0.CPOL ()
                If (BP)
                {
                    Store (0x1F, Local1)
                }
                Else
                {
                    Store (0x0F, Local1)
                }

                Release (\_SB.PCI0.ISA.EC0.MUT1)
                Return (Local1)
            }

            Method (_BIF, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                Store ("CMBatt - _BIF.BAT1", Debug)
                \_SB.PCI0.ISA.EC0.CPOL ()
                Release (\_SB.PCI0.ISA.EC0.MUT1)
                Return (PBIF)
            }

            Method (_BST, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                Store ("CMBatt - _BST.BAT1", Debug)
                \_SB.PCI0.ISA.EC0.CPOL ()
                Release (\_SB.PCI0.ISA.EC0.MUT1)
                Return (PBST)
            }

            Method (B1CK, 0, NotSerialized)
            {
                Store ("CMBatt - Notify(BAT1,0x81): B1CK", Debug)
                Notify (\_SB.BAT1, 0x81)
            }

            Method (B1ST, 0, NotSerialized)
            {
                Store ("CMBatt - Notify(BAT1,0x80): B1ST", Debug)
                Notify (\_SB.BAT1, 0x80)
            }

            Method (B1IF, 0, NotSerialized)
            {
                Store ("CMBatt - Notify(BAT1,0x81): B1IF", Debug)
                Notify (\_SB.BAT1, 0x81)
            }

            Method (UPBI, 0, NotSerialized)
            {
                Store ("CMBatt - UPBI.BAT1", Debug)
                Store (Zero, Local0)
                If (LNot (ECOK ()))
                {
                    Return (Local0)
                }

                Store (0x0C, Local1)
                Store (Buffer (0x0D)
                    {
                        0x00, 0x18, 0x10, 0x00, 0x19, 0x00, 0x00, 0x00,=20
                        0x00, 0x21, 0x00, 0x22, 0x20
                    }, Local2)
                While (LGreater (Local1, 0x08))
                {
                    If (LNot (And (UBIF, VTOB (Local1))))
                    {
                        GBFE (Local2, Local1, RefOf (Local3))
                        If (Local3)
                        {
                            If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x0B, 0x16, L=
ocal3, RefOf (Local4))))
                            {
                                Store (\_SB.PCI0.ISA.EC0.BCNT, Local5)
                                Store (Zero, Local3)
                                Store (Zero, ERRC)
                                While (LGreater (Local5, Local3))
                                {
                                    GBFE (Local4, Local3, RefOf (Local6))
                                    Increment (Local3)
                                    If (And (Local6, 0x80))
                                    {
                                        Increment (ERRC)
                                    }
                                }

                                If (LEqual (ERRC, 0x00))
                                {
                                    Store (Local4, Index (PBIF, Local1))
                                    Or (UBIF, VTOB (Local1), UBIF)
                                    Store (Ones, Local0)
                                }
                            }
                        }
                    }

                    Decrement (Local1)
                }

                While (LGreater (Local1, 0x00))
                {
                    If (LNot (And (UBIF, VTOB (Local1))))
                    {
                        GBFE (Local2, Local1, RefOf (Local3))
                        If (Local3)
                        {
                            If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x09, 0x16, L=
ocal3, RefOf (Local5))))
                            {
                                If (LAnd (Local5, LNot (And (Local5, 0x8000=
))))
                                {
                                    If (LEqual (Local1, 0x02))
                                    {
                                        ShiftRight (Local5, 0x05, Local5)
                                        ShiftLeft (Local5, 0x05, Local5)
                                        ShiftRight (Local5, 0x04, BATL)
                                        Add (BATL, 0x14, BATL)
                                    }

                                    Store (Local5, Index (PBIF, Local1))
                                    Or (UBIF, VTOB (Local1), UBIF)
                                    Store (Ones, Local0)
                                }
                            }
                        }
                    }

                    Decrement (Local1)
                }

                Store (0x0A, Local1)
                If (LNot (And (UBIF, VTOB (Local1))))
                {
                    If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x09, 0x16, 0x1C, Ref=
Of (Local5))))
                    {
                        Store (Local5, BATS)
                        Store (ITOS (ToBCD (Local5)), Index (PBIF, Local1))
                        Or (UBIF, VTOB (Local1), UBIF)
                        Store (Ones, Local0)
                    }
                }

                Store (PBIF, Debug)
                Return (Local0)
            }

            Method (UPBS, 0, NotSerialized)
            {
                Store ("CMBatt - UPBS.BAT1", Debug)
                Store (Zero, Local0)
                If (LNot (ECOK ()))
                {
                    Return (Local0)
                }

                Store (\_SB.PCI0.ISA.EC0.BT1S, Local5)
                Store (Local5, Local1)
                And (Local5, 0x07, Local5)
                If (LNot (LEqual (Local5, DerefOf (Index (PBST, 0x00)))))
                {
                    Store ("CMBatt - BAT1 STATE CHANGE", Debug)
                    Store (Local1, Debug)
                    Store (Local5, Index (PBST, 0x00))
                    Store (Local5, BATT)
                    Store (Ones, Local0)
                }

                Store (\_SB.PCI0.ISA.EC0.BT1C, Local5)
                If (LNot (And (Local5, 0x8000)))
                {
                    Store (Local5, BATC)
                    ShiftRight (Local5, 0x05, Local5)
                    ShiftLeft (Local5, 0x05, Local5)
                    If (LNot (LEqual (Local5, DerefOf (Index (PBST, 0x02)))=
))
                    {
                        Store (Local5, Index (PBST, 0x02))
                        Store (Ones, Local0)
                    }

                    If (And (BATT, 0x01))
                    {
                        If (LLess (Local5, BATL))
                        {
                            Or (\_SB.PCI0.ISA.EC0.PQ8A, 0x01, \_SB.PCI0.ISA=
=2EEC0.PQ8A)
                            Store (0x0780, \_SB.PCI0.ISA.EC0.HPCB)
                            Store (0x01, \_SB.PCI0.ISA.EC0.ENCB)
                        }
                    }
                }

                Store (\_SB.PCI0.ISA.EC0.BT1V, Local5)
                If (LNot (And (Local5, 0x8000)))
                {
                    Store (Local5, BATV)
                    ShiftRight (Local5, 0x05, Local5)
                    ShiftLeft (Local5, 0x05, Local5)
                    If (LNot (LEqual (Local5, DerefOf (Index (PBST, 0x03)))=
))
                    {
                        Store (Local5, Index (PBST, 0x03))
                        Store (Ones, Local0)
                    }
                }

                Store (\_SB.PCI0.ISA.EC0.BT1I, Local5)
                Store (Local5, BATI)
                If (And (BATI, 0x8000))
                {
                    Or (BATI, 0xFFFF0000, BATI)
                }

                If (And (Local1, 0x01))
                {
                    Store (\_SB.PCI0.ISA.EC0.BT1V, Local2)
                    If (LEqual (Local2, Zero))
                    {
                        Store (0x39D0, Local2)
                    }

                    Divide (0x01036640, Local2, , Local3)
                    If (And (Local5, 0x8000))
                    {
                        Or (Local5, 0xFFFF0000, Local5)
                        Add (Not (Local5), 0x01, Local5)
                        If (LGreater (Local3, Local5))
                        {
                            Store (Local3, Local5)
                        }
                    }
                    Else
                    {
                        Store (Local3, Local5)
                    }
                }

                If (And (Local1, 0x02))
                {
                    If (And (Local5, 0x8000))
                    {
                        Store (0x00, Local5)
                    }

                    If (LGreater (0x64, Local5))
                    {
                        Store (0x64, Local5)
                    }
                }

                If (LEqual (And (Local1, 0x03), 0x00))
                {
                    Store (0x00, Local5)
                }

                ShiftRight (Local5, 0x05, Local5)
                ShiftLeft (Local5, 0x05, Local5)
                If (LNot (LEqual (Local5, DerefOf (Index (PBST, 0x01)))))
                {
                    Store (Local5, Index (PBST, 0x01))
                    Store (Ones, Local0)
                }

                If (Local0)
                {
                    Store ("CMBATT - PBST Changed", Debug)
                }

                Store (PBST, Debug)
                Return (Local0)
            }

            Method (UPBH, 0, NotSerialized)
            {
                Store ("CMBatt - UPBH.BAT1", Debug)
                Store (Zero, Local0)
                If (LNot (ECOK ()))
                {
                    Return (Local0)
                }

                Store (0x00, Local1)
                Store (Buffer (0x03)
                    {
                        0x17, 0x0C, 0x10
                    }, Local2)
                While (LLess (Local1, 0x03))
                {
                    If (LNot (And (UBHD, VTOB (Local1))))
                    {
                        GBFE (Local2, Local1, RefOf (Local3))
                        If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x09, 0x16, Local=
3, RefOf (Local5))))
                        {
                            Store (Local5, Index (PBHD, Local1))
                            Or (UBHD, VTOB (Local1), UBHD)
                            Store (Ones, Local0)
                        }
                    }

                    Increment (Local1)
                }

                Store (PBHD, Debug)
                Return (Local0)
            }

            Method (IVBI, 0, NotSerialized)
            {
                Store (0x01E9, UBIF)
                Store (0x0B40, Index (PBIF, 0x01))
                Store (0x0B40, Index (PBIF, 0x02))
                Store (0x39D0, Index (PBIF, 0x04))
                Store ("Bad", Index (PBIF, 0x09))
                Store ("Bad", Index (PBIF, 0x0A))
                Store ("Bad", Index (PBIF, 0x0B))
                Store ("Bad", Index (PBIF, 0x0C))
            }

            Method (IVBS, 0, NotSerialized)
            {
                Store (0x00, Index (PBST, 0x00))
                Store (0xFFFFFFFF, Index (PBST, 0x01))
                Store (0xFFFFFFFF, Index (PBST, 0x02))
                Store (0x39D0, Index (PBST, 0x03))
            }

            Method (IVBH, 0, NotSerialized)
            {
                Store (0x00, UBHD)
                Store (0xFFFF, Index (PBHD, 0x00))
                Store (0xFFFF, Index (PBHD, 0x01))
                Store (0xFFFF, Index (PBHD, 0x02))
            }

            Method (CHBP, 1, NotSerialized)
            {
                Store ("CMBatt - CHBP.BAT1", Debug)
                Store (Zero, Local0)
                If (LNot (ECOK ()))
                {
                    Return (Local0)
                }

                Store (VTOB (Subtract (_UID, 0x01)), Local1)
                Or (ShiftLeft (Local1, 0x0C), 0x0FFF, Local2)
                Store (Zero, Local3)
                If (And (Arg0, Local1))
                {
                    If (BP)
                    {
                        Store ("CMBatt - BAT1 still present", Debug)
                        \_SB.PCI0.ISA.EC0.SMWR (0x08, 0x14, 0x01, Local2)
                        \_SB.PCI0.ISA.EC0.SMRD (0x09, 0x14, 0x01, RefOf (Lo=
cal3))
                        If (LEqual (Local2, Or (Local3, 0x0FFF)))
                        {
                            If (UPBI ())
                            {
                                Or (0x01, Local0, Local0)
                            }

                            If (UPBS ())
                            {
                                Or (0x02, Local0, Local0)
                            }

                            UPBH ()
                        }
                    }
                    Else
                    {
                        Store ("CMBatt - BAT1 connected", Debug)
                        \_SB.PCI0.ISA.EC0.SMWR (0x08, 0x14, 0x01, Local2)
                        \_SB.PCI0.ISA.EC0.SMRD (0x09, 0x14, 0x01, RefOf (Lo=
cal3))
                        If (LEqual (Local2, Or (Local3, 0x0FFF)))
                        {
                            UPBI ()
                            UPBS ()
                            UPBH ()
                        }

                        Store (0x01, BP)
                        Or (0x05, Local0, Local0)
                    }
                }
                Else
                {
                    If (BP)
                    {
                        Store ("CMBatt - BAT1 disconnected", Debug)
                        Store (0x00, BP)
                        IVBI ()
                        IVBS ()
                        IVBH ()
                        Or (0x04, Local0, Local0)
                    }
                }

                If (LAnd (And (Arg0, Local1), LNot (LEqual (UBIF, 0x1FFF))))
                {
                    Store (0x01, REPT)
                }
                Else
                {
                    Store (0x00, REPT)
                }

                Return (Local0)
            }
        }
    }

    Method (_PTS, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x01)) {}
        If (LEqual (Arg0, 0x03))
        {
            Store (0x01, \_SB.PCI0.ISA.EC0.WORE)
            Store (0x00, \_SB.PCI0.PMU.LLOW)
            Store (0x01, \_SB.PCI0.PMU.LHGH)
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (0x01, \_SB.PCI0.ISA.EC0.S4FG)
            Store (0x00, \_SB.PCI0.ISA.EC0.WORE)
            \_SB.PCI0.ISA.HPSS (0x18, 0x00)
        }

        If (LEqual (Arg0, 0x05))
        {
/*
            Store (0x00, \_SB.PCI0.ISA.EC0.WORE)
            If (\_SB.PCI0.ISA.WOLE)
            {
                Store (0x01, \_SB.PCI0.ISA.EC0.WOLE)
            }
            Else
            {
                Store (0x00, \_SB.PCI0.ISA.EC0.WOLE)
            }

            \_SB.PCI0.ISA.HPSS (0x02, 0x00)
            Sleep (0x07D0)
*/
        }
    }

    Method (_WAK, 1, NotSerialized)
    {
        If (\_SB.ECOK ())
        {
            Store (\_SB.PCI0.ISA.HPSS (0x08, 0x11), Local0)
            \_SB.PCI0.ISA.EC0.CMC2 (0xC4, Local0, 0x82)
        }

        If (LEqual (Arg0, 0x01)) {}
        If (LEqual (Arg0, 0x03))
        {
            Store (0x01, \_SB.PCI0.ISA.KBC0.KBS3)
            If (\_SB.ECOK ())
            {
                Store (0x12, \_SB.PCI0.ISA.EC0.BFLG)
                Store (0x08, \_SB.PCI0.ISA.EC0.BPD)
                Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                \_SB.PCI0.ISA.EC0.BPOL ()
                Release (\_SB.PCI0.ISA.EC0.MUT1)
            }

            Store (0x00, \_SB.PCI0.PMU.LHGH)
            Store (0x01, \_SB.PCI0.PMU.LLOW)
            \_SB.PCI0.ISA.HPSS (0x11, 0x00)
        }

        If (LEqual (Arg0, 0x04))
        {
            Notify (\_SB.PWRB, 0x02)
            If (\_SB.ECOK ())
            {
                Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                Store (\_SB.PCI0.ISA.EC0.ADP, Local0)
                Release (\_SB.PCI0.ISA.EC0.MUT1)
                If (Local0)
                {
                    Store (0x00, TRDC)
                    Store (0x00, TREN)
                }
                Else
                {
                    Store (0x06, TRDC)
                    Store (0x01, TREN)
                }
            }
        }

        If (LEqual (Arg0, 0x05)) {}

	Return(Package(0x02){0x00, 0x00})
    }

    Scope (_SI)
    {
        Method (_SST, 1, NotSerialized)
        {
            If (LEqual (Arg0, 0x01))
            {
                Store ("=3D=3D=3D=3D=3D SST Working =3D=3D=3D=3D=3D", Debug)
            }

            If (LEqual (Arg0, 0x02))
            {
                Store ("=3D=3D=3D=3D=3D SST Waking =3D=3D=3D=3D=3D", Debug)
            }

            If (LEqual (Arg0, 0x03))
            {
                Store ("=3D=3D=3D=3D=3D SST Sleeping =3D=3D=3D=3D=3D", Debu=
g)
            }

            If (LEqual (Arg0, 0x04))
            {
                Store ("=3D=3D=3D=3D=3D SST Sleeping S4 =3D=3D=3D=3D=3D", D=
ebug)
            }
        }
    }

    Scope (_GPE)
    {
        Method (_L03, 0, NotSerialized)
        {
            Notify (\_SB.LID, 0x80)
        }

        Method (_L08, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L09, 0, NotSerialized)
        {
            Notify (\_SB.PCI0, 0x02)
            Sleep (0x01F4)
            Notify (\_SB.PCI0.AGPB.VGA, 0x00)
        }

        Method (_L0A, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.MDEM, 0x02)
        }

        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L0D, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L23, 0, NotSerialized)
        {
            Notify (\_TZ.THRM, 0x80)
        }

        Method (_L24, 0, NotSerialized)
        {
            Sleep (0x01F4)
            If (\_SB.PCI0.PMU.CRTI)
            {
                Store (0x00, \_SB.PCI0.PMU.CRTR)
                Store (0x01, \_SB.PCI0.PMU.CRTF)
            }
            Else
            {
                Store (0x00, \_SB.PCI0.PMU.CRTF)
                Store (0x01, \_SB.PCI0.PMU.CRTR)
            }

            \_SB.PCI0.AGPB.VGA.DRUL (0x02)
        }
    }

    OperationRegion (\P378, SystemIO, 0x0378, 0x02)
    Field (\P378, ByteAcc, NoLock, Preserve)
    {
        O378,   8,=20
        I379,   8
    }

    Method (DBGS, 1, Serialized)
    {
        ROMC (Arg0, 0x1009)
    }

    Method (DBGT, 1, Serialized)
    {
        ROMC (Arg0, 0x100A)
    }

    Method (DBGC, 1, Serialized)
    {
        PHDB (Arg0)
        P1CH (0x20)
    }

    Method (P1CH, 1, Serialized)
    {
        ROMC (Arg0, 0x100E)
    }

    Method (PDDB, 1, Serialized)
    {
        ROMC (Arg0, 0x0300)
    }

    Method (PHDB, 1, Serialized)
    {
        ROMC (Arg0, 0x0200)
    }

    Method (PHDW, 1, Serialized)
    {
        ROMC (Arg0, 0x0201)
    }

    Method (PHDD, 1, Serialized)
    {
        ROMC (Arg0, 0x0202)
    }

    Method (ROMC, 2, Serialized)
    {
        And (I379, 0xF8, Local0)
        If (LEqual (Local0, 0xB0))
        {
            FODW (0xAA55)
            FODW (Arg1)
            If (LEqual (Arg1, 0x0200))
            {
                CHDB (Arg0)
            }
            Else
            {
                If (LEqual (Arg1, 0x0201))
                {
                    CHDW (Arg0)
                }
                Else
                {
                    If (LEqual (Arg1, 0x0202))
                    {
                        CHDD (Arg0)
                    }
                    Else
                    {
                        If (LEqual (Arg1, 0x0300))
                        {
                            CHDB (Arg0)
                        }
                        Else
                        {
                            If (LEqual (Arg1, 0x1009))
                            {
                                CSTR (Arg0)
                            }
                            Else
                            {
                                If (LEqual (Arg1, 0x100A))
                                {
                                    CSTR (Arg0)
                                }
                                Else
                                {
                                    If (LEqual (Arg1, 0x100E))
                                    {
                                        C1CH (Arg0)
                                    }
                                    Else
                                    {
                                    }
                                }
                            }
                        }
                    }
                }
            }

            FODB (0x66)
        }
    }

    Method (CSTR, 1, Serialized)
    {
        Store (SizeOf (Arg0), Local1)
        Name (BUFF, Buffer (Local1) {})
        Store (Arg0, BUFF)
        Store (Zero, Local2)
        FODW (0x0D0A)
        While (LNot (LEqual (Local2, Local1)))
        {
            Store (DerefOf (Index (BUFF, Local2)), Local3)
            Increment (Local2)
            FODB (Local3)
        }

        FODB (0x00)
    }

    Method (C1CH, 1, Serialized)
    {
        FODB (Arg0)
        FODB (0x07)
    }

    Method (CHDB, 1, Serialized)
    {
        FODB (Arg0)
    }

    Method (CHDW, 1, Serialized)
    {
        FODW (Arg0)
    }

    Method (CHDD, 1, Serialized)
    {
        FODD (Arg0)
    }

    Method (\FODD, 1, NotSerialized)
    {
        Store (Arg0, Local0)
        ShiftRight (Local0, 0x10, Local1)
        And (Local1, 0xFFFF, Local1)
        And (Local0, 0xFFFF, Local0)
        FODW (Local0)
        FODW (Local1)
    }

    Method (\FODW, 1, NotSerialized)
    {
        Store (Arg0, Local0)
        ShiftRight (Local0, 0x08, Local1)
        And (Local1, 0xFF, Local1)
        And (Local0, 0xFF, Local0)
        FODB (Local0)
        FODB (Local1)
    }

    Method (\FODB, 1, NotSerialized)
    {
        Or (Arg0, 0x10, Local0)
        Store (Local0, O378)
        Store (0x01, Local3)
        While (Local3)
        {
            If (LEqual (And (I379, 0x80, Local3), 0x00))
            {
                ShiftRight (I379, 0x03, Local0)
                And (Local0, 0x0F, Local0)
                ShiftRight (Arg0, 0x04, Local1)
                Store (Local1, O378)
                Store (0x01, Local2)
                While (Local2)
                {
                    If (And (I379, 0x80, Local2))
                    {
                        Store (I379, Local1)
                        Store (0x00, Local2)
                    }
                    Else
                    {
                        Store (0x01, Local2)
                    }
                }

                ShiftLeft (Local1, 0x01, Local1)
                And (Local1, 0xF0, Local1)
                Or (Local1, Local0, Local0)
                Store (0x00, Local3)
            }
        }
    }
}


--Boundary-01=_ev0TBhFDs+CoON0--

--nextPart1530638.aGhObgOZEB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBT0vetofNKe8dDvARAvRUAKCKRvf6RsZuuE6Hg2lxesHrs7zXAgCfXEtJ
q5v7YvtZPImzmexNQiwqYhU=
=g7Le
-----END PGP SIGNATURE-----

--nextPart1530638.aGhObgOZEB--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
