From: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
Subject: [PATCH 2/2] ACPI: minor printk format change in acpi_pad
Date: Wed,  2 Feb 2011 23:27:04 +0000 (UTC)
Message-ID: <20110202232435.22145.88013.sendpatchset@nchumbalkar.americas.hpqcorp.net>
References: <20110202232425.22145.40776.sendpatchset@nchumbalkar.americas.hpqcorp.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:5969 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab1BBX1F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Feb 2011 18:27:05 -0500
In-Reply-To: <20110202232425.22145.40776.sendpatchset@nchumbalkar.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Naga Chumbalkar <nagananda.chumbalkar@hp.com>

Minor format change.

Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
---
 drivers/acpi/acpi_pad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 474be3a..a43fa1a 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -456,7 +456,7 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 			dev_name(&device->dev), event, 0);
 		break;
 	default:
-		printk(KERN_WARNING"Unsupported event [0x%x]\n", event);
+		printk(KERN_WARNING "Unsupported event [0x%x]\n", event);
 		break;
 	}
 }
-- 
1.7.1.2

