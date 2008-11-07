From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/21] fujitsu-laptop: fix section mismatch warning
Date: Thu, 06 Nov 2008 23:39:22 -0500
Message-ID: <afeb12b7478fee31888e7c34804bee2f658e7765.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:64771 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbYKGEjk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:40 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9Y00JGI4XX0PN1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:33 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/fujitsu-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
index d2cf0bf..9124fcd 100644
--- a/drivers/misc/fujitsu-laptop.c
+++ b/drivers/misc/fujitsu-laptop.c
@@ -473,7 +473,7 @@ static int dmi_check_cb_p8010(const struct dmi_system_id *id)
 	return 0;
 }
 
-static struct dmi_system_id __initdata fujitsu_dmi_table[] = {
+static struct dmi_system_id fujitsu_dmi_table[] = {
 	{
 	 .ident = "Fujitsu Siemens S6410",
 	 .matches = {
-- 
1.5.6.5

