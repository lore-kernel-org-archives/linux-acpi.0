From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: GPE/lid handling issue with 20030228
Date: Tue, 25 Mar 2003 07:13:47 +0000 (UTC)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <25626.4336560436$1048576427@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Resent-Message-Id: <20030325065948.2AA2FF7E64-Js9ok1HmyL5Dfl1Wns4P8EEOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Date: Mon Mar 24 23:00:25 2003
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Greetings. 

Just upgraded my kernel to 2.4.21-pre5 + a bunch of swsup patches + acpi-20030228-2.4.21-pre4.diff.gz

Most everything works fine with ACPI as with previous versions, except
I seem to have lost my lid button. ;( 

It doesn't seem to generate any event. It sees the button, but the
state is always open no matter what. 

Also, the ac_adapter now seems to always be on-line...
It also doesn't appear to generate any events, although when I unplug
the laptop the battery seems to notice that it's discharging. 

With my new kernel bootup looks like: 

Mar 24 22:36:08 voldemort kernel:    tbget-0292: *** Info: Table [DSDT] replaced by host OS
Mar 24 22:36:08 voldemort kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Mar 24 22:36:08 voldemort kernel: Parsing all Control Methods:.......................................................................
.....................................................................................................................................
.....................................
Mar 24 22:36:08 voldemort kernel: Table [DSDT] - 780 Objects with 88 Devices 241 Methods 24 Regions
Mar 24 22:36:08 voldemort kernel: Parsing all Control Methods:
Mar 24 22:36:08 voldemort kernel: Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
Mar 24 22:36:08 voldemort kernel: Parsing all Control Methods:
Mar 24 22:36:08 voldemort kernel: Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
Mar 24 22:36:08 voldemort kernel: ACPI Namespace successfully loaded at root c0764a7c
Mar 24 22:36:08 voldemort kernel: evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
Mar 24 22:36:08 voldemort kernel:    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 0000000000001028
Mar 24 22:36:08 voldemort kernel:    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L11 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L13 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L14 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L15 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L17 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L18 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000000000102C
Mar 24 22:36:08 voldemort kernel:    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 to GPE31
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L0B is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L11 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L13 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L14 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L15 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L17 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L18 is not valid
Mar 24 22:36:08 voldemort kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid
Mar 24 22:36:09 voldemort kernel: Executing all Device _STA and_INI methods:...evrgnini-0261: *** Error: Could not install pci_config
 handler for C03C, AE_ALREADY_EXISTS
Mar 24 22:36:09 voldemort kernel: ....evrgnini-0261: *** Error: Could not install pci_config handler for C03C, AE_ALREADY_EXISTS
Mar 24 22:36:09 voldemort kernel: .............................................................evrgnini-0261: *** Error: Could not in
stall pci_config handler for C03C, AE_ALREADY_EXISTS
Mar 24 22:36:09 voldemort kernel: ....................
Mar 24 22:36:09 voldemort kernel: 88 Devices found containing: 88 _STA, 5 _INI methods
Mar 24 22:36:09 voldemort autofs: automount startup succeeded
Mar 24 22:36:09 voldemort kernel: Completing Region/Field/Buffer/Package initialization:.............................................
................................................
Mar 24 22:36:09 voldemort kernel: Initialized 14/24 Regions 0/0 Fields 25/26 Buffers 54/63 Packages (796 nodes)
Mar 24 22:36:09 voldemort kernel: ACPI: Interpreter enabled
Mar 24 22:36:09 voldemort kernel: ACPI: Using PIC for interrupt routing
Mar 24 22:36:09 voldemort kernel: ACPI: System [ACPI] (supports S0 S3 (bios) S4 S5)
Mar 24 22:36:09 voldemort kernel: ACPI: PCI Root Bridge [C03C] (00:00)
Mar 24 22:36:09 voldemort kernel: PCI: Probing PCI hardware (bus 00)
Mar 24 22:36:09 voldemort kernel: PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Mar 24 22:36:09 voldemort kernel: Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
Mar 24 22:36:09 voldemort kernel: ACPI: Embedded Controller [C0D0] (gpe 29)
Mar 24 22:36:09 voldemort kernel: schedule_task(): keventd has not started
Mar 24 22:36:09 voldemort kernel: ACPI: Power Resource [C140] (off)
Mar 24 22:36:10 voldemort kernel: ACPI: Power Resource [C154] (off)
Mar 24 22:36:10 voldemort kernel: ACPI: Power Resource [C158] (off)
Mar 24 22:36:10 voldemort kernel: ACPI: Power Resource [C15B] (off)
Mar 24 22:36:10 voldemort kernel: ACPI: Power Resource [C164] (on)
Mar 24 22:36:10 voldemort kernel: ACPI: PCI Interrupt Link [C0B6] (IRQs 5 10 *11)
Mar 24 22:36:10 voldemort kernel: ACPI: PCI Interrupt Link [C0B7] (IRQs *5 10 11)
Mar 24 22:36:10 voldemort kernel: ACPI: PCI Interrupt Link [C0B8] (IRQs 5 10 11, disabled)
Mar 24 22:36:10 voldemort kernel: ACPI: PCI Interrupt Link [C0B9] (IRQs 5 10 *11)
Mar 24 22:36:10 voldemort kernel: ACPI: PCI Interrupt Link [C0BA] (IRQs 5 *10 11)
Mar 24 22:36:10 voldemort kernel: pci_link-0106 [25] acpi_pci_link_check_po: Blank IRQ resource
Mar 24 22:36:10 voldemort kernel: ACPI: PCI Interrupt Link [C0BB] (IRQs, disabled)
Mar 24 22:36:10 voldemort kernel: pci_link-0106 [26] acpi_pci_link_check_po: Blank IRQ resource
Mar 24 22:36:10 voldemort kernel: ACPI: PCI Interrupt Link [C0BC] (IRQs, disabled)
Mar 24 22:36:10 voldemort kernel: pci_link-0106 [27] acpi_pci_link_check_po: Blank IRQ resource
Mar 24 22:36:10 voldemort kernel: ACPI: PCI Interrupt Link [C0BD] (IRQs, disabled)
Mar 24 22:36:10 voldemort kernel: ACPI: Power Resource [C0CF] (on)
Mar 24 22:36:10 voldemort kernel: ACPI: Power Resource [C1D0] (off)
Mar 24 22:36:10 voldemort kernel: ACPI: Power Resource [C1D1] (off)
Mar 24 22:36:10 voldemort kernel: ACPI: Power Resource [C1D2] (off)
Mar 24 22:36:10 voldemort kernel: ACPI: Power Resource [C1D3] (off)
Mar 24 22:36:10 voldemort kernel: ACPI: PCI Interrupt Link [C0B8] enabled at IRQ 5
Mar 24 22:36:10 voldemort kernel: pci_link-0436 [26] acpi_pci_link_check   : Invalid link context
Mar 24 22:36:10 voldemort kernel: pci_link-0436 [26] acpi_pci_link_check   : Invalid link context
Mar 24 22:36:11 voldemort kernel: pci_link-0436 [26] acpi_pci_link_check   : Invalid link context
Mar 24 22:36:23 voldemort kernel: ACPI: AC Adapter [C11A] (on-line)
Mar 24 22:36:23 voldemort kernel: ACPI: Battery Slot [BAT1] (battery present)
Mar 24 22:36:23 voldemort kernel: ACPI: Battery Slot [BAT0] (battery absent)
Mar 24 22:36:23 voldemort kernel: ACPI: Power Button (FF) [PWRF]
Mar 24 22:36:23 voldemort kernel: ACPI: Sleep Button (CM) [C11E]
Mar 24 22:36:23 voldemort kernel: ACPI: Lid Switch [C11D]
Mar 24 22:36:23 voldemort kernel: ACPI: Fan [FAN0] (off)
Mar 24 22:36:23 voldemort kernel: ACPI: Fan [FAN1] (off)
Mar 24 22:36:23 voldemort kernel: ACPI: Fan [FAN2] (off)
Mar 24 22:36:23 voldemort kernel: ACPI: Fan [FAN3] (off)
Mar 24 22:36:23 voldemort kernel: ACPI: Processor [C000] (supports C1 C2 C3, 2 performance states, 8 throttling states)
Mar 24 22:36:23 voldemort kernel: [ACPI Debug] Integer: 0000000000000E3A
Mar 24 22:36:23 voldemort kernel: [ACPI Debug] Integer: 0000000000000DB8
Mar 24 22:36:23 voldemort kernel: [ACPI Debug] Integer: 0000000000000D7C
Mar 24 22:36:23 voldemort kernel: [ACPI Debug] Integer: 0000000000000D4A
Mar 24 22:36:23 voldemort kernel: [ACPI Debug] Integer: 0000000000000C3C
Mar 24 22:36:23 voldemort kernel: ACPI: Thermal Zone [TZ1] (58 C)
Mar 24 22:36:23 voldemort kernel: ACPI: Thermal Zone [TZ2] (53 C)
Mar 24 22:36:23 voldemort kernel: [ACPI Debug] Integer: 0000000000000CBE
Mar 24 22:36:23 voldemort kernel: ACPI: Thermal Zone [TZ3] (16 C)

With the older kernel running acpi-20030122 where the lid works I see:

Mar 24 20:20:55 voldemort kernel:    tbget-0273: *** Info: Table [DSDT] replaced by host OS
Mar 24 20:20:55 voldemort kernel:  tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Mar 24 20:20:55 voldemort kernel: Parsing all Control Methods:.......................................................................
.....................................................................................................................................
.....................................
Mar 24 20:20:55 voldemort kernel: Table [DSDT] - 780 Objects with 88 Devices 241 Methods 24 Regions
Mar 24 20:20:55 voldemort kernel: Parsing all Control Methods:
Mar 24 20:20:55 voldemort kernel: Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
Mar 24 20:20:55 voldemort kernel: Parsing all Control Methods:
Mar 24 20:20:55 voldemort kernel: Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
Mar 24 20:20:55 voldemort kernel: ACPI Namespace successfully loaded at root c03749fc
Mar 24 20:20:55 voldemort kernel: evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode successful
Mar 24 20:20:55 voldemort kernel:    evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
Mar 24 20:20:55 voldemort kernel:    evgpe-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
Mar 24 20:20:55 voldemort kernel: Executing all Device _STA and_INI methods:...evrgnini-0242: *** Error: Could not install pci_config
 handler for C03C, AE_ALREADY_EXISTS
Mar 24 20:20:55 voldemort kernel: ....evrgnini-0242: *** Error: Could not install pci_config handler for C03C, AE_ALREADY_EXISTS
Mar 24 20:20:55 voldemort kernel: .............................................................evrgnini-0242: *** Error: Could not in
stall pci_config handler for C03C, AE_ALREADY_EXISTS
Mar 24 20:20:55 voldemort kernel: ....................
Mar 24 20:20:55 voldemort kernel: 88 Devices found containing: 88 _STA, 5 _INI methods
Mar 24 20:20:55 voldemort kernel: Completing Region/Field/Buffer/Package initialization:.............................................
................................................
Mar 24 20:20:55 voldemort kernel: Initialized 14/24 Regions 0/0 Fields 25/26 Buffers 54/63 Packages (796 nodes)
Mar 24 20:20:55 voldemort kernel: ACPI: Interpreter enabled
Mar 24 20:20:55 voldemort kernel: ACPI: Using PIC for interrupt routing
Mar 24 20:20:55 voldemort kernel: ACPI: System [ACPI] (supports S0 S3 (bios) S4 S5)
Mar 24 20:20:55 voldemort kernel: ACPI: PCI Root Bridge [C03C] (00:00)
Mar 24 20:20:55 voldemort kernel: pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:04.01 not present in PCI namespace
Mar 24 20:20:56 voldemort kernel: ACPI: Embedded Controller [C0D0] (gpe 29)
Mar 24 20:20:56 voldemort kernel: ACPI: Power Resource [C140] (off)
Mar 24 20:20:56 voldemort kernel: ACPI: Power Resource [C154] (off)
Mar 24 20:20:56 voldemort kernel: ACPI: Power Resource [C158] (off)
Mar 24 20:20:56 voldemort kernel: ACPI: Power Resource [C15B] (off)
Mar 24 20:20:56 voldemort kernel: ACPI: Power Resource [C164] (on)
Mar 24 20:20:56 voldemort kernel: pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.00 not present in PCI namespace
Mar 24 20:20:56 voldemort kernel: pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.01 not present in PCI namespace
Mar 24 20:20:56 voldemort kernel: pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.02 not present in PCI namespace
Mar 24 20:20:56 voldemort kernel: pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.07 not present in PCI namespace
Mar 24 20:20:56 voldemort kernel: ACPI: PCI Interrupt Link [C0B6] (IRQs 5 10 *11)
Mar 24 20:20:56 voldemort kernel: ACPI: PCI Interrupt Link [C0B7] (IRQs *5 10 11)
Mar 24 20:20:56 voldemort kernel: ACPI: PCI Interrupt Link [C0B8] (IRQs 5 10 11, disabled)
Mar 24 20:20:56 voldemort kernel: ACPI: PCI Interrupt Link [C0B9] (IRQs 5 10 *11)
Mar 24 20:20:56 voldemort kernel: ACPI: PCI Interrupt Link [C0BA] (IRQs 5 *10 11)
Mar 24 20:20:56 voldemort kernel: pci_link-0122 [14] acpi_pci_link_get_poss: Blank IRQ resource
Mar 24 20:20:56 voldemort last message repeated 2 times
Mar 24 20:20:56 voldemort kernel: ACPI: Power Resource [C0CF] (on)
Mar 24 20:20:56 voldemort kernel: ACPI: Power Resource [C1D0] (off)
Mar 24 20:20:56 voldemort kernel: ACPI: Power Resource [C1D1] (off)
Mar 24 20:20:56 voldemort kernel: ACPI: Power Resource [C1D2] (off)
Mar 24 20:20:56 voldemort kernel: ACPI: Power Resource [C1D3] (off)
Mar 24 20:20:56 voldemort kernel: PCI: Probing PCI hardware
Mar 24 20:20:56 voldemort kernel: ACPI: PCI Interrupt Link [C0B8] enabled at IRQ 5
Mar 24 20:20:56 voldemort kernel: PCI: Using ACPI for IRQ routing
Mar 24 20:21:09 voldemort kernel: ACPI: AC Adapter [C11A] (on-line)
Mar 24 20:21:09 voldemort kernel: ACPI: Battery Slot [C11C] (battery present)
Mar 24 20:21:09 voldemort kernel: ACPI: Battery Slot [C11B] (battery absent)
Mar 24 20:21:09 voldemort kernel: ACPI: Power Button (FF) [PWRF]
Mar 24 20:21:09 voldemort kernel: ACPI: Sleep Button (CM) [C11E]
Mar 24 20:21:09 voldemort kernel: ACPI: Lid Switch [C11D]
Mar 24 20:21:09 voldemort kernel: ACPI: Fan [C1D4] (off)
Mar 24 20:21:09 voldemort kernel: ACPI: Fan [C1D5] (off)
Mar 24 20:21:09 voldemort kernel: ACPI: Fan [C1D6] (off)
Mar 24 20:21:09 voldemort kernel: ACPI: Fan [C1D7] (off)
Mar 24 20:21:09 voldemort kernel: ACPI: Processor [C000] (supports C1 C2 C3, 2 performance states, 8 throttling states)
Mar 24 20:21:09 voldemort kernel: [ACPI Debug] Integer: 0000000000000E3A
Mar 24 20:21:09 voldemort kernel: [ACPI Debug] Integer: 0000000000000DB8
Mar 24 20:21:09 voldemort kernel: [ACPI Debug] Integer: 0000000000000D7C
Mar 24 20:21:09 voldemort kernel: [ACPI Debug] Integer: 0000000000000D4A
Mar 24 20:21:09 voldemort kernel: [ACPI Debug] Integer: 0000000000000C3C
Mar 24 20:21:09 voldemort kernel: ACPI: Thermal Zone [TZ1] (59 C)
Mar 24 20:21:09 voldemort kernel: ACPI: Thermal Zone [TZ2] (53 C)
Mar 24 20:21:09 voldemort kernel: [ACPI Debug] Integer: 0000000000000CBE
Mar 24 20:21:09 voldemort kernel: ACPI: Thermal Zone [TZ3] (36 C)

I note that some of the GPE's its complaining about refrence the lid
button: 

    Scope (_GPE)
    {
        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.C03C.C04E, 0x02)
        }

        Method (_L11, 0, NotSerialized)
        {
            And (\_SB.C03C.C04F.C05B, 0xFFFFFFF3, Local0)
            Or (Local0, 0x04, \_SB.C03C.C04F.C05B)
            Notify (\_SB.LID, 0x80)
        }

I'm using the dsdt from the acpi wiki for the presario 2800. 
I can also provide dsl, asl, hex versions or you can see it on the
wiki. 

Any ideas? Things to try? 

kevin




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
