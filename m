From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/23] ACPICA: Fix to allow zero-length ASL field declarations
Date: Wed, 11 Jun 2008 03:59:20 -0400
Message-ID: <7e7c9052a617ea6086144a4fbda262d32a100479.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:43667 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbYFKH75 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:57 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2A008D9GVAAVP2@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:35 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Allows null field list in Field(), BankField(), and IndexField().

2.6.26-rc1 regression: ACPI fails to load SDT. - Dell M1530
http://bugzilla.kernel.org/show_bug.cgi?id=10606

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsfield.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsfield.c b/drivers/acpi/dispatcher/dsfield.c
index c780783..f988a5e 100644
--- a/drivers/acpi/dispatcher/dsfield.c
+++ b/drivers/acpi/dispatcher/dsfield.c
@@ -450,10 +450,6 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	if (!arg) {
-		return_ACPI_STATUS(AE_AML_NO_OPERAND);
-	}
-
 	/* Creating new namespace node(s), should not already exist */
 
 	flags = ACPI_NS_NO_UPSEARCH | ACPI_NS_DONT_OPEN_SCOPE |
@@ -467,6 +463,7 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 
 	/*
 	 * Walk the list of entries in the field_list
+	 * Note: field_list can be of zero length. In this case, Arg will be NULL.
 	 */
 	while (arg) {
 		/*
-- 
1.5.6.rc2.23.gea81e

