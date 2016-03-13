From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/1] ACPI / property: fix data node parsing in acpi_get_next_subnode
Date: Sun, 13 Mar 2016 02:33:30 +0200
Message-ID: <1457829210-16892-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63247 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbcCMAdz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Mar 2016 19:33:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, Irina Tirdea <irina.tirdea@intel.com>

When an ACPI node has both ACPI device nodes and ACPI data nodes,
acpi_get_next_subnode will return the ACPI data nodes of its last
parsed child.

Make sure that the acpi device that is parsed is the original acpi
node and not any of its children.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/acpi/property.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 2aee416..f2fd3fe 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -816,6 +816,7 @@ struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 			next = adev->node.next;
 			if (next == head) {
 				child = NULL;
+				adev = ACPI_COMPANION(dev);
 				goto nondev;
 			}
 			adev = list_entry(next, struct acpi_device, node);
-- 
1.9.1

