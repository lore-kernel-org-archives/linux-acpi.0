From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/15] ACPICA: 20160212 Release
Date: Fri, 19 Feb 2016 14:15:53 +0800
Message-ID: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12510 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425849AbcBSGQB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Feb 2016 01:16:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The 20160212 ACPICA kernel-resident subsystem updates are linuxized based
on the linux-pm/linux-next branch.

The patchset has passed the following build/boot tests.
Build tests are performed as follows:
1. i386 + allyes
2. i386 + allno
3. i386 + default + ACPI_DEBUGGER=y
4. i386 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
5. i386 + default + ACPI_DEBUG=n + ACPI=y
6. i386 + default + ACPI=n
7. x86_64 + allyes
8. x86_64 + allno
9. x86_64 + default + ACPI_DEBUGGER=y
10.x86_64 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
11.x86_64 + default + ACPI_DEBUG=n + ACPI=y
12.x86_64 + default + ACPI=n
Boot tests are performed as follows:
1. i386 + default + ACPI_DEBUGGER=y
2. x86_64 + default + ACPI_DEBUGGER=y
Where:
1. i386: machine named as "Dell Inspiron Mini 1010"
2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
3. default: kernel configuration with following items enabled:
   All hardware drivers related to the machines of i386/x86_64
   All "drivers/acpi" configurations
   All "drivers/platform" drivers
   All other drivers that link the APIs provided by ACPICA subsystem

The divergences checking result:
Before applying (20160108 Release):
  506 lines
After applying (20160212 Release):
  506 lines

Bob Moore (8):
  ACPICA: Remove incorrect "static" from a global structure
  ACPICA: iASL: Fix some typos with the name strtoul64
  ACPICA: iASL: Update to use internal acpi_ut_strtoul64 function
  ACPICA: Remove unnecessary arguments to ACPI_INFO
  ACPICA: ACPI 6.1: Add full support for this version of ACPI spec
  ACPICA: Revert "Parser: Fix for SuperName method invocation"
  ACPICA: Utilities: Update trace mechinism for acquire_object
  ACPICA: Update version to 20160212

Colin Ian King (1):
  ACPICA: debugger: dbconvert: free pld_info on error return path

David E. Box (1):
  ACPICA: ACPI 6.0/iASL: Add support for the External AML opcode

Lv Zheng (4):
  ACPICA: Tables: make default region accessible during the table load
  ACPICA: ACPICA: Tune _REG evaluations order in the initialization
    steps
  ACPICA: Namespace: Ensure \_SB._INI executed before any _REG
  ACPICA: Namespace: Rename acpi_gbl_reg_methods_enabled to
    acpi_gbl_namespace_initialized

waddlesplash (1):
  ACPICA: aclocal: Put parens around some definitions.

 drivers/acpi/acpica/acglobal.h  |    2 +-
 drivers/acpi/acpica/aclocal.h   |    6 +-
 drivers/acpi/acpica/acnamesp.h  |    2 +-
 drivers/acpi/acpica/acpredef.h  |   11 +-
 drivers/acpi/acpica/dbcmds.c    |    2 +-
 drivers/acpi/acpica/dbconvert.c |    5 +-
 drivers/acpi/acpica/dsmethod.c  |    3 +-
 drivers/acpi/acpica/dsobject.c  |    3 +-
 drivers/acpi/acpica/evgpeblk.c  |    3 +-
 drivers/acpi/acpica/evgpeinit.c |    2 +-
 drivers/acpi/acpica/evregion.c  |    2 +-
 drivers/acpi/acpica/exconfig.c  |    4 +-
 drivers/acpi/acpica/exoparg3.c  |    4 +-
 drivers/acpi/acpica/nseval.c    |    3 +-
 drivers/acpi/acpica/nsinit.c    |  135 ++++++++++++---------
 drivers/acpi/acpica/psargs.c    |    9 +-
 drivers/acpi/acpica/tbinstal.c  |    5 +-
 drivers/acpi/acpica/tbprint.c   |    7 +-
 drivers/acpi/acpica/tbutils.c   |    4 +-
 drivers/acpi/acpica/tbxfload.c  |   28 ++++-
 drivers/acpi/acpica/utcache.c   |    2 +-
 drivers/acpi/acpica/utdecode.c  |   30 ++---
 drivers/acpi/acpica/utnonansi.c |  246 ++++++++++++++++++++++++++++++++-------
 drivers/acpi/acpica/uttrack.c   |    2 +-
 drivers/acpi/acpica/utxferror.c |    3 +-
 drivers/acpi/acpica/utxfinit.c  |   42 +++----
 include/acpi/acoutput.h         |    2 +-
 include/acpi/acpixf.h           |    8 +-
 include/acpi/actbl.h            |    2 +-
 include/acpi/actbl1.h           |   29 ++++-
 include/acpi/actypes.h          |    3 +-
 31 files changed, 418 insertions(+), 191 deletions(-)

-- 
1.7.10

