From: stef <svoltz-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Subject: Re: 2.4.21-rc1-acpi20030424: hwclock --hctosys hangs on toshiba L2
Date: Mon, 28 Apr 2003 22:04:33 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030428220433.GA2455@wanadoo.fr>
References: <200304281603.23325.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200304281603.23325.mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 28, 2003 at 04:03:23PM +0800, Michael Frank wrote:
> Hi All,
> 
> RH9-pre (phoebe), system hangs on setting kernel parameters in rc.sysinit. 
> 
> Commenting out hwclock --hctosys in rc.sysinit enables normal boot. No other problems encountered. 
> 
> System clock can be set using ntpdate.
> 
> 2.4.21-rc1-acpi20030328 and 2.4.21-pre7-acpi20030328 tested ok this morning.
> 
> Regards
> Michael Frank
> 
> ------ dmesg [] = snip
> 
> Linux version 2.4.21-rc1-mhf24 (root@mhfl3) (gcc version 2.95.3 20010315 (release)) #2 Mon Apr 28 14:34:45 HKT 2003
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
>  BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
>  BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000ef5c000 (usable)
>  BIOS-e820: 000000000ef5c000 - 000000000ef60000 (reserved)
>  BIOS-e820: 000000000ef60000 - 000000000ef70000 (ACPI data)
>  BIOS-e820: 000000000ef70000 - 000000000f070000 (reserved)
>  BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
> 239MB LOWMEM available.
> ACPI: have wakeup address 0xc0001000
> On node 0 totalpages: 61276
> zone(0): 4096 pages.
> zone(1): 57180 pages.
> zone(2): 0 pages.
> ACPI: RSDP (v000 TOSHIB                     ) @ 0x000f01a0
> ACPI: RSDT (v001 TOSHIB L1       08194.01296) @ 0x0ef60000
> ACPI: FADT (v002 TOSHIB L1       08194.01296) @ 0x0ef60058
> ACPI: DBGP (v001 TOSHIB L1       08194.01296) @ 0x0ef600dc
> ACPI: BOOT (v001 TOSHIB L1       08194.01296) @ 0x0ef60030
> ACPI: DSDT (v001 TOSHIB GT       08194.01296) @ 0x00000000
> ACPI: BIOS passes blacklist
> Kernel command line: vga=0xf06 ro root=/dev/hda2 resume=/dev/hda4 4 nousb
> 
> []
> 
> ACPI: Subsystem revision 20030424
> 
> []
> 
> Parsing all Control Methods:...
> Table [DSDT] - 508 Objects with 38 Devices 93 Methods 9 Regions
> ACPI Namespace successfully loaded at root c031d37c
> evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
> evgpeblk-0740 [06] ev_create_gpe_block   : GPE Block: [_GPE] 8 registers at 000000000000EE18 on interrupt 9
> evgpeblk-0745 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 to GPE 0x3F
> evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L09 as GPE number 0x09
> evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L1A as GPE number 0x1A
> Executing all Device _STA and_INI methods:..
> 38 Devices found containing: 38 _STA, 1 _INI methods
> Completing Region/Field/Buffer/Package initialization:.
> Initialized 6/9 Regions 0/0 Fields 15/15 Buffers 18/18 Packages (508 nodes)
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: System [ACPI] (supports S0 S3 (swsusp) S4 S5)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11, disabled)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11, disabled)
> ACPI: Power Resource [PFN0] (off)
> ACPI: Power Resource [PFN1] (off)
> PCI: Probing PCI hardware
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
> 
> []
> 
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID]
> ACPI: Processor [CPU0] (supports C1 C2 C3)
> ACPI: Thermal Zone [THRM] (75 C)
> 
> []
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


	Hello,

	I have the same problem with my HP Pavilion N5441. hwclock hangs the laptop. Here's last
lines of strace (copied by hand):
.......
open("/dev/rtc",O_RDONLY|O_LARGEFILE)=3
ioctl(3,RTC_UIE_ON,0)=0
read(3,

	then nothing more.

Regards,
	Stef


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
