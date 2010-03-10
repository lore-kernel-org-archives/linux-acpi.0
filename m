From: Bruno Bigras <bigras.bruno@gmail.com>
Subject: [PATCH] acpi: sleep: fixed a brace coding style issue
Date: Tue,  9 Mar 2010 23:56:20 -0500
Message-ID: <1268196980-5697-1-git-send-email-bigras.bruno@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Bruno Bigras <bigras.bruno@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Fix a coding style issue.

Signed-off-by: Bruno Bigras <bigras.bruno@gmail.com>
---
 drivers/acpi/sleep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 3bde594..fc8343f 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -62,9 +62,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
 #ifdef CONFIG_ACPI_SLEEP
 	/* do we have a wakeup address for S2 and S3? */
 	if (acpi_state == ACPI_STATE_S3) {
-		if (!acpi_wakeup_address) {
+		if (!acpi_wakeup_address)
 			return -EFAULT;
-		}
+
 		acpi_set_firmware_waking_vector(
 				(acpi_physical_address)acpi_wakeup_address);
 
-- 
1.7.0.2
