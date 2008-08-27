From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] acpi_ns_get_external_pathname(): fix a memory leak
Date: Thu, 28 Aug 2008 01:03:11 +0300
Message-ID: <20080827220311.GN11734@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:51825 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbYH0WEF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 18:04:05 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Andi Kleen <ak@linux.intel.com>, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

This patch fixes a memory leak in an error path.

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
446be2de05a8c1fbf2208311673a19aaf26b188e 
diff --git a/drivers/acpi/namespace/nsnames.c b/drivers/acpi/namespace/nsnames.c
index bd57738..f03410c 100644
--- a/drivers/acpi/namespace/nsnames.c
+++ b/drivers/acpi/namespace/nsnames.c
@@ -150,20 +150,21 @@ char *acpi_ns_get_external_pathname(struct acpi_namespace_node *node)
 	name_buffer = ACPI_ALLOCATE_ZEROED(size);
 	if (!name_buffer) {
 		ACPI_ERROR((AE_INFO, "Allocation failure"));
 		return_PTR(NULL);
 	}
 
 	/* Build the path in the allocated buffer */
 
 	status = acpi_ns_build_external_path(node, size, name_buffer);
 	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(name_buffer);
 		return (NULL);
 	}
 
 	return_PTR(name_buffer);
 }
 #endif
 
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_get_pathname_length
