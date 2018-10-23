From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI updates for v4.20-rc1
Date: Tue, 23 Oct 2018 07:38:10 +0200
Message-ID: <CAJZ5v0jbwJ04_n0xrs+9hL-hVT5+JYcMRo1MMACbKgHVsFnpTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.20-rc1

with top-most commit 0a1875ad29ef6436da3c184494b509697c8e0cf7

 Merge branches 'acpi-property' and 'acpi-sbs'

on top of commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e

 Linux 4.19-rc8

to receive ACPI updates for 4.20-rc1.

These fix ACPICA issues related to the handling of module-level AML,
fix an ordering issue during ACPI initialization, update ACPICA to
upstream revision 20181003 (including fixes mostly), fix issues with
system-wide suspend/resume related to the ACPI driver for Intel
SoCs (LPSS), fix device enumeration issues on boards with Dollar
Cove or Whiskey Cove Intel PMICs, prevent ACPICA from calling
ktime_get() in unsuitable conditions, update a few drivers and
clean up some code in several places.

Specifics:

 - Fix ACPICA issues related to the handling of module-level AML
   and make the ACPI initialization code parse ECDT before loading
   the definition block tables (Erik Schmauss).

 - Update ACPICA to upstream revision 20181003 including fixes
   related to the ill-defined "generic serial bus" and the handling
   of the _REG object (Bob Moore).

 - Fix some issues with system-wide suspend/resume on Intel BYT/CHT
   related to the handling of I2C controllers in the ACPI LPSS driver
   for Intel SoCs (Hans de Goede).

 - Modify the ACPI namespace scanning code to enumerate INT33FE HID
   devices as platform devices with I2C resources to avoid device
   enumeration problems on boards with Dollar Cove or Whiskey Cove
   Intel PMICs (Hans de Goede).

 - Prevent ACPICA from using ktime_get() during early resume from
   system-wide suspend before resuming the timekeeping which generally
   is unsafe and triggers a warning from the timekeeping code (Bart
   Van Assche).

 - Add low-level real time clock support to the ACPI Time and Aalarm
   Device (TAD) driver (Rafael Wysocki).

 - Fix the ACPI SBS driver to avoid GPE storms on MacBook Pro and
   Oopses when removing modules (Ronald Tschalär).

 - Fix the ACPI PPTT parsing code to handle architecturally unknown
   cache types properly (Jeffrey Hugo).

 - Fix initialization issue in the ACPI processor driver (Dou Liyang).

 - Clean up the code in several places (Andy Shevchenko, Bartlomiej
   Zolnierkiewicz, David Arcari, zhong jiang).

Thanks!


---------------

Andy Shevchenko (4):
      ACPI / glue: Split dev_is_platform() out of module for wide use
      ACPI / property: Switch to bitmap_zalloc()
      ACPI / PMIC: Sort headers alphabetically
      ACPI / PMIC: Convert drivers to use SPDX identifier

Bart Van Assche (1):
      ACPI / OSL: Use 'jiffies' as the time bassis for acpi_os_get_timer()

Bartlomiej Zolnierkiewicz (1):
      ACPI: remove redundant 'default n' from Kconfig

Bob Moore (6):
      ACPICA: Update for generic_serial_bus and
attrib_raw_process_bytes protocol
      ACPICA: Rename some of the Field Attribute defines
      ACPICA: Update for field unit access
      ACPICA: Split large interpreter file
      ACPICA: Never run _REG on system_memory and system_IO
      ACPICA: Update version to 20181003

David Arcari (1):
      mailbox: PCC: handle parse error

Dou Liyang (1):
      ACPI / processor: Fix the return value of acpi_processor_ids_walk()

Erik Schmauss (4):
      ACPICA: AML interpreter: add region addresses in global list
during initialization
      ACPICA: AML Parser: fix parse loop to correctly skip erroneous
extended opcodes
      ACPICA: Remove acpi_gbl_group_module_level_code and only use
acpi_gbl_execute_tables_as_methods instead
      ACPI: probe ECDT before loading AML tables regardless of
module-level code flag

Hans de Goede (9):
      ACPI / LPSS: Add alternative ACPI HIDs for Cherry Trail DMA controllers
      ACPI / LPSS: Exclude I2C busses shared with PUNIT from pmc_atom_d3_mask
      ACPI / LPSS: Make hid_uid_match helper take an acpi_device as
first argument
      ACPI / LPSS: Make hid_uid_match helper accept a NULL uid argument
      ACPI / LPSS: Make acpi_lpss_find_device() also find PCI devices
      ACPI / LPSS: Add a device link from the GPU to the CHT I2C7 controller
      ACPI / LPSS: Add a device link from the GPU to the BYT I2C5 controller
      ACPI / LPSS: Resume BYT/CHT I2C controllers from resume_noirq
      ACPI / scan: Create platform device for INT33FE ACPI nodes

Jeffrey Hugo (2):
      drivers: base: cacheinfo: Do not populate sysfs for unknown cache types
      ACPI/PPTT: Handle architecturally unknown cache types

Rafael J. Wysocki (1):
      ACPI: TAD: Add low-level support for real time capability

Ronald Tschalär (2):
      ACPI / SBS: Fix GPE storm on recent MacBookPro's
      ACPI / SBS: Fix rare oops when removing modules

zhong jiang (1):
      ACPI: custom_method: remove meaningless null check before debugfs_remove()

---------------

 drivers/acpi/Kconfig                     |   6 -
 drivers/acpi/acpi_lpss.c                 | 118 ++++++++--
 drivers/acpi/acpi_processor.c            |   7 +-
 drivers/acpi/acpi_tad.c                  | 201 +++++++++++++++++
 drivers/acpi/acpica/Makefile             |   1 +
 drivers/acpi/acpica/acevents.h           |   2 +
 drivers/acpi/acpica/acinterp.h           |  23 ++
 drivers/acpi/acpica/aclocal.h            |   2 +-
 drivers/acpi/acpica/amlcode.h            |  10 +-
 drivers/acpi/acpica/dsopcode.c           |   4 +
 drivers/acpi/acpica/evregion.c           |  17 +-
 drivers/acpi/acpica/evrgnini.c           |   6 +-
 drivers/acpi/acpica/evxfregn.c           |   1 -
 drivers/acpi/acpica/exfield.c            | 326 ++++++----------------------
 drivers/acpi/acpica/exserial.c           | 360 +++++++++++++++++++++++++++++++
 drivers/acpi/acpica/psloop.c             |  16 +-
 drivers/acpi/acpica/tbxfload.c           |   3 +-
 drivers/acpi/bus.c                       |  44 ++--
 drivers/acpi/custom_method.c             |   3 +-
 drivers/acpi/glue.c                      |   2 +-
 drivers/acpi/osl.c                       |  16 +-
 drivers/acpi/pmic/intel_pmic_bxtwc.c     |  12 +-
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c  |   1 +
 drivers/acpi/pmic/intel_pmic_chtwc.c     |  10 +-
 drivers/acpi/pmic/intel_pmic_crc.c       |  16 +-
 drivers/acpi/pmic/intel_pmic_xpower.c    |  16 +-
 drivers/acpi/pmic/tps68470_pmic.c        |   2 +-
 drivers/acpi/pptt.c                      |  33 ++-
 drivers/acpi/sbs.c                       |   8 +-
 drivers/acpi/sbshc.c                     |   2 +
 drivers/acpi/scan.c                      |   1 +
 drivers/acpi/x86/apple.c                 |   4 +-
 drivers/base/cacheinfo.c                 |   2 +
 drivers/mailbox/pcc.c                    |   7 +-
 drivers/platform/x86/intel_cht_int33fe.c |  24 +--
 include/acpi/acconfig.h                  |  17 +-
 include/acpi/acexcep.h                   |   9 +-
 include/acpi/acpixf.h                    |   9 +-
 include/linux/platform_device.h          |   1 +
 39 files changed, 908 insertions(+), 434 deletions(-)
