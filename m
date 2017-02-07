From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] acpi,
 nfit: skip ARS on machine-check-recovery capable platforms
Date: Tue, 07 Feb 2017 15:43:50 -0800
Message-ID: <148651103020.2605.2544850985469410207.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:44561 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932149AbdBGXr4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Feb 2017 18:47:56 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org

If the platform supports machine-check-recovery then there is little
reason to kick off opportunistic scrubs to collect a media error list.
That initial scrub is only useful when it might prevent a kernel panic
from consuming poison (a media error from memory).

Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    6 ++++--
 drivers/acpi/nfit/mce.c  |    7 +++++++
 drivers/acpi/nfit/nfit.h |    5 +++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 7361d00818e2..bbefd9516939 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2500,10 +2500,12 @@ static void acpi_nfit_scrub(struct work_struct *work)
 	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
 		/*
 		 * Flag all the ranges that still need scrubbing, but
-		 * register them now to make data available.
+		 * register them now to make data available. If the
+		 * platform supports machine-check recovery then we skip
+		 * these opportunistic scans.
 		 */
 		if (!nfit_spa->nd_region) {
-			nfit_spa->ars_required = 1;
+			nfit_spa->ars_required = is_ars_required();
 			acpi_nfit_register_region(acpi_desc, nfit_spa);
 		}
 	}
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index e5ce81c38eed..1e6f1e7100f9 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -92,6 +92,13 @@ static struct notifier_block nfit_mce_dec = {
 	.notifier_call	= nfit_handle_mce,
 };
 
+bool is_ars_required(void)
+{
+        if (static_branch_unlikely(&mcsafe_key))
+                return false;
+	return true;
+}
+
 void nfit_mce_register(void)
 {
 	mce_register_decode_chain(&nfit_mce_dec);
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index fc29c2e9832e..925f2a3d896e 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -211,6 +211,7 @@ int acpi_nfit_ars_rescan(struct acpi_nfit_desc *acpi_desc);
 #ifdef CONFIG_X86_MCE
 void nfit_mce_register(void);
 void nfit_mce_unregister(void);
+bool is_ars_required(void);
 #else
 static inline void nfit_mce_register(void)
 {
@@ -218,6 +219,10 @@ static inline void nfit_mce_register(void)
 static inline void nfit_mce_unregister(void)
 {
 }
+static inline bool is_ars_required(void)
+{
+	return true;
+}
 #endif
 
 int nfit_spa_type(struct acpi_nfit_system_address *spa);

