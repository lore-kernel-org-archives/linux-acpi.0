From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] PNP: Set up pnp_debug via module and not via boot param.
Date: Mon, 25 Oct 2010 21:11:16 +0200
Message-ID: <1288033876-22929-2-git-send-email-trenn@suse.de>
References: <1288033876-22929-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42371 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab0JYTLr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 15:11:47 -0400
In-Reply-To: <1288033876-22929-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, bjorn.helgaas@hp.com
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

Cleanup only, no functional change (pnp.debug can be enabled
and disabled at runtime, but that's not a real enhancement).

This one depends on another PNP cleanup patch:
PNP: Compile all pnp built-in stuff in one module namespace

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: linux-acpi@vger.kernel.org
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
1.6.3

