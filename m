From: Pavel Machek <pavel@suse.cz>
Subject: acpi_evaluate_integer broken by design
Date: Tue, 25 Nov 2008 12:05:08 +0100
Message-ID: <20081125110508.GA1943@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54310 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYKYLDV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Nov 2008 06:03:21 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>


Now I know why I had strange "scheduling in atomic" problems:
acpi_evaluate_integer() does malloc(..., irqs_disabled() ? GFP_ATOMIC
: GFP_KERNEL)... which is (of course) broken.

There's no way to reliably tell if we need GFP_ATOMIC or not from
code, this one for example fails to detect spinlocks held.

Fortunately, allocation seems small enough to be done on stack.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index e827be3..f844941 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -259,34 +259,26 @@ acpi_evaluate_integer(acpi_handle handle
 		      struct acpi_object_list *arguments, unsigned long long *data)
 {
 	acpi_status status = AE_OK;
-	union acpi_object *element;
+	union acpi_object element;
 	struct acpi_buffer buffer = { 0, NULL };
 
-
 	if (!data)
 		return AE_BAD_PARAMETER;
 
-	element = kzalloc(sizeof(union acpi_object), irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
-	if (!element)
-		return AE_NO_MEMORY;
-
 	buffer.length = sizeof(union acpi_object);
-	buffer.pointer = element;
+	buffer.pointer = &element;
 	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_util_eval_error(handle, pathname, status);
-		kfree(element);
 		return status;
 	}
 
-	if (element->type != ACPI_TYPE_INTEGER) {
+	if (element.type != ACPI_TYPE_INTEGER) {
 		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
-		kfree(element);
 		return AE_BAD_DATA;
 	}
 
-	*data = element->integer.value;
-	kfree(element);
+	*data = element.integer.value;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Return value [%llu]\n", *data));
 



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
