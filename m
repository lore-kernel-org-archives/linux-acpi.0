From: Andrei Epure <epure.andrei@gmail.com>
Subject: [PATCH] acpi: replaced kmalloc+memcpy with kmemdup
Date: Mon, 11 Mar 2013 10:20:16 +0200
Message-ID: <1362990016-21249-1-git-send-email-epure.andrei@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrei Epure <epure.andrei@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Andrei Epure <epure.andrei@gmail.com>
---
 drivers/acpi/bus.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 01708a1..292de3c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -288,13 +288,12 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 	}
 out_success:
 	context->ret.length = out_obj->buffer.length;
-	context->ret.pointer = kmalloc(context->ret.length, GFP_KERNEL);
+	context->ret.pointer = kmemdup(out_obj->buffer.pointer,
+				       context->ret.length, GFP_KERNEL);
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
