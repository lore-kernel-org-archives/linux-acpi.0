From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] ACPICA: Put back the call to acpi_os_validate_address
Date: Tue, 29 Nov 2011 22:13:35 +0800
Message-ID: <1322576015.6856.10.camel@hp6530s>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28917 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760Ab1K2OO7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Nov 2011 09:14:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, kronos.it@gmail.com, "Moore, Robert" <robert.moore@intel.com>

The call to acpi_os_validate_address in acpi_ds_get_region_arguments was
removed by mistake in commit 9ad19ac(ACPICA: Split large dsopcode and
dsload.c files).

Put it back.

Reported-and-bisected-by: Luca Tettamanti <kronos.it@gmail.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---

Len,

Could you apply this patch?
And it should be ported to stable kernel since v2.6.39.

 drivers/acpi/acpica/dsargs.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index 634f5b2..d69e4a5 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -387,5 +387,29 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 	status = acpi_ds_execute_arguments(node, extra_desc->extra.scope_node,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Validate the region address/length via the host OS */
+
+	status = acpi_os_validate_address(obj_desc->region.space_id,
+					  obj_desc->region.address,
+					  (acpi_size) obj_desc->region.length,
+					  acpi_ut_get_node_name(node));
+
+	if (ACPI_FAILURE(status)) {
+		/*
+		 * Invalid address/length. We will emit an error message and mark
+		 * the region as invalid, so that it will cause an additional error if
+		 * it is ever used. Then return AE_OK.
+		 */
+		ACPI_EXCEPTION((AE_INFO, status,
+				"During address validation of OpRegion [%4.4s]",
+				node->name.ascii));
+		obj_desc->common.flags |= AOPOBJ_INVALID;
+		status = AE_OK;
+	}
+
 	return_ACPI_STATUS(status);
 }
-- 
1.7.2.5



