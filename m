From: Pavel Kysilka <goldenfish-kkCZSxYw6FY@public.gmane.org>
Subject: S5 not working, and another problem
Date: Sat, 20 Nov 2004 03:55:33 +0100
Message-ID: <20041120025533.GA2384@prog3>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

	Hi all,

i was testing today acpi with 2.6.10-rc2 kernel on my computer.

0) 
there are difference with dmesg and /proc/acpi/sleep

dmesg::
ACPI: (supports S0 S1 S4bios S5)

cat /proc/acpi/sleep ::
S0 S1 S4 S4bios S5 

feature or error ?

1)

echo 1 > /proc/acpi/sleep
echo 4 > /proc/acpi/sleep
echo 4b > /proc/acpi/sleep

this states working fine. only problem with emu10k1 chip (no support,
but no freeze). module snd-via82xxx freeze with S1,S4 computer (reported
today to alsa-devel list).

echo 5 >  /proc/acpi/sleep not working.
i look in the log and no information. 
button and command "poweroff" work good.

2) i look in the difference of dmesg (2.6.10-rc1->2.6.10-rc2):
ignore ext3-fs recovery.

 1c1
 < Linux version 2.6.10-rc1 (root@prog3) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #6 Fri Oct 29 20:59:56 CEST 2004
 ---
 > Linux version 2.6.10-rc2 (root@prog3) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 Wed Nov 17 20:52:04 CET 2004
 21c21
 < Kernel command line: BOOT_IMAGE=2.6.10-rc1 ro root=302
 ---
 > Kernel command line: BOOT_IMAGE=2.6.10-rc2 ro root=302
 29c29
 < Memory: 385244k/393152k available (2592k kernel code, 7376k reserved, 883k data, 152k init, 0k highmem)
 ---
 > Memory: 385104k/393152k available (2667k kernel code, 7516k reserved, 939k data, 164k init, 0k highmem)
 42a43,46
 >  tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
 > Parsing all Control Methods:....................................................................
 > Table [DSDT](id F004) - 281 Objects with 27 Devices 68 Methods 18 Regions
 > ACPI Namespace successfully loaded at root c04c6ba0
 43a48
 > evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successful
 48c53,59
 < ACPI: Subsystem revision 20040816
 ---
 > ACPI: Subsystem revision 20041105
 > evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
 > evgpeblk-0987 [06] ev_create_gpe_block   : Found 3 Wake, Enabled 0 Runtime GPEs in this block
 > Completing Region/Field/Buffer/Package initialization:.......................................
 > Initialized 18/18 Regions 1/1 Fields 16/16 Buffers 4/6 Packages (290 nodes)
 > Executing all Device _STA and_INI methods:..............................
 > 30 Devices found containing: 30 _STA, 1 _INI methods
 58a70,73
 > pnp: PnP ACPI init
 > acpi_bus-0077 [03] acpi_bus_get_device   : Error getting context for object [c13738fc]
 > acpi_bus-0077 [03] acpi_bus_get_device   : Error getting context for object [c13736e8]
 > pnp: PnP ACPI: found 12 devices
 62,72c77,83
 < ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
 < ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
 < ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
 < ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
 < ACPI: PCI interrupt 0000:00:07.5[C] -> GSI 11 (level, low) -> IRQ 11
 < ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
 < ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
 < ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 (level, low) -> IRQ 10
 < ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
 < ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
 < ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
 ---
 > ** PCI interrupts are no longer routed automatically.  If this
 > ** causes a device to stop working, it is probably because the
 > ** driver failed to call pci_enable_device().  As a temporary
 > ** workaround, the "pci=routeirq" argument restores the old
 > ** behavior.  If this argument makes the device work again,
 > ** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
 > ** so I can fix the driver.
 83a95,96
 > ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
 > PCI: setting IRQ 11 as level-triggered
 139,142d151
 < EXT3-fs: INFO: recovery required on readonly filesystem.
 < EXT3-fs: write access will be enabled during recovery.
 < (fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 0, recovered transactions 512905 to 512932
 < (fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 1124 and revoked 0/8 blocks
 144d152
 < EXT3-fs: recovery complete.
 147c155
 < Freeing unused kernel memory: 152k freed
 ---
 > Freeing unused kernel memory: 164k freed
 154c162,165
 < ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
 ---
 > ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
 > PCI: setting IRQ 10 as level-triggered
 > ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 10 (level, low) -> IRQ 10
 > ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
 158a170
 > ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
 171c183,184
 < ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
 ---
 > ACPI: Processor [CPU0] (supports C1 C2)
 > ACPI: Processor [CPU0] (supports 2 throttling states)
 

   for information and testing (disk non destructive) contact me.

 sorry for my bad english. thank for your time.
 
bye 
  pavel kysilka
  programmer http://www.bsys.cz/


________ Information from NOD32 ________
This message was checked by NOD32 Antivirus System for Linux Mail Server.

http://www.nod32.com


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
