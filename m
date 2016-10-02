From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI material for v4.9-rc1
Date: Mon, 3 Oct 2016 00:56:04 +0200
Message-ID: <CAJZ5v0ij+mUnjJZ3RR37yUFgc+RPndwPNhTGa3RF4PNFQ+RH8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33779 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbcJBW4H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Oct 2016 18:56:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

Hi Linus,

This goes early as I will be traveling for a good part of the next week.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.9-rc1

with top-most commit 8c4b172123c08a7138ee01675c130c83f9c1117c

 Merge branches 'acpi-button', 'acpi-battery' and 'acpi-doc'

on top of commit 08895a8b6b06ed2323cd97a36ee40a116b3db8ed

 Linux 4.8-rc8

to receive ACPI updates for v4.9-rc1.

First off, the ACPICA code in the kernel is updated to upstream revision
20160831 that brings in a few bug fixes and cleanups.  In particular, it is
possible to mask GPEs now (and the sysfs interface for GPE control is fixed
on top of that), problems related to the table loading mechanism are fixed
and all code related to FADT version 2 (which has never been part of the ACPI
specification) is dropped.

On the new features front, there is a new watchdog driver based on the ACPI
WDAT (ACPI Watchdog Action Table), needed on some platforms to replace the
iTCO watchdog that doesn't work there, and some UART devices get new definitions
of built-in properties (to be accessed via the generic device properties API).

Also, included is a fix for an ACPI-related PCI resorces allocation issue and a
few problems in the EC driver and in the button and battery drivers are fixed.

In addition to that, the ACPI CPPC library is updated to make batching of
requests sent over the PCC channel possible (which reduces the PCC usage
overhead substantially in some cases) and to support functional fixed hardware
(FFH) type of CPPC registers access (which will allow CPPC to be used on x86
too in the future).

As usual, there are some assorted fixes and cleanups too.

Specifics:

 - Update of the ACPICA code in the kernel to upstream revision 20160831 with
   the following major changes:
   * New mechanism for GPE masking.
   * Fixes for issues related to the LoadTable operator and table loading.
   * Fixes for issues related to so-called module-level code (MLC), that is
     AML that doesn't belong to any methods.
   * Change of the return value of the _OSI method to reflect the Windows
     behavior.
   * GAS (Generic Address Structure) support fix related to 32-bit FADT
     addresses.
   * Elimination of unnecessary FADT version 2 support.
   * ACPI tools fixes and cleanups.
   From Bob Moore, Lv Zheng, and Jung-uk Kim.

 - ACPI sysfs interface updates to fix GPE handling (on top of the new GPE
   masking mechanism in ACPICA) and issues related to table loading (Lv Zheng).

 - New watchdog driver based on the ACPI WDAT (ACPI Watchdog Action Table),
   needed on some platforms to replace the iTCO watchdog that doesn't work there
   and related updates of the intel_pmc_ipc, i2c/i801 and MFD/lcp_ich drivers
   (Mika Westerberg).

 - Driver core fix to prevent it from leaking secondary fwnode objects during
   device removal (Lukas Wunner).

 - New definitions of built-in properties for UART in ACPI-based x86 SoC drivers
   and a 8250_dw driver quirk for the APM X-Gene SoC (Heikki Krogerus).

 - New device ID for the Vulcan SPI controller and constification of local
   strucures in the AMD SoC (APD) ACPI driver (Kamlakant Patel, Julia Lawall).

 - Fix for a bug causing the allocation of PCI resorces to fail if
   ACPI-enumerated child platform devices are registered below the PCI
   devices in question (Mika Westerberg).

 - Change of the default polarity for PCI legacy IRQs to high on systems
   booting wth ACPI on platforms with a GIC interrupt controller model
   fixing the discrepancy between the specification and HW behavior (Lorenzo
   Pieralisi).

 - Fixes for the handling of system suspend/resume in the ACPI EC driver and
   update of that driver to make it cope with the cases when the EC device
   defined in the ECDT has to be used throughout the entire system life cycle
   (Lv Zheng).

 - Update of the ACPI CPPC library to allow it to batch requests sent over the
   PCC channel (to reduce overhead), to support the fixed functional hardware
   (FFH) CPPC registers access type, to notify the mailbox framework about TX
   completions when the interrupt flag is set for the PCC mailbox, and to
   support HW-Reduced Communication Subspace type 2 (Ashwin Chaugule, Prashanth
   Prakash, Srinivas Pandruvada, Hoan Tran).

 - ACPI button driver fix and documentation update related to the handling of
   laptop lids (Lv Zheng).

 - ACPI battery driver initialization fix (Carlos Garnacho).

 - ACPI GPIO enumeration documentation update (Mika Westerberg).

 - Assorted updates of the core ACPI bus type code (Lukas Wunner, Lv Zheng).

 - Assorted cleanups of the ACPI table parsing code and the x86-specific ACPI
   code (Al Stone).

 - Fixes for assorted ACPI-related issues found in linux-next (Wei Yongjun).

Thanks!

---------------

Al Stone (5):
      ACPI / tables: fix incorrect counts returned by acpi_parse_entries_array()
      ACPI / tables: fix acpi_parse_entries_array() so it traverses
all subtables
      ACPI / tables: do not report the number of entries ignored by
acpi_parse_entries()
      x86: ACPI: remove extraneous white space after semicolon
      x86: ACPI: make variable names clearer in acpi_parse_madt_lapic_entries()

Ashwin Chaugule (2):
      ACPI / CPPC: restructure read/writes for efficient sys mapped reg ops
      ACPI / CPPC: add sysfs support to compute delivered performance

Bob Moore (13):
      ACPICA: Interpreter: Remove temporary code for External() opcode
      ACPICA: Debugger: Extend some max line lengths
      ACPICA: Disassembler: Add option to emit embedded External
operators/opcodes
      ACPICA: Simplify configuration for "Max Loops" system parameter
      ACPICA: iASL/Disassembler: Add a check for missing filename
      ACPICA: Use os_allocate_zeroed
      ACPICA: FADT support cleanup
      ACPICA: Update version to 20160729
      ACPICA: Debugger: Add subcommand for predefined name execution
      ACPICA: Cleanup for all string-to-integer conversions
      ACPICA: Add a couple of casts to uthex.c
      ACPICA: Update return value for intenal _OSI method
      ACPICA: Update version to 20160831

Carlos Garnacho (1):
      ACPI / battery: Add sysfs representation after checking _BST

Heikki Krogerus (3):
      ACPI / APD: Provide build-in properties of the UART
      ACPI / LPSS: Provide build-in properties of the UART
      serial: 8250_dw: Add quirk for APM X-Gene SoC

Hoan Tran (1):
      ACPI / CPPC: Support PCC with interrupt flag
      mailbox: pcc: Support HW-Reduced Communication Subspace type 2

Julia Lawall (1):
      ACPI / APD: constify local structures

Jung-uk Kim (2):
      ACPICA: Fix deconstification warnings (-Wcast-qual) with function traces.
      ACPICA: Fix deconstification warnings (-Wcast-qual) with
acpi_ns_root_initialize().

Kamlakant Patel (1):
      ACPI / APD: Add device HID for Vulcan SPI controller

Lorenzo Pieralisi (1):
      ACPI / PCI: fix GIC irq model default PCI IRQ polarity

Lukas Wunner (2):
      ACPI / bus: Make acpi_get_first_physical_node() public
      driver core: Don't leak secondary fwnode on device removal

Lv Zheng (46):
      ACPICA: Utilities: Introduce facility to allow Linux to set
correct logging levels
      ACPICA: Divergence: Port declarators back to ACPICA
      ACPICA: Events: Introduce acpi_mask_gpe() to implement GPE
masking mechanism
      ACPICA: Debugger: Fix wrong inclusions in dbfileio.c
      ACPICA: OSL: Add correct acpi_gbl_debug_timeout export to allow
acpiexec to link
      ACPICA: acpidump: Fix a duplicate variable definition
      ACPICA: Applications: Enable USE_NATIVE_ALLOCATE_ZEROED
environment for all applications
      ACPICA: Clib: Fix build issues when ACPI_USE_STANDARD_HEADERS is
not defined by converting size_t to acpi_size
      ACPICA: Clib: Cleanup va_arg related code
      ACPICA: Clib: Fix wrong mini C library usage
      ACPICA: Clib/EFI: Fix wrong order of standard integer types/IO handles
      ACPICA: MSVC9: Fix <sys/stat.h> inclusion order issue
      ACPICA: Clib: Add -nostdinc support for EFI layer
      ACPICA: Clib: Eliminate acpi_os_XXXFile()/acpi_log_error and
link clibrary fxxx()/errno/perror() instead
      ACPICA: Applications: Fix a potential issue that help messages
may be dumped to acpi_gbl_debug_file
      ACPICA: EFI: Port acpidump to EDK2 environment
      ACPICA: OSL: Cleanup the inclusion order of the compiler-specific headers
      ACPICA: OSL: Fix a regression that old GCC requires a workaround
for strchr()
      ACPI / sysfs: Use new GPE masking mechanism in GPE interface
      ACPI / EC: Add PM operations for suspend/resume noirq stage
      ACPI / EC: Add EC_FLAGS_QUERY_ENABLED to reveal a hidden logic
      ACPI / EC: Fix an issue that SCI_EVT cannot be detected after
event is enabled
      ACPI / EC: Add PM operations to improve event handling for resume process
      ACPI / EC: Add PM operations to improve event handling for suspend process
      ACPI / EC: Enable event freeze mode to improve event handling
for suspend process
      ACPI / button: Fix an issue in button.lid_init_state=ignore mode
      ACPI / button: Add document for ACPI control method lid device
restrictions
      ACPI / EC: Cleanup first_ec/boot_ec code
      ACPI / EC: Fix a memory leakage issue in acpi_ec_add()
      ACPI / EC: Fix a gap that ECDT EC cannot handle EC events
      ACPI / EC: Fix issues related to boot_ec
      ACPICA: Tables: Remove acpi_tb_install_fixed_table()
      ACPICA: Tables: Remove wrong table event macros
      ACPICA: Tables: Add new table events indicating table
installation/uninstallation
      ACPICA: Tables: Override all 64-bit GAS fields when
acpi_gbl_use32_bit_fadt_addresses is TRUE
      ACPICA: Interpreter: Fix MLC issues by switching to new
term_list grammar for table loading
      ACPICA: Namespace: Add acpi_ns_get_node_unlocked()
      ACPICA: Namespace: Fix dynamic table loading issues
      ACPICA: Dispatcher: Fix a mutex issue for method auto serialization
      ACPICA: Tables: Tune table mutex to be a leaf lock
      ACPICA: Tables: Fix a regression in acpi_tb_find_table()
      ACPI / sysfs: Fix an issue for LoadTable opcode
      ACPI / sysfs: Update sysfs signature handling code
      ACPICA: Tables: Fix "UNLOAD" code path lock issues
      ACPICA: Parser: Fix a regression in LoadTable support
      ACPI / bus: Adjust ACPI subsystem initialization for new table
loading mode

Mika Westerberg (7):
      PCI: Add pci_find_resource()
      ACPI / platform: Pay attention to parent device's resources
      ACPI / watchdog: Add support for WDAT hardware watchdog
      mfd: lpc_ich: Do not create iTCO watchdog when WDAT table exists
      i2c: i801: Do not create iTCO watchdog when WDAT table exists
      platform/x86: intel_pmc_ipc: Do not create iTCO watchdog when
WDAT table exists
      ACPI / documentation: Use recommended name in GPIO property names

Prakash, Prashanth (5):
      ACPI / CPPC: acquire pcc_lock only while accessing PCC subspace
      ACPI / CPPC: support for batching CPPC requests
      ACPI / CPPC: set a non-zero value for transition_latency
      ACPI / CPPC: move all PCC related information into pcc_data
      ACPI / CPPC: check for error bit in PCC status field

Srinivas Pandruvada (4):
      ACPI / CPPC: Allow build with ACPI_CPU_FREQ_PSS config
      ACPI / CPPC: Don't return on CPPC probe failure
      ACPI / CPPC: Add support for functional fixed hardware address
      ACPI / CPPC: Add prefix cppc to cpudata structure name

Wei Yongjun (3):
      ACPI / tables: Remove duplicated include from tables.c
      watchdog: wdat_wdt: fix return value check in wdat_wdt_probe()
      watchdog: wdat_wdt: Fix warning for using 0 as NULL

---------------

 Documentation/acpi/acpi-lid.txt                    |  96 +++
 Documentation/acpi/gpio-properties.txt             |  10 +-
 arch/x86/kernel/acpi/Makefile                      |   1 +
 arch/x86/kernel/acpi/boot.c                        |   6 +-
 arch/x86/kernel/acpi/cppc_msr.c                    |  58 ++
 drivers/acpi/Kconfig                               |   4 +-
 drivers/acpi/Makefile                              |   1 +
 drivers/acpi/acpi_apd.c                            |  27 +-
 drivers/acpi/acpi_lpss.c                           |  17 +
 drivers/acpi/acpi_platform.c                       |  20 +-
 drivers/acpi/acpi_watchdog.c                       | 123 ++++
 drivers/acpi/acpica/Makefile                       |   1 +
 drivers/acpi/acpica/acapps.h                       |  10 +-
 drivers/acpi/acpica/acdebug.h                      |   2 +-
 drivers/acpi/acpica/acevents.h                     |   3 +
 drivers/acpi/acpica/acglobal.h                     |   2 +
 drivers/acpi/acpica/aclocal.h                      |   2 +
 drivers/acpi/acpica/acnamesp.h                     |   8 +
 drivers/acpi/acpica/acparser.h                     |   2 +
 drivers/acpi/acpica/actables.h                     |  12 +-
 drivers/acpi/acpica/acutils.h                      |  53 +-
 drivers/acpi/acpica/dbconvert.c                    |   7 +-
 drivers/acpi/acpica/dbexec.c                       |  62 +-
 drivers/acpi/acpica/dbfileio.c                     |  20 +-
 drivers/acpi/acpica/dbinput.c                      |   2 +
 drivers/acpi/acpica/dbmethod.c                     | 132 ++++
 drivers/acpi/acpica/dbobject.c                     |   4 +-
 drivers/acpi/acpica/dsmethod.c                     |  14 +-
 drivers/acpi/acpica/dsutils.c                      |  17 +-
 drivers/acpi/acpica/dswexec.c                      |   3 +-
 drivers/acpi/acpica/dswload2.c                     |   7 +-
 drivers/acpi/acpica/evgpe.c                        |  57 ++
 drivers/acpi/acpica/evgpeinit.c                    |   7 +-
 drivers/acpi/acpica/evrgnini.c                     |   3 +-
 drivers/acpi/acpica/evxfgpe.c                      |  43 ++
 drivers/acpi/acpica/exconcat.c                     |   2 +-
 drivers/acpi/acpica/exconfig.c                     | 141 ++---
 drivers/acpi/acpica/exconvrt.c                     |   8 +-
 drivers/acpi/acpica/exmisc.c                       |   4 +-
 drivers/acpi/acpica/exoparg1.c                     |  23 +-
 drivers/acpi/acpica/exresop.c                      |  11 +-
 drivers/acpi/acpica/extrace.c                      |  25 -
 drivers/acpi/acpica/exutils.c                      |   8 +
 drivers/acpi/acpica/hwgpe.c                        |  23 +-
 drivers/acpi/acpica/nsaccess.c                     |   6 +-
 drivers/acpi/acpica/nsconvert.c                    |   1 -
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsload.c                       |  30 +-
 drivers/acpi/acpica/nsparse.c                      | 165 ++++-
 drivers/acpi/acpica/nsutils.c                      |  66 +-
 drivers/acpi/acpica/psparse.c                      |   6 +-
 drivers/acpi/acpica/psxface.c                      |  84 +++
 drivers/acpi/acpica/tbdata.c                       | 147 ++++-
 drivers/acpi/acpica/tbfadt.c                       | 136 ++---
 drivers/acpi/acpica/tbfind.c                       |  12 +-
 drivers/acpi/acpica/tbinstal.c                     |  73 +--
 drivers/acpi/acpica/tbutils.c                      |   3 +-
 drivers/acpi/acpica/tbxface.c                      |   4 +-
 drivers/acpi/acpica/tbxfload.c                     |  66 +-
 drivers/acpi/acpica/tbxfroot.c                     |   5 +-
 drivers/acpi/acpica/utaddress.c                    |   8 -
 drivers/acpi/acpica/utbuffer.c                     |  30 +-
 drivers/acpi/acpica/utdebug.c                      |  61 +-
 drivers/acpi/acpica/utdecode.c                     |   2 +-
 drivers/acpi/acpica/uthex.c                        |  46 +-
 drivers/acpi/acpica/utinit.c                       |   2 +-
 drivers/acpi/acpica/utnonansi.c                    | 357 +----------
 drivers/acpi/acpica/utosi.c                        |  22 +-
 drivers/acpi/acpica/utpredef.c                     |   2 -
 drivers/acpi/acpica/utprint.c                      | 105 +++-
 drivers/acpi/acpica/utstrtoul64.c                  | 348 +++++++++++
 drivers/acpi/acpica/uttrack.c                      |   4 +-
 drivers/acpi/acpica/utxface.c                      |   2 +-
 drivers/acpi/acpica/utxfinit.c                     |   9 +-
 drivers/acpi/battery.c                             |  10 +-
 drivers/acpi/bus.c                                 |   6 +-
 drivers/acpi/button.c                              |  85 ++-
 drivers/acpi/cppc_acpi.c                           | 664 ++++++++++++++++-----
 drivers/acpi/ec.c                                  | 468 ++++++++++++---
 drivers/acpi/internal.h                            |  15 +-
 drivers/acpi/pci_irq.c                             |  10 +-
 drivers/acpi/processor_driver.c                    |   4 +-
 drivers/acpi/scan.c                                |   2 +
 drivers/acpi/sleep.c                               |   6 +-
 drivers/acpi/sysfs.c                               |  99 +--
 drivers/acpi/tables.c                              |  16 +-
 drivers/base/core.c                                |   1 +
 drivers/cpufreq/cppc_cpufreq.c                     |  15 +-
 drivers/i2c/busses/i2c-i801.c                      |   4 +-
 drivers/mailbox/pcc.c                              | 316 +++++++---
 drivers/mfd/lpc_ich.c                              |   4 +
 drivers/pci/pci.c                                  |  24 +
 drivers/platform/x86/intel_pmc_ipc.c               |  12 +-
 drivers/tty/serial/8250/8250_dw.c                  |  15 +-
 drivers/watchdog/Kconfig                           |  13 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/wdat_wdt.c                        | 526 ++++++++++++++++
 include/acpi/acconfig.h                            |   4 +
 include/acpi/acoutput.h                            |   6 +-
 include/acpi/acpiosxf.h                            |  43 +-
 include/acpi/acpixf.h                              |  44 +-
 include/acpi/actbl.h                               | 164 ++---
 include/acpi/actypes.h                             |  64 +-
 include/acpi/cppc_acpi.h                           |  18 +-
 include/acpi/platform/acenv.h                      |  90 ++-
 include/acpi/platform/acenvex.h                    |  21 +-
 include/acpi/platform/acgcc.h                      |  17 +-
 include/acpi/platform/acgccex.h                    |  58 ++
 include/acpi/platform/aclinux.h                    |  22 +-
 include/acpi/platform/aclinuxex.h                  |   2 +-
 include/linux/acpi.h                               |  13 +
 include/linux/pci.h                                |   4 +
 tools/power/acpi/common/cmfsize.c                  |  13 +-
 tools/power/acpi/common/getopt.c                   |   4 +-
 .../acpi/os_specific/service_layers/oslibcfs.c     | 217 -------
 .../acpi/os_specific/service_layers/osunixxf.c     |   3 -
 tools/power/acpi/tools/acpidump/Makefile           |   3 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |  12 +-
 tools/power/acpi/tools/acpidump/apdump.c           |  75 +--
 tools/power/acpi/tools/acpidump/apfiles.c          |  56 +-
 tools/power/acpi/tools/acpidump/apmain.c           |  37 +-
 121 files changed, 4263 insertions(+), 1928 deletions(-)
