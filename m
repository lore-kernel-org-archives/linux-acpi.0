From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] fujitsu-laptop: fix section mismatch warning
Date: Wed, 08 Oct 2008 14:22:35 -0700
Message-ID: <48ED249B.7050908@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:14495 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbYJHVXK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 17:23:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org, akpm <akpm@linux-foundation.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

From: Randy Dunlap <randy.dunlap@oracle.com>

Could fix a bug in a hotplug add scenario.

WARNING: drivers/misc/fujitsu-laptop.o(.text+0xbde): Section mismatch in reference from the function acpi_fujitsu_add() to the variable .init.data:fujitsu_dmi_table
The function acpi_fujitsu_add() references
the variable __initdata fujitsu_dmi_table.
This is often because acpi_fujitsu_add lacks a __initdata 
annotation or the annotation of fujitsu_dmi_table is wrong.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
---
 drivers/misc/fujitsu-laptop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lin2627-r9g1-sections.orig/drivers/misc/fujitsu-laptop.c
+++ lin2627-r9g1-sections/drivers/misc/fujitsu-laptop.c
@@ -455,7 +455,7 @@ static int dmi_check_cb_s6410(const stru
 	return 0;
 }
 
-static struct dmi_system_id __initdata fujitsu_dmi_table[] = {
+static struct dmi_system_id fujitsu_dmi_table[] = {
 	{
 	 .ident = "Fujitsu Siemens",
 	 .matches = {
