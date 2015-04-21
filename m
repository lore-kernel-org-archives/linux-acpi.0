From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH] sbshc: fix NULL pointer dereference on rmmod
Date: Wed, 22 Apr 2015 00:25:36 +0100
Message-ID: <20150421232536.GA4769@localhost>
References: <20150417111124.GA3554@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36609 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933415AbbDUXZk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2015 19:25:40 -0400
Received: by wizk4 with SMTP id k4so157531059wiz.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Apr 2015 16:25:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150417111124.GA3554@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Use list_for_each_entry_safe for iterating because handler may be freed
in the loop.

BUG: unable to handle kernel NULL pointer dereference at 000000000000002c
IP: [<ffffffff814d69c8>] acpi_ec_put_query_handler+0x7/0x1a
Call Trace:
 acpi_ec_remove_query_handler+0x87/0x97
 acpi_smbus_hc_remove+0x2a/0x44 [sbshc]
 acpi_device_remove+0x7b/0x9a
 __device_release_driver+0x7e/0x110
 driver_detach+0xb0/0xc0
 bus_remove_driver+0x54/0xe0
 driver_unregister+0x2b/0x60
 acpi_bus_unregister_driver+0x10/0x12
 acpi_smb_hc_driver_exit+0x10/0x12 [sbshc]
 SyS_delete_module+0x1b8/0x210
 system_call_fastpath+0x12/0x6a

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
 drivers/acpi/ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 220d640..5e8fed4 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -861,7 +861,7 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 		}
 	}
 	mutex_unlock(&ec->mutex);
-	list_for_each_entry(handler, &free_list, node)
+	list_for_each_entry_safe(handler, tmp, &free_list, node)
 		acpi_ec_put_query_handler(handler);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
-- 
2.1.4

