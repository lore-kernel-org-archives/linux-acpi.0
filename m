From: akpm@linux-foundation.org
Subject: [patch (for 2.6.25?) 3/3] acpi: fix overflow
Date: Tue, 04 Mar 2008 15:00:14 -0800
Message-ID: <200803042300.m24N0EiR001549@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55321 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755132AbYCDXBB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 18:01:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, ming.m.lin@intel.com, rui.zhang@intel.com

From: Lin Ming <ming.m.lin@intel.com>

Fix a memory overflow bug when copying NULL internal package element object to
external.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/utilities/utobject.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/utilities/utobject.c~acpi-fix-overflow drivers/acpi/utilities/utobject.c
--- a/drivers/acpi/utilities/utobject.c~acpi-fix-overflow
+++ a/drivers/acpi/utilities/utobject.c
@@ -432,7 +432,7 @@ acpi_ut_get_simple_object_size(union acp
 	 * element -- which is legal)
 	 */
 	if (!internal_object) {
-		*obj_length = 0;
+		*obj_length = sizeof(union acpi_object);
 		return_ACPI_STATUS(AE_OK);
 	}
 
_
