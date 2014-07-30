From: Arjun Sreedharan <arjun024@gmail.com>
Subject: [PATCH] ACPI: fix test for hex digit.
Date: Thu, 31 Jul 2014 01:22:12 +0530
Message-ID: <1406749932-1709-1-git-send-email-arjun024@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

decimal 0 is ascii for NULL. Hex digit matching should be from '0'
(decimal 30 of ascii) to '9' and 'A' to 'F'.
Unfixed version returns true for #,$,%,& etc.

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 drivers/acpi/acpi_pnp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 4ddb0dc..a4945a5 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -322,7 +322,7 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
 
 static bool is_hex_digit(char c)
 {
-	return (c >= 0 && c <= '9') || (c >= 'A' && c <= 'F');
+	return (c >= '0' && c <= '9') || (c >= 'A' && c <= 'F');
 }
 
 static bool matching_id(char *idstr, char *list_id)
-- 
1.8.1.msysgit.1
