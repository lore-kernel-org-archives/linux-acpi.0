From: Paul Richards <pauldoo-uGgzU+OBInnR7s880joybQ@public.gmane.org>
Subject: Battery status report works in 2.4.18 but not 2.4.19  (Sony VAIO
 PCG-GR414SP)
Date: Sun, 25 Aug 2002 18:18:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D69114B.4070904@pauldoo.net>
Reply-To: pauldoo-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I have the laptop mentioned in the title and under 2.4.18 
(acpi-20020726-2.4.18.diff.gz applied) I can read the battery status 
report just dandy using acpi but with 2.4.19 
(acpi-20020821-2.4.19.diff.gz applied) I can't..

Both kernels were compiled with the same version of gcc, binutils etc 
etc..  I did have slightly different configs for them both but nothing 
acpi related.  ACPI in both kernels was compiled right in (ie, not just 
a module)..

Under 2.4.19 some of the other ACPI stuff works or at least appears 
under /proc/acpi, just not the battery.

Anyway, here are the relevant sections of the dmesg outputs..

BTW, does anyone know what those AE_ERROR things are?  They appeared all 
over the 2.4.19 dmesg output even for stuff not related to ACPI.

TIA,


***************  2.4.18  ***************
[snip]
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6c90
ACPI: RSDT (v001 SONY   C0       08194.00809) @ 0x0fefa690
ACPI: FADT (v001   SONY       C0 08194.00809) @ 0x0fefef64
ACPI: BOOT (v001   SONY       C0 08194.00809) @ 0x0fefefd8
[snip]
ACPI: Subsystem revision 20020725
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
PCI: Using configuration type 1
  tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing 
Methods:.................................................................................................................................................................................................
Table [DSDT] - 568 Objects with 55 Devices 193 Methods 21 Regions
ACPI Namespace successfully loaded at root c03687dc
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode 
successful
Executing all Device _STA and_INI methods:................evrgnini-0243: 
*** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
.evrgnini-0243: *** Error: Could not install Pci_config handler for 
PCI0, AE_ALREADY_EXISTS
...............................evrgnini-0243: *** Error: Could not 
install Pci_config handler for PCI0, AE_ALREADY_EXISTS
....evrgnini-0243: *** Error: Could not install Pci_config handler for 
PCI0, AE_ALREADY_EXISTS
...
55 Devices found containing: 55 _STA, 4 _INI methods
Completing Region/Field/Buffer/Package 
initialization:..................................................................
Initialized 14/21 Regions 0/0 Fields 25/25 Buffers 27/27 Packages (568 
nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 2: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:02.00 not 
present in PCI namespace
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
pci_link-0219 [17] acpi_pci_link_get_curr: Blank IRQ resource
ACPI: PCI Interrupt Link [LNKF] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
[snip]
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports C1 C2, 2 performance states)
ACPI: Thermal Zone [ATF0] (54 C)


********************  2.4.19  *****************
  tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing 
Methods:.................................................................................................................................................................................................
193 Control Methods found and parsed (568 nodes total)
ACPI Namespace successfully loaded at root c0340d60
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode 
successful
Executing device _INI methods:................evregion-0302 [21] 
Ev_address_space_dispa: Region handler: AE_ERROR [PCIConfig]
evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[PCIConfig]
Ps_execute: method failed - \_SB_.PCI0.HUB_.CRD0._INI (c12e7a68)
   nsinit-0351 [04] Ns_init_one_device    : \   /_SB_PCI0HUB_CRD0._INI 
failed: AE_ERROR
.evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[PCIConfig]
evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[PCIConfig]
Ps_execute: method failed - \_SB_.PCI0.HUB_.CRD1._INI (c12e6188)
   nsinit-0351 [04] Ns_init_one_device    : \   /_SB_PCI0HUB_CRD1._INI 
failed: AE_ERROR
.............evregion-0302 [22] Ev_address_space_dispa: Region handler: 
AE_ERROR [System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.EC0_.BAT1._STA (c12e23c8)
   uteval-0337 [05] Ut_execute_STA        : _STA on BAT1 failed AE_ERROR
.evregion-0302 [22] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.EC0_.BAT2._STA (c12e2848)
   uteval-0337 [05] Ut_execute_STA        : _STA on BAT2 failed AE_ERROR
..evregion-0302 [22] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.COMA._STA (c12e1368)
   uteval-0337 [05] Ut_execute_STA        : _STA on COMA failed AE_ERROR
.evregion-0302 [22] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.LPTA._STA (c12e1a68)
   uteval-0337 [05] Ut_execute_STA        : _STA on LPTA failed AE_ERROR
.evregion-0302 [22] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.LPTB._STA (c12e0208)
   uteval-0337 [05] Ut_execute_STA        : _STA on LPTB failed AE_ERROR
.evregion-0302 [22] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.ECP_._STA (c12e0808)
   uteval-0337 [05] Ut_execute_STA        : _STA on ECP_ failed AE_ERROR
.evregion-0302 [22] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.FDC_._STA (c12e0d88)
   uteval-0337 [05] Ut_execute_STA        : _STA on FDC_ failed AE_ERROR
......evregion-0302 [21] Ev_address_space_dispa: Region handler: 
AE_ERROR [System_memory]
Ps_execute: method failed - \_SB_.PCI0.IDEC.SECD._INI (cff3eb68)
   nsinit-0351 [04] Ns_init_one_device    : \   /_SB_PCI0IDECSECD._INI 
failed: AE_ERROR
.evregion-0302 [22] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.IDEC.SECD.S_D0._STA (cff3e968)
   uteval-0337 [05] Ut_execute_STA        : _STA on S_D0 failed AE_ERROR
...........
55 Devices found: 47 _STA, 1 _INI
Completing Region and Field initialization:...............
15/21 Regions, 0/0 Fields initialized (568 nodes total)
ACPI: Subsystem enabled
evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.EC0_.BAT1._STA (c12e23c8)
   uteval-0337 [04] Ut_execute_STA        : _STA on BAT1 failed AE_ERROR
evregion-0302 [23] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.EC0_.BAT1._STA (c12e23c8)
evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.EC0_.BAT2._STA (c12e2848)
   uteval-0337 [04] Ut_execute_STA        : _STA on BAT2 failed AE_ERROR
evregion-0302 [23] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.EC0_.BAT2._STA (c12e2848)
evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.COMA._STA (c12e1368)
   uteval-0337 [04] Ut_execute_STA        : _STA on COMA failed AE_ERROR
evregion-0302 [23] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.COMA._STA (c12e1368)
evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.LPTA._STA (c12e1a68)
   uteval-0337 [04] Ut_execute_STA        : _STA on LPTA failed AE_ERROR
evregion-0302 [23] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.LPTA._STA (c12e1a68)
evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.LPTB._STA (c12e0208)
   uteval-0337 [04] Ut_execute_STA        : _STA on LPTB failed AE_ERROR
evregion-0302 [23] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.LPTB._STA (c12e0208)
evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.ECP_._STA (c12e0808)
   uteval-0337 [04] Ut_execute_STA        : _STA on ECP_ failed AE_ERROR
evregion-0302 [23] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.ECP_._STA (c12e0808)
evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.FDC_._STA (c12e0d88)
   uteval-0337 [04] Ut_execute_STA        : _STA on FDC_ failed AE_ERROR
evregion-0302 [23] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.LPC0.FDC_._STA (c12e0d88)
evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.IDEC.SECD.S_D0._STA (cff3e968)
   uteval-0337 [04] Ut_execute_STA        : _STA on S_D0 failed AE_ERROR
evregion-0302 [23] Ev_address_space_dispa: Region handler: AE_ERROR 
[System_memory]
Ps_execute: method failed - \_SB_.PCI0.IDEC.SECD.S_D0._STA (cff3e968)
EC: found, GPE 28
ACPI: System firmware supports S0 S3 S4 S5
Processor[0]: C0 C1 C2
ACPI: AC Adapter found
ACPI: Power Button (CM) found
ACPI: Lid Switch (CM) found
evregion-0302 [25] Ev_address_space_dispa: Region handler: 
AE_BAD_PARAMETER [Embedded_control]
  dswexec-0392 [16] Ds_exec_end_op        : [Shift_right]: Could not 
resolve operands, AE_BAD_PARAMETER
Ps_execute: method failed - \_TZ_.ATF0._TMP (cff3d888)


-- 
Paul Richards



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
