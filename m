From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/2] acer-wmi: Fix backlight on AMW0 (V1) laptops
Date: Fri, 08 Feb 2008 23:51:49 +0000
Message-ID: <20080208235149.2786.12835.stgit@pacifica>
References: <20080208235137.2786.80503.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:35732 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753575AbYBHXwH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2008 18:52:07 -0500
In-Reply-To: <20080208235137.2786.80503.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>

There is some leftover cruft from the old quirk infrastructure that causes
us to be unable to set the backlight on older laptops.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Len Brown <lenb@kernel.org>
---

 drivers/misc/acer-wmi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index a4d6775..d7aea93 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -428,11 +428,9 @@ static acpi_status AMW0_set_u32(u32 value, u32 cap, struct wmi_interface *iface)
 		if (value > max_brightness)
 			return AE_BAD_PARAMETER;
 		switch (quirks->brightness) {
-		case 1:
-			return ec_write(0x83, value);
 		default:
-			return AE_BAD_ADDRESS;
-		break;
+			return ec_write(0x83, value);
+			break;
 		}
 	default:
 		return AE_BAD_ADDRESS;

