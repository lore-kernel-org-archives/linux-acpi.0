From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/26] ACPICA: Fix some typos in comments
Date: Wed, 31 Oct 2012 10:26:23 +0800
Message-ID: <f5587d209a33987df0585799d4045c890e602518.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24652 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875Ab2JaC0e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:26:34 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

No functional changes.  Some small fixes within commments. Colin
Ian King.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbxfload.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index f87cc63..a5e1e4e 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -211,7 +211,7 @@ static acpi_status acpi_tb_load_namespace(void)
  * DESCRIPTION: Dynamically load an ACPI table from the caller's buffer. Must
  *              be a valid ACPI table with a valid ACPI table header.
  *              Note1: Mainly intended to support hotplug addition of SSDTs.
- *              Note2: Does not copy the incoming table. User is reponsible
+ *              Note2: Does not copy the incoming table. User is responsible
  *              to ensure that the table is not deleted or unmapped.
  *
  ******************************************************************************/
-- 
1.7.10

