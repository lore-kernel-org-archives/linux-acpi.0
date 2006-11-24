From: Len Brown <len.brown@intel.com>
Subject: [PATCH 33/65] ACPICA: Add declarations for ASF! sub-tables
Date: Fri, 24 Nov 2006 02:18:43 -0500
Message-ID: <11643527951196-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10249 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757621AbWKXHP5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:57 -0500
In-Reply-To: <11643527943385-git-send-email-len.brown@intel.com>
Message-Id: <0441d700442eb4c9345d4f2b6700c8fda5c1288b.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/actbl1.h |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8494c42..3156d1a 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -148,7 +148,21 @@ struct acpi_asf_alert {
 	u8 deassert_mask;
 	u8 alerts;
 	u8 data_length;
-	u8 array[1];
+};
+
+struct acpi_asf_alert_data {
+	u8 address;
+	u8 command;
+	u8 mask;
+	u8 value;
+	u8 sensor_type;
+	u8 type;
+	u8 offset;
+	u8 source_type;
+	u8 severity;
+	u8 sensor_number;
+	u8 entity;
+	u8 instance;
 };
 
 /* 2: ASF Remote Control */
@@ -158,7 +172,13 @@ struct acpi_asf_remote {
 	u8 controls;
 	u8 data_length;
 	u16 reserved2;
-	u8 array[1];
+};
+
+struct acpi_asf_control_data {
+	u8 function;
+	u8 address;
+	u8 command;
+	u8 value;
 };
 
 /* 3: ASF RMCP Boot Options */
@@ -180,7 +200,6 @@ struct acpi_asf_address {
 	struct acpi_asf_header header;
 	u8 eprom_address;
 	u8 devices;
-	u8 smbus_addresses[1];
 };
 
 /*******************************************************************************
-- 
1.4.4.1
