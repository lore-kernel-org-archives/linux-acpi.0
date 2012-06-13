From: "Xiao, Hui" <hui.xiao@linux.intel.com>
Subject: [RFC] ACPI, APEI: Fix incorrect bit width + offset check condition
Date: Wed, 13 Jun 2012 15:39:44 +0800
Message-ID: <1339573184-3122-1-git-send-email-hui.xiao@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63165 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab2FMIEF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2012 04:04:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: garyhade@us.ibm.com, tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, pluto@agmk.net, khali@linux-fr.org, linux-acpi@vger.kernel.org
Cc: "Xiao, Hui" <hui.xiao@linux.intel.com>, Chen Gong <gong.chen@linux.intel.com>

Fix the incorrect bit width + offset check condition in apei_check_gar()
function introduced by commit v3.3-5-g15afae6.

The bug caused regression on EINJ error injection with errors:

[Firmware Bug]: APEI: Invalid bit width + offset in GAR [0x1121a5000/64/0/3/0]

on a valid address region of:
    - Register bit width: 64 bits
    - Register bit offset: 0
    - Access Size: 03 [DWord Access: 32]

Signed-off-by: Xiao, Hui <hui.xiao@linux.intel.com>
Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/apei-base.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 5577762..95e07b2 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -586,9 +586,12 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 	}
 	*access_bit_width = 1UL << (access_size_code + 2);
 
-	if ((bit_width + bit_offset) > *access_bit_width) {
+	/* bit_width and bit_offset must be zero when addressing a data
+	 * structure. So just check for non-zero case here */
+	if ((bit_width != 0 && *access_bit_width > bit_width) ||
+			bit_offset > *access_bit_width) {
 		pr_warning(FW_BUG APEI_PFX
-			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
+			   "Invalid bit width or offset in GAR [0x%llx/%u/%u/%u/%u]\n",
 			   *paddr, bit_width, bit_offset, access_size_code,
 			   space_id);
 		return -EINVAL;
-- 
1.7.3.4

