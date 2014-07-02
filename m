From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI / EC: Free saved_ec on error exit path
Date: Thu,  3 Jul 2014 00:35:09 +0100
Message-ID: <1404344109-30805-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Smatch detected two memory leaks on saved_ec:

drivers/acpi/ec.c:1070 acpi_ec_ecdt_probe() warn: possible
  memory leak of 'saved_ec'
drivers/acpi/ec.c:1109 acpi_ec_ecdt_probe() warn: possible
  memory leak of 'saved_ec'

Free saved_ec on these two error exit paths to stop the memory
leak.  Note that saved_ec maybe null, but kfree on null is allowed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/ec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ad11ba4..9800f50 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1066,8 +1066,10 @@ int __init acpi_ec_ecdt_probe(void)
 	/* fall through */
 	}
 
-	if (EC_FLAGS_SKIP_DSDT_SCAN)
+	if (EC_FLAGS_SKIP_DSDT_SCAN) {
+		kfree(saved_ec);
 		return -ENODEV;
+	}
 
 	/* This workaround is needed only on some broken machines,
 	 * which require early EC, but fail to provide ECDT */
@@ -1105,6 +1107,7 @@ install:
 	}
 error:
 	kfree(boot_ec);
+	kfree(saved_ec);
 	boot_ec = NULL;
 	return -ENODEV;
 }
-- 
2.0.1
