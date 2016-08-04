From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/30] ACPICA: Debugger: Extend some max line lengths
Date: Thu,  4 Aug 2016 16:42:55 +0800
Message-ID: <95fcc39c3cd645bb9a1ca48f72fe55093f24e22e.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49063 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932814AbcHDInX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:43:23 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 622063bae684490191c8e8b10bf18e86d0ab4ebf

Fix a couple of arbitrarily small output line lengths.

Link: https://github.com/acpica/acpica/commit/622063ba
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbobject.c |    4 ++--
 drivers/acpi/acpica/nsdump.c   |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dbobject.c b/drivers/acpi/acpica/dbobject.c
index 1d59e8b..08eaaf3 100644
--- a/drivers/acpi/acpica/dbobject.c
+++ b/drivers/acpi/acpica/dbobject.c
@@ -142,11 +142,11 @@ void acpi_db_decode_internal_object(union acpi_operand_object *obj_desc)
 
 	case ACPI_TYPE_STRING:
 
-		acpi_os_printf("(%u) \"%.24s",
+		acpi_os_printf("(%u) \"%.60s",
 			       obj_desc->string.length,
 			       obj_desc->string.pointer);
 
-		if (obj_desc->string.length > 24) {
+		if (obj_desc->string.length > 60) {
 			acpi_os_printf("...");
 		} else {
 			acpi_os_printf("\"");
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index ce1f860..84f35dd 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -338,7 +338,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 		case ACPI_TYPE_STRING:
 
 			acpi_os_printf("Len %.2X ", obj_desc->string.length);
-			acpi_ut_print_string(obj_desc->string.pointer, 32);
+			acpi_ut_print_string(obj_desc->string.pointer, 80);
 			acpi_os_printf("\n");
 			break;
 
-- 
1.7.10

