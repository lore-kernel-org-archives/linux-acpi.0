From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Repeatable lockup with sustained polling of battery state
Date: 30 Oct 2002 16:29:18 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036013358.9704.93.camel@sirius.strandboge.cxm>
References: <1034266219.1287.40.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1034266219.1287.40.camel-Ty44UuN9vPJ5T2F9fCU5s856D9/Od9gv@public.gmane.org>
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

I posted the below a few weeks ago, and am very interested in getting
this issue resolved.  This was my first post to the list, and I tried to
give as much info as I could, but nobody responded.

What should I send in that would be more helpful?  I am willing to try
patches, etc.  

Jamie Strandboge

On Thu, 2002-10-10 at 12:10, James D Strandboge wrote:
> I started using ACPI for my Dell Inspiron 8200 (Debian Sid, with kernel
> 2.4.19 with the acpi20021008 patch) recently, and have in general had
> good results.  However, when polling /proc/acpi/battery/BAT1/state for
> any length of time, the system freezes.  I can ping it, but cannot login
> with ssh or telnet.  I have adjusted the BIOS (I turned of USB Legacy
> support) as well as passing pci=noacpi to the kernel on boot with no
> change.  I have also used the 20020918 patch with no change. 
> /var/log/acpid and /var/log/kern.log don't show any errors either.
> 
> To make sure it was just the acpi code, and not usb or X or something
> else, I booted into single user mode (after a reboot), then ran
> '/etc/init.d/hotplug stop'.  I also used rmmod on all modules except
> 'unix' and 'rtc'.  The system froze, but because I didn't enable
> networking for the test, I couldn't ping it-- but in all previous tests
> (eg with X, with USB, etc)  I could always ping, I just couldn't ssh or
> telnet
> 
> I use this script to trigger the event, which can take anywhere from a
> few minutes to an hour to trigger the lockup:
> #!/bin/sh
> 
> while [ /bin/true ]
> do
> 	REMAIN=`grep remain /proc/acpi/battery/BAT1/state | awk '{ print $3 }'`
> 	if [ $REMAIN -lt 0 ]
> 	then
> 		echo "problem"
> 		exit 1
> 	fi
> 	echo $REMAIN
> done
> exit 0;
> 
> I have never seen the 'problem' echo from the script.  Once when viewing
> the aftermath of a lockup, however, the script complained that $REMAIN
> was not set, so I assume /proc/acpi/battery/BAT1/state was not available
> at that time.  Today, I had a blank screen after the lockup, so I don't
> know what the script said.
> 
> Here is the output of dmesg:
> 
> Linux version 2.4.19-acpi2dbg (james-Ty44UuN9vPJ5T2F9fCU5s856D9/Od9gv@public.gmane.org) (gcc version
> 2.95.4 20011002 (Debian prerelease)) #1 Sun Oct 6 23:16:09 EDT 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001ffe2800 (usable)
>  BIOS-e820: 000000001ffe2800 - 0000000020000000 (reserved)
>  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
>  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
> 511MB LOWMEM available.
> ACPI: have wakeup address 0xc0001000
> Advanced speculative caching feature not present
> On node 0 totalpages: 131042
> zone(0): 4096 pages.
> zone(1): 126946 pages.
> zone(2): 0 pages.
> ACPI: RSDP (v000 DELL                       ) @ 0x000fde50
> ACPI: RSDT (v001 DELL    CPi R   10194.01539) @ 0x000fde64
> ACPI: FADT (v001 DELL    CPi R   10194.01539) @ 0x000fde90
> ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000
> ACPI: BIOS passes blacklist
> Kernel command line: 1 root=/dev/hda5 ro hdb=ide-scsi noapic
> video=vga16:off
> ide_setup: hdb=ide-scsi
> Initializing CPU#0
> Detected 1595.322 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 3185.04 BogoMIPS
> Memory: 516156k/524168k available (1124k kernel code, 7624k reserved,
> 478k data, 92k init, 0k highmem)
> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
> Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> CPU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 12K, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: After vendor init, caps: 3febf9ff 00000000 00000000 00000000
> CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
> CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
> CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
> mtrr: detected mtrr type: Intel
> ACPI: Subsystem revision 20021002
> PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=2
> PCI: Using configuration type 1
>  tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully
> acquired
> Parsing
> Methods:......................................................................................................................................................................
> Table [DSDT] - 439 Objects with 68 Devices 166 Methods 7 Regions
> ACPI Namespace successfully loaded at root c02c185c
> evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode
> successful
> Executing all Device _STA and_INI
> methods:....................................................................
> 68 Devices found containing: 68 _STA, 3 _INI methods
> Completing Region/Field/Buffer/Package
> initialization:..............................................................
> Initialized 5/7 Regions 2/10 Fields 22/25 Buffers 33/33 Packages (439
> nodes)
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> Unknown bridge resource 2: assuming transparent
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:1d.01 not
> present in PCI namespace
> pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:1d.07 not
> present in PCI namespace
> ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7, enabled at IRQ 11)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
> pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:08.00 not
> present in PCI namespace
> pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:0c.00 not
> present in PCI namespace
> ACPI: Power Resource [PADA] (on)
> PCI: Probing PCI hardware
> PCI: Using ACPI for IRQ routing
> PCI: if you experience problems, try using option 'pci=noacpi' or even
> 'acpi=off'
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> VFS: Diskquotas version dquot_6.4.0 initialized
> Journalled Block Device driver loaded
> devfs: v1.12a (20020514) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
> devfs: boot_options: 0x0
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [BAT0] (battery absent)
> ACPI: Battery Slot [BAT1] (battery present)
> ACPI: Lid Switch [LID]
> ACPI: Power Button (CM) [PBTN]
> ACPI: Sleep Button (CM) [SBTN]
> ACPI: Processor [CPU0] (supports C1 C2, 2 performance states, 8
> throttling states)
> ACPI: Thermal Zone [THM] (56 C)
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT
> SHARE_IRQ SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS02 at 0x03e8 (irq = 4) is a 16550A
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ICH3M: IDE controller on PCI bus 00 dev f9
> PCI: Enabling device 00:1f.1 (0005 -> 0007)
> ICH3M: chipset revision 2
> ICH3M: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
> hda: IC25N040ATCS05-0, ATA DISK drive
> hdb: TOSHIBA CD-RW/DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
> ide2: ports already in use, skipping probe
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: 78140160 sectors (40008 MB) w/7898KiB Cache, CHS=4864/255/63
> Partition check:
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> Linux IP multicast router 0.06 plus PIM-SM
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 92k freed
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Adding Swap: 265032k swap-space (priority -1)
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
> Real Time Clock Driver v1.10e
> Intel 810 + AC97 Audio, version 0.21, 10:15:53 Oct  7 2002
> PCI: Setting latency timer of device 00:1f.5 to 64
> i810: Intel ICH3 found at IO 0xdc80 and 0xd800, IRQ 11
> i810_audio: Audio Controller supports 6 channels.
> ac97_codec: AC97 Audio codec, id: 0x4352:0x595b (Unknown)
> i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
> ac97_codec: AC97 Modem codec, id: 0x4358:0x5421 (Unknown)
> i810_audio: timed out waiting for codec 1 analog ready.
> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.275 $ time 10:16:05 Oct  7 2002
> usb-uhci.c: High bandwidth mode enabled
> PCI: Setting latency timer of device 00:1d.0 to 64
> usb-uhci.c: USB UHCI at I/O 0xbf80, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Setting latency timer of device 00:1d.2 to 64
> usb-uhci.c: USB UHCI at I/O 0xbf20, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> usb.c: USB disconnect on device 1
> usb.c: USB bus 1 deregistered
> usb.c: USB disconnect on device 1
> usb.c: USB bus 2 deregistered
> usb.c: deregistering driver usbdevfs
> usb.c: deregistering driver hub
> scsi : 0 hosts left.
> 
> 
> Here is the output of ps aux, before I ran my script:
> 
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> root         1  2.2  0.0  1268  480 ?        S    07:26   0:03 init
> [S]     
> root         2  0.0  0.0     0    0 ?        SW   07:26   0:00 [keventd]
> root         3  0.0  0.0     0    0 ?        SWN  07:26   0:00
> [ksoftirqd_CPU0]
> root         4  0.0  0.0     0    0 ?        SW   07:26   0:00 [kswapd]
> root         5  0.0  0.0     0    0 ?        SW   07:26   0:00 [bdflush]
> root         6  0.0  0.0     0    0 ?        SW   07:26   0:00
> [kupdated]
> root         7  0.0  0.0     0    0 ?        SW   07:26   0:00
> [kjournald]
> root        71  0.0  0.0     0    0 ?        SW   07:27   0:00
> [kjournald]
> root       345  0.0  0.0  1268  480 tty1     S    07:27   0:00 init
> [S]     
> root       346  0.0  0.2  2384 1396 tty1     S    07:27   0:00 bash
> root       443  0.0  0.1  2568  780 tty1     R    07:29   0:00 ps aux
> 
> 
> 
> Here are the contents of the three files for this battery.
> 
> cat /proc/acpi/battery/BAT1/alarm:
> alarm:                   3000 mWh
> 
> cat /proc/acpi/battery/BAT1/info:
> present:                 yes
> design capacity:         65120 mWh
> last full capacity:      63270 mWh
> battery technology:      rechargeable
> design voltage:          14800 mV
> design capacity warning: 3000 mWh
> design capacity low:     1000 mWh
> capacity granularity 1:  200 mWh
> capacity granularity 2:  200 mWh
> model number:            LIP8120DLP
> serial number:           60765
> battery type:            LION
> OEM info:                Sony Corp.
> 
> cat /proc/acpi/battery/BAT1/state:
> present:                 yes
> capacity state:          ok
> charging state:          unknown
> present rate:            unknown
> remaining capacity:      65120 mWh
> present voltage:         16670 mV
> 
> 
> Here are the contents of /proc/interrupts when the system is booted into
> runlevel 3 (with X on my machine).
> 
> cat /proc/interrupts:
>            CPU0       
>   0:     283973          XT-PIC  timer
>   1:       8881          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   8:          3          XT-PIC  rtc
>   9:          0          XT-PIC  acpi
>  11:        928          XT-PIC  Intel ICH3, usb-uhci, usb-uhci, Texas
> Instruments PCI4451 PC card Cardbus Controller, Texas Instruments
> PCI4451 PC card Cardbus Controller (#2), eth0
>  12:      29430          XT-PIC  PS/2 Mouse
>  14:     203208          XT-PIC  ide0
> NMI:          0 
> ERR:          0
> 
> 
> 
> Please let me know if I can supply any other information or test
> patches.  Other 8200 users have simply said acpi doesn't work on this
> laptop, but that is not true.  AC, LID and POWERBTN events all work fine
> (haven't tried sleep yet) and I can change the CPU performance (haven't
> tried throttling yet).  Polling the battery is the only problem I have
> had so far-- it generally works, but sustained polling doesn't.  As long
> as I don't poll the battery, I've had the system run for days with no
> problems.  I did look at the kernel source, but there wasn't anything
> obvious (to me) that was wrong.
> 
> Thanks,
> 
> Jamie Strandboge
> 
> -- 
> Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
> GPG/PGP ID:   26384A3A
> Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A
> 
> Visit Perinton Nursery School at:
> http://perintonnurseryschool.org/
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

Visit Perinton Nursery School at:
http://perintonnurseryschool.org/



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
