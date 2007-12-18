From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] [WIP] ACPI: WMI: Limit size of device string to 19 characters
Date: Tue, 18 Dec 2007 23:52:46 +0000
Message-ID: <20071218235246.12940.54577.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:42115 "EHLO
	pacifica." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1754051AbXLRXxM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Dec 2007 18:53:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Until Kay Sievers bus_id variable length code goes in, this is a
temporary workaround.

NOT-Signed-Off-By: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Len Brown <lenb@kernel.org>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
---

 drivers/acpi/wmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index f9f289e..0106ec4 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -848,7 +848,7 @@ static int wmi_create_devs(void)
 		gblock = &wblock->gblock;
 
 		wmi_gtoa(gblock->guid, guid_string);
-		memcpy(guid_dev->bus_id, guid_string, 36);
+		memcpy(guid_dev->bus_id, guid_string, 19);
 
 		result = device_register(guid_dev);
 		if (result)

