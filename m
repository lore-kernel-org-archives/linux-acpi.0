From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 24/30] ACPI-processor: Rename jump labels in
 acpi_processor_get_throttling_control()
Date: Sat, 10 Sep 2016 12:06:24 +0200
Message-ID: <c31f3058-d30c-d814-5827-5b0f5851472b@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:61349 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932155AbcIJKGd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 06:06:33 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 21:12:17 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_throttling.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index dcebb4b2..cdcd5d6f 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -442,7 +442,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 	    || (ptc->package.count != 2)) {
 		printk(KERN_ERR PREFIX "Invalid _PTC data\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	/*
@@ -457,7 +457,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 		printk(KERN_ERR PREFIX
 		       "Invalid _PTC data (control_register)\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 	memcpy(&pr->throttling.control_register, obj.buffer.pointer,
 	       sizeof(struct acpi_ptc_register));
@@ -473,7 +473,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 	    || (obj.buffer.pointer == NULL)) {
 		printk(KERN_ERR PREFIX "Invalid _PTC data (status_register)\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	memcpy(&pr->throttling.status_register, obj.buffer.pointer,
@@ -485,17 +485,15 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 		throttling->control_register.bit_offset) > 32) {
 		printk(KERN_ERR PREFIX "Invalid _PTC control register\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	if ((throttling->status_register.bit_width +
 		throttling->status_register.bit_offset) > 32) {
 		printk(KERN_ERR PREFIX "Invalid _PTC status register\n");
 		result = -EFAULT;
-		goto end;
 	}
-
-      end:
+ free_buffer:
 	kfree(buffer.pointer);
 
 	return result;
-- 
2.10.0

