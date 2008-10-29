From: akpm@linux-foundation.org
Subject: [patch 1/3] fujitsu-laptop: fix section mismatch warning
Date: Wed, 29 Oct 2008 14:13:20 -0700
Message-ID: <200810292113.m9TLDLOO016596@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48966 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753847AbYJ2VNm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Oct 2008 17:13:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, randy.dunlap@oracle.com, jwoithe@physics.adelaide.edu.au

From: Randy Dunlap <randy.dunlap@oracle.com>

Could fix a bug in a hotplug add scenario.

WARNING: drivers/misc/fujitsu-laptop.o(.text+0xbde): Section mismatch in reference from the function acpi_fujitsu_add() to the variable .init.data:fujitsu_dmi_table
The function acpi_fujitsu_add() references
the variable __initdata fujitsu_dmi_table.
This is often because acpi_fujitsu_add lacks a __initdata
annotation or the annotation of fujitsu_dmi_table is wrong.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/misc/fujitsu-laptop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/misc/fujitsu-laptop.c~fujitsu-laptop-fix-section-mismatch-warning drivers/misc/fujitsu-laptop.c
--- a/drivers/misc/fujitsu-laptop.c~fujitsu-laptop-fix-section-mismatch-warning
+++ a/drivers/misc/fujitsu-laptop.c
@@ -473,7 +473,7 @@ static int dmi_check_cb_p8010(const stru
 	return 0;
 }
 
-static struct dmi_system_id __initdata fujitsu_dmi_table[] = {
+static struct dmi_system_id fujitsu_dmi_table[] = {
 	{
 	 .ident = "Fujitsu Siemens S6410",
 	 .matches = {
_
