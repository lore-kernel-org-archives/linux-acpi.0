From: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: No battery information - Compaq Evo N800v, 2.4.20pre8, acpi 20021002
Date: 31 Dec 2002 06:29:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87n0mmzrh1.fsf@lapper.ihatent.com>
References: <200210081115.21667.mark.pritchard-acpi@modus.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mark Pritchard <mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I've had some limited success now with getting things to work on y
Compaq Evo n800c. Currently I'm running on 2.4.20 with the ACPI patch
version 20021212. It does not apply cleanly to my version of 2.4.20,
and I don't have access to the net just now to see if it's my version
of the kernel or if it's the ACPI that is bad. However, its just parts
of the mpparse.c file it complains about and I'm on a UP system.

Basically what I've done is to get the DSDT form my system, disasemble
it with iasl, recompile it with iasl after only fixing the *'es on the
PnP resources, and not altering C11D->BAT1, etc.

The only thing I cannot do is to display the content of
/proc/acpi/battery/C11D/state. What whill happen is that it will
happily show me the content and then the machine will coldly restat
after a few seconds. Doing a "sync; cat /proc/acpi/battery/C11D/*>
blah; sync" left me with this content though:

-- alarm:
alarm:                   unsupported

-- info:
present:                 yes
design capacity:         1918 mAh
last full capacity:      1918 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 192 mAh
design capacity low:     0 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            Primary
serial number:           30 30 32 36 00 00 00 00
battery type:            4E4F494C
OEM info:                 COMPAQ 

-- state:
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            1400 mA
remaining capacity:      1913 mAh
present voltage:         16012 mV

And it's been a long time since I've had much physics, but the design
capacity doesn't seem right to me. I'm able to run about 13-14 mins on
battery, before the machine dies, from a fully charged battery.

After rebooting, this is what the entries said:

-- alarm:
alarm:                   unsupported

-- info:
present:                 yes
design capacity:         1918 mAh
last full capacity:      1918 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 192 mAh
design capacity low:     0 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            Primary
serial number:           30 30 32 36 00 00 00 00
battery type:            4E4F494C
OEM info:                 COMPAQ 

-- state:
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            1169 mA
remaining capacity:      724 mAh
present voltage:         16690 mV

It's also interesting to note taht with the new DSDT I chopped
together myself, the LED indicating it's time to get plugged into an
AC adapter or loose work, does not work anymore.

Currently my bootlog gives me this:

ACPI: RSDP (v000 COMPAQ                     ) @ 0x000f9970
ACPI: RSDT (v001 COMPAQ CPQ004A  04368.00544) @ 0x2fff0c84
ACPI: FADT (v002 COMPAQ CPQ004A  00000.00002) @ 0x2fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 00000.04097) @ 0x2fff65d4
ACPI: SSDT (v001 COMPAQ   CPQMag 00000.04097) @ 0x2fff66e2
ACPI: DSDT (v001 COMPAQ  EVON800 00001.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: root=/dev/hda5 ro hdc=ide-scsi s
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1694.553 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3381.65 BogoMIPS
Memory: 775208k/786240k available (1339k kernel code, 10644k reserved, 455k data, 112k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021212
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
    ACPI-0274: *** Info: Table [DSDT] replaced by host OS
    ACPI-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
    ACPI-0263: *** Info: GPE Block1 defined as GPE16 to GPE31
    ACPI-0243: *** Error: Could not install Pci_config handler for C03C, AE_ALREADY_EXISTS
    ACPI-0243: *** Error: Could not install Pci_config handler for C03C, AE_ALREADY_EXISTS
    ACPI-0243: *** Error: Could not install Pci_config handler for C03C, AE_ALREADY_EXISTS
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [C03C] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.C03C._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C03D._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C04E._PRT]
ACPI: Embedded Controller [C0D0] (gpe 29)
schedule_task(): keventd has not started
ACPI: Power Resource [C141] (off)
ACPI: Power Resource [C155] (off)
ACPI: Power Resource [C159] (off)
ACPI: Power Resource [C15D] (off)
ACPI: Power Resource [C166] (on)
ACPI: PCI Interrupt Link [C0B6] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0B7] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [C0B8] (IRQs 5 10 11, disabled)
ACPI: PCI Interrupt Link [C0B9] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BA] (IRQs 5 *10 11)
ACPI: Power Resource [C0CF] (on)
ACPI: Power Resource [C1D5] (off)
ACPI: Power Resource [C1D6] (off)
ACPI: Power Resource [C1D7] (off)
ACPI: Power Resource [C1D8] (off)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [C0B8] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found

For what it's worth, at least I've made some progress, and my machine
seems to at least know when to throttle up and down from the C-states:

lapper root # cat /proc/acpi/processor/C000/power 
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00001030]
   *C2:                  promotion[C3] demotion[C1] latency[002] usage[00198960]
    C3:                  promotion[--] demotion[C2] latency[085] usage[00000148]

If anyone have pointers on how to take this further, please let us
know? :)

mvh,
A

Mark Pritchard <mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org> writes:

> Hi,
> 
> I'm having a problem with seeing battery status on my Compaq Evo N800v. The 
> proc filesystem has plenty of entries for everything other than the battery 
> (I've included a list below). 
> 
> I'd really appreciate some advice, and I'm more than happy to provide more 
> info/test things.
> 
> Cheers
> 
> Mark Pritchard
> 
> -------------------
> 
> Useful info:
> 
> * RedHat 7.3
> 
> * Kernel 2.4.20-pre8 with acpi-20021002-2.4.20-pre8.diff.gz
> 
> * DSDT available at 
> 
> 	http://www.modus.com.au/scratch/dsdt.compaq_evo_n800v.gz
> 
> * Contents of /proc/acpi:
> 
> [pritchma@seth pritchma]$ find /proc/acpi |sort
> /proc/acpi
> /proc/acpi/ac_adapter
> /proc/acpi/ac_adapter/C11A
> /proc/acpi/ac_adapter/C11A/state
> /proc/acpi/alarm
> /proc/acpi/button
> /proc/acpi/button/power
> /proc/acpi/button/power/PWRF
> /proc/acpi/button/power/PWRF/info
> /proc/acpi/dsdt
> /proc/acpi/event
> /proc/acpi/fadt
> /proc/acpi/info
> /proc/acpi/power_resource
> /proc/acpi/power_resource/C0CF
> /proc/acpi/power_resource/C0CF/state
> /proc/acpi/power_resource/C140
> /proc/acpi/power_resource/C140/state
> /proc/acpi/power_resource/C154
> /proc/acpi/power_resource/C154/state
> /proc/acpi/power_resource/C158
> /proc/acpi/power_resource/C158/state
> /proc/acpi/power_resource/C15B
> /proc/acpi/power_resource/C15B/state
> /proc/acpi/power_resource/C164
> /proc/acpi/power_resource/C164/state
> /proc/acpi/power_resource/C1D0
> /proc/acpi/power_resource/C1D0/state
> /proc/acpi/power_resource/C1D1
> /proc/acpi/power_resource/C1D1/state
> /proc/acpi/power_resource/C1D2
> /proc/acpi/power_resource/C1D2/state
> /proc/acpi/power_resource/C1D3
> /proc/acpi/power_resource/C1D3/state
> /proc/acpi/processor
> /proc/acpi/processor/C000
> /proc/acpi/processor/C000/info
> /proc/acpi/processor/C000/limit
> /proc/acpi/processor/C000/performance
> /proc/acpi/processor/C000/power
> /proc/acpi/processor/C000/throttling
> /proc/acpi/sleep
> /proc/acpi/thermal_zone
> /proc/acpi/thermal_zone/TZ1
> /proc/acpi/thermal_zone/TZ1/cooling_mode
> /proc/acpi/thermal_zone/TZ1/polling_frequency
> /proc/acpi/thermal_zone/TZ1/state
> /proc/acpi/thermal_zone/TZ1/temperature
> /proc/acpi/thermal_zone/TZ1/trip_points
> /proc/acpi/thermal_zone/TZ2
> /proc/acpi/thermal_zone/TZ2/cooling_mode
> /proc/acpi/thermal_zone/TZ2/polling_frequency
> /proc/acpi/thermal_zone/TZ2/state
> /proc/acpi/thermal_zone/TZ2/temperature
> /proc/acpi/thermal_zone/TZ2/trip_points
> /proc/acpi/thermal_zone/TZ3
> /proc/acpi/thermal_zone/TZ3/cooling_mode
> /proc/acpi/thermal_zone/TZ3/polling_frequency
> /proc/acpi/thermal_zone/TZ3/state
> /proc/acpi/thermal_zone/TZ3/temperature
> /proc/acpi/thermal_zone/TZ3/trip_points
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
Alexander Hoogerhuis                               | alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
