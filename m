From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v1 2/5] PNP: add interface to retrieve ACPI device from a
	PNPACPI device
Date: Tue, 17 Nov 2009 17:05:19 -0700
Message-ID: <20091118000519.14214.61241.stgit@bob.kio>
References: <20091118000427.14214.14043.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:1662 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbZKRAFN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2009 19:05:13 -0500
In-Reply-To: <20091118000427.14214.14043.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Corey Minyard <minyard@acm.org>, Bela Lubkin <blubkin@vmware.com>, linux-acpi@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>, openipmi-developer@lists.sourceforge.net, Len Brown <lenb@kernel.org>

Add pnp_acpi_device(pnp_dev), which takes a PNP device and returns the
associated ACPI device (or NULL, if the device is not a PNPACPI device).

This allows us to write a PNP driver that can manage both traditional
PNPBIOS and ACPI devices, treating ACPI-only functionality as an optional
extension.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/pnp/pnpacpi/core.c |    2 +-
 include/linux/pnp.h        |   13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index b2348fc..8dd0f37 100644
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

