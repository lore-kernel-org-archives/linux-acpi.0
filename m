From: Martin Michlmayr <tbm@cyrius.com>
Subject: Fix section conflict of acpi_rs_match_vendor_resource
Date: Tue, 15 May 2007 19:15:44 +0200
Message-ID: <20070515171544.GA20439@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:1230 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759732AbXEORvB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 May 2007 13:51:01 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Building with GCC 4.2, I get the following error:

  CC      drivers/acpi/resources/rsxface.o
drivers/acpi/resources/rsxface.c:479: error: __ksymtab_acpi_rs_match_vendor_resource causes a section type conflict

This is because acpi_rs_match_vendor_resource is both declared static
and exported.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

--- a/drivers/acpi/resources/rsxface.c
+++ b/drivers/acpi/resources/rsxface.c
@@ -64,7 +64,7 @@ ACPI_MODULE_NAME("rsxface")
 	ACPI_COPY_FIELD(out, in, address_length);            \
 	ACPI_COPY_FIELD(out, in, resource_source);
 /* Local prototypes */
-static acpi_status
+acpi_status
 acpi_rs_match_vendor_resource(struct acpi_resource *resource, void *context);
 
 static acpi_status
@@ -428,7 +428,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_vendor_resource)
  * DESCRIPTION: Match a vendor resource via the ACPI 3.0 UUID
  *
  ******************************************************************************/
-static acpi_status
+acpi_status
 acpi_rs_match_vendor_resource(struct acpi_resource *resource, void *context)
 {
 	struct acpi_vendor_walk_info *info = context;

-- 
Martin Michlmayr
http://www.cyrius.com/
