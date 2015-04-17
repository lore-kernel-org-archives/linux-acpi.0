From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPICA updates for v4.1-rc1
Date: Fri, 17 Apr 2015 02:48:44 +0200
Message-ID: <CAJZ5v0guxwWXZhkdhGQEDCESMDySjbPKDzhwGfi1TePjK1RMgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35077 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbbDQAsq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Apr 2015 20:48:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpica-4.1-rc1

to receive ACPICA material for v4.1-rc1 with top-most commit
0ee0d34985ceffe4036319e1e46df8bff591b9e3

 ACPICA: Store GPE register enable masks upfront

on top of commit 39a8804455fb23f09157341d3ba7db6d7ae6ee76

 Linux 4.0

This updates the kernel's ACPICA code to upstream revision 20150410
and adds a fix for a GPE handling regression introduced during the
3.19 cycle on top of that.

Included are two stable-candidate bug fixes (one of them fixing a
3.16 regression), multiple other fixes and a bunch of cleanups.

Specifics:

 - Fix for a GPE handling regression on Dell Latitude D600 that
   caused GPE signaling to stop working on that machine, which
   appears to be due to a hardware glitch, but it used to work
   and it can be made work again in a relativly straightforward
   way (Rafael J Wysocki).

 - Fix for a mutex unlock regression related to the handling of ACPI
   tables introduced during the 3.16 development cycle (Octavian Purdila).

 - _REV modification to always return 2 which has been done by all
   versions of Windows since NT and the firmware people started to
   use it to distinguish between OSes in their AML and do some silly
   and wrong things on that basis (Bob Moore).

 - Fixes and cleanups related to the acpi_physicall_address data type
   including one stable-candidate fix for an issue occasionally occuring
   on 64-bit machines running 32-bit kernels where using offsets provided
   by the firmware may lead to address overflows (Lv Zheng).

 - External() opcode support infrastructure needed for recompiling
   disassembled ACPI tables in some cases including interpreter
   modification to ignore that opcode (Bob Moore).

 - Support for the "Windows 2015" string in _OSI (Bob Moore).

 - GPE debug interface change to return values read from hardware
   registers (Lv Zheng).

 - Removal of the __DATE__ macro usage in tools (Rasmus Villemoes).

 - Assorted minor fixes and cleanups (Lv Zheng, Rickard Strandqvist,
   Bob Moore).

Thanks!


---------------

Bob Moore (15):
      ACPICA: Casting changes around acpi_physical_address/acpi_size.
      ACPICA: Fix a sscanf format string.
      ACPICA: Update Resource descriptor dump module.
      ACPICA: Update AML Debugger global variables.
      ACPICA: iASL/Disassembler: Add option to assume table contains valid AML.
      ACPICA: iASL: Enhancement for constant folding.
      ACPICA: Add infrastructure for External() opcode.
      ACPICA: Add "Windows 2015" string to _OSI support.
      ACPICA: Permanently set _REV to the value '2'.
      ACPICA: Remove unused internal AML opcode.
      ACPICA: Add "//" before ascii output of buffers.
      ACPICA: Update for SLIC ACPI table.
      ACPICA: iASL: Add support for MSDM ACPI table.
      ACPICA: Disassembler: Some cleanup of the table dump module.
      ACPICA: Update version to 20150410.

Lv Zheng (13):
      ACPICA: Linuxize: Reduce divergences for 20150410 release.
      ACPICA: Tables: Change acpi_find_root_pointer() to use
acpi_physical_address.
      ACPICA: Unix: Cleanup to use ACPI_TO_INTEGER() to calc page offset.
      ACPICA: Executer: Cleanup to remove an unnecessary conversion.
      ACPICA: Utilities: Cleanup to enforce
ACPI_PHYSADDR_TO_PTR()/ACPI_PTR_TO_PHYSADDR().
      ACPICA: Utilities: Cleanup to convert physical address printing formats.
      ACPICA: Utilities: Cleanup to remove useless
ACPI_PRINTF/FORMAT_xxx helpers.
      ACPICA: Utilities: split IO address types from data type models.
      ACPICA: Events: Add support to return both enable/status
register values for GPE and fixed event.
      ACPICA: Tables: Move an iasl specific table function to iasl source file.
      ACPICA: Utilities: Correct conditional compilation definitions.
      ACPICA: Resources: Correct conditional compilation definitions.
      ACPICA: Fix a couple issues with the local printf module.

Octavian Purdila (1):
      ACPICA: Tables: Don't release ACPI_MTX_TABLES in
acpi_tb_install_standard_table().

Rafael J. Wysocki (1):
      ACPICA: Store GPE register enable masks upfront

Rasmus Villemoes (1):
      ACPICA: Applications: Remove use of __DATE__ macro.

Rickard Strandqvist (1):
      ACPICA: Utilities: Remove unused acpi_ut_create_pkg_state_and_push().

---------------

 drivers/acpi/acpica/acapps.h                       |   8 +-
 drivers/acpi/acpica/acglobal.h                     |   5 +-
 drivers/acpi/acpica/aclocal.h                      |   2 +-
 drivers/acpi/acpica/acmacros.h                     |  13 +-
 drivers/acpi/acpica/acopcode.h                     |   2 +
 drivers/acpi/acpica/acresrc.h                      |   6 +-
 drivers/acpi/acpica/acstruct.h                     |   5 -
 drivers/acpi/acpica/actables.h                     |   9 +-
 drivers/acpi/acpica/acutils.h                      |  22 +-
 drivers/acpi/acpica/amlcode.h                      |   2 +-
 drivers/acpi/acpica/dsopcode.c                     |   7 +-
 drivers/acpi/acpica/dsutils.c                      |  11 +
 drivers/acpi/acpica/evgpe.c                        |   5 +-
 drivers/acpi/acpica/evregion.c                     |   2 +-
 drivers/acpi/acpica/evxfevnt.c                     |   5 +-
 drivers/acpi/acpica/exdump.c                       |   4 +-
 drivers/acpi/acpica/exfldio.c                      |  10 +-
 drivers/acpi/acpica/exoparg3.c                     |  13 +-
 drivers/acpi/acpica/exregion.c                     |  17 +-
 drivers/acpi/acpica/hwgpe.c                        |  24 ++-
 drivers/acpi/acpica/hwvalid.c                      |  16 +-
 drivers/acpi/acpica/nsdump.c                       |  12 +-
 drivers/acpi/acpica/psopcode.c                     |   8 +-
 drivers/acpi/acpica/psopinfo.c                     |   2 +-
 drivers/acpi/acpica/rsdump.c                       | 227 +++++++++++----------
 drivers/acpi/acpica/tbdata.c                       |  35 +++-
 drivers/acpi/acpica/tbinstal.c                     |  67 ++----
 drivers/acpi/acpica/tbprint.c                      |  19 +-
 drivers/acpi/acpica/tbxfroot.c                     |   7 +-
 drivers/acpi/acpica/utaddress.c                    |  34 ++-
 drivers/acpi/acpica/utbuffer.c                     |   8 +
 drivers/acpi/acpica/utglobal.c                     |  13 +-
 drivers/acpi/acpica/utmisc.c                       |   2 +
 drivers/acpi/acpica/utosi.c                        |   1 +
 drivers/acpi/acpica/utprint.c                      |  13 +-
 drivers/acpi/acpica/utstate.c                      |  34 ---
 drivers/acpi/acpica/utuuid.c                       |   2 +
 include/acpi/acpixf.h                              |  14 +-
 include/acpi/actbl2.h                              |  70 ++-----
 include/acpi/actypes.h                             |  50 +++--
 include/acpi/platform/acenv.h                      |   1 +
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 43 files changed, 391 insertions(+), 420 deletions(-)
