From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [RESEND PATCH 2/2] device property: fix for a case of use-after-free
Date: Tue,  8 Mar 2016 15:44:37 +0200
Message-ID: <1457444677-25645-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1457444677-25645-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50106 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932394AbcCHNoo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Mar 2016 08:44:44 -0500
In-Reply-To: <1457444677-25645-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Youn <John.Youn@synopsys.com>, linux-acpi@vger.kernel.org

In device_remove_property_set(), the secondary fwnode needs
to be cleared before the pset is freed. This fixes a
use-after-free when a property set is providing the primary
fwnode.

Reported-by: John Youn <John.Youn@synopsys.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/property.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index a163f2c..a9df21a9 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -820,11 +820,13 @@ void device_remove_property_set(struct device *dev)
 	 * the pset. If there is no real firmware node (ACPI/DT) primary
 	 * will hold the pset.
 	 */
-	if (!is_pset_node(fwnode))
+	if (is_pset_node(fwnode))
+		dev->fwnode = NULL;
+	else
 		fwnode = fwnode->secondary;
 	if (!IS_ERR(fwnode) && is_pset_node(fwnode))
-		pset_free_set(to_pset_node(fwnode));
-	set_secondary_fwnode(dev, NULL);
+		set_secondary_fwnode(dev, NULL);
+	pset_free_set(to_pset_node(fwnode));
 }
 EXPORT_SYMBOL_GPL(device_remove_property_set);
 
-- 
2.7.0

