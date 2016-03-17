From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH] ACPI / property: Export a couple of symbols.
Date: Wed, 16 Mar 2016 17:23:19 -0700
Message-ID: <1458174199-23615-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robert Richter <rrichter@cavium.com>, Tomasz Nowicki <tn@semihalf.com>, David Daney <david.daney@cavium.com>
List-Id: linux-acpi@vger.kernel.org

From: David Daney <david.daney@cavium.com>

The acpi_dev_prop_read() and acpi_dev_prop_read_single() can be called
by drivers.  Add EXPORT_SYMBOL_GPL to them to allow use by modular
drivers.  This makes them consistent with acpi_dev_get_property() and
acpi_node_get_property_reference() which are already exported.

Signed-off-by: David Daney <david.daney@cavium.com>
---
FWIW: We hope to submit soon Cavium Thunder networking patches that
fail under modular builds without these exports.

 drivers/acpi/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 2aee416..de225dc 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -638,6 +638,7 @@ int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
 {
 	return adev ? acpi_data_prop_read_single(&adev->data, propname, proptype, val) : -EINVAL;
 }
+EXPORT_SYMBOL_GPL(acpi_dev_prop_read_single);
 
 static int acpi_copy_property_array_u8(const union acpi_object *items, u8 *val,
 				       size_t nval)
@@ -772,6 +773,7 @@ int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
 {
 	return adev ? acpi_data_prop_read(&adev->data, propname, proptype, val, nval) : -EINVAL;
 }
+EXPORT_SYMBOL_GPL(acpi_dev_prop_read);
 
 /**
  * acpi_node_prop_read - retrieve the value of an ACPI property with given name.
-- 
1.7.11.7
