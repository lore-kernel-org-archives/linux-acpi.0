From: Joshua Hunt <johunt@akamai.com>
Subject: [PATCH v2 1/2] ACPI, APEI: Fix leaked resources
Date: Tue,  8 Mar 2016 10:52:11 -0500
Message-ID: <1457452332-2673-2-git-send-email-johunt@akamai.com>
References: <1457452332-2673-1-git-send-email-johunt@akamai.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from prod-mail-xrelay05.akamai.com ([23.79.238.179]:35244 "EHLO
	prod-mail-xrelay05.akamai.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751516AbcCHPwP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 10:52:15 -0500
In-Reply-To: <1457452332-2673-1-git-send-email-johunt@akamai.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gong.chen@intel.com, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, Joshua Hunt <johunt@akamai.com>

We leak the NVS and arch resources (if used), in apei_resources_request.
They are allocated to make sure we exclude them from the APEI resources,
but they are never freed at the end of the function. Free them now.

Signed-off-by: Josh Hunt <johunt@akamai.com>
---
 drivers/acpi/apei/apei-base.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index a2c8d7a..da370e1 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -536,7 +536,8 @@ int apei_resources_request(struct apei_resources *resources,
 		goto err_unmap_ioport;
 	}
 
-	return 0;
+	goto arch_res_fini;
+
 err_unmap_ioport:
 	list_for_each_entry(res, &resources->ioport, list) {
 		if (res == res_bak)
@@ -551,7 +552,8 @@ err_unmap_iomem:
 		release_mem_region(res->start, res->end - res->start);
 	}
 arch_res_fini:
-	apei_resources_fini(&arch_res);
+	if (arch_apei_filter_addr)
+		apei_resources_fini(&arch_res);
 nvs_res_fini:
 	apei_resources_fini(&nvs_resources);
 	return rc;
-- 
1.7.9.5

