From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/48] PNP: Set up pnp_debug via module and not via boot param.
Date: Wed, 12 Jan 2011 05:18:56 -0500
Message-ID: <cdefba03e44bd3b3311a3849a81ec7030dfa1519.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:51264 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab1ALKTy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 05:19:54 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEW0062NND4EVB0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 04:19:53 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
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
1.7.4.rc1.7.g2cf08

