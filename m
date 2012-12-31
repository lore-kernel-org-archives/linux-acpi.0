From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/27] ACPICA 20121220 Release
Date: Mon, 31 Dec 2012 08:03:41 +0800
Message-ID: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:58320 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAD7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:03:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

The 20121220 ACPICA linuxized patches are based on the pm/acpica
branch with 20121114 ACPICA linuxized patches applied.

QA process result:
1. Basic build/boot test passed:
   Debian testing on DELL Inspiron Mini (Intel ATOM z530)
2. Coding style issues have been decreased:
   4132 Lines -> 4114 Lines
3. Current source code differences between Linux and ACPICA with
   some unpublished patches is:
   59.3 Kbytes, 1641 Lines
4. Reviewed in release engineering, result is attached as follows:
   ACPICA has released 56 patches in 20121220, 27 patches of them
   have modified the source codes used in Linux.
   20121220 | ACPICA | Reviewed | ACPICA only  | Human intervention
   01       | 01     | o        | x            | x
   02       | 05     | o        | x            | x
   03       | 06     | o        | x(hwtimer.c) | x
   04       | 07     | o        | x            | x
   05       | 08     | o        | x            | x
   06       | 18     | o        | x            | o (slow hardware)
   07(TPM2) | 20     | o        | x            | x
   08       | 21     | o        | x            | x
   09       | 23     | x        | x            | x
   10       | 24     | o        | x            | x
   11       | 25     | o        | x            | o (return_UINTx)
   12       | 26     | o        | x            | o (debug enabling)
   13       | 27     | o        | o(rsdump.c)  | x
   14       | 28     | o        | x            | x
   15(CSRT) | 30     | o        | x            | x
   16(TPM2) | 31     | o        | x            | x
   17       | 32     | o        | x            | x
   18       | 34     | o        | x            | x
   19       | 35     | o        | x            | x
   20       | 36     | o        | x            | x
   21       | 37     | o        | x            | x
   22       | 38     | o        | x            | x
   23       | 39     | o        | x            | x
   24       | 41     | o        | x            | x
   25       | 43     | o        | x            | x
   26       | 46     | x        | x            | x
   27       | 56     | o        | x            | x
   This information may also be useful for the reviewers.
   Note: Though not-reviewed patches are checked by divergences check
         script, the purposes are still get examined by human eyes.
         No divergences on affected source files will be taken as good
         patch.
   Note: ACPICA-only patches should not do any funtional changes to
         Linux.
   Note: Human intervention is required for some patches due to the
         coding style differences. Such intervention is not recorded
         in the table above, only actual code insertions/deletions are
         recorded.

Please review.

Aaron Lu (2):
  ACPICA: Resource manager: Add support for ACPI 5 wake bit in IRQ
    descriptor.
  ACPICA: Resources: Support for ACPI 5 wake bit in ExtendedInterrupt
    descriptor.

Bob Moore (23):
  ACPICA: Resources: New interface, AcpiWalkResourceBuffer.
  ACPICA: Change exception code for LoadTable operator.
  ACPICA: Eliminate some small unnecessary pathname functions.
  ACPICA: Add root node optimization to internal get namespace node
    function.
  ACPICA: Lint changes, no functional change.
  ACPICA: Add time macros for various timer/time manipulation.
  ACPICA: Add header file support for the ACPI 5 TPM2 ACPI table.
  ACPICA: DEBUG_PRINT macros: Update to improve performance.
  ACPICA: FUNCTION_TRACE macros: Check if debug is enabled up-front.
  ACPICA: Eliminate superfluous return_UINT8 and return_UINT32 macros.
  ACPICA: Update ACPI_IS_DEBUG_ENABLED macro.
  ACPICA: Deploy new ACPI_IS_DEBUG_ENABLED macro in debug output code.
  ACPICA: Merge all debug output macros into a single file, acoutput.
  ACPICA: iASL: Finish support for CSRT table.
  ACPICA: iASL: Finish support for the TPM2 table.
  ACPICA: Update for non-configured ACPI_IS_DEBUG_ENABLED macro.
  ACPICA: Namespace: Eliminate dot...dot output during initialization.
  ACPICA: Update ACPICA initialization messages.
  ACPICA: Interpreter: Add warning if 64-bit constant appears in 32-bit
    table.
  ACPICA: Resources: Split interrupt share/wake bits into two fields.
  ACPICA: Interpreter: Fix Store() when implicit conversion is not
    possible.
  ACPICA: Source restructuring: split large files into 8 new files.
  ACPICA: Update version to 20121220.

Rafael J. Wysocki (1):
  ACPICA: Resource Manager: Add a pointer cast for a namespace node.

Tim Gardner (1):
  ACPICA: Fix possible memory leak in dispatcher error path.

 drivers/acpi/acpica/Makefile     |    8 +-
 drivers/acpi/acpica/acdebug.h    |   17 +
 drivers/acpi/acpica/acevents.h   |   21 +-
 drivers/acpi/acpica/acinterp.h   |    2 +-
 drivers/acpi/acpica/acmacros.h   |  137 +------
 drivers/acpi/acpica/acnamesp.h   |   14 +-
 drivers/acpi/acpica/acparser.h   |   25 +-
 drivers/acpi/acpica/acresrc.h    |    6 +-
 drivers/acpi/acpica/acutils.h    |   50 ++-
 drivers/acpi/acpica/dsmethod.c   |    1 +
 drivers/acpi/acpica/dsobject.c   |   14 +-
 drivers/acpi/acpica/dsutils.c    |   10 +-
 drivers/acpi/acpica/dswexec.c    |    4 +-
 drivers/acpi/acpica/evgpe.c      |    6 +-
 drivers/acpi/acpica/evgpeblk.c   |   22 +-
 drivers/acpi/acpica/evgpeinit.c  |    3 +
 drivers/acpi/acpica/evhandler.c  |  529 ++++++++++++++++++++++++
 drivers/acpi/acpica/evregion.c   |  582 +++------------------------
 drivers/acpi/acpica/evsci.c      |    4 +-
 drivers/acpi/acpica/exconfig.c   |    7 +-
 drivers/acpi/acpica/exconvrt.c   |    2 +-
 drivers/acpi/acpica/exdump.c     |   19 +-
 drivers/acpi/acpica/exprep.c     |    4 +-
 drivers/acpi/acpica/exstore.c    |   29 +-
 drivers/acpi/acpica/exstoren.c   |    2 +-
 drivers/acpi/acpica/exutils.c    |   22 +-
 drivers/acpi/acpica/hwacpi.c     |    8 +-
 drivers/acpi/acpica/hwsleep.c    |    2 +-
 drivers/acpi/acpica/hwtimer.c    |    7 +-
 drivers/acpi/acpica/hwxfsleep.c  |    2 +-
 drivers/acpi/acpica/nsdump.c     |    8 +-
 drivers/acpi/acpica/nsinit.c     |   21 +-
 drivers/acpi/acpica/nspredef.c   |  581 +-------------------------
 drivers/acpi/acpica/nsprepkg.c   |  621 ++++++++++++++++++++++++++++
 drivers/acpi/acpica/nsutils.c    |   77 ++--
 drivers/acpi/acpica/nsxfeval.c   |    2 +-
 drivers/acpi/acpica/nsxfname.c   |    2 +-
 drivers/acpi/acpica/psargs.c     |    7 +-
 drivers/acpi/acpica/psloop.c     |  621 ----------------------------
 drivers/acpi/acpica/psobject.c   |  647 +++++++++++++++++++++++++++++
 drivers/acpi/acpica/psopcode.c   |  172 --------
 drivers/acpi/acpica/psopinfo.c   |  223 ++++++++++
 drivers/acpi/acpica/psutils.c    |    8 -
 drivers/acpi/acpica/rsdump.c     |  419 +------------------
 drivers/acpi/acpica/rsdumpinfo.c |  454 +++++++++++++++++++++
 drivers/acpi/acpica/rsirq.c      |   32 +-
 drivers/acpi/acpica/rsserial.c   |    8 +-
 drivers/acpi/acpica/rsutils.c    |    4 +-
 drivers/acpi/acpica/rsxface.c    |  101 +++--
 drivers/acpi/acpica/tbxfload.c   |    2 +-
 drivers/acpi/acpica/utaddress.c  |    4 +-
 drivers/acpi/acpica/utdebug.c    |  118 ++++--
 drivers/acpi/acpica/utdelete.c   |    2 +-
 drivers/acpi/acpica/utmisc.c     |  828 ++++----------------------------------
 drivers/acpi/acpica/utownerid.c  |  218 ++++++++++
 drivers/acpi/acpica/utstring.c   |  574 ++++++++++++++++++++++++++
 include/acpi/acconfig.h          |    1 +
 include/acpi/acoutput.h          |  150 ++++++-
 include/acpi/acpixf.h            |    7 +-
 include/acpi/acrestyp.h          |   10 +-
 include/acpi/actbl2.h            |   23 +-
 include/acpi/actbl3.h            |   32 +-
 include/acpi/actypes.h           |   21 +-
 63 files changed, 4068 insertions(+), 3489 deletions(-)
 create mode 100644 drivers/acpi/acpica/evhandler.c
 create mode 100644 drivers/acpi/acpica/nsprepkg.c
 create mode 100644 drivers/acpi/acpica/psobject.c
 create mode 100644 drivers/acpi/acpica/psopinfo.c
 create mode 100644 drivers/acpi/acpica/rsdumpinfo.c
 create mode 100644 drivers/acpi/acpica/utownerid.c
 create mode 100644 drivers/acpi/acpica/utstring.c

-- 
1.7.10

