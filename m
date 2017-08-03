From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/15] ACPICA: Add a comment, no functional change
Date: Thu,  3 Aug 2017 14:26:38 +0800
Message-ID: <80e42989e573df6257093402632b06b6341856bf.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47301 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751924AbdHCG0m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:26:42 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit d586c29a026a6172c1113df4d75fd6d764196e77

Describe 2nd byte of the end_tag resource descriptor.

Link: https://github.com/acpica/acpica/commit/d586c29a
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utresrc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index d955bf8..517acf8 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -239,6 +239,13 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 				return_ACPI_STATUS(AE_AML_NO_RESOURCE_END_TAG);
 			}
 
+			/*
+			 * Don't attempt to perform any validation on the 2nd byte.
+			 * Although all known ASL compilers insert a zero for the 2nd
+			 * byte, it can also be a checksum (as per the ACPI spec),
+			 * and this is occasionally seen in the field. July 2017.
+			 */
+
 			/* Return the pointer to the end_tag if requested */
 
 			if (!user_function) {
-- 
2.7.4

