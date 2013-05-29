From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/07] ACPICA 20130418 Release
Date: Wed, 29 May 2013 10:08:46 +0800
Message-ID: <cover.1367913046.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35777 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934963Ab3E2CJC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 May 2013 22:09:02 -0400
In-Reply-To: <cover.1367813690.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The 20130418 ACPICA kernel resident system updates is linuxized based on
the pm/linux-next branch.
The patch set has passed basic build/boot tests on i386/x86-64 machines.

Bob Moore (5):
  ACPICA: Change an exception code for the ASL UnLoad() operator
  ACPICA: Add BIOS error interface for predefined name validation
    support
  ACPICA: Add argument typechecking for all predefined ACPI names
  ACPICA: Predefined name support: Remove unused local variable
  ACPICA: Update version to 20130418

Lv Zheng (1):
  ACPICA: Remove unused macros, no functional change

Zhang Rui (1):
  ACPICA: Update for "orphan" embedded controller _REG method support

 drivers/acpi/acpica/Makefile      |    1 +
 drivers/acpi/acpica/aclocal.h     |   17 ---
 drivers/acpi/acpica/acmacros.h    |   10 +-
 drivers/acpi/acpica/acnamesp.h    |   43 ++++--
 drivers/acpi/acpica/acpredef.h    |    4 +-
 drivers/acpi/acpica/acstruct.h    |   40 +++--
 drivers/acpi/acpica/acutils.h     |    6 +
 drivers/acpi/acpica/evgpe.c       |    1 -
 drivers/acpi/acpica/evregion.c    |   63 +++-----
 drivers/acpi/acpica/exconfig.c    |    2 +-
 drivers/acpi/acpica/hwxface.c     |    6 +-
 drivers/acpi/acpica/nsarguments.c |  294 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nseval.c      |  247 ++++++++++++++++++-------------
 drivers/acpi/acpica/nsinit.c      |    7 +-
 drivers/acpi/acpica/nspredef.c    |  202 ++++++-------------------
 drivers/acpi/acpica/nsprepkg.c    |   76 +++++-----
 drivers/acpi/acpica/nsrepair.c    |   50 +++----
 drivers/acpi/acpica/nsrepair2.c   |   87 +++++------
 drivers/acpi/acpica/nsxfeval.c    |  162 ++++++++++++++++----
 drivers/acpi/acpica/psxface.c     |   14 +-
 drivers/acpi/acpica/rsutils.c     |    2 +-
 drivers/acpi/acpica/uteval.c      |    2 +-
 drivers/acpi/acpica/utpredef.c    |   16 +-
 drivers/acpi/acpica/utxferror.c   |   51 ++++++-
 include/acpi/acconfig.h           |    4 +-
 include/acpi/acoutput.h           |    8 +-
 include/acpi/acpixf.h             |    2 +-
 27 files changed, 882 insertions(+), 535 deletions(-)
 create mode 100644 drivers/acpi/acpica/nsarguments.c

-- 
1.7.10

