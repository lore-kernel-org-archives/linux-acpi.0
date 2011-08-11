From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PNP: update pnp.debug usage (needs value on command line)
Date: Thu, 11 Aug 2011 12:14:05 -0600
Message-ID: <20110811181405.24086.85736.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:40257 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1HKSON (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Aug 2011 14:14:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Commit cdefba03e44 changed pnp.debug from a boot param to a module param,
which means it needs a value when used on the command line.

CC: Thomas Renninger <trenn@suse.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/kernel-parameters.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e279b72..130713f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2081,9 +2081,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			Override pmtimer IOPort with a hex value.
 			e.g. pmtmr=0x508
 
-	pnp.debug	[PNP]
-			Enable PNP debug messages.  This depends on the
-			CONFIG_PNP_DEBUG_MESSAGES option.
+	pnp.debug=1	[PNP]
+			Enable PNP debug messages (depends on the
+			CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
+			via /sys/module/pnp/parameters/debug.  We always show
+			current resource usage; turning this on also shows
+			possible settings and some assignment information.
 
 	pnpacpi=	[ACPI]
 			{ off }

