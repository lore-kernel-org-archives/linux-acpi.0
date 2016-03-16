From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 3/3] ACPI: update the definition of common notification values
Date: Wed, 16 Mar 2016 13:37:02 -0600
Message-ID: <1458157022-18633-4-git-send-email-pprakash@codeaurora.org>
References: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60447 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935092AbcCPThU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2016 15:37:20 -0400
In-Reply-To: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: harba@codeaurora.org, rjw@rjwysocki.net, Prashanth Prakash <pprakash@codeaurora.org>

Per ACPI spec 6.1, the device object notification value of 0x0C is
now reserved, so updating the definition to reflect the same.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index db46546..4553300 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -627,7 +627,7 @@ typedef u64 acpi_integer;
 #define ACPI_NOTIFY_DEVICE_PLD_CHECK    (u8) 0x09
 #define ACPI_NOTIFY_RESERVED            (u8) 0x0A
 #define ACPI_NOTIFY_LOCALITY_UPDATE     (u8) 0x0B
-#define ACPI_NOTIFY_SHUTDOWN_REQUEST    (u8) 0x0C
+#define ACPI_NOTIFY_RESERVED_2          (u8) 0x0C
 #define ACPI_NOTIFY_AFFINITY_UPDATE     (u8) 0x0D
 
 #define ACPI_NOTIFY_MAX                 0x0D
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

