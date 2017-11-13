From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI updates for v4.15-rc1
Date: Mon, 13 Nov 2017 23:06:53 +0100
Message-ID: <CAJZ5v0gVsZFDryPjUS01Bd1xkH72Mr3s60VJ7n2O4dkknHG5Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:53088 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbdKMWGy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Nov 2017 17:06:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.15-rc1

with top-most commit eb5fcc3134b5375593de5325ddf4b1404b36b602

 Merge branches 'acpi-ec', 'acpi-button', 'acpi-sysfs', 'acpi-lpss'
and 'acpi-cppc'

on top of commit 39dae59d66acd86d1de24294bd2f343fd5e7a625

 Linux 4.14-rc8

to receive ACPI updates for 4.15-rc1.

These update ACPICA to upstream revision 20170831, fix APEI to use
the fixmap instead of ioremap_page_range(), add an operation region
driver for TI PMIC TPS68470, add support for PCC subspace IDs to the
ACPI CPPC driver, fix a few assorted issues and clean up some code.

Specifics:

 - Update the ACPICA code to upstream revision 20170831 including:
   * PDTT table header support (Bob Moore).
   * Cleanup and extension of internal string-to-integer conversion
     functions (Bob Moore).
   * Support for 64-bit hardware accesses (Lv Zheng).
   * ACPI PM Timer code adjustment to deal with 64-bit return values
     of acpi_hw_read() (Bob Moore).
   * Support for deferred table verification in acpiexec (Lv Zheng).

 - Fix APEI to use the fixmap instead of ioremap_page_range() which
   cannot work correctly the way the code in there attempted to use
   it and drop some code that's not necessary any more after that
   change (James Morse).

 - Clean up the APEI support code and make it use 64-bit timestamps
   (Arnd Bergmann, Dongjiu Geng, Jan Beulich).

 - Add operation region driver for TI PMIC TPS68470 (Rajmohan Mani).

 - Add support for PCC subspace IDs to the ACPI CPPC driver (George
   Cherian).

 - Fix an ACPI EC driver regression related to the handling of EC
   events during the "noirq" phases of system suspend/resume (Lv
   Zheng).

 - Delay the initialization of the lid state in the ACPI button
   driver to fix issues appearing on some systems (Hans de Goede).

 - Extend the KIOX000A "device always present" quirk to cover all
   affected BIOS versions (Hans de Goede).

 - Clean up some code in the ACPI core and drivers (Colin Ian King,
   Gustavo Silva).

Thanks!


---------------

Arnd Bergmann (1):
      APEI / ERST: use 64-bit timestamps

Bob Moore (6):
      ACPICA: Header support for the PDTT ACPI table
      ACPICA: Restructure/cleanup all string-to-integer conversion functions
      ACPICA: String conversions: Cleanup/format comments. No functional changes
      ACPICA: String conversions: Update to add new behaviors
      ACPICA: Update acpi_get_timer for 64-bit interface to acpi_hw_read
      ACPICA: Update version to 20170831

Colin Ian King (2):
      ACPI / sysfs: Make function param_set_trace_method_name() static
      ACPI / LPSS: Remove redundant initialization of clk

Dongjiu Geng (1):
      ACPI / APEI: remove the unused dead-code for SEA/NMI notification type

George Cherian (2):
      mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
      ACPI / CPPC: Make CPPC ACPI driver aware of PCC subspace IDs

Gustavo A. R. Silva (1):
      ACPI: Mark expected switch fall-throughs

Hans de Goede (2):
      ACPI / x86: Extend KIOX000A quirk to cover all affected BIOS versions
      ACPI / button: Delay acpi_lid_initialize_state() until first
user space open

James Morse (4):
      ACPI / APEI: Replace ioremap_page_range() with fixmap
      ACPI / APEI: Remove ghes_ioremap_area
      arm64: mm: Remove arch_apei_flush_tlb_one()
      ACPI / APEI: Remove arch_apei_flush_tlb_one()

Jan Beulich (1):
      ACPI / APEI: adjust a local variable type in ghes_ioremap_pfn_irq()

Lv Zheng (3):
      ACPICA: Hardware: Enable 64-bit support of hardware accesses
      ACPICA: acpiexec: Add testability of deferred table verification
      ACPI / EC: Fix regression related to triggering source of EC
event handling

Rajmohan Mani (1):
      ACPI / PMIC: Add TI PMIC TPS68470 operation region driver

---------------

 arch/arm64/include/asm/acpi.h            |  12 -
 arch/arm64/include/asm/fixmap.h          |   7 +
 arch/arm64/mm/mmu.c                      |   4 +
 arch/x86/include/asm/fixmap.h            |   6 +
 arch/x86/kernel/acpi/apei.c              |   5 -
 drivers/acpi/Kconfig                     |  16 ++
 drivers/acpi/Makefile                    |   2 +
 drivers/acpi/ac.c                        |   1 +
 drivers/acpi/acpi_lpss.c                 |   2 +-
 drivers/acpi/acpi_processor.c            |   1 +
 drivers/acpi/acpica/Makefile             |   1 +
 drivers/acpi/acpica/achware.h            |   4 +-
 drivers/acpi/acpica/acinterp.h           |   6 +-
 drivers/acpi/acpica/acutils.h            |  33 ++-
 drivers/acpi/acpica/dbconvert.c          |   5 +-
 drivers/acpi/acpica/dswexec.c            |   2 +-
 drivers/acpi/acpica/evgpe.c              |   6 +-
 drivers/acpi/acpica/exconcat.c           |   2 +-
 drivers/acpi/acpica/exconvrt.c           |  30 +-
 drivers/acpi/acpica/exmisc.c             |   2 +-
 drivers/acpi/acpica/exresop.c            |   2 +-
 drivers/acpi/acpica/hwgpe.c              |   4 +-
 drivers/acpi/acpica/hwregs.c             |  72 ++---
 drivers/acpi/acpica/hwtimer.c            |  10 +-
 drivers/acpi/acpica/hwxface.c            | 118 +-------
 drivers/acpi/acpica/nsconvert.c          |   4 +-
 drivers/acpi/acpica/tbxface.c            |   9 +-
 drivers/acpi/acpica/utstrsuppt.c         | 438 +++++++++++++++++++++++++++++
 drivers/acpi/acpica/utstrtoul64.c        | 442 +++++++++++++++---------------
 drivers/acpi/apei/erst.c                 |   2 +-
 drivers/acpi/apei/ghes.c                 | 117 ++------
 drivers/acpi/button.c                    |  26 +-
 drivers/acpi/cppc_acpi.c                 | 240 ++++++++++------
 drivers/acpi/dock.c                      |   1 +
 drivers/acpi/ec.c                        |  12 +-
 drivers/acpi/pmic/tps68470_pmic.c        | 455 +++++++++++++++++++++++++++++++
 drivers/acpi/resource.c                  |   1 +
 drivers/acpi/sysfs.c                     |   3 +-
 drivers/acpi/x86/utils.c                 |  18 +-
 drivers/mailbox/pcc.c                    |   1 -
 include/acpi/acexcep.h                   |  16 +-
 include/acpi/acpixf.h                    |   2 +-
 include/acpi/actbl1.h                    |  30 ++
 include/acpi/apei.h                      |   1 -
 include/acpi/pcc.h                       |   1 +
 tools/power/acpi/tools/acpidump/Makefile |   1 +
 tools/power/acpi/tools/acpidump/apdump.c |   3 +-
 tools/power/acpi/tools/acpidump/apmain.c |   4 +-
 48 files changed, 1551 insertions(+), 629 deletions(-)
