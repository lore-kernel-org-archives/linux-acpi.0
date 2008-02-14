From: Holger Macht <hmacht@suse.de>
Subject: [PATCH] ACPI: Do not pass NULL to acpi_get_handle() when looking
	for _EJD
Date: Thu, 14 Feb 2008 13:40:34 +0100
Message-ID: <20080214124034.GA9708@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:45175 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759178AbYBNMjm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Feb 2008 07:39:42 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, trenn@suse.de

When trying to get the acpi_handle from an acpi_buffer, pass
ACPI_ROOT_OBJECT instead of NULL to acpi_get_handle(). This fixes the
detection of dock dependent bays.


Signed-off-by: Holger Macht <hmacht@suse.de>
---

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

