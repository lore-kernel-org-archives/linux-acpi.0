From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.32.stable] ACPI: remove Asus P2B-DS from acpi=ht blacklist
Date: Thu, 18 Feb 2010 23:05:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002182303120.17638@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:49203 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0BSEGB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Feb 2010 23:06:01 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200A5LM1NNZ55@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Feb 2010 22:05:53 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

upstream 97c169d39b6846a564dc8d883832e7fef9bdb77d
From: Len Brown <len.brown@intel.com>

We realized when we broke acpi=ht
http://bugzilla.kernel.org/show_bug.cgi?id=14886
that acpi=ht is not needed on this box
and folks have been using acpi=force on it anyway.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/boot.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 0acbcdf..af1c583 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1344,14 +1344,6 @@ static struct dmi_system_id __initdata acpi_dmi_table[] = {
 	 },
 	{
 	 .callback = force_acpi_ht,
-	 .ident = "ASUS P2B-DS",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-		     DMI_MATCH(DMI_BOARD_NAME, "P2B-DS"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
 	 .ident = "ASUS CUR-DLS",
 	 .matches = {
 		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-- 
1.7.0.17.g7e5eb

