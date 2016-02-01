From: Joshua Hunt <johunt@akamai.com>
Subject: [PATCH 1/2] ACPI, APEI: Fix leaked resources
Date: Mon,  1 Feb 2016 13:47:47 -0500
Message-ID: <1454352468-14371-2-git-send-email-johunt@akamai.com>
References: <1454352468-14371-1-git-send-email-johunt@akamai.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from prod-mail-xrelay07.akamai.com ([23.79.238.175]:9866 "EHLO
	prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752909AbcBASzC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2016 13:55:02 -0500
In-Reply-To: <1454352468-14371-1-git-send-email-johunt@akamai.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Joshua Hunt <johunt@akamai.com>

We leak the NVS and arch resources (if used), in apei_resources_request.
They are allocated to make sure we exclude them from the APEI resources,
but they are never freed at the end of the function. Free them now.

Signed-off-by: Josh Hunt <johunt@akamai.com>

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index a2c8d7a..1ac449b 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -536,6 +536,11 @@ int apei_resources_request(struct apei_resources *resources,
 		goto err_unmap_ioport;
 	}
 
+	/* Cleanup unmerged resources */
+	if (arch_apei_filter_addr)
+		apei_resources_fini(&arch_res);
+	apei_resources_fini(&nvs_resources);
+
 	return 0;
 err_unmap_ioport:
 	list_for_each_entry(res, &resources->ioport, list) {
-- 
1.7.9.5

