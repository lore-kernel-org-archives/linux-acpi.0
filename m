From: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>
Subject: Re: No handler for Region [ERAM] on Gateway M350?
Date: Sun, 11 Jan 2004 14:04:29 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0401111400070.18870-100000@data.upl.cs.wisc.edu>
References: <1073784787.4900.14.camel@kinkakuji>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1073784787.4900.14.camel-o+XryGznM0/1KXRcyAk9cg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dan <dan-bIuJOMs36aklhIHd5qHT+2D2FQJk+8+b@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Check the archives of this list for the threads titled:

  /proc/battery empty on Gateway 400VTX
  acpi on gateway 200x
  acpi on new gateway laptops
  Gateway 200x - trouble supplying ECDT table
  ACPI/ECDT on gateway 200x notebook

As well as this bug entry:
  http://bugzilla.kernel.org/show_bug.cgi?id=1744


In short:
  1) Apply the latest acpi patches

  2) Make sure your DSDT is correct as per
     http://acpi.sourceforge.net/dsdt/index.php

  3) Apply the patch listed in the bugzilla entry

I believe the patches were for 2.4.x branch. I'm assuming once a suitable
fix/workaround is determined this stuff will make it into the standard
acpi patch sets and eventually into the mainstream kernels. Not exactly an
easy solution, but it does appear to work for those that have tried it.

-casey




On Sat, 10 Jan 2004, Dan wrote:

> Hello,
>
>   I've recently been trying to get ACPI support up and running on my
> Gateway M350 laptop...using kernel 2.6.1.  Everything seems to appear
> just fine in /proc/acpi, except for the battery information;
> /proc/acpi/battery exists, but there is nothing in the directory =(
> There is a series of error messages (AE_NOT_EXIST) in the dmesg output
> relating to it, preceeded by a "No Handler for Region [ERAM]" error that
> I suspect is the source of the other problems.  The kernel config with
> regards to ACPI is as follows:
>
> # Power management options (ACPI, APM)
> # ACPI (Advanced Configuration and Power Interface) Support
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_ACPI_RELAXED_AML is not set
> # CONFIG_SERIAL_8250_ACPI is not set
> ~~~~~~~~~~~~End .config~~~~~~~~~~~
>
> The relevant section of dmesg is:
>
> ACPI: RSDT (v001 GATEWA M350WVN  0x20030926  LTP 0x00000000) @0x1f6e6891
> ACPI: FADT (v001 GATEWA M350WVN  0x20030926 PTL  0x00000050) @0x1f6ebe6a
> ACPI: BOOT (v001 GATEWA M350WVN  0x20030926  LTP 0x00000001) @0x1f6ebfd8
> ACPI: MADT (v001 INTEL  MONTARA  0x20030926 PTL  0x00000050) @0x1f6ebf7e
> ACPI: SSDT (v001 INTEL  CPU0CST  0x00000001 INTL 0x20030224) @0x1f6e6ada
> ACPI: SSDT (v001  INTEL  EISTRef 0x00002000 INTL 0x20030224) @0x1f6e68c9
> ACPI: DSDT (v001 GATEWA M350WVN  0x20030926 MSFT 0x0100000e) @0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:2 APIC version 20
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
> IOAPIC[0]: Assigned apic_id 1
> IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, IRQ 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI BALANCE SET
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Building zonelist for node : 0
> current: c03c5a60
> current->thread_info: c0448000
> Initializing CPU#0
> Kernel command line: root=/dev/hda2 video=vesa:ywrap,mtrr vga=0x317
> PID hash table entries: 2048 (order 11: 16384 bytes)
> Detected 2656.456 MHz processor.
> Using tsc for high-res timesource
> Console: colour dummy device 80x25
> Memory: 505328k/514944k available (2400k kernel code, 8856k reserved,
> 952k data, 156k init, 0k highmem)
> zapping low mappings.
> Calibrating delay loop... 5242.88 BogoMIPS
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> checking if image is initramfs...it isn't (ungzip failed); looks like an
> initrd
> Freeing initrd memory: 13k freed
> CPU:     After generic identify, caps: bfebfbff 00000000 00000000
> 00000000
> CPU:     After vendor identify, caps: bfebfbff 00000000 00000000
> 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU: Intel Mobile Intel(R) Pentium(R) 4     CPU 2.66GHz stepping 09
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> ENABLING IO-APIC IRQs
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 1-0, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22,
> 1-23 not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 2654.0887 MHz.
> ..... host bus clock speed is 132.0744 MHz.
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfd9b2, last bus=2
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20031203
>  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
> acquired
> Parsing all Control
> Methods:..........................................................
> Table [DSDT](id F006) - 687 Objects with 55 Devices 194 Methods 19
> Regions
> Parsing all Control Methods:.
> Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
> Parsing all Control Methods:...
> Table [SSDT](id F004) - 4 Objects with 0 Devices 3 Methods 0 Regions
> ACPI Namespace successfully loaded at root c04852bc
> IOAPIC[0]: Set PCI routing entry (1-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
> evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
> successful
> evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at
> 0000000000001028 on int 9
> Completing Region/Field/Buffer/Package
> initialization:..........................................................
> Initialized 19/19 Regions 0/0 Fields 20/20 Buffers 19/19 Packages (700
> nodes)
> Executing all Device _STA and_INI methods:........evregion-0251 [21]
> ev_address_space_dispa: No handler for Region [ERAM] (df652c28)
> [EmbeddedControl]
>  exfldio-0284 [20] ex_access_region      : Region EmbeddedControl(3) has
> no handler
>  dswexec-0435 [13] ds_exec_end_op        : [LGreater]: Could not resolve
> operands, AE_NOT_EXIST
>  psparse-1120: *** Error: Method execution failed [\_SB_.PCI0._INI]
> (Node df657528), AE_NOT_EXIST
>   nsinit-0408 [06] ns_init_one_device    : \_SB_.PCI0._INI failed:
> AE_NOT_EXIST
> ..................................................
> 58 Devices found containing: 58 _STA, 0 _INI methods
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> evregion-0251 [21] ev_address_space_dispa: No handler for Region [ERAM]
> (df652c28) [EmbeddedControl]
>  exfldio-0284 [20] ex_access_region      : Region EmbeddedControl(3) has
> no handler
>  psparse-1120: *** Error: Method execution failed [\_SB_.BAT0._STA]
> (Node df658428), AE_NOT_EXIST
> ~~~~~~~~~~End dmesg~~~~~~~~~~~~~~
>
> As you can see in the above section, the first error (and what I suspect
> is causing the subsequent AE_NOT_EXIST errors) is the "No Handler for
> Region [ERAM]" message that I can't seem to diagnose.  I've attached a
> dump of my DSDT data, after running it through acpidmp, in case it's
> relevant (bzipped so that it's not 200+K =P).  Any ideas at all would be
> MOST appreciated =)  Thanks so much!
>
> ~D. Stone
>









-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
