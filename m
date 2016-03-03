From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2] nfit: Continue init even if ARS commands are unimplemented
Date: Thu,  3 Mar 2016 15:39:41 -0700
Message-ID: <1457044781-15443-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59784 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757139AbcCCWjv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Mar 2016 17:39:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

If firmware doesn't implement any of the ARS commands, take that to
mean that ARS is unsupported, and continue to initialize regions without
bad block lists. We cannot make the assumption that ARS commands will be
unconditionally supported on all NVDIMMs.

Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---

v2:
- improve the debug message when we his this unimplemented case (Dan).

 drivers/acpi/nfit.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index fb53db1..35947ac 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -1590,14 +1590,21 @@ static int acpi_nfit_find_poison(struct acpi_nfit_desc *acpi_desc,
 	start = ndr_desc->res->start;
 	len = ndr_desc->res->end - ndr_desc->res->start + 1;
 
+	/*
+	 * If ARS is unimplemented, unsupported, or if the 'Persistent Memory
+	 * Scrub' flag in extended status is not set, skip this but continue
+	 * initialization
+	 */
 	rc = ars_get_cap(nd_desc, ars_cap, start, len);
+	if (rc == -ENOTTY) {
+		dev_dbg(acpi_desc->dev,
+			"Address Range Scrub is not implemented, won't create an error list\n");
+		rc = 0;
+		goto out;
+	}
 	if (rc)
 		goto out;
 
-	/*
-	 * If ARS is unsupported, or if the 'Persistent Memory Scrub' flag in
-	 * extended status is not set, skip this but continue initialization
-	 */
 	if ((ars_cap->status & 0xffff) ||
 		!(ars_cap->status >> 16 & ND_ARS_PERSISTENT)) {
 		dev_warn(acpi_desc->dev,
-- 
2.5.0

