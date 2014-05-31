From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH v2 0/2] ACPI: Fix a regression of the table checksum verification.
Date: Sat, 31 May 2014 08:14:26 +0800
Message-ID: <cover.1401494652.git.lv.zheng@intel.com>
References: <e28682572e0736657b0120aeec5f64ac21159faf.1401415540.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:64050 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932699AbaEaAOm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 May 2014 20:14:42 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so2228238pbc.26
        for <linux-acpi@vger.kernel.org>; Fri, 30 May 2014 17:14:42 -0700 (PDT)
In-Reply-To: <e28682572e0736657b0120aeec5f64ac21159faf.1401415540.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Lv Zheng <lv.zheng@intel.com>

There is a warning message triggered by the early table chekcusm
verification during boot. Large tables cannot be installed on x86 platforms
due to this failure. The root cause is the size limitation of the current
x86 early mapping implementation, it's thus not suitable to be used to map
ACPI tables.

This patchset fixes this regression by stopping verifying table checksums
during the early boot stage.

Lv Zheng (2):
  ACPICA: Tables: Add mechanism to control early table checksum
    verification.
  ACPI: Fix regressions that x86 Linux kernel suffers from early
    mapping size limitation.

 Documentation/kernel-parameters.txt |    5 +++
 drivers/acpi/acpica/actables.h      |    8 +++--
 drivers/acpi/acpica/tbdata.c        |   67 +++++++++++++++++++++++++++--------
 drivers/acpi/acpica/tbinstal.c      |    8 ++---
 drivers/acpi/acpica/tbutils.c       |    4 ---
 drivers/acpi/bus.c                  |    3 ++
 drivers/acpi/tables.c               |   23 ++++++++++++
 include/acpi/acpixf.h               |    9 +++++
 8 files changed, 101 insertions(+), 26 deletions(-)

-- 
1.7.10

