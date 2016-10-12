From: Joe Perches <joe@perches.com>
Subject: [PATCH] acpi_os_vprintf: Use printk_get_level() to avoid unnecessary KERN_CONT
Date: Wed, 12 Oct 2016 11:50:34 -0700
Message-ID: <2344de692f658b8bb07ba53702286b43911e4753.1476298191.git.joe@perches.com>
References: <CA+55aFxNKFxa0Hh39o0gnxkskpW1Pg004-UnH5YaUQVq4oeDGA@mail.gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:53876 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755137AbcJLSuv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Oct 2016 14:50:51 -0400
In-Reply-To: <CA+55aFxNKFxa0Hh39o0gnxkskpW1Pg004-UnH5YaUQVq4oeDGA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

acpi_os_vprintf currently always uses a KERN_CONT prefix which may be
followed immediately by a proper KERN_<LEVEL>.  Check if the buffer
already has a KERN_<LEVEL> at the start of the buffer and avoid the
unnecessary KERN_CONT.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/acpi/osl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 4305ee9db4b2..416953a42510 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -162,11 +162,18 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 	if (acpi_in_debugger) {
 		kdb_printf("%s", buffer);
 	} else {
-		printk(KERN_CONT "%s", buffer);
+		if (printk_get_level(buffer))
+			printk("%s", buffer);
+		else
+			printk(KERN_CONT "%s", buffer);
 	}
 #else
-	if (acpi_debugger_write_log(buffer) < 0)
-		printk(KERN_CONT "%s", buffer);
+	if (acpi_debugger_write_log(buffer) < 0) {
+		if (printk_get_level(buffer))
+			printk("%s", buffer);
+		else
+			printk(KERN_CONT "%s", buffer);
+	}
 #endif
 }
 
-- 
2.10.0.rc2.1.g053435c

