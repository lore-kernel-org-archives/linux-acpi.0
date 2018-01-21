From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI updates for v4.16-rc1
Date: Sun, 21 Jan 2018 03:20:50 +0100
Message-ID: <CAJZ5v0iH04ZneJOSA+KDnbXKcVU72BiHoX7DFmCvUQJ6WPcUNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

This goes early because of my LCA travel.

In case you decide to open the 4.16 merge window any time soon, please
pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.16-rc1

with top-most commit a7f2766ac7c359216da4e714dc117c881e39a74a

 Merge branches 'acpi-gpio', 'acpi-button', 'acpi-battery' and 'acpi-video'

on top of commit a8750ddca918032d6349adbf9a4b6555e7db20da

 Linux 4.15-rc8

to receive ACPI updates for 4.16-rc1.

The majority of this is an update of the ACPICA kernel code to
upstream revision 20171215 with a cosmetic change and a maintainers
information update on top of it.

The rest is mostly some minor fixes and cleanups in the ACPI drivers
and cleanups to initialization on x86.

Specifics:

 - Update the ACPICA kernel code to upstream revision 20171215 including:
   * Support for ACPI 6.0A changes in the NFIT table (Bob Moore).
   * Local 64-bit divide in string conversions (Bob Moore).
   * Fix for a regression in acpi_evaluate_object_type() (Bob Moore).
   * Fixes for memory leaks during package object resolution (Bob Moore).
   * Deployment of safe version of strncpy() (Bob Moore).
   * Debug and messaging updates (Bob Moore).
   * Support for PDTT, SDEV, TPM2 tables in iASL and tools (Bob Moore).
   * Null pointer dereference avoidance in Op and cleanups (Colin Ian King)=
.
   * Fix for memory leak from building prefixed pathname (Erik Schmauss).
   * Coding style fixes, disassembler and compiler updates (Hanjun Guo,
     Erik Schmauss).
   * Additional PPTT flags from ACPI 6.2 (Jeremy Linton).
   * Fix for an off-by-one error in acpi_get_timer_duration() (Jung-uk Kim)=
.
   * Infinite loop detection timeout and utilities cleanups (Lv Zheng).
   * Windows 10 version 1607 and 1703 OSI strings (Mario Limonciello).

 - Update ACPICA information in MAINTAINERS to reflect the current
   status of ACPICA maintenance and rename a local variable in one
   function to match the corresponding upstream code (Rafael Wysocki).

 - Clean up ACPI-related initialization on x86 (Andy Shevchenko).

 - Add support for Intel Merrifield to the ACPI GPIO code (Andy
   Shevchenko).

 - Clean up ACPI PMIC drivers (Andy Shevchenko, Arvind Yadav).

 - Fix the ACPI Generic Event Device (GED) driver to free IRQs on
   shutdown and clean up the PCI IRQ Link driver (Sinan Kaya).

 - Make the GHES code call into the AER driver on all errors and
   clean up the ACPI APEI code (Colin Ian King, Tyler Baicar).

 - Make the IA64 ACPI NUMA code parse all SRAT entries (Ganapatrao
   Kulkarni).

 - Add a lid switch blacklist to the ACPI button driver and make it
   print extra debug messages on lid events (Hans de Goede).

 - Add quirks for Asus GL502VSK and UX305LA to the ACPI battery
   driver and clean it up somewhat (Bj=C3=B8rn Mork, Kai-Heng Feng).

 - Add device link for CHT SD card dependency on I2C to the ACPI
   LPSS (Intel SoCs) driver and make it avoid creating platform
   device objects for devices without MMIO resources (Adrian Hunter,
   Hans de Goede).

 - Fix the ACPI GPE mask kernel command line parameter handling
   (Prarit Bhargava).

 - Fix the handling of (incorrectly exposed) backlight interfaces
   without LCD (Hans de Goede).

 - Fix the usage of debugfs_create_*() in the ACPI EC driver (Geert
   Uytterhoeven).

Thanks!


---------------

Adrian Hunter (1):
      ACPI / LPSS: Add device link for CHT SD card dependency on I2C

Andy Shevchenko (8):
      ACPI / x86: boot: Swap variables in condition in
acpi_register_gsi_ioapic()
      ACPI / x86: boot: Get rid of ACPI_INVALID_GSI
      ACPI / x86: boot: Use INVALID_ACPI_IRQ instead of 0 for
acpi_sci_override_gsi
      ACPI / x86: boot: Don't setup SCI on HW-reduced platforms
      ACPI / x86: boot: Propagate error code in acpi_gsi_to_irq()
      ACPI: utils: Introduce acpi_dev_get_first_match_name()
      gpio: merrifield: Add support of ACPI enabled platforms
      ACPI / PMIC: Convert to use builtin_platform_driver() macro

Arvind Yadav (1):
      ACPI / PMIC: constify platform_device_id

Bj=C3=B8rn Mork (1):
      ACPI: battery: Drop redundant test for failure

Bob Moore (22):
      ACPICA: Rename AE_AML_INFINITE_LOOP exception
      ACPICA: Tools: Deploy -vd option (build date/time) across all tools
      ACPICA: iASL/Tools: Add support for PDTT, SDEV, TPM2 ACPI tables
      ACPICA: Update version to 20170929
      ACPICA: Use local 64-bit divide support for string conversions
      ACPICA: Update output from ACPI_EXCEPTION macro
      ACPICA: Add an additional error message for EC timeouts
      ACPICA: Enhance error messages from namespace create/lookup operation=
s
      ACPICA: ACPI 6.0A: Changes to the NFIT ACPI table
      ACPICA: Small typo fix, no functional change
      ACPICA: Debugger: add "background" command for method execution
      ACPICA: Update mutex error messages, no functional change
      ACPICA: Update linkage for get mutex name interface
      ACPICA: Update version to 20171110
      ACPICA: Debug output, no functional change
      ACPICA: Update for a few debug output statements
      ACPICA: Fix a regression in the acpi_evaluate_object_type() interface
      ACPICA: Cleanup the global variables and update comments
      ACPICA: Create and deploy safe version of strncpy
      ACPICA: Rename a global variable, no functional change
      ACPICA: Fix a couple memory leaks during package object resolution
      ACPICA: Update version to 20171215

Colin Ian King (3):
      ACPICA: Avoid null pointer dereference on Op.
      ACPICA: Trivial fix to spelling mistake in comment
      ACPI / APEI: remove redundant variables len and node_len

Erik Schmauss (8):
      ACPICA: Disassembler: reset parser_state's Aml pointer when
parsing bad externals
      ACPICA: disassembler: getting rid of error message
      ACPICA: iASL: change processing of external op namespace nodes
for correctness
      ACPICA: ACPICA: style edits to utility function output, no
functional change
      ACPICA: Namespace: fix memory leak from building prefixed pathname
      ACPICA: Debugger: fix slight indentation issue
      ACPICA: DT compiler: prevent error if optional field at the end
of table is not present
      ACPICA: trivial style fix, no functional change

Ganapatrao Kulkarni (1):
      ACPI / NUMA: ia64: Parse all entries of SRAT memory affinity table

Geert Uytterhoeven (1):
      ACPI: EC: Fix debugfs_create_*() usage

Hanjun Guo (1):
      ACPICA: iasl: Add SMMUv3 device ID mapping index support

Hans de Goede (4):
      ACPI: button: Add a debug message when we're sending a LID event
      ACPI: button: Add a LID switch blacklist and add 1 model to it
      ACPI / video: Default lcd_only to true on Win8-ready and newer machin=
es
      ACPI / LPSS: Do not instiate platform_dev for devs without MMIO resou=
rces

Jeremy Linton (1):
      ACPICA: ACPI 6.2: Additional PPTT flags

Jung-uk Kim (1):
      ACPICA: Fix an off-by-one error in acpi_get_timer_duration().

Kai-Heng Feng (1):
      ACPI / battery: Add quirk for Asus GL502VSK and UX305LA

Lv Zheng (2):
      ACPICA: Dispatcher: Introduce timeout mechanism for infinite
loop detection
      ACPICA: Utilities: Cleanup style issue for bit clearing

Mario Limonciello (1):
      ACPICA: Recognize the Windows 10 version 1607 and 1703 OSI strings

Prarit Bhargava (1):
      ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs

Rafael J. Wysocki (2):
      ACPICA: Rename variable to match upstream
      ACPICA: Update information in MAINTAINERS

Sinan Kaya (2):
      ACPI: GED: unregister interrupts during shutdown
      ACPI/PCI: pci_link: reduce verbosity when IRQ is enabled

Tyler Baicar (2):
      ACPI: APEI: handle PCIe AER errors in separate function
      ACPI: APEI: call into AER handling regardless of severity

---------------

 Documentation/admin-guide/kernel-parameters.txt |   1 -
 MAINTAINERS                                     |   2 +-
 arch/ia64/kernel/acpi.c                         |   5 +
 arch/x86/include/asm/acpi.h                     |   2 +-
 arch/x86/kernel/acpi/boot.c                     |  35 +++---
 drivers/acpi/acpi_lpss.c                        | 139 ++++++++++++++++++++=
+
 drivers/acpi/acpi_video.c                       |  14 ++-
 drivers/acpi/acpica/acapps.h                    |   3 +
 drivers/acpi/acpica/acdebug.h                   |   4 +
 drivers/acpi/acpica/acglobal.h                  |  82 ++++--------
 drivers/acpi/acpica/aclocal.h                   |  15 +--
 drivers/acpi/acpica/acmacros.h                  |   2 +-
 drivers/acpi/acpica/acnamesp.h                  |   3 +
 drivers/acpi/acpica/acutils.h                   |  23 ++--
 drivers/acpi/acpica/dbexec.c                    | 110 +++++++++++++++-
 drivers/acpi/acpica/dbfileio.c                  |   4 +-
 drivers/acpi/acpica/dbinput.c                   | 145 ++++++++++++--------=
-
 drivers/acpi/acpica/dscontrol.c                 |  18 +--
 drivers/acpi/acpica/dsfield.c                   |  28 +++--
 drivers/acpi/acpica/dsobject.c                  |   4 +-
 drivers/acpi/acpica/dspkginit.c                 |  21 ++--
 drivers/acpi/acpica/dsutils.c                   |   3 +-
 drivers/acpi/acpica/dswload.c                   |   6 +-
 drivers/acpi/acpica/dswload2.c                  |  13 +-
 drivers/acpi/acpica/evregion.c                  |  10 ++
 drivers/acpi/acpica/exdump.c                    |  11 +-
 drivers/acpi/acpica/hwtimer.c                   |  29 +++--
 drivers/acpi/acpica/hwvalid.c                   |  14 +--
 drivers/acpi/acpica/nsaccess.c                  |  13 +-
 drivers/acpi/acpica/nsconvert.c                 |   3 +-
 drivers/acpi/acpica/nsnames.c                   | 149 ++++++++++++++++++++=
++
 drivers/acpi/acpica/nssearch.c                  |   1 +
 drivers/acpi/acpica/nsxfeval.c                  |   9 +-
 drivers/acpi/acpica/psargs.c                    |   2 +-
 drivers/acpi/acpica/psobject.c                  |  10 +-
 drivers/acpi/acpica/psutils.c                   |  14 ++-
 drivers/acpi/acpica/utdebug.c                   |  18 ++-
 drivers/acpi/acpica/utdecode.c                  |  11 +-
 drivers/acpi/acpica/uterror.c                   |  73 +++++++++++
 drivers/acpi/acpica/utinit.c                    |   1 -
 drivers/acpi/acpica/utmath.c                    |   4 +-
 drivers/acpi/acpica/utmutex.c                   |   9 +-
 drivers/acpi/acpica/utnonansi.c                 |  11 +-
 drivers/acpi/acpica/utosi.c                     |   2 +
 drivers/acpi/acpica/utstrsuppt.c                |  42 ++++---
 drivers/acpi/acpica/uttrack.c                   |   6 +-
 drivers/acpi/acpica/utxferror.c                 |   8 +-
 drivers/acpi/apei/ghes.c                        |  79 +++++++-----
 drivers/acpi/battery.c                          |  36 +++++-
 drivers/acpi/button.c                           |  22 ++++
 drivers/acpi/ec.c                               |   2 +-
 drivers/acpi/ec_sys.c                           |   2 +-
 drivers/acpi/evged.c                            |  47 ++++++-
 drivers/acpi/internal.h                         |   2 +-
 drivers/acpi/numa.c                             |   3 +-
 drivers/acpi/pci_link.c                         |   2 +-
 drivers/acpi/pmic/intel_pmic_bxtwc.c            |   9 +-
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c         |   5 +-
 drivers/acpi/pmic/intel_pmic_chtwc.c            |   9 +-
 drivers/acpi/pmic/intel_pmic_crc.c              |   7 +-
 drivers/acpi/pmic/intel_pmic_xpower.c           |   7 +-
 drivers/acpi/sysfs.c                            |  26 ++--
 drivers/acpi/utils.c                            |  41 ++++--
 drivers/gpio/gpio-merrifield.c                  |  11 +-
 include/acpi/acconfig.h                         |   4 +-
 include/acpi/acexcep.h                          |  12 +-
 include/acpi/acpi_bus.h                         |   3 +
 include/acpi/acpixf.h                           |   6 +-
 include/acpi/actbl1.h                           | 159 ++++++++++++++++++++=
++--
 include/acpi/actbl2.h                           |  15 ++-
 include/acpi/actypes.h                          |   4 +
 include/linux/acpi.h                            |   6 +
 tools/power/acpi/tools/acpidump/apmain.c        |  28 ++++-
 73 files changed, 1263 insertions(+), 416 deletions(-)
