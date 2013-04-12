From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/11] ACPICA 20130328 Release
Date: Fri, 12 Apr 2013 08:24:14 +0800
Message-ID: <cover.1365473141.git.lv.zheng@intel.com>
References: <cover.1364865215.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25224 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab3DLAYU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 20:24:20 -0400
In-Reply-To: <cover.1364865215.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

The 20130328 ACPICA kernel resident system updates is linuxized based on
the pm/linux-next branch.
The patch set has passed a basic build/boot test on z530.

Fixed several possible race conditions with the internal object reference 
counting mechanism. Some of the external ACPICA interfaces update object 
reference counts without holding the interpreter or namespace lock. This 
change adds a spinlock to protect reference count updates on the internal 
ACPICA objects. Reported by and with assistance from Andriy Gapon 
(avg@FreeBSD.org).

FADT support: Removed an extraneous warning for very large GPE register sets. 
This change removes a size mismatch warning if the legacy length field for a 
GPE register set is larger than the 64-bit GAS structure can accommodate. GPE 
register sets can be larger than the 255-bit width limitation of the GAS 
structure. Linn Crosetto (linn@hp.com).

_OSI Support: handle any errors from AcpiOsAcquireMutex. Check for error 
return from this interface. Handles a possible timeout case if 
ACPI_WAIT_FOREVER is modified by the host to be a value less than "forever". 
Jung-uk Kim.

Predefined name support: Add allowed/required argument type information to 
the master predefined info table. This change adds the infrastructure to 
enable typechecking on incoming arguments for all predefined methods/objects. 
It does not actually contain the code that will fully utilize this 
information, this is still under development. Also condenses some duplicate 
code for the predefined names into a new module, utilities/utpredef.c

Example Code and Data Size: These are the sizes for the OS-independent 
acpica.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The 
debug version of the code includes the debug output trace mechanism and has a 
much larger code and data size.

  Previous Release:
    Non-Debug Version:  95.0K Code, 25.9K Data, 120.9K Total
    Debug Version:     182.9K Code, 75.6K Data, 258.5K Total
  Current Release:
    Non-Debug Version:  95.2K Code, 26.4K Data, 121.6K Total
    Debug Version:     183.0K Code, 76.0K Data, 259.0K Total

Bob Moore (6):
  ACPICA: Predefine names: Add allowed argument types to master info
    table
  ACPICA: Improve error message for Index() operator
  ACPICA: Remove FORCE_DELETE option for global reference count
    mechanism
  ACPICA: Fix a format string for 64-bit generation
  ACPICA: Update version to 20130328
  ACPICA: Add a lock to the internal object reference count mechanism

Colin Ian King (2):
  ACPICA: Fix a typo in an error message
  ACPICA: Fix a typo in a function header, no functional change

Jung-uk Kim (1):
  ACPICA: _OSI Support: handle any errors from AcpiOsAcquireMutex

Linn Crosetto (1):
  ACPICA: FADT: Remove extraneous warning for very large GPE registers

Tang Chen (1):
  ACPICA: Fix for some comments/headers

 drivers/acpi/acpica/Makefile   |    1 +
 drivers/acpi/acpica/acglobal.h |    1 +
 drivers/acpi/acpica/aclocal.h  |   13 +-
 drivers/acpi/acpica/acnamesp.h |    4 -
 drivers/acpi/acpica/acpredef.h | 1305 ++++++++++++++++++++++++++++------------
 drivers/acpi/acpica/acutils.h  |   25 +-
 drivers/acpi/acpica/dswexec.c  |    2 +-
 drivers/acpi/acpica/evevent.c  |    2 +-
 drivers/acpi/acpica/exoparg2.c |   11 +-
 drivers/acpi/acpica/nseval.c   |   26 +-
 drivers/acpi/acpica/nspredef.c |  106 +---
 drivers/acpi/acpica/tbfadt.c   |    4 +
 drivers/acpi/acpica/tbxface.c  |   22 +-
 drivers/acpi/acpica/utdelete.c |   96 +--
 drivers/acpi/acpica/utmutex.c  |    9 +-
 drivers/acpi/acpica/utosi.c    |   26 +-
 drivers/acpi/acpica/utpredef.c |  399 ++++++++++++
 drivers/acpi/acpica/utxface.c  |   17 +-
 include/acpi/acpixf.h          |    2 +-
 19 files changed, 1481 insertions(+), 590 deletions(-)
 create mode 100644 drivers/acpi/acpica/utpredef.c

-- 
1.7.10

