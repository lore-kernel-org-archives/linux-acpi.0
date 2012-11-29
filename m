From: Colin King <colin.king@canonical.com>
Subject: [PATCH 1/5] ACPI dock: remove unnecessary newline from exception message
Date: Thu, 29 Nov 2012 11:53:12 +0000
Message-ID: <1354189996-14431-2-git-send-email-colin.king@canonical.com>
References: <1354189996-14431-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354189996-14431-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

ACPI_EXCEPTION() already appends a newline, so there is no
need for the failed _DCK messaged to include one too.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/dock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 88eb143..a873c6b 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -475,7 +475,7 @@ static void handle_dock(struct dock_station *ds, int dock)
 	status = acpi_evaluate_object(ds->handle, "_DCK", &arg_list, &buffer);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
 		ACPI_EXCEPTION((AE_INFO, status, "%s - failed to execute"
-			" _DCK\n", (char *)name_buffer.pointer));
+			" _DCK", (char *)name_buffer.pointer));
 
 	kfree(buffer.pointer);
 	kfree(name_buffer.pointer);
-- 
1.8.0
