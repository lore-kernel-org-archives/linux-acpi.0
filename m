From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 61/66] drivers/acpi/sleep.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:42 +0100
Message-ID: <1267289508-31031-62-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:46242 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030535Ab0B0Q6E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Feb 2010 11:58:04 -0500
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Len Brown <lenb@kernel.org>, Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

drivers/acpi/sleep.h:3: WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 drivers/acpi/sleep.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index 8a8f3b3..25b8bd1 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -1,6 +1,6 @@
 
 extern u8 sleep_states[];
-extern int acpi_suspend (u32 state);
+extern int acpi_suspend(u32 state);
 
 extern void acpi_enable_wakeup_device_prep(u8 sleep_state);
 extern void acpi_enable_wakeup_device(u8 sleep_state);
-- 
1.7.0.90.g251a4

