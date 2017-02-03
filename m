From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH] acpica: Fix double-free in acpi_ns_repair_CID()
Date: Fri,  3 Feb 2017 15:56:54 -0500
Message-ID: <20170203205654.28269-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34073 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbdBCU5V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2017 15:57:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>, linux@endlessm.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>

When acpi_ns_repair_CID() is called for a _CID which returns a package
of strings, it calls acpi_ns_repair_HID() for each of the package
elements.  acpi_ns_repair_HID() calls acpi_ut_remove_reference() on the
original object, but acpi_ns_repair_CID() calls it again on return,
leading to a double free.

This problem was seen on a Acer TravelMate P449-G2-MG.

Thanks to Daniel Drake for helping investigating this problem.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/acpi/acpica/nsrepair2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index d5336122486b..c429c8eca476 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -411,8 +411,6 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
 
 			(*element_ptr)->common.reference_count =
 			    original_ref_count;
-
-			acpi_ut_remove_reference(original_element);
 		}
 
 		element_ptr++;
-- 
2.11.0

