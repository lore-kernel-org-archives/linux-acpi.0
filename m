From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: asus_acpi bugs
Date: Mon, 12 Sep 2005 22:15:45 +0200
Message-ID: <20050912201545.GB3320@hell.org.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047FA08F@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30047FA08F-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Brown, Len:
> >> http://bugzilla.kernel.org/show_bug.cgi?id=5067
> >> http://bugzilla.kernel.org/show_bug.cgi?id=5092

Here is another take on this issue, as much ugly as, IMHO, correct. I
*would* prefer this to be applied rather than the other patch, because it
fixes the root cause of the problem instead of trying to work around it.
Of course, I'm pretty sure fiddling with global variables will not be taken
lightly...
NOTE: the actual fix is in the initial hunks, the last one is just code
reordering and whitespace stuff.

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>

--- a/drivers/acpi/asus_acpi.c	2005-09-12 21:39:47.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2005-09-12 21:53:19.000000000 +0200
@@ -962,6 +962,7 @@
 	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *model = NULL;
 	int bsts_result;
+	int acpi_is_strict = acpi_strict;
 	acpi_status status;
 
 	/*
@@ -978,6 +979,10 @@
 	else
 		asus_info = (struct acpi_table_header *) dsdt.pointer;
 
+	/* Implicit return code confuses model detection, disable it */
+	if (!acpi_is_strict)
+		acpi_strict = 1;
+
 	/* We have to write 0 on init this far for all ASUS models */
 	if (!write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
 		printk(KERN_ERR "  Hotkey initialization failed\n");
@@ -990,6 +995,10 @@
 	else if (bsts_result)
 		printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n", bsts_result);
 
+	/* Restore if disabled previously */
+	if (!acpi_is_strict)
+		acpi_strict = 0;
+
 	/* Samsung P30 has a device with a valid _HID whose INIT does not 
 	 * return anything. Catch this one and any similar here */
 	if (buffer.pointer == NULL) {
@@ -1007,56 +1016,56 @@
 		return AE_OK;
 	}
 	
+	hotk->model = END_MODEL;
+
 	model = (union acpi_object *) buffer.pointer;
 	if (model->type == ACPI_TYPE_STRING) {
 		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
+		if (strncmp(model->string.pointer, "L3D", 3) == 0)
+			hotk->model = L3D;
+		else if (strncmp(model->string.pointer, "L3H", 3) == 0 ||
+		         strncmp(model->string.pointer, "L2E", 3) == 0)
+			hotk->model = L3H;
+		else if (strncmp(model->string.pointer, "L3", 2) == 0 ||
+			 strncmp(model->string.pointer, "L2B", 3) == 0)
+			hotk->model = L3C;
+		else if (strncmp(model->string.pointer, "L8L", 3) == 0)
+			hotk->model = L8L;
+		else if (strncmp(model->string.pointer, "L4R", 3) == 0)
+			hotk->model = L4R;
+		else if (strncmp(model->string.pointer, "M6N", 3) == 0)
+			hotk->model = M6N;
+		else if (strncmp(model->string.pointer, "M6R", 3) == 0)
+			hotk->model = M6R;
+		else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
+		         strncmp(model->string.pointer, "M3N", 3) == 0 ||
+		         strncmp(model->string.pointer, "M5N", 3) == 0 ||
+		         strncmp(model->string.pointer, "M6N", 3) == 0 ||
+		         strncmp(model->string.pointer, "S1N", 3) == 0 ||
+		         strncmp(model->string.pointer, "S5N", 3) == 0 ||
+		         strncmp(model->string.pointer, "W1N", 3) == 0)
+			hotk->model = xxN;
+		else if (strncmp(model->string.pointer, "M1", 2) == 0)
+			hotk->model = M1A;
+		else if (strncmp(model->string.pointer, "M2", 2) == 0 ||
+		         strncmp(model->string.pointer, "L4E", 3) == 0)
+			hotk->model = M2E;
+		else if (strncmp(model->string.pointer, "L2", 2) == 0)
+			hotk->model = L2D;
+		else if (strncmp(model->string.pointer, "L8", 2) == 0)
+			hotk->model = S1x;
+		else if (strncmp(model->string.pointer, "D1", 2) == 0)
+			hotk->model = D1x;
+		else if (strncmp(model->string.pointer, "A1", 2) == 0)
+			hotk->model = A1x;
+		else if (strncmp(model->string.pointer, "A2", 2) == 0)
+			hotk->model = A2x;
+		else if (strncmp(model->string.pointer, "J1", 2) == 0)
+			hotk->model = S2x;
+		else if (strncmp(model->string.pointer, "L5", 2) == 0)
+			hotk->model = L5x;
 	}
 
-	hotk->model = END_MODEL;
-	if (strncmp(model->string.pointer, "L3D", 3) == 0)
-		hotk->model = L3D;
-	else if (strncmp(model->string.pointer, "L3H", 3) == 0 ||
-		 strncmp(model->string.pointer, "L2E", 3) == 0)
-		hotk->model = L3H;
-	else if (strncmp(model->string.pointer, "L3", 2) == 0 ||
-		 strncmp(model->string.pointer, "L2B", 3) == 0)
-		hotk->model = L3C;
-	else if (strncmp(model->string.pointer, "L8L", 3) == 0)
-		hotk->model = L8L;
-	else if (strncmp(model->string.pointer, "L4R", 3) == 0)
-		hotk->model = L4R;
-	else if (strncmp(model->string.pointer, "M6N", 3) == 0)
-		hotk->model = M6N;
-	else if (strncmp(model->string.pointer, "M6R", 3) == 0)
-		hotk->model = M6R;
-	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
-		 strncmp(model->string.pointer, "M3N", 3) == 0 ||
-		 strncmp(model->string.pointer, "M5N", 3) == 0 ||
-		 strncmp(model->string.pointer, "M6N", 3) == 0 ||
-		 strncmp(model->string.pointer, "S1N", 3) == 0 ||
-		 strncmp(model->string.pointer, "S5N", 3) == 0 ||
-                 strncmp(model->string.pointer, "W1N", 3) == 0)
-		hotk->model = xxN;
-	else if (strncmp(model->string.pointer, "M1", 2) == 0)
-		hotk->model = M1A;
-	else if (strncmp(model->string.pointer, "M2", 2) == 0 ||
-		 strncmp(model->string.pointer, "L4E", 3) == 0)
-		hotk->model = M2E;
-	else if (strncmp(model->string.pointer, "L2", 2) == 0)
-		hotk->model = L2D;
-	else if (strncmp(model->string.pointer, "L8", 2) == 0)
-		hotk->model = S1x;
-	else if (strncmp(model->string.pointer, "D1", 2) == 0)
-		hotk->model = D1x;
-	else if (strncmp(model->string.pointer, "A1", 2) == 0)
-		hotk->model = A1x;
-	else if (strncmp(model->string.pointer, "A2", 2) == 0)
-		hotk->model = A2x;
-	else if (strncmp(model->string.pointer, "J1", 2) == 0)
-		hotk->model = S2x;
-	else if (strncmp(model->string.pointer, "L5", 2) == 0)
-		hotk->model = L5x;
-
 	if (hotk->model == END_MODEL) {
 		printk("unsupported, trying default values, supply the "
 		       "developers with your DSDT\n");


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
