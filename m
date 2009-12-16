From: Len Brown <lenb@kernel.org>
Subject: [PATCH 077/103] PNP: add interface to retrieve ACPI device from a
 PNPACPI device
Date: Wed, 16 Dec 2009 03:36:28 -0500
Message-ID: <9065ce4500085b9ca66b19d3c4d21a73cb410173.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760814AbZLPKGF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:05 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:55 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Add pnp_acpi_device(pnp_dev), which takes a PNP device and returns the
associated ACPI device (or NULL, if the device is not a PNPACPI device).

This allows us to write a PNP driver that can manage both traditional
PNPBIOS and ACPI devices, treating ACPI-only functionality as an optional
extension.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/core.c |    3 ++-
 include/linux/pnp.h        |   13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index b2348fc..5314bf6 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -144,7 +144,7 @@ static int pnpacpi_resume(struct pnp_dev *dev)
 }
 #endif
 
-static struct pnp_protocol pnpacpi_protocol = {
+struct pnp_protocol pnpacpi_protocol = {
 	.name	 = "Plug and Play ACPI",
 	.get	 = pnpacpi_get_resources,
 	.set	 = pnpacpi_set_resources,
@@ -154,6 +154,7 @@ static struct pnp_protocol pnpacpi_protocol = {
 	.resume = pnpacpi_resume,
 #endif
 };
+EXPORT_SYMBOL(pnpacpi_protocol);
 
 static int __init pnpacpi_add_device(struct acpi_device *device)
 {
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index fddfafa..7c4193e 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -334,6 +334,19 @@ extern struct pnp_protocol pnpbios_protocol;
 #define pnp_device_is_pnpbios(dev) 0
 #endif
 
+#ifdef CONFIG_PNPACPI
+extern struct pnp_protocol pnpacpi_protocol;
+
+static inline struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
+{
+	if (dev->protocol == &pnpacpi_protocol)
+		return dev->data;
+	return NULL;
+}
+#else
+#define pnp_acpi_device(dev) 0
+#endif
+
 /* status */
 #define PNP_READY		0x0000
 #define PNP_ATTACHED		0x0001
-- 
1.6.0.6

