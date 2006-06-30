From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 8/10] rework model detection
Date: Sat, 1 Jul 2006 01:11:22 +0200
Message-ID: <20060630231122.GJ31642@hell.org.pl>
References: <20060118212110.GA7199@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:17668 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1751567AbWF3XLZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 19:11:25 -0400
Content-Disposition: inline
In-Reply-To: <20060630225905.GB31642@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This patch reworks laptop model detection.

This addresses the Samsung P30 issue, where the INIT method would return no
object, but the implicit return in the AML interpreter would confuse the
driver. It also accounts for a newer batch of Asus models whose INIT
returns ACPI_TYPE_BUFFER instead of STRING.

The handling is now much leaner, if we get a buffer or a string, we check
against known values, in every other case we use a different path
(currently DSDT signatures). The bulk of this patch is separating the
string matching from asus_hotk_get_info() into a separate function.

This patch properly fixes http://bugme.osdl.org/show_bug.cgi?id=5067 and
http://bugme.osdl.org/show_bug.cgi?id=5092 and makes the driver fully
functional again with acpi=strict on all machines.

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/asus_acpi.c	2006-01-18 18:10:40.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2006-01-18 18:20:11.000000000 +0100
@@ -1048,6 +1048,65 @@ static void asus_hotk_notify(acpi_handle
 }
 
 /*
+ * Match the model string to the list of supported models. Return END_MODEL if
+ * no match or model is NULL.
+ */
+static int asus_model_match(char *model)
+{
+	if (model == NULL)
+		return END_MODEL;
+
+	if (strncmp(model, "L3D", 3) == 0)
+		return L3D;
+	else if (strncmp(model, "L2E", 3) == 0 ||
+		 strncmp(model, "L3H", 3) == 0 || strncmp(model, "L5D", 3) == 0)
+		return L3H;
+	else if (strncmp(model, "L3", 2) == 0 || strncmp(model, "L2B", 3) == 0)
+		return L3C;
+	else if (strncmp(model, "L8L", 3) == 0)
+		return L8L;
+	else if (strncmp(model, "L4R", 3) == 0)
+		return L4R;
+	else if (strncmp(model, "M6N", 3) == 0 || strncmp(model, "W3N", 3) == 0)
+		return M6N;
+	else if (strncmp(model, "M6R", 3) == 0 || strncmp(model, "A3G", 3) == 0)
+		return M6R;
+	else if (strncmp(model, "M2N", 3) == 0 ||
+		 strncmp(model, "M3N", 3) == 0 ||
+		 strncmp(model, "M5N", 3) == 0 ||
+		 strncmp(model, "M6N", 3) == 0 ||
+		 strncmp(model, "S1N", 3) == 0 ||
+		 strncmp(model, "S5N", 3) == 0 || strncmp(model, "W1N", 3) == 0)
+		return xxN;
+	else if (strncmp(model, "M1", 2) == 0)
+		return M1A;
+	else if (strncmp(model, "M2", 2) == 0 || strncmp(model, "L4E", 3) == 0)
+		return M2E;
+	else if (strncmp(model, "L2", 2) == 0)
+		return L2D;
+	else if (strncmp(model, "L8", 2) == 0)
+		return S1x;
+	else if (strncmp(model, "D1", 2) == 0)
+		return D1x;
+	else if (strncmp(model, "A1", 2) == 0)
+		return A1x;
+	else if (strncmp(model, "A2", 2) == 0)
+		return A2x;
+	else if (strncmp(model, "J1", 2) == 0)
+		return S2x;
+	else if (strncmp(model, "L5", 2) == 0)
+		return L5x;
+	else if (strncmp(model, "A4G", 3) == 0)
+		return A4G;
+	else if (strncmp(model, "W1N", 3) == 0)
+		return W1N;
+	else if (strncmp(model, "W5A", 3) == 0)
+		return W5A;
+	else
+		return END_MODEL;
+}
+
+/*
  * This function is used to initialize the hotk with right values. In this
  * method, we can make all the detection we want, and modify the hotk struct
  */
@@ -1057,6 +1116,7 @@ static int __init asus_hotk_get_info(voi
 	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *model = NULL;
 	int bsts_result;
+	char *string = NULL;
 	acpi_status status;
 
 	/*
@@ -1086,120 +1146,63 @@ static int __init asus_hotk_get_info(voi
 		printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n",
 		       bsts_result);
 
-	/* This is unlikely with implicit return */
-	if (buffer.pointer == NULL)
-		return -EINVAL;
-
-	model = (union acpi_object *)buffer.pointer;
 	/*
-	 * Samsung P30 has a device with a valid _HID whose INIT does not 
-	 * return anything. It used to be possible to catch this exception,
-	 * but the implicit return code will now happily confuse the 
-	 * driver. We assume that every ACPI_TYPE_STRING is a valid model
-	 * identifier but it's still possible to get completely bogus data.
+	 * Try to match the object returned by INIT to the specific model.
+	 * Handle every possible object (or the lack of thereof) the DSDT 
+	 * writers might throw at us. When in trouble, we pass NULL to 
+	 * asus_model_match() and try something completely different.
 	 */
-	if (model->type == ACPI_TYPE_STRING) {
-		printk(KERN_NOTICE "  %s model detected, ",
-		       model->string.pointer);
-	} else {
-		if (asus_info &&	/* Samsung P30 */
+	if (buffer.pointer) {
+		model = (union acpi_object *)buffer.pointer;
+		switch (model->type) {
+		case ACPI_TYPE_STRING:
+			string = model->string.pointer;
+			break;
+		case ACPI_TYPE_BUFFER:
+			string = model->buffer.pointer;
+			break;
+		default:
+			kfree(model);
+			break;
+		}
+	}
+	hotk->model = asus_model_match(string);
+	if (hotk->model == END_MODEL) {	/* match failed */
+		if (asus_info &&
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {
 			hotk->model = P30;
 			printk(KERN_NOTICE
 			       "  Samsung P30 detected, supported\n");
 		} else {
 			hotk->model = M2E;
-			printk(KERN_WARNING "  no string returned by INIT\n");
-			printk(KERN_WARNING "  trying default values, supply "
-			       "the developers with your DSDT\n");
+			printk(KERN_NOTICE "  unsupported model %s, trying "
+			       "default values\n", string);
+			printk(KERN_NOTICE
+			       "  send /proc/acpi/dsdt to the developers\n");
 		}
 		hotk->methods = &model_conf[hotk->model];
-
-		kfree(model);
-
 		return AE_OK;
 	}
-
-	hotk->model = END_MODEL;
-	if (strncmp(model->string.pointer, "L3D", 3) == 0)
-		hotk->model = L3D;
-	else if (strncmp(model->string.pointer, "L2E", 3) == 0 ||
-		 strncmp(model->string.pointer, "L3H", 3) == 0 ||
-		 strncmp(model->string.pointer, "L5D", 3) == 0)
-		hotk->model = L3H;
-	else if (strncmp(model->string.pointer, "L3", 2) == 0 ||
-		 strncmp(model->string.pointer, "L2B", 3) == 0)
-		hotk->model = L3C;
-	else if (strncmp(model->string.pointer, "L8L", 3) == 0)
-		hotk->model = L8L;
-	else if (strncmp(model->string.pointer, "L4R", 3) == 0)
-		hotk->model = L4R;
-	else if (strncmp(model->string.pointer, "M6N", 3) == 0 ||
-		 strncmp(model->string.pointer, "W3N", 3) == 0)
-		hotk->model = M6N;
-	else if (strncmp(model->string.pointer, "M6R", 3) == 0 ||
-		 strncmp(model->string.pointer, "A3G", 3) == 0)
-		hotk->model = M6R;
-	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
-		 strncmp(model->string.pointer, "M3N", 3) == 0 ||
-		 strncmp(model->string.pointer, "M5N", 3) == 0 ||
-		 strncmp(model->string.pointer, "M6N", 3) == 0 ||
-		 strncmp(model->string.pointer, "S1N", 3) == 0 ||
-		 strncmp(model->string.pointer, "S5N", 3) == 0)
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
-	else if (strncmp(model->string.pointer, "A4G", 3) == 0)
-		hotk->model = A4G;
-	else if (strncmp(model->string.pointer, "W1N", 3) == 0)
-		hotk->model = W1N;
-	else if (strncmp(model->string.pointer, "W5A", 3) == 0)
-		hotk->model = W5A;
-
-	if (hotk->model == END_MODEL) {
-		printk("unsupported, trying default values, supply the "
-		       "developers with your DSDT\n");
-		hotk->model = M2E;
-	} else {
-		printk("supported\n");
-	}
-
 	hotk->methods = &model_conf[hotk->model];
+	printk(KERN_NOTICE "  %s model detected, supported\n", string);
 
 	/* Sort of per-model blacklist */
-	if (strncmp(model->string.pointer, "L2B", 3) == 0)
+	if (strncmp(string, "L2B", 3) == 0)
 		hotk->methods->lcd_status = NULL;
 	/* L2B is similar enough to L3C to use its settings, with this only 
 	   exception */
-	else if (strncmp(model->string.pointer, "A3G", 3) == 0)
+	else if (strncmp(string, "A3G", 3) == 0)
 		hotk->methods->lcd_status = "\\BLFG";
 	/* A3G is like M6R */
-	else if (strncmp(model->string.pointer, "S5N", 3) == 0 ||
-		 strncmp(model->string.pointer, "M5N", 3) == 0 ||
-		 strncmp(model->string.pointer, "W3N", 3) == 0)
+	else if (strncmp(string, "S5N", 3) == 0 ||
+		 strncmp(string, "M5N", 3) == 0 ||
+		 strncmp(string, "W3N", 3) == 0)
 		hotk->methods->mt_mled = NULL;
 	/* S5N, M5N and W3N have no MLED */
-	else if (strncmp(model->string.pointer, "L5D", 3) == 0)
+	else if (strncmp(string, "L5D", 3) == 0)
 		hotk->methods->mt_wled = NULL;
 	/* L5D's WLED is not controlled by ACPI */
-	else if (strncmp(model->string.pointer, "M2N", 3) == 0)
+	else if (strncmp(string, "M2N", 3) == 0)
 		hotk->methods->mt_wled = "WLED";
 	/* M2N has a usable WLED */
 	else if (asus_info) {
