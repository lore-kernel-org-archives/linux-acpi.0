From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/5] thinkpad-acpi: fix CONFIG_THINKPAD_ACPI_HOTKEY_POLL build
 problem
Date: Sun, 27 Sep 2009 04:32:41 -0400
Message-ID: <b684a3637e0887683a0a3d6fd471fc41d7c1606a.1254040242.git.len.brown@intel.com>
References: <1254040365-18971-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:40763 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbZI0Icp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Sep 2009 04:32:45 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KQM009Z7FQOG9KK@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 27 Sep 2009 03:32:49 -0500 (CDT)
In-reply-to: <1254040365-18971-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix this problem when CONFIG_THINKPAD_ACPI_HOTKEY_POLL is undefined:

  CHECK   drivers/platform/x86/thinkpad_acpi.c
drivers/platform/x86/thinkpad_acpi.c:1968:21: error: not an lvalue
  CC [M]  drivers/platform/x86/thinkpad_acpi.o
drivers/platform/x86/thinkpad_acpi.c: In function 'tpacpi_hotkey_driver_mask_set':
drivers/platform/x86/thinkpad_acpi.c:1968: error: lvalue required as left operand of assignment

Reported-by: Noah Dain <noahdain@gmail.com>
Reported-by: Audrius Kazukauskas <audrius@neutrino.lt>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3910f2f..d93108d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2235,7 +2235,9 @@ static int tpacpi_hotkey_driver_mask_set(const u32 mask)
 
 	HOTKEY_CONFIG_CRITICAL_START
 	hotkey_driver_mask = mask;
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	hotkey_source_mask |= (mask & ~hotkey_all_mask);
+#endif
 	HOTKEY_CONFIG_CRITICAL_END
 
 	rc = hotkey_mask_set((hotkey_acpi_mask | hotkey_driver_mask) &
-- 
1.6.0.6

