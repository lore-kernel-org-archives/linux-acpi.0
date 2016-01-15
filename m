From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 3/3] libnvdimm: use enums for ARS statuses
Date: Thu, 14 Jan 2016 18:31:56 -0700
Message-ID: <1452821516-26788-4-git-send-email-vishal.l.verma@intel.com>
References: <1452821516-26788-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:8358 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbcAOBcJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 20:32:09 -0500
In-Reply-To: <1452821516-26788-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Linda Knippers <linda.knippers@hpe.com>

Replace the status checking in ARS_START, ARS_STATUS with enums for
readability.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/nvdimm/core.c    | 17 +++++++----------
 drivers/nvdimm/nd-core.h | 13 +++++++++++++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 69994036..489414f 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -542,15 +542,14 @@ static int ars_do_start(struct nvdimm_bus_descriptor *nd_desc,
 		if (rc)
 			return rc;
 		switch (cmd->status) {
-		case 0:
+		case ND_ARS_START_SUCCESS:
 			return 0;
-		case 1:
+		case ND_ARS_START_UNSUPP:
 			/* ARS unsupported, but we should never get here */
 			return 0;
-		case 2:
+		case ND_ARS_START_INVALID_PARAM:
 			return -EINVAL;
-		case 3:
-			/* ARS is in progress */
+		case ND_ARS_START_IN_PROGRESS:
 			msleep(1000);
 			break;
 		default:
@@ -572,14 +571,12 @@ static int ars_get_status(struct nvdimm_bus_descriptor *nd_desc,
 
 		/* Check extended status (Upper two bytes) */
 		switch (cmd->status >> 16) {
-		case 0:
+		case ND_ARS_STATUS_EXT_SUCCESS:
 			return 0;
-		case 1:
-			/* ARS is in progress */
+		case ND_ARS_STATUS_EXT_IN_PROGRESS:
 			msleep(1000);
 			break;
-		case 2:
-			/* No ARS performed for the current boot */
+		case ND_ARS_STATUS_EXT_NOT_DONE:
 			return 0;
 		default:
 			return -ENXIO;
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 1d1500f..c4a2744 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -43,6 +43,19 @@ struct nvdimm {
 	int id;
 };
 
+enum {
+	ND_ARS_START_SUCCESS = 0,
+	ND_ARS_START_UNSUPP = 1,
+	ND_ARS_START_INVALID_PARAM = 2,
+	ND_ARS_START_IN_PROGRESS = 3,
+};
+
+enum {
+	ND_ARS_STATUS_EXT_SUCCESS = 0,
+	ND_ARS_STATUS_EXT_IN_PROGRESS = 1,
+	ND_ARS_STATUS_EXT_NOT_DONE = 2,
+};
+
 bool is_nvdimm(struct device *dev);
 bool is_nd_pmem(struct device *dev);
 bool is_nd_blk(struct device *dev);
-- 
2.5.0

