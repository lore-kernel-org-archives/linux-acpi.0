From: Len Brown <lenb@kernel.org>
Subject: [PATCH 078/122] ACPI: thinkpad-acpi: trivial fix of error message
Date: Thu, 23 Oct 2008 02:38:52 -0400
Message-ID: <4f778b92c9d8d87c670fc063c66edf1aa46f6f1c.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:37959 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279AbYJWGkT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:19 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600EEBIIZP617@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:11 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, Len Brown <len.brown@intel.com>

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

Trivial fix makes the error message match the code before it (ibm->driver
vs ibm->acpi-driver) better.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 1dcf066..6c9b6c8 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -582,7 +582,8 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 
 	ibm->acpi->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
 	if (!ibm->acpi->driver) {
-		printk(TPACPI_ERR "kzalloc(ibm->driver) failed\n");
+		printk(TPACPI_ERR
+		       "failed to allocate memory for ibm->acpi->driver\n");
 		return -ENOMEM;
 	}
 
-- 
1.5.5.1

