From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 5/5] [WIP] ACPI: WMI: Limit size of device string to 19
	characters
Date: Sat, 02 Feb 2008 12:17:48 +0000
Message-ID: <20080202121747.2286.1640.stgit@pacifica>
References: <20080202121718.2286.89857.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:51351 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756037AbYBBMSO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Feb 2008 07:18:14 -0500
In-Reply-To: <20080202121718.2286.89857.stgit@pacifica>
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
index 9562607..181fe93 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -885,7 +885,7 @@ static int wmi_create_devs(void)
 		gblock = &wblock->gblock;
 
 		wmi_gtoa(gblock->guid, guid_string);
-		memcpy(guid_dev->bus_id, guid_string, 36);
+		memcpy(guid_dev->bus_id, guid_string, 19);
 
 		result = device_register(guid_dev);
 		if (result)

