From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 5/5] ACPI: WMI: Limit size of device string to 19 characters
Date: Wed, 12 Dec 2007 02:09:19 +0000
Message-ID: <200712120209.20471.carlos@strangeworlds.co.uk>
References: <200712120201.45478.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:36222 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbXLLCK6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Dec 2007 21:10:58 -0500
In-Reply-To: <200712120201.45478.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

Until Kay Sievers bus_id variable length code goes in, this is a
temporary workaround.
---
 drivers/acpi/wmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 62b8c1b..9af6b80 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -853,7 +853,7 @@ static int wmi_create_devs(void)
 		gblock = &wblock->gblock;
 
 		wmi_gtoa(gblock->guid, guid_string);
-		memcpy(guid_dev->bus_id, guid_string, 36);
+		memcpy(guid_dev->bus_id, guid_string, 19);
 
 		result = device_register(guid_dev);
 		if (result)
-- 
1.5.3.4

