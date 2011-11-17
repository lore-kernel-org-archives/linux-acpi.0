From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] ACPI: Use kmemdup rather than duplicating its
 implementation
Date: Thu, 17 Nov 2011 23:43:40 +0100
Message-ID: <1321569820.1624.278.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The semantic patch that makes this change is available
in scripts/coccinelle/api/memdup.cocci.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/acpi/bus.c b/drivers/acpi/bus.c
--- a/drivers/acpi/bus.c 2011-11-08 08:49:58.136858513 +0100
+++ b/drivers/acpi/bus.c 2011-11-08 10:40:30.311111025 +0100
@@ -503,13 +503,12 @@ acpi_status acpi_run_osc(acpi_handle han
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
