From: Lv Zheng <lv.zheng@intel.com>
Subject: [UPDATE PATCH v2 0/6] ACPI/EC: Critical race fixes.
Date: Mon,  7 Jul 2014 11:09:49 +0800
Message-ID: <cover.1404700569.git.lv.zheng@intel.com>
References: <cover.1402792240.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39694 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbaGGDJ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Jul 2014 23:09:59 -0400
In-Reply-To: <cover.1402792240.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

History:
v1:
 The collection of bug-fixes from kernel bugzilla bug 70891.
v2:
 1. Improves the patch descriptions to make the root cause of the 70891 bug
    more correct.
 2. Improves a race fix to make it more robust.
v2 UPDATE:
 Added "Reported-by" and "Tested-by" from kernel bugzilla bug 59911/63931
 as a result of EC bug triage. Only patch descriptions are updated.
 Removed the GPE fix, it is included by another GPE API fix series.

This patchset includes the following improvements of the ACPI/EC driver:
1. Fixes 2 race conditions in the current EC driver.
2. Cleans up the first command byte write as one of the race condition fix
   requires additional cleanup for the first command byte write. And this
   also helps us to do improvements in the BURST mode in the future.
3. Improves debugging message, register details can be enabled by defining
   DEBUG. And bug fixes and reports are based on this improvement.
The EC driver is upgraded to v2.2 to indicate the difference from the
previous buggy one, so that the future bug reports can be correctly
categorized.

All patches are tested to be valid fixes for the following bugs:
https://bugzilla.kernel.org/show_bug.cgi?id=59911
https://bugzilla.kernel.org/show_bug.cgi?id=63931
https://bugzilla.kernel.org/show_bug.cgi?id=70891

Lv Zheng (6):
  ACPI/EC: Fix an issue that advance_transaction() processes stale
    hardware status.
  ACPI/EC: Add asynchronous command byte write support.
  ACPI/EC: Remove duplicated ec_wait_ibf0() waiter.
  ACPI/EC: Fix a race condition in ec_transaction_completed().
  ACPI/EC: Update revision due to full asynchrnous command support.
  ACPI/EC: Add detailed fields debugging support of EC_SC(R).

 drivers/acpi/ec.c |  159 +++++++++++++++++++++++++++--------------------------
 1 file changed, 81 insertions(+), 78 deletions(-)

-- 
1.7.10

