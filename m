From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/7] ACPICA / debugger: Add in-kernel AML debugger support
Date: Tue, 10 Nov 2015 16:21:30 +0800
Message-ID: <cover.1447143067.git.lv.zheng@intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15874 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbbKJIWI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Nov 2015 03:22:08 -0500
In-Reply-To: <cover.1446790780.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patchset enables ACPICA debugger for Linux kernel and implements a
userspace utility to access it.

A. Build the AML debugger
In order to build the kernel support of AML debugger, the following kconfig
items should be enabled:
 CONFIG_ACPI_DEBUG=y
 CONFIG_ACPI_DEBUGGER=y
 CONFIG_DEBUG_FS=y
 CONFIG_ACPI_DEBUGGER_USER=m
The userspace tool can be found at tools/power/acpi/tools/acpidbg. To
build this utility, staying in tools folder and type "make acpi".

B. Load the AML debugger during runtime
In order to use the in-kernel AML debugger, the following command should be
executed using root user:
 # modprobe acpi_dbg
 # mount -t debugfs none /sys/kernel/debug
 # acpidbg

C. Batch mode
In order to support scripts, the userspace utility also supports single
command batch mode:
 # acpidbg -b "help"
 # acpidbg -b "tables"
 # acpidbg -b "find _LID"
 # acpidbg -b "execute \_SB.LID0._LID"
You can find the documentation about the ACPICA debugger commands in:
 https://acpica.org/sites/acpica/files/acpica-reference_17.pdf
 (The latest document can be found at https://acpica.org/documentation)
And refer to the chapter - ACPICA debugger reference to obtain the full
description of the debugger commands. Note that not all commands are
supported by an in-kernel AML debugger.

D. Unload the AML debugger during runtime
After terminating all acpidbg instances, the following command can be
executed to remove the AML debugger from kernel:
 # rmmod acpi_dbg

The following tasks are not completed:
1. .flush() support in the kernel debugger IO driver.
2. multi-commands batch mode.

v2:
1. Fix a help message issue for the userspace acpidbg utility (this is a
   typo fix).
2. Fix a batch mode issue by adding "\n" to the prompt sequence (this was
   lost due to too many rebase cycles).
3. Fix kconfig dependency for an intermediate patch (this is only useful in
   case the latter patches are reverted).
4. Add more accurate runtime debugger stub mechanism and remove old
   ACPI_DEBUGGER_EXEC() stub mechanism.
5. Add x86 acpi_os_readable() support.

Chen Yu (1):
  ACPI / x86: introduce acpi_os_readable() support

Colin Ian King (1):
  ACPICA: Debugger: Remove unnecessary status check

Lv Zheng (5):
  ACPICA: Debugger: Convert some mechanisms to OSPM specific
  ACPICA: Debugger: Fix runtime stub issues of ACPI_DEBUGGER_EXEC using
    different stub mechanism
  ACPI / debugger: Add IO interface to access debugger functionalities
  tools/power/acpi: Add userspace AML interface support
  ACPI / debugger: Add module support for ACPI debugger

 arch/x86/Kconfig                         |    1 +
 arch/x86/include/asm/acenv.h             |    1 +
 arch/x86/kernel/acpi/boot.c              |   14 +
 drivers/acpi/Kconfig                     |   16 +-
 drivers/acpi/Makefile                    |    1 +
 drivers/acpi/acpi_dbg.c                  |  818 ++++++++++++++++++++++++++++++
 drivers/acpi/acpica/acdebug.h            |   36 +-
 drivers/acpi/acpica/acglobal.h           |    5 -
 drivers/acpi/acpica/acmacros.h           |   11 -
 drivers/acpi/acpica/dbdisply.c           |   12 +
 drivers/acpi/acpica/dbinput.c            |  100 +---
 drivers/acpi/acpica/dbxface.c            |   93 ++--
 drivers/acpi/acpica/dscontrol.c          |   10 +-
 drivers/acpi/acpica/dsutils.c            |   16 +-
 drivers/acpi/acpica/dswexec.c            |   16 +-
 drivers/acpi/acpica/utmutex.c            |   17 -
 drivers/acpi/bus.c                       |    1 +
 drivers/acpi/osl.c                       |  262 +++++++++-
 include/acpi/acpiosxf.h                  |   18 +-
 include/acpi/acpixf.h                    |   34 ++
 include/acpi/platform/aclinux.h          |    3 +-
 include/acpi/platform/aclinuxex.h        |    8 +-
 include/linux/acpi.h                     |   71 +++
 tools/power/acpi/Makefile                |   16 +-
 tools/power/acpi/tools/acpidbg/Makefile  |   27 +
 tools/power/acpi/tools/acpidbg/acpidbg.c |  438 ++++++++++++++++
 26 files changed, 1833 insertions(+), 212 deletions(-)
 create mode 100644 drivers/acpi/acpi_dbg.c
 create mode 100644 tools/power/acpi/tools/acpidbg/Makefile
 create mode 100644 tools/power/acpi/tools/acpidbg/acpidbg.c

-- 
1.7.10

