From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Repeatable lockup with sustained polling of battery
	state
Date: 26 Nov 2002 14:35:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1038339343.1840.4.camel@sirius.strandboge.cxm>
References: <1034266219.1287.40.camel@sirius.strandboge.cxm>
	 <1036013358.9704.93.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-B2/o8gfdCuFtajoV8lQY"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1036013358.9704.93.camel-Ty44UuN9vPJ5T2F9fCU5s856D9/Od9gv@public.gmane.org>
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


--=-B2/o8gfdCuFtajoV8lQY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-10-30 at 16:29, James D Strandboge wrote:
> I posted the below a few weeks ago, and am very interested in getting
> this issue resolved.  This was my first post to the list, and I tried to
> give as much info as I could, but nobody responded.
> 
> What should I send in that would be more helpful?  I am willing to try
> patches, etc.  
> 

I am still having this problem.  I have attached my dsdt file in hopes
someone can help with this.  I am using 2.4.20-rc2 with acpi-20021118. 
I get no errors on boot, and cannot find any errors in my logs.  If I
poll my battery state, the system locks up.  One extra note is that the
BIOS keys do in fact work when the machine is locked, I just can't get
the OS to respond.

Thank you for your help,

Jamie Strandboge

> 
> On Thu, 2002-10-10 at 12:10, James D Strandboge wrote:
> > I started using ACPI for my Dell Inspiron 8200 (Debian Sid, with kernel
> > 2.4.19 with the acpi20021008 patch) recently, and have in general had
> > good results.  However, when polling /proc/acpi/battery/BAT1/state for
> > any length of time, the system freezes.  I can ping it, but cannot login
> > with ssh or telnet.  I have adjusted the BIOS (I turned of USB Legacy
> > support) as well as passing pci=noacpi to the kernel on boot with no
> > change.  I have also used the 20020918 patch with no change. 
> > /var/log/acpid and /var/log/kern.log don't show any errors either.
> > 
> > To make sure it was just the acpi code, and not usb or X or something
> > else, I booted into single user mode (after a reboot), then ran
> > '/etc/init.d/hotplug stop'.  I also used rmmod on all modules except
> > 'unix' and 'rtc'.  The system froze, but because I didn't enable
> > networking for the test, I couldn't ping it-- but in all previous tests
> > (eg with X, with USB, etc)  I could always ping, I just couldn't ssh or
> > telnet
> > 
> > I use this script to trigger the event, which can take anywhere from a
> > few minutes to an hour to trigger the lockup:
> > #!/bin/sh
> > 
> > while [ /bin/true ]
> > do
> > 	REMAIN=`grep remain /proc/acpi/battery/BAT1/state | awk '{ print $3 }'`
> > 	if [ $REMAIN -lt 0 ]
> > 	then
> > 		echo "problem"
> > 		exit 1
> > 	fi
> > 	echo $REMAIN
> > done
> > exit 0;
> > 
> > I have never seen the 'problem' echo from the script.  Once when viewing
> > the aftermath of a lockup, however, the script complained that $REMAIN
> > was not set, so I assume /proc/acpi/battery/BAT1/state was not available
> > at that time.  Today, I had a blank screen after the lockup, so I don't
> > know what the script said.
> > 
> > Here is the output of dmesg:
> > 
> > Linux version 2.4.19-acpi2dbg (james-Ty44UuN9vPJ5T2F9fCU5s856D9/Od9gv@public.gmane.org) (gcc version
> > 2.95.4 20011002 (Debian prerelease)) #1 Sun Oct 6 23:16:09 EDT 2002
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> >  BIOS-e820: 0000000000100000 - 000000001ffe2800 (usable)
> >  BIOS-e820: 000000001ffe2800 - 0000000020000000 (reserved)
> >  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
> >  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
> > 511MB LOWMEM available.
> > ACPI: have wakeup address 0xc0001000
> > Advanced speculative caching feature not present
> > On node 0 totalpages: 131042
> > zone(0): 4096 pages.
> > zone(1): 126946 pages.
> > zone(2): 0 pages.
> > ACPI: RSDP (v000 DELL                       ) @ 0x000fde50
> > ACPI: RSDT (v001 DELL    CPi R   10194.01539) @ 0x000fde64
> > ACPI: FADT (v001 DELL    CPi R   10194.01539) @ 0x000fde90
> > ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000
> > ACPI: BIOS passes blacklist
> > Kernel command line: 1 root=/dev/hda5 ro hdb=ide-scsi noapic
> > video=vga16:off
> > ide_setup: hdb=ide-scsi
> > Initializing CPU#0
> > Detected 1595.322 MHz processor.
> > Console: colour VGA+ 80x25
> > Calibrating delay loop... 3185.04 BogoMIPS
> > Memory: 516156k/524168k available (1124k kernel code, 7624k reserved,
> > 478k data, 92k init, 0k highmem)
> > Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> > Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
> > Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
> > Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> > Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> > CPU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
> > CPU: L1 I cache: 12K, L1 D cache: 8K
> > CPU: L2 cache: 512K
> > CPU: After vendor init, caps: 3febf9ff 00000000 00000000 00000000
> > CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
> > CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
> > CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
> > Enabling fast FPU save and restore... done.
> > Enabling unmasked SIMD FPU exception support... done.
> > Checking 'hlt' instruction... OK.
> > POSIX conformance testing by UNIFIX
> > mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
> > mtrr: detected mtrr type: Intel
> > ACPI: Subsystem revision 20021002
> > PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=2
> > PCI: Using configuration type 1
> >  tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully
> > acquired
> > Parsing
> > Methods:......................................................................................................................................................................
> > Table [DSDT] - 439 Objects with 68 Devices 166 Methods 7 Regions
> > ACPI Namespace successfully loaded at root c02c185c
> > evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode
> > successful
> > Executing all Device _STA and_INI
> > methods:....................................................................
> > 68 Devices found containing: 68 _STA, 3 _INI methods
> > Completing Region/Field/Buffer/Package
> > initialization:..............................................................
> > Initialized 5/7 Regions 2/10 Fields 22/25 Buffers 33/33 Packages (439
> > nodes)
> > ACPI: Interpreter enabled
> > ACPI: Using PIC for interrupt routing
> > ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
> > ACPI: PCI Root Bridge [PCI0] (00:00)
> > PCI: Probing PCI hardware (bus 00)
> > Unknown bridge resource 2: assuming transparent
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> > pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:1d.01 not
> > present in PCI namespace
> > pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:1d.07 not
> > present in PCI namespace
> > ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
> > ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7, enabled at IRQ 11)
> > ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
> > ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
> > pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:08.00 not
> > present in PCI namespace
> > pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:0c.00 not
> > present in PCI namespace
> > ACPI: Power Resource [PADA] (on)
> > PCI: Probing PCI hardware
> > PCI: Using ACPI for IRQ routing
> > PCI: if you experience problems, try using option 'pci=noacpi' or even
> > 'acpi=off'
> > Linux NET4.0 for Linux 2.4
> > Based upon Swansea University Computer Society NET3.039
> > Initializing RT netlink socket
> > Starting kswapd
> > VFS: Diskquotas version dquot_6.4.0 initialized
> > Journalled Block Device driver loaded
> > devfs: v1.12a (20020514) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
> > devfs: boot_options: 0x0
> > ACPI: AC Adapter [AC] (on-line)
> > ACPI: Battery Slot [BAT0] (battery absent)
> > ACPI: Battery Slot [BAT1] (battery present)
> > ACPI: Lid Switch [LID]
> > ACPI: Power Button (CM) [PBTN]
> > ACPI: Sleep Button (CM) [SBTN]
> > ACPI: Processor [CPU0] (supports C1 C2, 2 performance states, 8
> > throttling states)
> > ACPI: Thermal Zone [THM] (56 C)
> > pty: 256 Unix98 ptys configured
> > Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT
> > SHARE_IRQ SERIAL_PCI enabled
> > ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > ttyS02 at 0x03e8 (irq = 4) is a 16550A
> > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > ICH3M: IDE controller on PCI bus 00 dev f9
> > PCI: Enabling device 00:1f.1 (0005 -> 0007)
> > ICH3M: chipset revision 2
> > ICH3M: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
> >     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
> > hda: IC25N040ATCS05-0, ATA DISK drive
> > hdb: TOSHIBA CD-RW/DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
> > ide2: ports already in use, skipping probe
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > hda: 78140160 sectors (40008 MB) w/7898KiB Cache, CHS=4864/255/63
> > Partition check:
> >  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
> > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols: ICMP, UDP, TCP, IGMP
> > IP: routing cache hash table of 4096 buckets, 32Kbytes
> > TCP: Hash tables configured (established 32768 bind 32768)
> > Linux IP multicast router 0.06 plus PIM-SM
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode.
> > VFS: Mounted root (ext3 filesystem) readonly.
> > Freeing unused kernel memory: 92k freed
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > Adding Swap: 265032k swap-space (priority -1)
> > EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
> > Real Time Clock Driver v1.10e
> > Intel 810 + AC97 Audio, version 0.21, 10:15:53 Oct  7 2002
> > PCI: Setting latency timer of device 00:1f.5 to 64
> > i810: Intel ICH3 found at IO 0xdc80 and 0xd800, IRQ 11
> > i810_audio: Audio Controller supports 6 channels.
> > ac97_codec: AC97 Audio codec, id: 0x4352:0x595b (Unknown)
> > i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
> > ac97_codec: AC97 Modem codec, id: 0x4358:0x5421 (Unknown)
> > i810_audio: timed out waiting for codec 1 analog ready.
> > SCSI subsystem driver Revision: 1.00
> > scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> >   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> >   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> >   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> >   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> >   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> >   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> >   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
> > EXT3-fs: mounted filesystem with ordered data mode.
> > usb.c: registered new driver usbdevfs
> > usb.c: registered new driver hub
> > usb-uhci.c: $Revision: 1.275 $ time 10:16:05 Oct  7 2002
> > usb-uhci.c: High bandwidth mode enabled
> > PCI: Setting latency timer of device 00:1d.0 to 64
> > usb-uhci.c: USB UHCI at I/O 0xbf80, IRQ 11
> > usb-uhci.c: Detected 2 ports
> > usb.c: new USB bus registered, assigned bus number 1
> > hub.c: USB hub found
> > hub.c: 2 ports detected
> > PCI: Setting latency timer of device 00:1d.2 to 64
> > usb-uhci.c: USB UHCI at I/O 0xbf20, IRQ 11
> > usb-uhci.c: Detected 2 ports
> > usb.c: new USB bus registered, assigned bus number 2
> > hub.c: USB hub found
> > hub.c: 2 ports detected
> > usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> > usb.c: USB disconnect on device 1
> > usb.c: USB bus 1 deregistered
> > usb.c: USB disconnect on device 1
> > usb.c: USB bus 2 deregistered
> > usb.c: deregistering driver usbdevfs
> > usb.c: deregistering driver hub
> > scsi : 0 hosts left.
> > 
> > 
> > Here is the output of ps aux, before I ran my script:
> > 
> > USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> > root         1  2.2  0.0  1268  480 ?        S    07:26   0:03 init
> > [S]     
> > root         2  0.0  0.0     0    0 ?        SW   07:26   0:00 [keventd]
> > root         3  0.0  0.0     0    0 ?        SWN  07:26   0:00
> > [ksoftirqd_CPU0]
> > root         4  0.0  0.0     0    0 ?        SW   07:26   0:00 [kswapd]
> > root         5  0.0  0.0     0    0 ?        SW   07:26   0:00 [bdflush]
> > root         6  0.0  0.0     0    0 ?        SW   07:26   0:00
> > [kupdated]
> > root         7  0.0  0.0     0    0 ?        SW   07:26   0:00
> > [kjournald]
> > root        71  0.0  0.0     0    0 ?        SW   07:27   0:00
> > [kjournald]
> > root       345  0.0  0.0  1268  480 tty1     S    07:27   0:00 init
> > [S]     
> > root       346  0.0  0.2  2384 1396 tty1     S    07:27   0:00 bash
> > root       443  0.0  0.1  2568  780 tty1     R    07:29   0:00 ps aux
> > 
> > 
> > 
> > Here are the contents of the three files for this battery.
> > 
> > cat /proc/acpi/battery/BAT1/alarm:
> > alarm:                   3000 mWh
> > 
> > cat /proc/acpi/battery/BAT1/info:
> > present:                 yes
> > design capacity:         65120 mWh
> > last full capacity:      63270 mWh
> > battery technology:      rechargeable
> > design voltage:          14800 mV
> > design capacity warning: 3000 mWh
> > design capacity low:     1000 mWh
> > capacity granularity 1:  200 mWh
> > capacity granularity 2:  200 mWh
> > model number:            LIP8120DLP
> > serial number:           60765
> > battery type:            LION
> > OEM info:                Sony Corp.
> > 
> > cat /proc/acpi/battery/BAT1/state:
> > present:                 yes
> > capacity state:          ok
> > charging state:          unknown
> > present rate:            unknown
> > remaining capacity:      65120 mWh
> > present voltage:         16670 mV
> > 
> > 
> > Here are the contents of /proc/interrupts when the system is booted into
> > runlevel 3 (with X on my machine).
> > 
> > cat /proc/interrupts:
> >            CPU0       
> >   0:     283973          XT-PIC  timer
> >   1:       8881          XT-PIC  keyboard
> >   2:          0          XT-PIC  cascade
> >   8:          3          XT-PIC  rtc
> >   9:          0          XT-PIC  acpi
> >  11:        928          XT-PIC  Intel ICH3, usb-uhci, usb-uhci, Texas
> > Instruments PCI4451 PC card Cardbus Controller, Texas Instruments
> > PCI4451 PC card Cardbus Controller (#2), eth0
> >  12:      29430          XT-PIC  PS/2 Mouse
> >  14:     203208          XT-PIC  ide0
> > NMI:          0 
> > ERR:          0
> > 
> > 
> > 
> > Please let me know if I can supply any other information or test
> > patches.  Other 8200 users have simply said acpi doesn't work on this
> > laptop, but that is not true.  AC, LID and POWERBTN events all work fine
> > (haven't tried sleep yet) and I can change the CPU performance (haven't
> > tried throttling yet).  Polling the battery is the only problem I have
> > had so far-- it generally works, but sustained polling doesn't.  As long
> > as I don't poll the battery, I've had the system run for days with no
> > problems.  I did look at the kernel source, but there wasn't anything
> > obvious (to me) that was wrong.
> > 
> > Thanks,
> > 
> > Jamie Strandboge
> > 
> > -- 
> > Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
> > GPG/PGP ID:   26384A3A
> > Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A
> > 
> > Visit Perinton Nursery School at:
> > http://perintonnurseryschool.org/
> > 
> > 
> > 
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

Visit Perinton Nursery School at:
http://perintonnurseryschool.org/

--=-B2/o8gfdCuFtajoV8lQY
Content-Disposition: attachment; filename=dell_i8200_a07_dsdt.dat
Content-Type: video/mpeg; name=dell_i8200_a07_dsdt.dat
Content-Transfer-Encoding: quoted-printable

DSDT41=00=00=018INT430SYSFexxx=01=10=00=00MSFT=0E=00=00=01=08VERS=128=03=0D=
Project: DELL Mojave=00=0DDate: 01/28/1998=00=0DVer: 1.00.04=00=08MISC=11

=07=00=00=00=00=00=00=00=8CMISC
=00MIS0=8CMISC
=01MIS1=8CMISC
=02MIS2=8CMISC
=03MIS3=8CMISC
=04MIS4=8CMISC
=05MIS5=8CMISC
=06MIS6[=01SMIX=01=14J=05SMI_=02[#SMIX=FF=FFpi\._SB_SMIDph\._SB_SMICp\._SB_=
SMIC`=A2=12=92=93`
=00p\._SB_SMIC`p\._SB_SMIDa['SMIX=A4a=08SXX0=11=04=0B=00=01=08SXX1=11=03
=08=8BSXX1
=00SXX2=8BSXX1
=04SXX3=14=15SX10=00[#SMIX=FF=FFp
=00SXX2=141SX30=01pSXX2`u`=A0"=92=94`=87SXX0=8CSXX0SXX2SX20phSX20p`SXX2=144=
SX31=01pSXX2`r`
=02`=A0"=92=94`=87SXX0=8BSXX0SXX2SX21phSX21p`SXX2=144SX32=01pSXX2`r`
=04`=A0"=92=94`=87SXX0=8ASXX0SXX2SX22phSX22p`SXX2=14=1BSX33=02=A0=14=95i=87=
h=8ChiSX20SX30SX20=14=17SX34=02p
=00`=A2=0C=95`iSX33h`u`=14I=04SXX6=02pi\._SB_SMIDph\._SB_SMICp\._SB_SMIC`=
=A2=12=92=93`
=00p\._SB_SMIC`=A4\._SB_SMID=14=1DSXX5=02=A0=16=95i=87h=8ChiSX20SXX6
|SX20=14%SXX4=00SXX6
{
=00p
=00`=A2=12=95`SXX2SXX5SXX0`u`=14 SXX8=02=A0=19=95i=87h=8ChiSX20pSXX6
}
=00SX20=14$SXX7=00p
=00`=A2=19=95`SXX3rSXX2`aSXX8SXX0au`=14C=04SX11=00SXX4pSXX6
y
=00SXX3rSXX2SXX3`=A0=1C=95=87SXX0`p=87SXX0`t`SXX2`p`SXX3SXX7=143SX40=00pSXX=
2`u`=A0!=92=94`=87SXX0=8CSXX0SXX2SX20p`SXX2=A4SX20=A4
=00=146SX41=00pSXX2`r`
=02`=A0!=92=94`=87SXX0=8BSXX0SXX2SX21p`SXX2=A4SX21=A4
=00=146SX42=00pSXX2`r`
=04`=A0!=92=94`=87SXX0=8ASXX0SXX2SX22p`SXX2=A4SX22=A4
=00=14=1CSX43=02=A0=15=95i=87h=8ChiSX20pSX40SX20=14=17SX44=02p
=00`=A2=0C=95`iSX43h`u`=14"SX45=00pSX40`=08SX23=11=02`SX44SX23`=A4SX23=14=
=0CSX12=00['SMIX=14+PNPQ=01SX10SX30
=00SX30
=02SX30hSX11pSX40`SX12=A4`=14#PNPD=01SX10SX30
=00SX30
=03SX30hSX11SX12=14?PNPG=01SX10SX30
=00SX30
=00SX30hSX11=08PGET=11=05SXX3SX44PGETSXX3SX12=A4PGET=14*PNPS=02SX10SX30
=00SX30
=01SX30hSX34i=87iSX11SX12=14"PSW_=02SX10SX30
=06SX30hSX30iSX11SX12=14"DSS_=02SX10SX30
=08SX30hSX32iSX11SX12=14 GMEM=00SX10SX30
=07SX11pSX42`SX12=A4`=14 GORL=00SX10SX30
	SX11pSX42`SX12=A4`=08W98S=0DMicrosoft Windows=00=08NT5S=0DMicrosoft Window=
s NT=00=08WINM=0DMicrosoft WindowsME: Millennium Edition=00=08WXP_=0DWindow=
s 2001=00=14=12GETC=02=8ChiTCHR=A4TCHR=14@=05STRE=02=08STR1=11=03
P=08STR2=11=03
PphSTR1piSTR2p=00`p=01a=A2"apGETCSTR1`apGETCSTR2`b=A0=07=92=93ab=A4=00u`=A4=
=01=14N=07OSID=00=A0A=07=93MIS3
=00p
=04MIS3=A0=1B[=12\_OSI`=A0=11\_OSIWXP_p
@MIS3=A1D=04=A0=15STRE\_OS_W98Sp
=08MIS3=A0=15STRE\_OS_NT5Sp
=10MIS3=A0=15STRE\_OS_WINMp
 MIS3=A4MIS3=14$SOST=00SX10SX30

OSIDSX30MIS3SX11SX12=08WAKE
=00=14K=07NEVT=00pSMI_
=8C
=00`=A0=13{`
=01=00=86\._SB_PBTN
=80=A0
{`
=02=00EJTE=A0
{`
=04=00LIDE=A0
{`
=08=00PWRE=A0
{`
=10=00DCKE=A0
{`
 =00BAYE=A0=13{`
@=00=86\._SB_SBTN
=80=A0
{`
=80=00SMIE=14&EJTE=00pSMI_
=87
=00`=86\/=04_SB_PCI0PCIEGDCK
=01=14=3DLIDE=00pSMI_
=84
=00`=86\._SB_LID_
=80=A0=1F=92=93WAKE
=01=86\/=04_SB_PCI0AGP_VID_
=80=14D=0FPWRE=00pSMI_
=98
=00`=7F`MIS0a{`}
=01}
=02
=10=00=00MIS0=A0=13{a
=01=00=86\._SB_AC__
=80{MIS0
=02b=A0%{a
=02=00=A0=0Fb=86\._SB_BAT0
=81=A1=0E=86\._SB_BAT0
=81=A0=16{a
=04=00=A0=0Fb=86\._SB_BAT0
=80=A0=16{a
=08=00=A0=0Fb=86\._SB_BAT0
=80{MIS0
=10b=A0%{a
=10=00=A0=0Fb=86\._SB_BAT1
=81=A1=0E=86\._SB_BAT1
=81=A0=16{a
 =00=A0=0Fb=86\._SB_BAT1
=80=A0=16{a
@=00=A0=0Fb=86\._SB_BAT1
=80=14J=05DCKE=00pSMI_
=87
=00`=7F`MIS2ap`MIS2=A0;a=A0=18`=86\/=04_SB_PCI0PCIEGDCK
=00=A1=1FSMI_
=8D
=00=86\/=04_SB_PCI0PCIEGDCK
=01=14D=1FBAYE=00pSMI_
=86
=00`=7F`MIS1ap`MIS1=A0L=07{a
=01=00=A0=0E{`
=01=00SMI_
=92
=01=A1	SMI_
=92
=00=86\/=05_SB_PCI0ISABFDC0AFDC
=01=A0 {`
=02=00=86\/=05_SB_PCI0ISABFDC0BFDC
=01=A0 {`
=04=00=86\/=05_SB_PCI0ISABFDC0BFDC
=01=A0M=05{a
=02=00=A0=0E{`
=02=00SMI_
=93
=01=A1	SMI_
=93
=00=A0 {`
=01=00=86\/=05_SB_PCI0ISABFDC0BFDC
=01=A1=1B=86\/=05_SB_PCI0ISABFDC0AFDC
=01=A0M=05{a
=04=00=A0=0E{`
=04=00SMI_
=94
=01=A1	SMI_
=94
=00=A0 {`
=01=00=86\/=05_SB_PCI0ISABFDC0BFDC
=01=A1=1B=86\/=05_SB_PCI0ISABFDC0AFDC
=01=A0I=05{a
=08=00=A0=0E{`
=08=00SMI_
=90
=01=A1	SMI_
=90
=00=86\/=05_SB_PCI0IDE0SEC0MAST
=01=A0=1E=93OSID
@=86\/=04_SB_PCI0IDE0SEC0
=01=A0B=04{a
=10=00=A0=0E{`
=10=00SMI_
=91
=01=A1	SMI_
=91
=00=86\/=07_SB_PCI0PCIEMPCIDIDEPRIMMAST
=01=14G=07SMIE=00pSMI_
=96
=00`=A0=13{`
=01=00=86\._TZ_THM_
=80=A0=1C{`
=02=00=86\/=04_SB_PCI0AGP_VID_
=80=A0 {`
=04=00=86\._SB_BAT0
=81=86\._SB_BAT1
=81=A0=13{`
=08=00=86\._PR_CPU0
=80=14=0E\_PTS=01SMI_
=8Ah=14N
\_WAK=01SMI_
=A7MIS2SMI_
=9Ah=A0*=93h
=04pSMI_
=98
=00MIS0pSMI_
=86
=00MIS1p
=01MIS4SOST=86\._SB_AC__
=80pSMI_
=87
=00`=7F`MIS2a=A0E=04a=A0=18`=86\/=04_SB_PCI0PCIEGDCK
=00=A1(=A0&=93OSID
=08SMI_
=8D
=00=86\/=04_SB_PCI0PCIEGDCK
=01p`MIS2=14A=0FNWAK=00p
=01WAKEpSMI_
=89
=00`p
=00a=A0	=93`
=00p
=01a=A0
{`
=01=00p
=01a=A0
{`
=02=00LIDE=A0=1C{`
=04=00=86\/=04_SB_PCI0ISABUAR1
=02=A02{`
=08=00=86\/=04_SB_PCI0PCIECRD0
=02=86\/=04_SB_PCI0PCIECRD1
=02=A0=1C{`
=10=00=86\/=04_SB_PCI0PCIEGDCK
=02=A0=1C{`
@=00=86\/=04_SB_PCI0PCIEGDCK
=01=A0=13{`
 =00=A0=0C=93OSID
=08p
=01a=A0=0Fa=86\._SB_PBTN
=02p
=00WAKE=10E=0C\_GPE=14
_L1D=00NEVT=14
_L1C=00NWAK=14=17_L0B=00p
=00`=86\._SB_PCI0
=02=14
_L18=00p
=00`=14 _L1B=00p
=00`=86\/=04_SB_PCI0PCIEMPCI
=02=14=18_L03=00=86\/=03_SB_PCI0USB0
=02=14=18_L04=00=86\/=03_SB_PCI0USB1
=02=14=18_L0C=00=86\/=03_SB_PCI0USB2
=02=14=18_L05=00=86\/=03_SB_PCI0MODM
=02=08CRS0=11=04=0B=01=01=8CCRS0=0B=00=01CRS1=14=0DCRS3=00p
=00CRS1=14=1ECRS4=01=8CCRS0CRS1CRS2phCRS2uCRS1=14#CRS5=01=8BCRS0CRS1CRS2phC=
RS2uCRS1uCRS1=14$CRS6=01=8ACRS0CRS1CRS2phCRS2rCRS1
=04CRS1=14!CR_0=03CRS4
=86CRS5
	CRS4hCRS6iCRS6j=14&CR_1=04CRS4
GCRS4
=01CRS5hCRS5iCRS4jCRS4k=14F=04CR_2=02CRS4
=88CRS5
=0DCRS4
=02CRS4
=0CCRS4
=00CRS5
=00CRS5hrhi`v`CRS5`CRS5
=00CRS5i=14F=04CR_3=02CRS4
=88CRS5
=0DCRS4
=01CRS4
=0CCRS4
=03CRS5
=00CRS5hrhi`v`CRS5`CRS5
=00CRS5i=14F=04CR_4=02CRS4
=87CRS5
=17CRS4
=00CRS4
=0CCRS4
=03CRS6
=00CRS6hrhi`v`CRS6`CRS6
=00CRS6i=14=0CCR_5=00CRS5
y=10C=13\_PR_[=83J=12CPU0=01=E0=08=00=00=06=08_PCT=12,=02=11=14
=11=82=0C=00=01=08=00=00=B2=00=00=00=00=00=00=00y=00=11=14
=11=82=0C=00=01=08=00=00=86=00=00=00=00=00=00=00y=00=08PSSX=12 =02=12=0E=06
=00
=00
=00
=00
=00
=00=12=0E=06
=00
=00
=00
=00
=00
=00=14B=0B_PSS=00SX10SX30
=0BSX11=88PSSX
=00`pSX42=88=83`
=00=00pSX42=88=83`
=01=00pSX42=88=83`
=02=00pSX42=88=83`
=03=00pSX40=88=83`
=04=00pSX40=88=83`
=05=00=88PSSX
=01apSX42=88=83a
=00=00pSX42=88=83a
=01=00pSX42=88=83a
=02=00pSX42=88=83a
=03=00pSX40=88=83a
=04=00pSX40=88=83a
=05=00SX12=A4PSSX=14=12_PPC=00pSMI_
=AF
=00`=A4`=08\_S0_=12=08=03
=00
=00
=00=08\_S1_=12=08=03
=02
=00
=00=08\_S3_=12=08=03
=05
=00
=00=08\_S4_=12=08=03
=07
=00
=00=08\_S5_=12=08=03
=07
=00
=00=10D=06\_TZ_[=85K=05THM_=14=17_CRT=00p
^`w`

`r`=0B=AC
`=A4`=14=10_TMP=00pGINF
=04`=A4`=14+GINF=01SX10SX30hSX11pSX41`SX12=A0=0B=95`=0B=A6=0Bp=0B=A6=0B`=A4=
`=10=8F=F6=01\_SB_[=80SMIR=01
=B2
=02[=81=10SMIR=01SMIC=08SMID=08[=82L=04AC__=08_HID=0DACPI0003=00=08_PCL=12=
=0F=03\_SB_BAT0BAT1=14=17_PSR=00pSMI_
=85
=00`{`
=01`=A4`=14	_STA=00=A4
=0F=08BIFP=12=02=0D=14L=0CBIF_=01SX10SX30
=01SX30hSX11pSX42=88BIFP
=00=00pSX42=88BIFP
=01=00pSX42=88BIFP
=02=00pSX42=88BIFP
=03=00pSX42=88BIFP
=04=00pSX42=88BIFP
=05=00pSX42=88BIFP
=06=00pSX42=88BIFP
=07=00pSX42=88BIFP
=08=00pSX45=88BIFP
	=00pSX45=88BIFP

=00pSX45=88BIFP
=0B=00pSX45=88BIFP
=0C=00SX12=A4BIFP[=82C=0DBAT0=08_HID=0CA=D0=0C
=08_UID
=01=08_PCL=12=07=01\_SB_=14=17_STA=00{MIS0
=02`=A0=05`=A4
=1F=A4
=0F=14=0D_BIF=00=A4BIF_
=01=14@=06_BST=00SX10SX30
=02SX30
=01SX11=08BST0=12=02=04pSX42=88BST0
=00=00pSX42=88BST0
=01=00pSX42=88BST0
=02=00pSX42=88BST0
=03=00SX12=A4BST0=14'_BTP=01SX10SX30
=03SX30
=01SX32hSX11SX12["
=FA[=82O=0CBAT1=08_HID=0CA=D0=0C
=08_UID
=02=08_PCL=12=07=01\_SB_=14=17_STA=00{MIS0
=10`=A0=05`=A4
=1F=A4
=0F=14=0D_BIF=00=A4BIF_
=02=14@=06_BST=00SX10SX30
=02SX30
=02SX11=08BST1=12=02=04pSX42=88BST1
=00=00pSX42=88BST1
=01=00pSX42=88BST1
=02=00pSX42=88BST1
=03=00SX12=A4BST1=14#_BTP=01SX10SX30
=03SX30
=02SX32hSX11SX12[=82<LID_=08_HID=0CA=D0=0C=0D=14=12_LID=00pSMI_
=84
=00`=A4`=08_PRW=12=06=02
=1C
=03=14=0D_PSW=01PSW_h
=02[=82)PBTN=08_HID=0CA=D0=0C=0C=08_PRW=12=06=02
=1C
=04=14=0D_PSW=01PSW_h
=01[=82=0FSBTN=08_HID=0CA=D0=0C=0E[=82H=0CMB1_=08_HID=0CA=D0=0C=01=08_UID
=01=14@=0B_CRS=00CRS3CR_0
=01
=00=0C=00=FC	=00CR_0
=01=0C=00=FC	=00=0B=00=04=A0"=91=93OSID
=10=93OSID
@pGORL`CR_0
=00=0C=00=00=0C=00`CR_0
=00=0C=00=00=0E=00=0C=00=00=02=00pGMEM`t`=0C=00=00=01=00aCR_0
=01=0C=00=00=10=00ara=0C=00=00=10=00aCR_0
=01a=0C=00=00=01=00CR_0
=00=0C=00=00=DA=FE=0C=00=00=06=00CR_0
=00=0C=00=00=F8=FF=0C=00=00=08=00CR_5=A4CRS0[=82=8B=B3=01PCI0=08_HID=0CA=D0
=03=08_ADR
=00=08_PRW=12=06=02
=0B
=03=14L=04_INI=00pSMI_
=98
=00MIS0{MIS0}
=01}
=02
=10=00=00MIS0pSMI_
=86
=00MIS1pSMI_
=87
=00MIS2p
=01MIS4SOST=14O	_CRS=00CRS3CR_2
=00=0B=00=01CR_3
=00=0B=F8=0CCR_1=0B=F8=0C=0B=F8=0C
=01
=08CR_3=0B=00=0D=0B=00=F3CR_4=0C=00=00
=00=0C=00=00=02=00CR_4=0C=00=00=0D=00=0C=00=00=01=00r=0C=00=00=10=00GMEM`t=
=0C=00=00=DA=FE`aCR_4`at=0C=00=00=B8=FF=0C=00=00=E0=FEaCR_4=0C=00=00=E0=FEa=
t=0C=00=00=F8=FF=0C=00=00=C0=FFaCR_4=0C=00=00=C0=FFaCR_5=A4CRS0[=82J=06MB2_=
=08_HID=0CA=D0=0C=01=08_UID
=02=08CRS_=11A=04
=3DG=01=92=00=92=00=02=01G=01=B2=00=B2=00=02=01G=01 =00 =00=10=02G=01=A0=00=
=A0=00=10=02"=04=00G=01=D0=04=D0=04=10=02G=01=00=08=00=08=10=06G=01=08=08=
=08=08=08=08y=00=14=0B_CRS=00=A4CRS_[=82F=06MB3_=08_HID=0CA=D0=0C=01=08_UID
=03=08CRS_=11=3D
:G=01=B3=00=B3=00=01=01G=01=06=08=06=08=02=02G=01=10=08=10=08=10PG=01`=08`=
=08=10 G=01=80=08=80=08=10@G=01=C0=08=C0=08=10 G=01=E0=08=E0=08=10 y=00=14=
=0B_CRS=00=A4CRS_[=82H=14MB5_=08_HID=0CA=D0=0C=01=08_UID
=05=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00=08C_ME=11B=05
NG=01=00=F0=00=F0=01=FFG=01=00=F2=00=F2=01=FFG=01=00=F4=00=F4=01=FFG=01=00=
=F6=00=F6=01=FFG=01=00=F8=00=F8=01=FFG=01=00=FA=00=FA=01=FFG=01=00=FC=00=FC=
=01=FFG=01=00=FE=00=FE=01=FF=86	=00=01=00=00=00=FA=00=00=00=02y=00=08C_2K=
=11J=07
vG=01=00=F0=00=F0=01=FFG=01=00=F1=00=F1=01=FFG=01=00=F2=00=F2=01=FFG=01=00=
=F4=00=F4=01=FFG=01=00=F5=00=F5=01=FFG=01=00=F6=00=F6=01=FFG=01=00=F8=00=F8=
=01=FFG=01=00=F9=00=F9=01=FFG=01=00=FA=00=FA=01=FFG=01=00=FC=00=FC=01=FFG=
=01=00=FD=00=FD=01=FFG=01=00=FE=00=FE=01=FFG=01=F0=FF=F0=FF=01=10=86	=00=01=
=00=00=00=FA=00=00=00=02y=00=14=1B_STA=00pSMI_
=87
=00`=A0=05`=A4
=00=A1=04=A4
=0F=14!_CRS=00=A0=15=91=93OSID
=10=93OSID
@=A4C_2K=A4C_ME[=82G=84ISAB=08_ADR=0C=00=00=1F=00[=80PIRQ=02
`
=04[=80FDIS=02
=F2
=02[=82)PS2M=08_HID=0CA=D0=0F=13=08CRS_=11=08
=05"=00=10y=00=14=0B_CRS=00=A4CRS_[=829KBC_=08_HID=0CA=D0=03=03=08CRS_=11=
=18
=15G=01`=00`=00=10=01G=01d=00d=00=04=01"=02=00y=00=14=0B_CRS=00=A4CRS_[=829=
RTC_=08_HID=0CA=D0=0B=00=08CRS_=11=18
=15G=01p=00p=00=10=02"=00=01G=01r=00r=00=02=06y=00=14=0B_CRS=00=A4CRS_[=829=
TMR_=08_HID=0CA=D0=01=00=08CRS_=11=18
=15G=01@=00@=00=10=04"=01=00G=01P=00P=00=10=04y=00=14=0B_CRS=00=A4CRS_[=82G=
=04SPKR=08_HID=0CA=D0=08=00=08CRS_=11%
"G=01a=00a=00=01=01G=01c=00c=00=01=01G=01e=00e=00=01=01G=01g=00g=00=01=01y=
=00=14=0B_CRS=00=A4CRS_[=82F=04MB4_=08_HID=0CA=D0=0C=01=08_UID
=04=08CRS_=11=1D
=1AG=01.=00.=00=02=02G=01=00	=00	=10 G=01=F0=03=F0=03=10=02y=00=14=0B_CRS=
=00=A4CRS_[=82F	PIC_=08_HID=0BA=D0=08CRS_=11F=07
rG=01$=00$=00=04=02G=01(=00(=00=04=02G=01,=00,=00=04=02G=010=000=00=04=02G=
=014=004=00=04=02G=018=008=00=04=02G=01<=00<=00=04=02G=01=A4=00=A4=00=04=02=
G=01=A8=00=A8=00=04=02G=01=AC=00=AC=00=04=02G=01=B0=00=B0=00=04=02G=01=B4=
=00=B4=00=04=02G=01=B8=00=B8=00=04=02G=01=BC=00=BC=00=04=02y=00=14=0B_CRS=
=00=A4CRS_[=82J=05MAD_=08_HID=0CA=D0=02=00=08CRS_=118
5*=10=04G=01=00=00=00=00=10=10G=01=80=00=80=00=10=10G=01=C0=00=C0=00=10 G=
=01=10=00=10=00=10=10G=01=90=00=90=00=10=02G=01=93=00=93=00=01=0Dy=00=14=0B=
_CRS=00=A4CRS_[=821COPR=08_HID=0CA=D0=0C=04=08CRS_=11=10
=0DG=01=F0=00=F0=00=10=10"=00 y=00=14=0B_CRS=00=A4CRS_[=82J#FDC0=08_HID=0CA=
=D0=07=00=14=10_STA=00pPNPQ
=00`=A4`=14=0C_DIS=00PNPD
=00=14=0D_CRS=00=A4PNPG
=00=08_PRS=11=1B
=18"@=00G=01=F2=03=F2=03=01=04G=01=F7=03=F7=03=01=01*=04=00y=00=14=0D_SRS=
=01PNPS
=00h=14F=0B_FDE=00=08FDEB=11=03
=14=8AFDEB
=00FDE0=8AFDEB
=04FDE1=8AFDEB
=08FDE2=8AFDEB
=0CFDE3=8AFDEB
=10FDE4p
=00FDE0p
=00FDE1p
=00FDE2p
=00FDE3p
=02FDE4pSMI_
=86
=00`{`
=07`=80
=07a{MIS1aa=A0,`p
=01FDE0=A0"{`
=01=00=A0=0D{`
=02=00p
=01FDE1=A0=0D{`
=04=00p
=01FDE1=A4FDEB=08FINF=12"=10
=00
=04
O
=12
=01
=AF
=02
%
=02
=12
=1B
=FF
l
=F6
=0F
=08[=82@=07AFDC=08_ADR
=00=08_RMV
=00=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00=14)_STA=00pSMI_
=86
=00`{`
=07`=80
=07a{MIS1aa=A0=05`=A4
=0F=A4
=00=14=16_FDI=00p
=00=88FINF
=00=00=A4FINF[=82L=07BFDC=08_ADR
=01=08_RMV
=00=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00=145_STA=00pSMI_
=86
=00`{`
=07`=80
=07a{MIS1aa=A0=08=93`
=03=A4
=0F=A0=08=93`
=05=A4
=0F=A4
=00=14=16_FDI=00p
=01=88FINF
=00=00=A4FINF[=82E=0BUAR1=08_HID=0CA=D0=05=01=14=10_STA=00pPNPQ
=02a=A4a=14=0C_DIS=00PNPD
=02=14=0D_CRS=00=A4PNPG
=02=14@=05_PRS=00=08BUF0=11>
;1=05#X=1C=11G=01=F8=03=F8=03=08=081=05#X=1C=11G=01=F8=02=F8=02=08=081=05#X=
=1C=11G=01=E8=03=E8=03=08=081=05#X=1C=11G=01=E8=02=E8=02=08=088y=00=A4BUF0=
=14=0D_SRS=01PNPS
=02h=08_PRW=12=06=02
=1C
=03=14=0D_PSW=01PSW_h
=04[=82E=15IRDA=08_HID=0CM=A3=F0=10=14=10_STA=00pPNPQ
=03`=A4`=14=0C_DIS=00PNPD
=03=14=0D_CRS=00=A4PNPG
=03=08_PRS=11E=10=0B=00=010"=10=00G=01=E8=03=E8=03=08=08G=01p=02=00=04=08=
=08*=0E=000"=10=00G=01=E8=03=E8=03=08=08G=01p=02=00=04=08=08*=00=000"X=10G=
=01=F8=02=F8=02=08=08G=01p=02=00=04=08=08*=0E=000"X=10G=01=F8=03=F8=03=08=
=08G=01p=02=00=04=08=08*=0E=000"X=10G=01=E8=03=E8=03=08=08G=01p=02=00=04=08=
=08*=0E=000"X=10G=01=E8=02=E8=02=08=08G=01p=02=00=04=08=08*=0E=000"X=10G=01=
=F8=03=F8=03=08=08G=01p=02=00=04=08=08*=00=000"X=10G=01=F8=02=F8=02=08=08G=
=01p=02=00=04=08=08*=00=000"X=10G=01=E8=03=E8=03=08=08G=01p=02=00=04=08=08*=
=00=000"X=10G=01=E8=02=E8=02=08=08G=01p=02=00=04=08=08*=00=000"X=10G=01=E8=
=03=E8=03=08=08G=01=00=00=00=00=08=00*=00=008y=00=14=0D_SRS=01PNPS
=03h[=82A=14ECP_=08_HID=0CA=D0=04=01=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00=14=10=
_STA=00pPNPQ
=01a=A4a=14=0C_DIS=00PNPD
=01=14=0D_CRS=00=A4PNPG
=01=08_PRS=11F
=D20*=00=00"=B8=00G=01x=03x=03=08=08G=01x=07x=07=08=040*=0E=00"=80=00G=01x=
=03x=03=08=08G=01x=07x=07=08=040*=00=00"=B8=00G=01x=02x=02=08=08G=01x=06x=
=06=08=040*=0E=00"=B8=00G=01x=02x=02=08=08G=01x=06x=06=08=040*=00=00"=B8=00=
G=01=BC=03=BC=03=04=04G=01=BC=07=BC=07=04=040*=0E=00"=B8=00G=01=BC=03=BC=03=
=04=04G=01=BC=07=BC=07=04=040*=00=00"=00=00G=01x=03x=03=08=08G=01x=07x=07=
=08=040*=00=00"=00=00G=01x=02x=02=08=08G=01x=06x=06=08=040*=00=00"=00=00G=
=01=BC=03=BC=03=04=04G=01=BC=07=BC=07=04=048y=00=14=0D_SRS=01PNPS
=01h[=82M=05USB0=08_ADR=0C=00=00=1D=00[=80AD0_=02
=20
=04=08XPRW=12=06=02
=03
=01=08YPRW=12=06=02
=03
=00=14=1B_PRW=00=A0=0D=93OSID
 =A4YPRW=A1=06=A4XPRW[=82=0CHUB0=08_ADR
=00[=82@=0BUSB1=08_ADR=0C=01=00=1D=00[=80AD1_=02
=20
=04=08XPRW=12=06=02
=04
=01=08YPRW=12=06=02
=04
=00=14=1B_PRW=00=A0=0D=93OSID
 =A4YPRW=A1=06=A4XPRW[=82O=05HUB1=08_ADR
=00[=82'CH10=08_ADR
=01=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00[=82'CH11=08_ADR
=02=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00[=82K=0CUSB2=08_ADR=0C=02=00=1D=00=08_E=
JD=0D\_SB_.PCI0.PCIE.GDCK=00[=80AD2_=02
=20
=04=08XPRW=12=06=02
=0C
=01=08YPRW=12=06=02
=0C
=00=14=1B_PRW=00=A0=0D=93OSID
 =A4YPRW=A1=06=A4XPRW[=82O=05HUB2=08_ADR
=00[=82'CH20=08_ADR
=01=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00[=82'CH21=08_ADR
=02=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00[=82G	USB3=08_ADR=0C=07=00=1D=00=08_EJD=0D=
\_SB_.PCI0.PCIE.GDCK=00[=80AD3_=02
=20
=04[=82O=05HUB3=08_ADR
=00[=82'CH30=08_ADR
=01=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00[=82'CH31=08_ADR
=02=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00[=81=1A\/=04_SB_PCI0USB1AD1_=03U1BS [=
=81=1A\/=04_SB_PCI0USB2AD2_=03U2BS [=81=1A\/=04_SB_PCI0USB0AD0_=03U0BS [=81=
-\/=04_SB_PCI0ISABFDIS=02=00=08F0DS=01F1DS=01F2DS=01=00=04F7DS=01[=82@=0DMB=
6_=08_HID=0CA=D0=0C=01=08_UID
=06=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00=14=1B_STA=00pSMI_
=87
=00`=A0=05`=A4
=00=A1=04=A4
=0F=14A=08_CRS=00=08CUSB=11

G=01=00=00=00=00=01 y=00=8BCUSB
=02U1MN=8BCUSB
=04U1MX=8CCUSB
=07U1LNpF1DScp
=00F1DSpU1BSa{a=0B=FE=FFU1MN{a=0B=FE=FFU1MX=A0=0CU1MNp
 U1LN=A1=08p
=00U1LNpcF1DS=A4CUSB[=82-MB8_=08_HID=0CA=D0=0C=01=08_UID
=08=08_CRS=11=11
=0E=86	=00=01=00=FC=BF=FE=00=04=00=00y=00=08_PRT=12A=11
=12=1A=04=0C=FF=FF=1F=00
=00\/=03_SB_PCI0LNKA
=00=12=1A=04=0C=FF=FF=1F=00
=01\/=03_SB_PCI0LNKB
=00=12=1A=04=0C=FF=FF=1F=00
=02\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=1F=00
=03\/=03_SB_PCI0LNKD
=00=12=1A=04=0C=FF=FF=1D=00
=00\/=03_SB_PCI0LNKA
=00=12=1A=04=0C=FF=FF=1D=00
=01\/=03_SB_PCI0LNKD
=00=12=1A=04=0C=FF=FF=1D=00
=02\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=02=00
=00\/=03_SB_PCI0LNKA
=00=12=1A=04=0C=FF=FF=01=00
=00\/=03_SB_PCI0LNKA
=00=12=1A=04=0C=FF=FF=01=00
=01\/=03_SB_PCI0LNKB
=00[=81)\/=04_SB_PCI0ISABPIRQ=01PIRA=08PIRB=08PIRC=08PIRD=08[=82D=0CLNKA=08=
_HID=0CA=D0=0C=0F=08_UID
=01=08_PRS=11=09
=06#=00=0E=18y=00=14=1D_STA=00pPIRA`{`
=80`=A0=08=93`
=80=A4
	=A4
=0B=14=17_DIS=00pPIRA`}`
=80`p`PIRA=14J=04_CRS=00=08BUFA=11=09
=06#=00=00=18y=00=8BBUFA
=01IRA_pPIRA`{`
=8F`=A0=18=95`
=80{`
=0F=00p
=01aya`apaIRA_=A4BUFA=14=1C_SRS=01=8Bh
=01IRQA=81IRQA`v`p`PIRA[=82D=0CLNKB=08_HID=0CA=D0=0C=0F=08_UID
=02=08_PRS=11=09
=06#=A0=00=18y=00=14=1D_STA=00pPIRB`{`
=80`=A0=08=93`
=80=A4
	=A4
=0B=14=17_DIS=00pPIRB`}`
=80`p`PIRB=14J=04_CRS=00=08BUFB=11=09
=06#=00=00=18y=00=8BBUFB
=01IRB_pPIRB`{`
=8F`=A0=18=95`
=80{`
=0F=00p
=01aya`apaIRB_=A4BUFB=14=1C_SRS=01=8Bh
=01IRQB=81IRQB`v`p`PIRB[=82D=0CLNKC=08_HID=0CA=D0=0C=0F=08_UID
=03=08_PRS=11=09
=06#=00=0E=18y=00=14=1D_STA=00pPIRC`{`
=80`=A0=08=93`
=80=A4
	=A4
=0B=14=17_DIS=00pPIRC`}`
=80`p`PIRC=14J=04_CRS=00=08BUFC=11=09
=06#=00=00=18y=00=8BBUFC
=01IRC_pPIRC`{`
=8F`=A0=18=95`
=80{`
=0F=00p
=01aya`apaIRC_=A4BUFC=14=1C_SRS=01=8Bh
=01IRQC=81IRQC`v`p`PIRC[=82D=0CLNKD=08_HID=0CA=D0=0C=0F=08_UID
=04=08_PRS=11=09
=06#=A0=0E=18y=00=14=1D_STA=00pPIRD`{`
=80`=A0=08=93`
=80=A4
	=A4
=0B=14=17_DIS=00pPIRD`}`
=80`p`PIRD=14J=04_CRS=00=08BUFD=11=09
=06#=00=00=18y=00=8BBUFD
=01IRD_pPIRD`{`
=8F`=A0=18=95`
=80{`
=0F=00p
=01aya`apaIRD_=A4BUFD=14=1C_SRS=01=8Bh
=01IRQD=81IRQD`v`p`PIRD[=82I	IDE0=08_ADR=0C=01=00=1F=00=14	_STA=00=A4
=0F[=82=16PRI_=08_ADR
=00=14	_STA=00=A4
=0F[=82E=06SEC0=08_ADR
=01=14	_STA=00=A4
=0F[=82L=04MAST=08_ADR
=00=08_RMV
=00=147_STA=00pSMI_
=86
=00`{`
=08`=A0=10`}MIS1
=08MIS1=A4
=0F=80
=08`{MIS1`MIS1=A4
=00[=82=0FAUD_=08_ADR=0C=05=00=1F=00[=82=1BMODM=08_ADR=0C=06=00=1F=00=08_PR=
W=12=06=02
=05
=03[=82J=0FAGP_=08_ADR=0C=00=00=01=00=08_PRT=12=1B=01=12=18=04=0B=FF=FF
=00\/=03_SB_PCI0LNKA
=00[=82G=0CVID_=08_ADR
=00=14=16_DOS=01phMIS4SMI_
=9EMIS4=14=14_DOD=00=A4=12=0C=02=0C=00=01=01=00=0C=10=01=01=00[=82E=04CRT_=
=14
_ADR=00=A4=0B=00=01=14=12_DCS=00pSMI_
=8E
=01`=A4`=14=12_DGS=00pSMI_
=99
=01`=A4`=14=0D_DSS=01DSS_
=01h[=82E=04LCD_=14
_ADR=00=A4=0B=10=01=14=12_DCS=00pSMI_
=8E
=02`=A4`=14=12_DGS=00pSMI_
=99
=02`=A4`=14=0D_DSS=01DSS_
=02h[=82GZPCIE=08_ADR=0C=00=00=1E=00=08_PRW=12=06=02
=0B
=03=08_PRT=12N=0B=07=12=1A=04=0C=FF=FF=01=00
=00\/=03_SB_PCI0LNKD
=00=12=1A=04=0C=FF=FF=01=00
=01\/=03_SB_PCI0LNKD
=00=12=1A=04=0C=FF=FF=01=00
=02\/=03_SB_PCI0LNKD
=00=12=1A=04=0C=FF=FF=03=00
=00\/=03_SB_PCI0LNKD
=00=12=1A=04=0C=FF=FF=03=00
=01\/=03_SB_PCI0LNKB
=00=12=18=04=0B=FF=FF
=00\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=08=00
=00\/=03_SB_PCI0LNKC
=00[=82,CRD0=08_ADR=0C=00=00=01=00=14=0E_INI=00SMI_
=95
=04=08_S1D
=00=08_S3D
=03[=82,CRD1=08_ADR=0C=01=00=01=00=14=0E_INI=00SMI_
=9D
=04=08_S1D
=00=08_S3D
=03[=82F=14GDCK=08_HID=0CA=D0=0C=15=14G=05_STA=00=A0<{MIS5
=01=00pSMI_
=8D
=02b=A0(bpSMI_
=87
=00`=A0=18`=86\/=04_SB_PCI0PCIEGDCK
=00=A4
=00pSMI_
=87
=00`=A0=05`=A4
=0F=A4
=00=14(_UID=00SX10SX30
=05SX30OSIDSX11pSX42`SX12=A4`=14@=05_BDN=00pSMI_
=87
=00`=A0=0B=93`
=01=A4=0C=10=AC=80=07=A0=0B=93`
=02=A4=0C=10=AC=80=08=A0=0B=93`
=04=A4=0C=10=AC=80	=A0=0B=93`
=08=A4=0C=10=AC=80
=A0=0B=93`
=10=A4=0C=10=AC=80=0B=A4
=00=14	_EJ3=01=A4
=00=14I=05_DCK=01=A0=11hSMI_
=8D
=01p
=00MIS5=A1=17SMI_
=8D
=00p
=00MIS2p
=01MIS5}
=04
=10apSMI_
=86
=00`{`a`=80aa{MIS1aa}a`MIS1=A4
=01[=82*JLAN=08_ADR=0C=00=00=08=00=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00[=82E/MP=
CI=08_ADR=0C=00=00=0C=00=08_PRW=12=06=02
=1B
=03=08_EJD=0D\_SB_.PCI0.PCIE.GDCK=00=08ZPRT=12=0E=01=12=0B=04=0B=FF=FF
=00
=00
=00=08BPRT=12@=0C=07=12=1A=04=0C=FF=FF=05=00
=00\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=01=00
=00\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=01=00
=01\/=03_SB_PCI0LNKB
=00=12=1A=04=0C=FF=FF=01=00
=02\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=01=00
=03\/=03_SB_PCI0LNKB
=00=12=1A=04=0C=FF=FF=07=00
=00\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=08=00
=00\/=03_SB_PCI0LNKC
=00=08HPRT=12L=12=0B=12=1A=04=0C=FF=FF=05=00
=00\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=01=00
=00\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=01=00
=01\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=01=00
=02\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=01=00
=03\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=02=00
=00\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=02=00
=01\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=02=00
=02\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=02=00
=03\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=07=00
=00\/=03_SB_PCI0LNKC
=00=12=1A=04=0C=FF=FF=08=00
=00\/=03_SB_PCI0LNKC
=00=14+_PRT=00pSMI_
=87
=00`=A0
=93`
=02=A4BPRT=A0
=93`
=08=A4HPRT=A4ZPRT[=82F=04ADPT=08_ADR=0C=00=00=07=00[=84(PADA=00=00=00=14	_S=
TA=00=A4
=01=14
_ON_=00p
=00`=14
_OFF=00p
=00`=08_PR0=12=06=01PADA[=82<DIDE=08_ADR=0C=00=00=05=00[=82+PRIM=08_ADR
=00=14	_STA=00=A4
=0F[=82=13MAST=08_ADR
=00=08_RMV
=00
--=-B2/o8gfdCuFtajoV8lQY--



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
