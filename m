From: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Subject: [PATCH] drivers: acpi: Replaced kmalloc and memcpy with kmemdup
Date: Tue, 12 Mar 2013 10:22:21 +0200
Message-ID: <1363076541-30013-1-git-send-email-gheorghiuandru@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandru Gheorghiu <gheorghiuandru@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Replaced calls to kmalloc followed by memcpy with a single call to kmemdup.
Patch found using coccinelle.

Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
---
 drivers/acpi/bus.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 01708a1..6c8380e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -288,13 +288,12 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 	}
 out_success:
 	context->ret.length = out_obj->buffer.length;
-	context->ret.pointer = kmalloc(context->ret.length, GFP_KERNEL);
+	context->ret.pointer = kmemdup(out_obj->buffer.pointer,
+				context->ret.length, GFP_KERNEL);
 	if (!context->ret.pointer) {
 		status =  AE_NO_MEMORY;
 		goto out_kfree;
 	}
-	memcpy(context->ret.pointer, out_obj->buffer.pointer,
-		context->ret.length);
 	status =  AE_OK;
 
 out_kfree:
-- 
1.7.9.5
