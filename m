From: olm-acpi-devel-+d40ctR3GU7QT0dZR+AlfA@public.gmane.org
Subject: Error in "Executing all Device _STA and_INI methods"
Date: Tue, 20 Jan 2004 07:37:11 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0401200725360.21707@gyumri.hekiat.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I hope this is the correct list for this question.

I have a Gateway 400VTX laptop. It has a 2.2 GHz Celeron CPU.  I just
compiled and installed Linux 2.6.1 on it. I chose the "Intel P4/Xeon"
option (CONFIG_MPENTIUM4=y) from configuration. I have enabled APCI
but not APM.

I'm checking my dmesg and noticed some errors:

Executing all Device _STA and_INI methods:......evregion-0249 [21] ev_address_space_dispa: no handler for region(c12db5a8) [EmbeddedControl]
 exfldio-0282 [20] ex_access_region      : Region EmbeddedControl(3) has no handler
 dswexec-0422 [13] ds_exec_end_op        : [LGreater]: Could not resolve operands, AE_NOT_EXIST
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node c12e06a8), AE_NOT_EXIST
  nsinit-0397 [06] ns_init_one_device    : \_SB_.PCI0._INI failed: AE_NOT_EXIST

What does this mean? Don't seem to be able to put the machine to any
of the reduced states. The following commands produce nothing:

  echo "standby" > state
  echo "mem" > state
  echo "disk" > /sys/power/stat

It seems that the laptop is running too hot. I can feel the heat and
I don't know if this is 'acceptable' or not. Also, I get a lot of
lines line this in my dmesg:

[ACPI Debug] String: Temperature increasing: _Q80


Thanks in advance for your help.

Regards,

Ovanes

P.S. What follows is the portions of my dmesg which I found relevant
to APCI, up to the point where the error is printed.


ACPI: RSDP (v000 GATEWA                                    ) @ 0x000f6710
ACPI: RSDT (v001 GATEWA 400VTX   0x20030312  LTP 0x00000000) @ 0x0f6e6d53
ACPI: FADT (v001 GATEWA 400VTX   0x20030312 PTL  0x00000050) @ 0x0f6ebf64
ACPI: BOOT (v001 GATEWA 400VTX   0x20030312  LTP 0x00000001) @ 0x0f6ebfd8
ACPI: DSDT (v001 GATEWA 400VTX   0x20030312 MSFT 0x0100000e) @ 0x00000000
CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel Mobile Intel(R) Celeron(R) CPU 2.20GHz stepping 07
ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.................................................................................................................................................................................................
Table [DSDT](id F004) - 685 Objects with 55 Devices 193 Methods 15 Regions
ACPI Namespace successfully loaded at root c03c6cfc
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000001028 on int 9Completing Region/Field/Buffer/Package initialization:.................................................................
Initialized 15/15 Regions 0/0 Fields 28/28 Buffers 22/22 Packages (693 nodes)
Executing all Device _STA and_INI methods:......evregion-0249 [21] ev_address_space_dispa: no handler for region(c12db5a8) [EmbeddedControl]
 exfldio-0282 [20] ex_access_region      : Region EmbeddedControl(3) has no handler
 dswexec-0422 [13] ds_exec_end_op        : [LGreater]: Could not resolve operands, AE_NOT_EXIST
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node c12e06a8), AE_NOT_EXIST
  nsinit-0397 [06] ns_init_one_device    : \_SB_.PCI0._INI failed: AE_NOT_EXIST
..................................................
56 Devices found containing: 56 _STA, 0 _INI methods
ACPI: Interpreter enabled


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
