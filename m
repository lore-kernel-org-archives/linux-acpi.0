From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [Ubuntu PATCH] nssearch: bad characters shouldn't be fatal
Date: Tue, 20 Jun 2006 22:32:34 -0700
Message-ID: <4498D9F2.9090906@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:48486 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751062AbWFUFbJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 01:31:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm <akpm@osdl.org>

[UBUNTU:acpi] Bad characters shouldn't be fatal.

PatchAuthor: Len Brown <len.brown@intel.com>


---
 drivers/acpi/namespace/nssearch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-pv.orig/drivers/acpi/namespace/nssearch.c
+++ linux-2617-pv/drivers/acpi/namespace/nssearch.c
@@ -309,7 +309,7 @@ acpi_ns_search_and_enter(u32 target_name
 	if (!acpi_ut_valid_acpi_name(target_name)) {
 		ACPI_ERROR((AE_INFO, "Bad character in ACPI Name: %X",
 			    target_name));
-		return_ACPI_STATUS(AE_BAD_CHARACTER);
+		//return_ACPI_STATUS(AE_BAD_CHARACTER);
 	}
 
 	/* Try to find the name in the namespace level specified by the caller */



