From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v2 0/5] ACPICA / debugger: Add in-kernel AML debugger support
Date: Fri,  6 Nov 2015 14:46:50 +0800
Message-ID: <cover.1446790780.git.lv.zheng@intel.com>
References: <8c1016ca8a570ba7c7a1c9f0f88d73cd83cea490>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8c1016ca8a570ba7c7a1c9f0f88d73cd83cea490>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

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
3. upstream the userspace acpidbg to the ACPICA upstream.

Colin Ian King (1):
  ACPICA: Debugger: Remove unnecessary status check

Lv Zheng (4):
  ACPICA: Debugger: Convert some mechanisms to OSPM specific
  ACPI / debugger: Add IO interface to access debugger functionalities
  tools/power/acpi: Add userspace AML interface support
  ACPI / debugger: Add module support for ACPI debugger

 drivers/acpi/Kconfig                     |   13 +-
 drivers/acpi/Makefile                    |    1 +
 drivers/acpi/acpi_dbg.c                  |  818 ++++++++++++++++++++++++++++++
 drivers/acpi/acpica/acdebug.h            |    2 +-
 drivers/acpi/acpica/acglobal.h           |    5 -
 drivers/acpi/acpica/dbinput.c            |  100 +---
 drivers/acpi/acpica/dbxface.c            |   63 +--
 drivers/acpi/acpica/utmutex.c            |   17 -
 drivers/acpi/bus.c                       |    1 +
 drivers/acpi/osl.c                       |  250 ++++++++-
 include/acpi/acpiosxf.h                  |   18 +-
 include/acpi/acpixf.h                    |   11 +
 include/acpi/platform/aclinux.h          |    2 +
 include/acpi/platform/aclinuxex.h        |    9 +
 include/linux/acpi.h                     |   71 +++
 tools/power/acpi/Makefile                |   16 +-
 tools/power/acpi/tools/acpidbg/Makefile  |   27 +
 tools/power/acpi/tools/acpidbg/acpidbg.c |  438 ++++++++++++++++
 18 files changed, 1699 insertions(+), 163 deletions(-)
 create mode 100644 drivers/acpi/acpi_dbg.c
 create mode 100644 tools/power/acpi/tools/acpidbg/Makefile
 create mode 100644 tools/power/acpi/tools/acpidbg/acpidbg.c

-- 
1.7.10
