From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] acpi: Fix the mapping handle in case of declaring processors using the Device operator
Date: Thu, 16 Feb 2017 18:38:11 +0800
Message-ID: <1487241492-30005-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:47724 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753186AbdBPKif (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Feb 2017 05:38:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>

In ACPI spec, we can declare processors using both Processor and
Device operator. But now, we just handle the mapping of processors
which are declared by Processor operator.

It misses the processors declared by Device operator.

The patch adds this case of the Device operator.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 drivers/acpi/processor_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 611a558..1aab5b0 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -344,8 +344,10 @@ void __init acpi_set_processor_mapping(void)
 {
 	/* Set persistent cpu <-> node mapping for all processors. */
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, set_processor_node_mapping,
-			    NULL, NULL, NULL);
+				ACPI_UINT32_MAX, set_processor_node_mapping,
+				NULL, NULL, NULL);
+	acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, set_processor_node_mapping,
+				NULL, NULL);
 }
 #else
 void __init acpi_set_processor_mapping(void) {}
-- 
2.5.5



