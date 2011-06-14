From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch]acpi: add missing _OSI strings
Date: Tue, 14 Jun 2011 09:55:48 +0800
Message-ID: <1308016548.15392.119.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:24436 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138Ab1FNBzv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Jun 2011 21:55:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Jarosz, Sebastian" <sebastian.jarosz@intel.com>

Linux supports some optional features, but it should notify BIOS about them
in _OSI method. Currently Linux doesn't notify any, which might make such
features not work because BIOS doesn't know about them.

Reported-by: "Jarosz, Sebastian" <sebastian.jarosz@intel.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 52ca964..a305115 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1083,7 +1083,13 @@ struct osi_setup_entry {
 	bool enable;
 };
 
-static struct osi_setup_entry __initdata osi_setup_entries[OSI_STRING_ENTRIES_MAX];
+static struct osi_setup_entry __initdata
+		osi_setup_entries[OSI_STRING_ENTRIES_MAX] = {
+	{"Module Device", true},
+	{"Processor Device", true},
+	{"3.0 _SCP Extensions", true},
+	{"Processor Aggregator Device", true},
+};
 
 void __init acpi_osi_setup(char *str)
 {


