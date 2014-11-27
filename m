From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/6] ACPICA: 20141107 Release
Date: Thu, 27 Nov 2014 14:25:53 +0800
Message-ID: <cover.1416899966.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41012 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbaK0G0B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Nov 2014 01:26:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The 20141107 ACPICA kernel-resident subsystem updates are linuxized based
on the pm/linux-next branch to form this patchset.

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
   All drivers/acpi configurations
   All platform drivers

The divergences checking result:
Before applying (20140926 Release):
  852 lines
After applying (20141107 Release):
  852 lines

Bob Moore (6):
  ACPICA: iASL: Add support for to_PLD macro.
  ACPICA: acpiexec: Add option to specify an object initialization
    file.
  ACPICA: Disassembler: Add support for C-style operators and
    expressions.
  ACPICA: Disassembler: Update for C-style expressions.
  ACPICA: Disassembler: Emit correct string for 0 stop bits.
  ACPICA: Update version to 20141107.

 drivers/acpi/acpica/acglobal.h |    1 +
 drivers/acpi/acpica/aclocal.h  |    3 +++
 drivers/acpi/acpica/utresrc.c  |    2 +-
 drivers/acpi/acpica/utxface.c  |    4 +++-
 drivers/acpi/acpica/utxfinit.c |   11 +++++++++++
 include/acpi/acbuffer.h        |   14 +++++++++++---
 include/acpi/acpixf.h          |    2 +-
 7 files changed, 31 insertions(+), 6 deletions(-)

-- 
1.7.10

