From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] ACPI processor: reset the throttling state once it's
	invalid
Date: Mon, 11 May 2009 09:36:01 +0800
Message-ID: <1242005761.15284.120.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23620 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757081AbZEKBfb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 May 2009 21:35:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, theholyettlz@googlemail.com

Reset the throttling state once we find that it's invalid.
http://bugzilla.kernel.org/show_bug.cgi?id=13259

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: James Ettle <theholyettlz@googlemail.com>
---
 drivers/acpi/processor_throttling.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6/drivers/acpi/processor_throttling.c
@@ -840,6 +840,14 @@ static int acpi_processor_get_throttling
 	ret = acpi_read_throttling_status(pr, &value);
 	if (ret >= 0) {
 		state = acpi_get_throttling_state(pr, value);
+		if (state == -1) {
+			ACPI_WARNING((AE_INFO,
+				"Invalid throttling state, reset\n"));
+			state = 0;
+			ret = acpi_processor_set_throttling(pr, state);
+			if (ret)
+				return ret;
+		}
 		pr->throttling.state = state;
 	}
 


