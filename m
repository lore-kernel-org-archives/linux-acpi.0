From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/15] ACPI/PNP: avoid section mismatch warning
Date: Sat, 11 Dec 2010 02:06:38 -0500
Message-ID: <66c3ec4f1f70ee87833363166b594855631d7ba6.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33724 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab0LKHwv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:52:51 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900699780NVJ2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:52:51 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jan Beulich <JBeulich@novell.com>, Jan Beulich <jbeulich@novell.com>, Len Brown <len.brown@intel.com>

From: Jan Beulich <JBeulich@novell.com>

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 2d73dfc..57313f4 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -180,7 +180,7 @@ struct pnp_protocol pnpacpi_protocol = {
 };
 EXPORT_SYMBOL(pnpacpi_protocol);
 
-static char *pnpacpi_get_id(struct acpi_device *device)
+static char *__init pnpacpi_get_id(struct acpi_device *device)
 {
 	struct acpi_hardware_id *id;
 
-- 
1.7.3.3.480.g2f76a

