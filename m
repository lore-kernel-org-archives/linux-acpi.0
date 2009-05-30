From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/65] ACPI: Remove Asus P4B266 from blacklist
Date: Fri, 29 May 2009 21:41:43 -0400
Message-ID: <afc72c70407e33ea993e8ab7aa802299f64dfee8.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61678 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754943AbZE3Bmr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:47 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00K9JORCJRW3@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:49 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Olivier Berger <oberger@ouvaton.org>, Len Brown <len.brown@intel.com>

From: Olivier Berger <oberger@ouvaton.org>

See http://marc.info/?l=linux-acpi&m=124068823904429&w=2 for discussion

Signed-off-by: Olivier Berger <oberger@ouvaton.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/boot.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 82f051e..fb2e7c7 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1565,14 +1565,6 @@ static struct dmi_system_id __initdata acpi_dmi_table[] = {
 	 },
 	{
 	 .callback = force_acpi_ht,
-	 .ident = "ASUS P4B266",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-		     DMI_MATCH(DMI_BOARD_NAME, "P4B266"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
 	 .ident = "ASUS P2B-DS",
 	 .matches = {
 		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-- 
1.6.0.6

