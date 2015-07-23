From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/22] ACPICA: 20150717 Release
Date: Thu, 23 Jul 2015 12:51:58 +0800
Message-ID: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5123 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbbGWEwI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 00:52:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The 20150717 ACPICA kernel-resident subsystem updates are linuxized based
on the linux-pm/linux-next branch.

The patchset has passed the following build/boot tests.
Build tests are performed as follows:
1. i386 + default + COFNIG_ACPI=y
2. i386 + allyes + CONFIG_ACPI=y
3. i386 + default + COFNIG_ACPI=n
4. i386 + allyes + CONFIG_ACPI=n
5. x86_64 + default + COFNIG_ACPI=y
6. x86_64 + allyes + CONFIG_ACPI=y
7. x86_64 + default + COFNIG_ACPI=n
8. x86_64 + allyes + CONFIG_ACPI=n
Boot tests are performed as follows:
1. i386 + default + COFNIG_ACPI=y
2. x86_64 + default + COFNIG_ACPI=y
Where:
1. i386: machine named as "Dell Inspiron Mini 1010"
2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
3. default: kernel configuration with following items enabled:
   All hardware drivers related to the machines of i386/x86_64
   All "drivers/acpi" configurations
   All "drivers/platform" drivers
   All other drivers that link the APIs provided by ACPICA subsystem

The divergences checking result:
Before applying (20150619 Release):
  539 lines
After applying (20150717 Release):
  518 lines
Note that the reduction is due to:
1. The FACS related divergences are not counted;
2. Some debugger related divergences are merged in this release as the
   configurability of the debugger code has improved.

Bob Moore (6):
  ACPICA: iASL: Add new warnings for method local_x and arg_x
    variables.
  ACPICA: Cleanup use of all non-ANSI local C library functions.
  ACPICA: Cleanup use of NEGATIVE and POSITIVE defines.
  ACPICA: iASL: Add support for TCPA Server Table.
  ACPICA: iASL/Disassembler: Add prototype verbose mode.
  ACPICA: Update version to 20150717.

Lv Zheng (15):
  ACPICA: Parser: Reduce parser/namespace divergences for tracer
    support.
  ACPICA: Parser: Cleanup aml_offset in struct acpi_walk_state.
  ACPICA: Parser: Cleanup aml_offset in union acpi_operand_object.
  ACPICA: Dispatcher: Cleanup union acpi_operand_object's AML address
    assignments.
  ACPICA: Executer: Add back pointing reference of method operand.
  ACPICA: Namespace: Add function to directly return normalized full
    path.
  ACPICA: Dispatcher: Move stack traversal code to dispatcher.
  ACPICA: Dispatcher: Add trace support for interpreter.
  ACPICA: Executer: Add interpreter tracing mode for method tracing
    facility.
  ACPICA: Executer: Add OSL trace hook support.
  ACPICA: Executer: Add option to bypass opcode tracing.
  ACPICA: Parser: Remove redundant opcode execution debugging output.
  ACPICA: MSVC: Fix inclusion order issue of <crtdbg.h>.
  ACPICA: Debugger: Reduce structure size for debugger.
  ACPICA: Debugger: Move debugger specific APIs to debugger component.

Markus Elfring (1):
  ACPICA: Remove extraneous check for null walk_state.

 drivers/acpi/acpica/Makefile     |    2 +
 drivers/acpi/acpica/acdebug.h    |   19 ++
 drivers/acpi/acpica/acdispat.h   |    8 +
 drivers/acpi/acpica/acglobal.h   |    3 +-
 drivers/acpi/acpica/acinterp.h   |   22 +++
 drivers/acpi/acpica/aclocal.h    |   11 +-
 drivers/acpi/acpica/acmacros.h   |    9 +
 drivers/acpi/acpica/acnamesp.h   |   13 +-
 drivers/acpi/acpica/acobject.h   |    1 +
 drivers/acpi/acpica/acparser.h   |    4 +-
 drivers/acpi/acpica/acstruct.h   |    2 +-
 drivers/acpi/acpica/acutils.h    |   23 ++-
 drivers/acpi/acpica/dsargs.c     |    4 +-
 drivers/acpi/acpica/dsdebug.c    |  231 +++++++++++++++++++++++
 drivers/acpi/acpica/dsmethod.c   |   35 ++--
 drivers/acpi/acpica/dswload.c    |    2 +-
 drivers/acpi/acpica/dswload2.c   |    2 +-
 drivers/acpi/acpica/excreate.c   |    1 +
 drivers/acpi/acpica/exdebug.c    |  324 ++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/exdump.c     |    5 +-
 drivers/acpi/acpica/nsnames.c    |  275 +++++++++++++++------------
 drivers/acpi/acpica/nsparse.c    |   42 ++---
 drivers/acpi/acpica/nsutils.c    |    2 +-
 drivers/acpi/acpica/nsxfname.c   |    8 +-
 drivers/acpi/acpica/psargs.c     |   26 +--
 drivers/acpi/acpica/psloop.c     |   18 +-
 drivers/acpi/acpica/psobject.c   |   17 +-
 drivers/acpi/acpica/psparse.c    |   14 +-
 drivers/acpi/acpica/psutils.c    |    8 +-
 drivers/acpi/acpica/psxface.c    |  123 +-----------
 drivers/acpi/acpica/rscreate.c   |    3 +-
 drivers/acpi/acpica/utdebug.c    |   31 +++-
 drivers/acpi/acpica/utdelete.c   |    3 +
 drivers/acpi/acpica/utinit.c     |    2 -
 drivers/acpi/acpica/utmisc.c     |    2 +-
 drivers/acpi/acpica/utnonansi.c  |  380 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utstring.c   |  342 ----------------------------------
 include/acpi/acoutput.h          |   21 ++-
 include/acpi/acpiosxf.h          |    6 +
 include/acpi/acpixf.h            |   13 +-
 include/acpi/actbl2.h            |   17 +-
 include/acpi/actypes.h           |   11 +-
 include/acpi/platform/acenvex.h  |    3 +
 include/acpi/platform/acmsvcex.h |   54 ++++++
 include/acpi/platform/acwinex.h  |   49 +++++
 45 files changed, 1491 insertions(+), 700 deletions(-)
 create mode 100644 drivers/acpi/acpica/dsdebug.c
 create mode 100644 drivers/acpi/acpica/utnonansi.c
 create mode 100644 include/acpi/platform/acmsvcex.h
 create mode 100644 include/acpi/platform/acwinex.h

-- 
1.7.10

