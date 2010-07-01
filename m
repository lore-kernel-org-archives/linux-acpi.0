From: Huang Ying <ying.huang@intel.com>
Subject: [BUGFIX 1/2] ACPI, APEI, Fix a typo of error path of apei_resources_request
Date: Thu,  1 Jul 2010 16:29:02 +0800
Message-ID: <1277972943-1475-2-git-send-email-ying.huang@intel.com>
References: <1277972943-1475-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277972943-1475-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

Fix a typo of error path of apei_resources_request. release_mem_region
and release_region should be interchange.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/apei-base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -481,14 +481,14 @@ err_unmap_ioport:
 	list_for_each_entry(res, &resources->ioport, list) {
 		if (res == res_bak)
 			break;
-		release_mem_region(res->start, res->end - res->start);
+		release_region(res->start, res->end - res->start);
 	}
 	res_bak = NULL;
 err_unmap_iomem:
 	list_for_each_entry(res, &resources->iomem, list) {
 		if (res == res_bak)
 			break;
-		release_region(res->start, res->end - res->start);
+		release_mem_region(res->start, res->end - res->start);
 	}
 	return -EINVAL;
 }
