From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH 2/2] acpi: Add "acpi_osi=" for ASUS UX302LA to enable, brightness
 keys
Date: Thu, 18 Dec 2014 15:19:13 +0300
Message-ID: <5492C641.4040602@gmail.com>
References: <5492C5A3.8090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:61264 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbaLRMTQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Dec 2014 07:19:16 -0500
In-Reply-To: <5492C5A3.8090700@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, aaron.lu@intel.com

This patch is a workaround quirk to enable brightness keys.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=70241
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>

---
  drivers/acpi/blacklist.c | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index f78ed08..a96295c 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -391,6 +391,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
  		     DMI_MATCH(DMI_PRODUCT_NAME, "X200MA"),
  		},
  	},
+	{
+	.callback = dmi_disable_osi_all,
+	.ident = "ASUSTeK COMPUTER INC. UX302LA",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "UX302LA"),
+		},
+	},
  	{}
  };
  
-- 
1.9.1
