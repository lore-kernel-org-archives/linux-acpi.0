From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/10] ACPICA: Correctly support references in the union acpi_object.
Date: Sat,  8 Feb 2014 09:42:32 +0800
Message-ID: <76a70ef5fb43d83bd98354df0f7733dfe3c505de.1390438467.git.lv.zheng@intel.com>
References: <cover.1390438466.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18588 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaBHBmi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Feb 2014 20:42:38 -0500
In-Reply-To: <cover.1390438466.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change fixes the support to allow references (namespace nodes)
to be passed as arguments to control methods via the evaluate object
interface. This is probably most useful for testing purposes, however.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utcopy.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 95e55f5..270c164 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -535,10 +535,10 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
-		/* TBD: should validate incoming handle */
+		/* An incoming reference is defined to be a namespace node */
 
-		internal_object->reference.class = ACPI_REFCLASS_NAME;
-		internal_object->reference.node =
+		internal_object->reference.class = ACPI_REFCLASS_REFOF;
+		internal_object->reference.object =
 		    external_object->reference.handle;
 		break;
 
-- 
1.7.10

