From: akpm@linux-foundation.org
Subject: [patch 3/3] acpi: use macro to replace hard number
Date: Wed, 29 Oct 2008 14:13:22 -0700
Message-ID: <200810292113.m9TLDMY1016626@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53585 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753629AbYJ2VNc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Oct 2008 17:13:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, yinghai@kernel.org

From: Yinghai Lu <yinghai@kernel.org>

Impact: cleanup

Use MACRO for rev 3 fadt id instead of 3 directly.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/tables/tbfadt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/tables/tbfadt.c~acpi-use-macro-to-replace-hard-number drivers/acpi/tables/tbfadt.c
--- a/drivers/acpi/tables/tbfadt.c~acpi-use-macro-to-replace-hard-number
+++ a/drivers/acpi/tables/tbfadt.c
@@ -304,7 +304,7 @@ static void acpi_tb_convert_fadt(void)
 	 * The ACPI 1.0 reserved fields that will be zeroed are the bytes located at
 	 * offset 45, 55, 95, and the word located at offset 109, 110.
 	 */
-	if (acpi_gbl_FADT.header.revision < 3) {
+	if (acpi_gbl_FADT.header.revision < FADT2_REVISION_ID) {
 		acpi_gbl_FADT.preferred_profile = 0;
 		acpi_gbl_FADT.pstate_control = 0;
 		acpi_gbl_FADT.cst_control = 0;
_
