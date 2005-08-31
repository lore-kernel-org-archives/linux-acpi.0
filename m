From: akpm-3NddpPZAyC0@public.gmane.org
Subject: asus_acpi-m6000a-model-support.patch added to -mm tree
Date: Wed, 31 Aug 2005 14:30:36 -0700
Message-ID: <200508312128.j7VLS8nq000815@shell0.pdx.osdl.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: xhejtman-IGZnsrowxP9fmBTHTHKXmQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The patch titled

     asus_acpi M6000A model support

has been added to the -mm tree.  Its filename is

     asus_acpi-m6000a-model-support.patch

Patches currently in -mm which might be from xhejtman-IGZnsrowxP9fmBTHTHKXmQ@public.gmane.org are

asus_acpi-m6000a-model-support.patch



From: Lukas Hejtmanek <xhejtman-IGZnsrowxP9fmBTHTHKXmQ@public.gmane.org>

Here is a patch for Asus M6A laptop support. It works fine for me.

Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/asus_acpi.c |   52 ++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 40 insertions(+), 12 deletions(-)

diff -puN drivers/acpi/asus_acpi.c~asus_acpi-m6000a-model-support drivers/acpi/asus_acpi.c
--- 25/drivers/acpi/asus_acpi.c~asus_acpi-m6000a-model-support	Wed Aug 31 14:30:15 2005
+++ 25-akpm/drivers/acpi/asus_acpi.c	Wed Aug 31 14:30:15 2005
@@ -128,6 +128,7 @@ struct asus_hotk {
 		L8L,      //L8400L
 		M1A,      //M1300A
 		M2E,      //M2400E, L4400L
+		M6A,      //M6000A
 		M6N,      //M6800N
 		M6R,      //M6700R
 		P30,	  //Samsung P30
@@ -304,7 +305,20 @@ static struct model_data model_conf[END_
 		.display_set       = "SDSP",
 		.display_get       = "\\INFB"
 	},
-
+	{
+		.name              = "M6A",
+		/* M6A does not have MLED */
+		.mt_wled           = "WLED",
+		.mt_lcd_switch     = xxN_PREFIX "_Q10",
+		.lcd_status        = "\\RGPL",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.display_set       = "SDSP",
+		/* FIXME: this is not correct display_get.
+		 * It always returns 1 
+		 * */
+		.display_get       = "\\ADVG"
+	},
 	{
 		.name              = "M6N",
 		.mt_mled           = "MLED",
@@ -622,7 +636,7 @@ static int get_lcd_state(void)
 {
 	int lcd = 0;
 
-	if (hotk->model != L3H) {
+	if (hotk->model != L3H && hotk->model != M6A) {
 	/* We don't have to check anything if we are here */
 		if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
 			printk(KERN_WARNING "Asus ACPI: Error reading LCD status\n");
@@ -638,22 +652,33 @@ static int get_lcd_state(void)
 		
 		input.count = 2;
 		input.pointer = mt_params;
-		/* Note: the following values are partly guessed up, but 
-		   otherwise they seem to work */
 		mt_params[0].type = ACPI_TYPE_INTEGER;
-		mt_params[0].integer.value = 0x02;
 		mt_params[1].type = ACPI_TYPE_INTEGER;
-		mt_params[1].integer.value = 0x02;
+		if(hotk->model == L3H) {
+			/* Note: the following values are partly guessed up, 
+			 * but otherwise they seem to work */
+			mt_params[0].integer.value = 0x02;
+			mt_params[1].integer.value = 0x02;
+		} else if(hotk->model == M6A) {
+			mt_params[0].integer.value = 0x15;
+			mt_params[1].integer.value = 0x01;
+		}
 
 		output.length = sizeof(out_obj);
 		output.pointer = &out_obj;
 		
-		status = acpi_evaluate_object(NULL, hotk->methods->lcd_status, &input, &output);
+		status = acpi_evaluate_object(NULL, hotk->methods->lcd_status, 
+				&input, &output);
 		if (status != AE_OK)
 			return -1;
-		if (out_obj.type == ACPI_TYPE_INTEGER)
-			/* That's what the AML code does */
-			lcd = out_obj.integer.value >> 8;
+		if (out_obj.type == ACPI_TYPE_INTEGER) {
+			if(hotk->model== L3H) {
+				/* That's what the AML code does */
+				lcd = out_obj.integer.value >> 8;
+			} else if(hotk->model == M6A) {
+				lcd = out_obj.integer.value;
+			}
+		}
 	}
 	
 	return (lcd & 1);
@@ -1029,6 +1054,8 @@ static int __init asus_hotk_get_info(voi
 		hotk->model = M6N;
 	else if (strncmp(model->string.pointer, "M6R", 3) == 0)
 		hotk->model = M6R;
+	else if (strncmp(model->string.pointer, "M6A", 3) == 0)
+		hotk->model = M6A;
 	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
 		 strncmp(model->string.pointer, "M3N", 3) == 0 ||
 		 strncmp(model->string.pointer, "M5N", 3) == 0 ||
@@ -1058,8 +1085,9 @@ static int __init asus_hotk_get_info(voi
 		hotk->model = L5x;
 
 	if (hotk->model == END_MODEL) {
-		printk("unsupported, trying default values, supply the "
-		       "developers with your DSDT\n");
+		printk("unsupported model %s, trying default values, supply "
+		       "the developers with your DSDT\n", 
+		       model->string.pointer);
 		hotk->model = M2E;
 	} else {
 		printk("supported\n");
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
