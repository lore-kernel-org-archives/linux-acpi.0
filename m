From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [stable] Re: [patch 1/1] acpi: fix asus_acpi on Samsung P30/P35
Date: Sun, 15 Jan 2006 02:42:11 +0100
Message-ID: <20060115014211.GA27306@hell.org.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B30059658DB@hdsmsx401.amr.corp.intel.com> <20060104163729.GA6533@hell.org.pl> <20060105014707.GE3335@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060105014707.GE3335-HBBaT/yk5SZXd/9EBkU14x2eb7JE58TQ@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Greek0-hi6Y0CQ0nG0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Chris Wright:
> > > The only question is what to do for 2.6.14/15 stable.
> > > A. apply this patch after it is tested in 2.6.16?
> > > B. wait for an update to replace this patch?
> > Ugh, 5 am is not exactly the best time to sound clear and concise. What I
> > meant was, in short:
> > 1. The patch applied to acpi-test is sufficient for stable (i.e. 2.6.15.x).
> > 2. I will provide another patch for acpi-test with my next batch of
> >    updates. These will go into 2.6.16, .17 or whatever. Until this time,
> >    however, the patch supplied stays at acpi-test.
> Any reason not to push the current one up, instead of keeping an interim
> patch that is in stable and acpi-test, but nowhere else?  For -stable we
> prefer things that are upstream (i.e. reasonably well-tested).

Because:
1. Prior to this day, the patch didn't exist,
2. The new patch has absolutely no functional advantage over the old one
   (i.e. the one Len applied to acpi-test) except for making new model
   support easier (and I believe new model support is not the right place
   for -stable) and the code slightly more robust,
3. The patch involves moving some code around (the diff is ugly) and is, in
   comparison to the old one, non-trivial.

Anyway, I'm inlining the new patch, not for inclusion (it will only apply
against acpi4asus CVS anyway), but just for you to see how it's gonna look
like. If you still prefer this one over the other, I'll rebase it against
2.6.15.

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


Index: asus_core.c
===================================================================
RCS file: /cvsroot/acpi4asus/acpi4asus/driver/asus_core.c,v
retrieving revision 1.119
diff -u -r1.119 asus_core.c
--- asus_core.c	11 Jan 2006 00:01:30 -0000	1.119
+++ asus_core.c	15 Jan 2006 00:00:30 -0000
@@ -1043,6 +1043,69 @@
 }
 
 /*
+ * Match the model string to the list of supported models. Return END_MODEL if
+ * no match or model is NULL.
+ */
+static int __init asus_model_match(char *model)
+{
+	if (model == NULL)
+		return END_MODEL;
+
+	if (strncmp(model, "L3D", 3) == 0)
+		return L3D;
+	else if (strncmp(model, "L2E", 3) == 0 ||
+		 strncmp(model, "L3H", 3) == 0 ||
+		 strncmp(model, "L5D", 3) == 0)
+		return L3H;
+	else if (strncmp(model, "L3", 2) == 0 ||
+		 strncmp(model, "L2B", 3) == 0)
+		return L3C;
+	else if (strncmp(model, "L8L", 3) == 0)
+		return L8L;
+	else if (strncmp(model, "L4R", 3) == 0)
+		return L4R;
+	else if (strncmp(model, "M6N", 3) == 0 ||
+		 strncmp(model, "W3N", 3) == 0)
+		return M6N;
+	else if (strncmp(model, "M6R", 3) == 0 ||
+	         strncmp(model, "A3G", 3) == 0)
+		return M6R;
+	else if (strncmp(model, "M2N", 3) == 0 ||
+		 strncmp(model, "M3N", 3) == 0 ||
+		 strncmp(model, "M5N", 3) == 0 ||
+		 strncmp(model, "M6N", 3) == 0 ||
+		 strncmp(model, "S1N", 3) == 0 ||
+		 strncmp(model, "S5N", 3) == 0 ||
+                 strncmp(model, "W1N", 3) == 0)
+		return xxN;
+	else if (strncmp(model, "M1", 2) == 0)
+		return M1A;
+	else if (strncmp(model, "M2", 2) == 0 ||
+		 strncmp(model, "L4E", 3) == 0)
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
+ 	else if (strncmp(model, "W5A", 3) == 0)
+ 		return W5A;
+	else
+		return END_MODEL;
+}
+
+/*
  * This function is used to initialize the hotk with right values. In this
  * method, we can make all the detection we want, and modify the hotk struct
  */
@@ -1052,6 +1115,7 @@
 	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *model = NULL;
 	int bsts_result;
+	char *string = NULL;
 	acpi_status status;
 
 	/*
@@ -1080,110 +1144,65 @@
 	else if (bsts_result)
 		printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n", bsts_result);
 
-	if (buffer.pointer == NULL)
-		return -EINVAL;
-	model = (union acpi_object *) buffer.pointer;
-
-	/* Samsung P30 has a device with a valid _HID whose INIT does not 
-	 * return anything. Catch this one and any similar here */
-	if (model->type == ACPI_TYPE_STRING) {
-		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
-	} else {
-		if (asus_info && /* Samsung P30 */
+	/*
+	 * Try to match the object returned by INIT to the specific model.
+	 * Handle every possible object (or the lack of thereof) the DSDT 
+	 * writers might throw at us. When in trouble, we pass NULL to 
+	 * asus_model_match() and try something completely different.
+	 */
+	if (buffer.pointer) {
+		model = (union acpi_object *) buffer.pointer;
+		switch (model->type) {
+			case ACPI_TYPE_STRING:
+				string = model->string.pointer;
+				break;
+			case ACPI_TYPE_BUFFER:
+				string = model->buffer.pointer;
+				break;
+			default:
+				acpi_os_free(model);
+				break;
+		}
+	}
+	hotk->model = asus_model_match(string);
+	if (hotk->model == END_MODEL) { /* match failed */
+		if (asus_info &&
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {
 			hotk->model = P30;
-			printk(KERN_NOTICE "  Samsung P30 detected, supported\n");
+			printk(KERN_NOTICE
+			       "  Samsung P30 detected, supported\n");
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
-	         strncmp(model->string.pointer, "A3G", 3) == 0)
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
-	else if (strncmp(model->string.pointer, "A4G", 3) == 0)
-		hotk->model = A4G;
- 	else if (strncmp(model->string.pointer, "W5A", 3) == 0)
- 		hotk->model = W5A;
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
 	/* S5N and M5N have no MLED */
-	else if (strncmp(model->string.pointer, "L5D", 3) == 0) 
+	else if (strncmp(string, "L5D", 3) == 0) 
 		hotk->methods->mt_wled = NULL;
 	/* L5D's WLED is not controlled by ACPI */
-	else if (strncmp(model->string.pointer, "M2N", 3) == 0) 
+	else if (strncmp(string, "M2N", 3) == 0) 
 		hotk->methods->mt_wled = "WLED";
-	else if (strncmp(model->string.pointer, "W1N", 3) == 0) {
+	else if (strncmp(string, "W1N", 3) == 0) {
                 hotk->methods->mt_wled = "WLED";
                 hotk->methods->mt_ledd = "SLCM";
 	}
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
