From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 10/30] ACPI-processor: Rename jump labels in
 acpi_processor_get_performance_control()
Date: Sat, 10 Sep 2016 11:51:54 +0200
Message-ID: <519ba472-04d6-e82a-4572-d911d56909bb@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 18:50:48 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index b7e2f51..3a48c3a 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -240,7 +240,7 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	    || (pct->package.count != 2)) {
 		printk(KERN_ERR PREFIX "Invalid _PCT data\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	/*
@@ -254,7 +254,7 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	    || (obj.buffer.pointer == NULL)) {
 		printk(KERN_ERR PREFIX "Invalid _PCT data (control_register)\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 	memcpy(&pr->performance->control_register, obj.buffer.pointer,
 	       sizeof(struct acpi_pct_register));
@@ -270,13 +270,12 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	    || (obj.buffer.pointer == NULL)) {
 		printk(KERN_ERR PREFIX "Invalid _PCT data (status_register)\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	memcpy(&pr->performance->status_register, obj.buffer.pointer,
 	       sizeof(struct acpi_pct_register));
-
-      end:
+ free_buffer:
 	kfree(buffer.pointer);
 
 	return result;
-- 
2.10.0
