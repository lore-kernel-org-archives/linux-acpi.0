From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/33] PNP: Set up pnp_debug via module and not via boot param.
Date: Sun, 26 Dec 2010 17:43:23 -0500
Message-ID: <cdefba03e44bd3b3311a3849a81ec7030dfa1519.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:61058 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab0LZWoQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:44:16 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200EUZ4HHC0J8@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:44:12 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Cleanup only, no functional change (pnp.debug can be enabled
and disabled at runtime, but that's not a real enhancement).

This one depends on another PNP cleanup patch:
PNP: Compile all pnp built-in stuff in one module namespace

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/core.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 88b3cde..9801918 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -218,10 +218,5 @@ subsys_initcall(pnp_init);
 int pnp_debug;
 
 #if defined(CONFIG_PNP_DEBUG_MESSAGES)
-static int __init pnp_debug_setup(char *__unused)
-{
-	pnp_debug = 1;
-	return 1;
-}
-__setup("pnp.debug", pnp_debug_setup);
+module_param_named(debug, pnp_debug, int, 0644);
 #endif
-- 
1.7.3.3.557.gb5c17

