From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/12] ACPI: Do not pass NULL to acpi_get_handle() when looking for _EJD
Date: Tue, 11 Mar 2008 02:51:42 -0400
Message-ID: <3b5fee5952ff7eb6ff7a64247a01040b8b331b74.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:2378 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751392AbYCKGyz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:55 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Holger Macht <hmacht@suse.de>, Len Brown <len.brown@intel.com>

From: Holger Macht <hmacht@suse.de>

When trying to get the acpi_handle from an acpi_buffer, pass
ACPI_ROOT_OBJECT instead of NULL to acpi_get_handle(). This fixes the
detection of dock dependent bays.

Signed-off-by: Holger Macht <hmacht@suse.de>
Tested-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3fac011..d9b9143 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -609,7 +609,8 @@ acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd)
 	status = acpi_evaluate_object(handle, "_EJD", NULL, &buffer);
 	if (ACPI_SUCCESS(status)) {
 		obj = buffer.pointer;
-		status = acpi_get_handle(NULL, obj->string.pointer, ejd);
+		status = acpi_get_handle(ACPI_ROOT_OBJECT, obj->string.pointer,
+					 ejd);
 		kfree(buffer.pointer);
 	}
 	return status;
-- 
1.5.4.3.422.g34cd6

