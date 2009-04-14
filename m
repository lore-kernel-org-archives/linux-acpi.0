From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: [PATCH] pnp: add PNP resource range checking function
Date: Tue, 14 Apr 2009 12:46:18 -0700
Message-ID: <20090414124618.0dd9f536@hobbes>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-124.bluehost.com ([67.222.38.24]:46700 "HELO
	outbound-mail-124.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752993AbZDNTxA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Apr 2009 15:53:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

This patch adds a new export from the ACPI PNP core,
is_acpi_pnp_reserved, which is intended for use by drivers to check
whether a given range is already reserved (and therefore likely safe to
use) or not (indicating that new resource space should probably be
allocated).

If it looks reasonable, there's code in arch/x86/pci that could
probably be moved over to this as well.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 2834846..810feff 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -27,6 +27,94 @@
 #include "../base.h"
 #include "pnpacpi.h"
 
+/*
+ * Check the given resource against our test range
+ */
+static acpi_status check_pnp_resource(struct acpi_resource *res,
+				      void *data)
+{
+	struct resource *test_res = data;
+	struct acpi_resource_address64 address;
+	acpi_status status;
+
+	if (res->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
+		struct acpi_resource_fixed_memory32 *fixmem32 =
+			&res->data.fixed_memory32;
+		if (!fixmem32)
+			return AE_OK;
+
+		if ((test_res->start >= fixmem32->address) &&
+		    (test_res->end < (fixmem32->address +
+				      fixmem32->address_length))) {
+			test_res->flags = 1;
+			return AE_CTRL_TERMINATE;
+		}
+	}
+	if ((res->type != ACPI_RESOURCE_TYPE_ADDRESS32) &&
+	    (res->type != ACPI_RESOURCE_TYPE_ADDRESS64))
+		return AE_OK;
+
+	status = acpi_resource_to_address64(res, &address);
+	if (ACPI_FAILURE(status) ||
+	   (address.address_length <= 0) ||
+	   (address.resource_type != ACPI_MEMORY_RANGE))
+		return AE_OK;
+
+	if ((test_res->start >= address.minimum) &&
+	    (test_res->end < (address.minimum +
address.address_length))) {
+		test_res->flags = 1;
+		return AE_CTRL_TERMINATE;
+	}
+	return AE_OK;
+}
+
+/*
+ * Walk the current resource settings and check status
+ */
+static acpi_status find_pnp_resource(acpi_handle handle, u32 lvl,
+				     void *context, void **rv)
+{
+	struct resource *res = context;
+
+	acpi_walk_resources(handle, METHOD_NAME__CRS,
+			    check_pnp_resource, context);
+
+	if (res->flags)
+		return AE_CTRL_TERMINATE;
+
+	return AE_OK;
+}
+
+/**
+ * is_acpi_pnp_reserved - check whether a given range is reserved
+ * @start: start of range
+ * @end: end of range
+ *
+ * Check the given range (specified by @start and @end) against the
current
+ * PNP resource settings.
+ *
+ * RETURNS:
+ * Zero if the range is not currently reserved.
+ * Nonzero if the range is reserved.
+ */
+int is_acpi_pnp_reserved(u64 start, u64 end)
+{
+	struct resource res;
+
+	res.start = start;
+	res.end = end;
+	res.flags = 0;
+
+	acpi_get_devices("PNP0C01", find_pnp_resource, &res, NULL);
+
+	if (!res.flags)
+		acpi_get_devices("PNP0C02", find_pnp_resource, &res,
+				 NULL);
+
+	return res.flags;
+}
+EXPORT_SYMBOL(is_acpi_pnp_reserved);
+
 static int num = 0;
 
 /* We need only to blacklist devices that have already an acpi driver
that diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index ca3c887..2bc9cfc 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -446,6 +446,7 @@ int pnp_start_dev(struct pnp_dev *dev);
 int pnp_stop_dev(struct pnp_dev *dev);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
+int is_acpi_pnp_reserved(u64 start, u64 end);
 
 /* protocol helpers */
 int pnp_is_active(struct pnp_dev *dev);
@@ -476,6 +477,7 @@ static inline int pnp_start_dev(struct pnp_dev
*dev) { return -ENODEV; } static inline int pnp_stop_dev(struct pnp_dev
*dev) { return -ENODEV; } static inline int pnp_activate_dev(struct
pnp_dev *dev) { return -ENODEV; } static inline int
pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; } +static inline
int is_acpi_pnp_reserved(u64 start, u64 end) { return FALSE; } 
 /* protocol helpers */
 static inline int pnp_is_active(struct pnp_dev *dev) { return 0; }
