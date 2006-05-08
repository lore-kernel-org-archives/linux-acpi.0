From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch] fix pciehp compile issue when CONFIG_ACPI is not enabled.
Date: Mon, 08 May 2006 11:54:30 -0700
Message-ID: <1147114470.3094.14.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50951 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750706AbWEHSov (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 May 2006 14:44:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, greg@kroah.com

Fix compile error when CONFIG_ACPI is not defined.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 include/acpi/actypes.h |    1 +
 1 files changed, 1 insertion(+)

--- 2.6-git.orig/include/acpi/actypes.h
+++ 2.6-git/include/acpi/actypes.h
@@ -348,6 +348,7 @@ struct acpi_pointer {
  * Mescellaneous types
  */
 typedef u32 acpi_status;	/* All ACPI Exceptions */
+#define acpi_status acpi_status
 typedef u32 acpi_name;		/* 4-byte ACPI name */
 typedef char *acpi_string;	/* Null terminated ASCII string */
 typedef void *acpi_handle;	/* Actually a ptr to a NS Node */
