From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 3/3] acer-wmi: Add mail LED support for Acer Aspire 3610/ 5610
Date: Wed, 12 Mar 2008 20:13:00 +0000
Message-ID: <20080312201300.2071.42198.stgit@pacifica>
References: <20080312201238.2071.31534.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:45901 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752574AbYCLUNQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 16:13:16 -0400
In-Reply-To: <20080312201238.2071.31534.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Add a DMI quirk entry to add mail LED support for this laptop series.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/acer-wmi.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index 89d346b..dd13a37 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -219,6 +219,15 @@ static struct dmi_system_id acer_quirks[] = {
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "Acer Aspire 3610",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 3610"),
+		},
+		.driver_data = &quirk_acer_travelmate_2490,
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Acer Aspire 5100",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
@@ -228,6 +237,15 @@ static struct dmi_system_id acer_quirks[] = {
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "Acer Aspire 5610",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
+		},
+		.driver_data = &quirk_acer_travelmate_2490,
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Acer Aspire 5630",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),

