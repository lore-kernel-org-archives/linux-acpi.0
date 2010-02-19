From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] ACPI: remove "acpi=ht" DMI blacklist
Date: Fri, 19 Feb 2010 00:53:46 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002190051460.17638@localhost.localdomain>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
 <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain>
 <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain>
 <20100216154053.GA31195@srcf.ucam.org>
 <alpine.LFD.2.00.1002161553420.3995@localhost.localdomain>
 <20100217143245.GA18411@srcf.ucam.org>
 <alpine.LFD.2.00.1002171122140.4135@localhost.localdomain>
 <20100217183108.GA23189@srcf.ucam.org>
 <alpine.LFD.2.00.1002171618210.4135@localhost.localdomain>
 <20100217212851.GA27092@srcf.ucam.org>
 <alpine.LFD.2.00.1002190028510.17638@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:32992 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab0BSFxu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 00:53:50 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200FC8R1PQZ73@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Feb 2010 23:53:50 -0600 (CST)
In-reply-to: <alpine.LFD.2.00.1002190028510.17638@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, "Rafael J. Wysocki" <rjw@sisk.pl>

From: Len Brown <len.brown@intel.com>

SuSE added these entries when deploying ACPI in Linux-2.4.
I pulled them into Linux-2.6 on 2003-08-09.
Over the last 6+ years, several entries have proven to be
unnecessary and deleted, while no new entries have been added.
Matthew suggests that they now have negative value, and I agree.

Based-on-patch-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/boot.c |   93 -------------------------------------------
 1 files changed, 0 insertions(+), 93 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index af1c583..cba0311 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1264,23 +1264,6 @@ static int __init dmi_disable_acpi(const struct dmi_system_id *d)
 }
 
 /*
- * Limit ACPI to CPU enumeration for HT
- */
-static int __init force_acpi_ht(const struct dmi_system_id *d)
-{
-	if (!acpi_force) {
-		printk(KERN_NOTICE "%s detected: force use of acpi=ht\n",
-		       d->ident);
-		disable_acpi();
-		acpi_ht = 1;
-	} else {
-		printk(KERN_NOTICE
-		       "Warning: acpi=force overrules DMI blacklist: acpi=ht\n");
-	}
-	return 0;
-}
-
-/*
  * Force ignoring BIOS IRQ0 pin2 override
  */
 static int __init dmi_ignore_irq0_timer_override(const struct dmi_system_id *d)
@@ -1316,82 +1299,6 @@ static struct dmi_system_id __initdata acpi_dmi_table[] = {
 	 },
 
 	/*
-	 * Boxes that need acpi=ht
-	 */
-	{
-	 .callback = force_acpi_ht,
-	 .ident = "FSC Primergy T850",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "PRIMERGY T850"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
-	 .ident = "HP VISUALIZE NT Workstation",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "HP VISUALIZE NT Workstation"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
-	 .ident = "Compaq Workstation W8000",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Workstation W8000"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
-	 .ident = "ASUS CUR-DLS",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-		     DMI_MATCH(DMI_BOARD_NAME, "CUR-DLS"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
-	 .ident = "ABIT i440BX-W83977",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "ABIT <http://www.abit.com>"),
-		     DMI_MATCH(DMI_BOARD_NAME, "i440BX-W83977 (BP6)"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
-	 .ident = "IBM Bladecenter",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
-		     DMI_MATCH(DMI_BOARD_NAME, "IBM eServer BladeCenter HS20"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
-	 .ident = "IBM eServer xSeries 360",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
-		     DMI_MATCH(DMI_BOARD_NAME, "eServer xSeries 360"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
-	 .ident = "IBM eserver xSeries 330",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
-		     DMI_MATCH(DMI_BOARD_NAME, "eserver xSeries 330"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
-	 .ident = "IBM eserver xSeries 440",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "eserver xSeries 440"),
-		     },
-	 },
-
-	/*
 	 * Boxes that need ACPI PCI IRQ routing disabled
 	 */
 	{
-- 
1.7.0.17.g7e5eb


