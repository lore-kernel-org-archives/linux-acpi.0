From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI updates for v4.13-rc1
Date: Mon, 3 Jul 2017 23:50:41 +0200
Message-ID: <CAJZ5v0gCrQ=iNXXK+X1uCpM7ZzQpG4ewjO-pLHUwbUJZj2AdXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:38481 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdGCVum (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2017 17:50:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.13-rc1

with top-most commit 03471c06d02f80f9338a5df45f2a92ef38ca1233

 Merge branches 'acpi-ec' and 'acpi-video'

on top of commit c0bc126f97fb929b3ae02c1c62322645d70eb408

 Linux 4.12-rc7

to receive ACPI updates for v4.13-rc1.

These mostly update the ACPICA code in the kernel to upstream
revision 20170531 which covers all of the new material from ACPI 6.2,
including new tables (WSMT, HMAT, PPTT), new subtables and definition
changes for some existing tables (BGRT, HEST, SRAT, TPM2, PCCT),
new resource descriptor macros for pin control, support for new
predefined methods (_LSI, _LSR, _LSW, _HMA), fixes and cleanups.

On top of that, an additional ACPICA change from Kees (which also
is upstream already) switches all of the definitions of function
pointer structures in ACPICA to use designated initializers so as
to make the structure layout randomization GCC plugin work with it.

The rest is a few fixes and cleanups in the EC driver, an xpower PMIC
driver update, a new backlight blacklist entry, and update of the
tables configfs interface and a messages formatting cleanup.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision
   revision 20170531 (which covers all of the new material from
   ACPI 6.2) including:
   * Support for the PinFunction(), PinConfig(), PinGroup(),
     PinGroupFunction(), and PinGroupConfig() resource descriptors
     (Mika Westerberg).
   * Support for new subtables in HEST and SRAT, new notify value
     for HEST, header support for TPM2 table changes, and BGRT
     Status field update (Bob Moore).
   * Support for new PCCT subtables (David Box).
   * Support for _LSI, _LSR, _LSW, and _HMA as predefined methods
     (Erik Schmauss).
   * Support for the new WSMT, HMAT, and PPTT tables (Lv Zheng).
   * New UUID values for Processor Properties (Bob Moore).
   * New notify values for memory attributes and graceful shutdown
     (Bob Moore).
   * Fix related to the PCAT_COMPAT MADT flag (Janosch Hildebrand).
   * Resource to AML conversion fix for resources containing GPIOs
     (Mika Westerberg).
   * Disassembler-related updates (Bob Moore, David Box, Erik
     Schmauss).
   * Assorted fixes and cleanups (Bob Moore, Erik Schmauss, Lv Zheng,
     Cao Jin).

 - Modify ACPICA to always use designated initializers for function
   pointer structures to make the structure layout randomization GCC
   plugin work with it (Kees Cook).

 - Update the tables configfs interface to unload SSDTs on configfs
   entry removal (Jan Kiszka).

 - Add support for the GPI1 regulator to the xpower PMIC Operation
   Region handler (Hans de Goede).

 - Fix ACPI EC issues related to conflicting EC definitions in the
   ECDT and in the ACPI namespace (Lv Zheng, Carlo Caione, Chris
   Chiu).

 - Fix an interrupt storm issue in the EC driver and make its debug
   output work with dynamic debug as expected (Lv Zheng).

 - Add ACPI backlight quirk for Dell Precision 7510 (Shih-Yuan Lee).

 - Fix whitespace in pr_fmt() to align log entries properly in some
   places in the ACPI subsystem (Vincent Legoll).

Thanks!


---------------

Bob Moore (25):
      ACPICA: Add new notify value for memory attributes update
      ACPICA: Added two new UUID values
      ACPICA: Utilities: Make a notify value reserved
      ACPICA: Update Status field for BGRT table
      ACPICA: Add new notify value for HEST table
      ACPICA: Add new flags to HEST subtables
      ACPICA: Add support for new HEST subtable
      ACPICA: Add support for new SRAT subtable
      ACPICA: Add header support for TPM2 table changes
      ACPICA: Fix a type value overlap in the AML support file
      ACPICA: Update error message for field beyond buffer case
      ACPICA: Debugger/acpiexec: Cleanup error messages
      ACPICA: Disassembler: Abort on an invalid/unknown AML opcode
      ACPICA: Export the public mutex interfaces
      ACPICA: Remove extraneous status check
      ACPICA: Split resource descriptor decode strings to a new file
      ACPICA: Comment update: spelling/format. No functional change
      ACPICA: Fix for Device/Thermal objects with ObjectType and DerefOf
      ACPICA: Update two error messages to emit control method name
      ACPICA: Improvements for debug output only
      ACPICA: Unix application OSL: Correctly handle control-c (EINTR)
      ACPICA: Simplify output for the ACPI Debug Object
      ACPICA: acpiexec: enhance local signal handler
      ACPICA: Update a couple of debug output messages
      ACPICA: Update version to 20170531

Cao Jin (1):
      ACPICA: Update comments, no functional change

Carlo Caione (1):
      ACPI / EC: Add quirk for GL720VMK

Chris Chiu (1):
      ACPI / EC: Fix media keys not working problem on some Asus laptops

David E. Box (2):
      ACPICA: disassembler: improve Switch support
      ACPICA: Add support for new PCCT subtables

Erik Schmauss (11):
      ACPICA: Change path's type from u8* to char*
      ACPICA: Add support for _LSI as a predefined method
      ACPICA: Add support for _LSR as a predefined method
      ACPICA: Add support for _LSW as a predefined method
      ACPICA: Add support for _HMA as a predefined method
      ACPICA: Explicitly cast 1 to u32
      ACPICA: Changing External to a named object
      ACPICA: Changed Gbl_disasm_flag to acpi_gbl_disasm_flag
      ACPICA: Disassembler: prevent external op's from opening a new scope
      ACPICA: Disassembler: add external op to namespace on first pass
      ACPICA: Disassembler: allow conflicting external declarations to
be emitted.

Hans de Goede (1):
      ACPI / PMIC: xpower: Add support for the GPI1 regulator to the
OpRegion handler

Jan Kiszka (1):
      ACPI: configfs: Unload SSDT on configfs entry removal

Janosch Hildebrand (1):
      ACPICA: Tables: Fix defined values for MADT PCAT_COMPAT flag

Kees Cook (1):
      ACPICA: Use designated initializers

Lv Zheng (10):
      ACPICA: Tables: Add WSMT support
      ACPICA: Tables: Add HMAT table definitions
      ACPICA: Tables: Add PPTT table definitions
      ACPICA: OSL: Add support to exclude stdarg.h
      ACPICA: Events: Add runtime stub support for event APIs
      ACPICA: Dispatcher: Remove unnecessary call to debugger
      ACPI: EC: Fix an EC event IRQ storming issue
      ACPI: EC: Fix EC command visibility for dynamic debug
      ACPI / EC: Enhance boot EC sanity check
      ACPI / EC: Add support to skip boot stage DSDT probe

Mika Westerberg (6):
      ACPICA: ACPI 6.2: Add support for PinFunction() resource
      ACPICA: ACPI 6.2: Add support for PinConfig() resource
      ACPICA: ACPI 6.2: Add support for PinGroup() resource
      ACPICA: ACPI 6.2: Add support for PinGroupFunction() resource
      ACPICA: ACPI 6.2: Add support for PinGroupConfig() resource
      ACPICA: Core: Always set GPIO VendorOffset

Shih-Yuan Lee (FourDollars) (1):
      ACPI / video: Add quirks for the Dell Precision 7510

Vincent Legoll (1):
      ACPI: fix whitespace in pr_fmt() to align log entries

---------------

 drivers/acpi/acpi_configfs.c                       |  20 +-
 drivers/acpi/acpi_dbg.c                            |   2 +-
 drivers/acpi/acpica/Makefile                       |   1 +
 drivers/acpi/acpica/acapps.h                       |   4 +-
 drivers/acpi/acpica/acglobal.h                     |   3 +
 drivers/acpi/acpica/aclocal.h                      |  15 +-
 drivers/acpi/acpica/acopcode.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |  16 +
 drivers/acpi/acpica/acresrc.h                      |  15 +-
 drivers/acpi/acpica/acutils.h                      |   1 +
 drivers/acpi/acpica/amlcode.h                      |  61 ++--
 drivers/acpi/acpica/amlresrc.h                     | 104 ++++++
 drivers/acpi/acpica/dbexec.c                       |  12 +
 drivers/acpi/acpica/dbobject.c                     |   6 +-
 drivers/acpi/acpica/dbxface.c                      |   2 +-
 drivers/acpi/acpica/dsargs.c                       |   5 +-
 drivers/acpi/acpica/dsdebug.c                      |   1 +
 drivers/acpi/acpica/dsmethod.c                     |  12 +-
 drivers/acpi/acpica/dsopcode.c                     |  11 +-
 drivers/acpi/acpica/dsutils.c                      |   9 -
 drivers/acpi/acpica/dswexec.c                      |   4 +-
 drivers/acpi/acpica/dswload.c                      |  42 ++-
 drivers/acpi/acpica/dswload2.c                     |  16 +
 drivers/acpi/acpica/evxfevnt.c                     |  18 +
 drivers/acpi/acpica/exdebug.c                      |   4 +-
 drivers/acpi/acpica/exdump.c                       |  30 +-
 drivers/acpi/acpica/exoparg1.c                     |  25 +-
 drivers/acpi/acpica/exresolv.c                     |  23 +-
 drivers/acpi/acpica/hwxfsleep.c                    |  14 +-
 drivers/acpi/acpica/nsaccess.c                     |  27 ++
 drivers/acpi/acpica/nsnames.c                      |   3 -
 drivers/acpi/acpica/nsutils.c                      |   2 +-
 drivers/acpi/acpica/nsxfeval.c                     |  39 ++-
 drivers/acpi/acpica/psobject.c                     |  14 +
 drivers/acpi/acpica/psopcode.c                     |   8 +-
 drivers/acpi/acpica/psparse.c                      |  14 +-
 drivers/acpi/acpica/rscalc.c                       | 139 ++++++++
 drivers/acpi/acpica/rsdump.c                       |  48 +++
 drivers/acpi/acpica/rsdumpinfo.c                   | 114 +++++++
 drivers/acpi/acpica/rsinfo.c                       |  28 +-
 drivers/acpi/acpica/rsmisc.c                       |   4 +-
 drivers/acpi/acpica/rsserial.c                     | 373 +++++++++++++++++++++
 drivers/acpi/acpica/tbdata.c                       |   4 +
 drivers/acpi/acpica/tbfadt.c                       |   4 +-
 drivers/acpi/acpica/tbutils.c                      |   6 +-
 drivers/acpi/acpica/utdecode.c                     |   8 +-
 drivers/acpi/acpica/utownerid.c                    |  12 +-
 drivers/acpi/acpica/utresdecode.c                  | 315 +++++++++++++++++
 drivers/acpi/acpica/utresrc.c                      | 259 +-------------
 drivers/acpi/acpica/utxfmutex.c                    |   5 +-
 drivers/acpi/button.c                              |   2 +-
 drivers/acpi/ec.c                                  |  84 ++++-
 drivers/acpi/ioapic.c                              |   2 +-
 drivers/acpi/pmic/intel_pmic_xpower.c              |  21 +-
 drivers/acpi/video_detect.c                        |   8 +
 drivers/char/tpm/tpm_crb.c                         |   4 +-
 drivers/mailbox/pcc.c                              |  10 +-
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/acrestyp.h                            |  92 ++++-
 include/acpi/actbl1.h                              | 238 ++++++++++++-
 include/acpi/actbl2.h                              |  59 +++-
 include/acpi/actbl3.h                              |  82 ++++-
 include/acpi/actypes.h                             |  67 ++--
 include/acpi/acuuid.h                              |   5 +
 include/acpi/platform/acenv.h                      |   4 +
 include/acpi/platform/acgcc.h                      |  10 +
 include/acpi/platform/acintel.h                    |   2 +
 include/acpi/platform/aclinux.h                    |   2 +
 .../acpi/os_specific/service_layers/osunixxf.c     |  10 +-
 69 files changed, 2156 insertions(+), 452 deletions(-)
