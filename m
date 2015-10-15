From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/13] ACPICA: 20150930 Release
Date: Thu, 15 Oct 2015 10:07:40 +0800
Message-ID: <cover.1444874756.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62015 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932105AbbJOCHo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Oct 2015 22:07:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The 20150930 ACPICA kernel-resident subsystem updates are linuxized based
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
Before applying (20150818 Release):
  517 lines
After applying (20150930 Release):
  517 lines

Note there are still 2 ACPICA debugger patches not released during this
release cycle, so the debugger IO driver is not released in this cycle. In
this series the ACPICA debugger core is compile time enabled as all ACPICA
debugger files can be built with ACPI_DEBUGGER=y, but not runtime enabled
as there is no invocations calling ACPICA debugger APIs and its required
OSls are just stubs.

Bob Moore (8):
  ACPICA: Remove unnecessary conditional compilation.
  ACPICA: iASL: Add symbolic operator support for Index() operator.
  ACPICA: Update exception code for "file not found" error
  ACPICA: Debugger: Update mutexes used for multithreaded debugger
  ACPICA: Update NFIT table to rename a flags field
  ACPICA: Improve typechecking, both compile-time and runtime
  ACPICA: iASL: General cleanup of the file suffix #defines
  ACPICA: Update version to 20150930

Lv Zheng (5):
  ACPICA: Linuxize: Export debugger files to Linux
  ACPICA: Debugger: Fix "quit/exit" command by cleaning up user
    commands termination logic
  ACPICA: Debugger: Fix "terminate" command by cleaning up subsystem
    shutdown logic
  ACPI: Enable build of AML interpreter debugger
  ACPICA: Debugger: Fix dead lock issue ocurred in single stepping mode

 drivers/acpi/Kconfig                      |    9 +
 drivers/acpi/acpica/Makefile              |   16 +
 drivers/acpi/acpica/acapps.h              |    2 +-
 drivers/acpi/acpica/acdebug.h             |    6 +
 drivers/acpi/acpica/acglobal.h            |    6 +-
 drivers/acpi/acpica/acinterp.h            |    2 -
 drivers/acpi/acpica/aclocal.h             |   14 +-
 drivers/acpi/acpica/acnamesp.h            |    4 -
 drivers/acpi/acpica/acopcode.h            |    4 +-
 drivers/acpi/acpica/acparser.h            |    4 -
 drivers/acpi/acpica/acutils.h             |    2 -
 drivers/acpi/acpica/amlcode.h             |   11 +-
 drivers/acpi/acpica/dbcmds.c              | 1187 +++++++++++++++++++++++++++
 drivers/acpi/acpica/dbconvert.c           |  484 +++++++++++
 drivers/acpi/acpica/dbdisply.c            | 1108 +++++++++++++++++++++++++
 drivers/acpi/acpica/dbexec.c              |  763 +++++++++++++++++
 drivers/acpi/acpica/dbfileio.c            |  256 ++++++
 drivers/acpi/acpica/dbhistry.c            |  239 ++++++
 drivers/acpi/acpica/dbinput.c             | 1267 +++++++++++++++++++++++++++++
 drivers/acpi/acpica/dbmethod.c            |  369 +++++++++
 drivers/acpi/acpica/dbnames.c             |  947 +++++++++++++++++++++
 drivers/acpi/acpica/dbobject.c            |  533 ++++++++++++
 drivers/acpi/acpica/dbstats.c             |  546 +++++++++++++
 drivers/acpi/acpica/dbtest.c              | 1057 ++++++++++++++++++++++++
 drivers/acpi/acpica/dbutils.c             |  457 +++++++++++
 drivers/acpi/acpica/dbxface.c             |  487 +++++++++++
 drivers/acpi/acpica/evxface.c             |    2 +-
 drivers/acpi/acpica/exconvrt.c            |    1 +
 drivers/acpi/acpica/exresolv.c            |    1 -
 drivers/acpi/acpica/exresop.c             |    2 +
 drivers/acpi/acpica/exstore.c             |  120 ++-
 drivers/acpi/acpica/exstoren.c            |    5 +-
 drivers/acpi/acpica/nsdump.c              |    6 -
 drivers/acpi/acpica/nspredef.c            |    2 +-
 drivers/acpi/acpica/pstree.c              |    2 -
 drivers/acpi/acpica/psutils.c             |    2 -
 drivers/acpi/acpica/rsdump.c              |    3 -
 drivers/acpi/acpica/rsutils.c             |    2 -
 drivers/acpi/acpica/rsxface.c             |    4 +-
 drivers/acpi/acpica/utdecode.c            |   21 +-
 drivers/acpi/acpica/utfileio.c            |    6 +
 drivers/acpi/acpica/utinit.c              |   15 +-
 drivers/acpi/acpica/utmutex.c             |   21 +
 drivers/acpi/acpica/utxface.c             |   19 +-
 drivers/acpi/nfit.c                       |    6 +-
 drivers/acpi/nfit.h                       |    2 +-
 drivers/acpi/osl.c                        |   11 +-
 include/acpi/acexcep.h                    |    7 +-
 include/acpi/acpixf.h                     |   12 +-
 include/acpi/actbl1.h                     |    2 +-
 include/acpi/platform/acenv.h             |    8 +-
 include/acpi/platform/aclinux.h           |    7 +-
 include/acpi/platform/aclinuxex.h         |    5 +
 tools/power/acpi/tools/acpidump/apfiles.c |    2 +-
 54 files changed, 9941 insertions(+), 135 deletions(-)
 create mode 100644 drivers/acpi/acpica/dbcmds.c
 create mode 100644 drivers/acpi/acpica/dbconvert.c
 create mode 100644 drivers/acpi/acpica/dbdisply.c
 create mode 100644 drivers/acpi/acpica/dbexec.c
 create mode 100644 drivers/acpi/acpica/dbfileio.c
 create mode 100644 drivers/acpi/acpica/dbhistry.c
 create mode 100644 drivers/acpi/acpica/dbinput.c
 create mode 100644 drivers/acpi/acpica/dbmethod.c
 create mode 100644 drivers/acpi/acpica/dbnames.c
 create mode 100644 drivers/acpi/acpica/dbobject.c
 create mode 100644 drivers/acpi/acpica/dbstats.c
 create mode 100644 drivers/acpi/acpica/dbtest.c
 create mode 100644 drivers/acpi/acpica/dbutils.c
 create mode 100644 drivers/acpi/acpica/dbxface.c

-- 
1.7.10

