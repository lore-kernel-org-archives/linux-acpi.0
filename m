From: Alex Chiang <achiang@hp.com>
Subject: [PATCH] ACPI: update acpi_get_pci_dev() comments
Date: Fri, 26 Jun 2009 15:16:26 -0600
Message-ID: <20090626211626.GB980@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:19376 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbZFZVQY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 17:16:24 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Troy Moure <twmoure@szypr.net>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Recent commit 412af978 (ACPI: video: prevent NULL deref in
acpi_get_pci_dev()) was added to prevent a boot oops.

Update the implementation with some notes and analysis as to why
the fix is correct.

Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Troy Moure <twmoure@szypr.net>
Signed-off-by: Alex Chiang <achiang@hp.com>
---
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 55b5b90..570f32e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -344,6 +344,16 @@ struct acpi_handle_node {
  * function returns a pointer to its data structure.  The caller must
  * decrement the reference count by calling pci_dev_put().
  * If no device is found, %NULL is returned.
+ *
+ * XXX: You may be surprised at the results if you call this interface
+ * with a handle to a PCI root bridge and expect to get a pci_dev back.
+ * The PCI specification does not require a PCI root bridge to present
+ * configuration space, and thus may not have a valid associated pci_dev.
+ *
+ * [nb, all P2P bridges _are_ required to present configuration space]
+ *
+ * A PCI root bridge that presents config space is referred to as
+ * "materialized"; its converse is "non-materialized".
  */
 struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
 {
@@ -385,6 +395,11 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
 	 * Now, walk back down the PCI device tree until we return to our
 	 * original handle. Assumes that everything between the PCI root
 	 * bridge and the device we're looking for must be a P2P bridge.
+	 *
+	 * Note! It's possible for ACPI to describe a non-existent PCI device
+	 * due to either hotplug or a namespace shared across different
+	 * platforms with just enable or present bits to mask them out from
+	 * the initial PCI scan. So take care to check for a NULL pdev.
 	 */
 	list_for_each_entry(node, &device_list, node) {
 		acpi_handle hnd = node->handle;
