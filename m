From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] acpi/button.c: fix defined but not used warning
Date: Sat, 7 Jul 2018 08:25:01 -0700
Message-ID: <2e91930f-c762-532b-6607-223385078edb@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a build warning in the ACPI button driver when CONFIG_PROC_FS
is not enabled by marking the unused function as __maybe_unused.

../drivers/acpi/button.c:252:12: warning: 'acpi_button_state_seq_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/button.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-next-20180706.orig/drivers/acpi/button.c
+++ linux-next-20180706/drivers/acpi/button.c
@@ -21,6 +21,7 @@
 
 #define pr_fmt(fmt) "ACPI: button: " fmt
 
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -249,7 +250,8 @@ static int acpi_lid_notify_state(struct
 	return ret;
 }
 
-static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused acpi_button_state_seq_show(struct seq_file *seq,
+						     void *offset)
 {
 	struct acpi_device *device = seq->private;
 	int state;
