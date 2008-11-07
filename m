From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/5] ACPI: turn off all debug output by default
Date: Fri, 07 Nov 2008 16:58:00 -0700
Message-ID: <20081107235800.32050.4699.stgit@bob.kio>
References: <20081107235644.32050.74757.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:8313 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbYKGX6B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2008 18:58:01 -0500
In-Reply-To: <20081107235644.32050.74757.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Randy Dunlap <rdunlap@xenotime.net>

When CONFIG_ACPI_DEBUG=y, the default acpi_dbg_layer and acpi_dbg_level
values built into the ACPI CA have some debug output enabled.  We'd
rather be quiet unless the user actually specified the acpi.debug_level
argument.

This enables distros to ship with CONFIG_ACPI_DEBUG=y without
inundating users with debug output.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/bus.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c797c64..0ae9e3c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -688,6 +688,14 @@ void __init acpi_early_init(void)
 	if (acpi_disabled)
 		return;
 
+	/*
+	 * ACPI CA initializes acpi_dbg_level to non-zero, which means
+	 * we get debug output merely by turning on CONFIG_ACPI_DEBUG.
+	 * Turn it off so we don't get output unless the user specifies
+	 * acpi.debug_level.
+	 */
+	acpi_dbg_level = 0;
+
 	printk(KERN_INFO PREFIX "Core revision %08x\n", ACPI_CA_VERSION);
 
 	/* enable workarounds, unless strict ACPI spec. compliance */

