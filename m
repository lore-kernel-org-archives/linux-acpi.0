From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/29] thinkpad-acpi: fix use of MODULE_AUTHOR
Date: Thu, 23 Apr 2009 02:23:41 -0400
Message-ID: <f68f53a217b827580647d23fdc34eecdcb3739c6.1240467665.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:58416 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbZDWGYI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:08 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ004ZCJ46SUHO@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:07 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix the module to use one instance of MODULE_AUTHOR per author.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a1d2abc..7a7cac2 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7883,7 +7883,8 @@ IBM_BIOS_MODULE_ALIAS("I[BDHIMNOTWVYZ]");
 IBM_BIOS_MODULE_ALIAS("1[0368A-GIKM-PST]");
 IBM_BIOS_MODULE_ALIAS("K[UX-Z]");
 
-MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
+MODULE_AUTHOR("Borislav Deianov <borislav@users.sf.net>");
+MODULE_AUTHOR("Henrique de Moraes Holschuh <hmh@hmh.eng.br>");
 MODULE_DESCRIPTION(TPACPI_DESC);
 MODULE_VERSION(TPACPI_VERSION);
 MODULE_LICENSE("GPL");
-- 
1.6.0.6

