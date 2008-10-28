From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] acpi: use macro to replace hard number
Date: Tue, 28 Oct 2008 00:39:12 -0700
Message-ID: <4906C1A0.1090701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46097 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbYJ1HkN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Oct 2008 03:40:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>


Impact: cleanup

use MACRO for rev 3 fadt id instead of 3 directly

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/acpi/tables/tbfadt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/tables/tbfadt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables/tbfadt.c
+++ linux-2.6/drivers/acpi/tables/tbfadt.c
@@ -304,7 +304,7 @@ static void acpi_tb_convert_fadt(void)
 	 * The ACPI 1.0 reserved fields that will be zeroed are the bytes located at
 	 * offset 45, 55, 95, and the word located at offset 109, 110.
 	 */
-	if (acpi_gbl_FADT.header.revision < 3) {
+	if (acpi_gbl_FADT.header.revision < FADT2_REVISION_ID) {
 		acpi_gbl_FADT.preferred_profile = 0;
 		acpi_gbl_FADT.pstate_control = 0;
 		acpi_gbl_FADT.cst_control = 0;
