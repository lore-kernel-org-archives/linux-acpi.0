From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH] Fix regression on Samsung P30 [was: Re: asus_acpi bugs]
Date: Wed, 14 Sep 2005 10:13:11 +0200
Message-ID: <20050914081311.GA3229@hell.org.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047FA08F@hdsmsx401.amr.corp.intel.com> <20050912201443.GA3320@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050912201443.GA3320-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Karol Kozimor:
> > >> http://bugzilla.kernel.org/show_bug.cgi?id=5067
> > >> http://bugzilla.kernel.org/show_bug.cgi?id=5092

OK, the previous patch just didn't work. Here's the original fix with
better comments. Please apply.

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>


--- a/drivers/acpi/asus_acpi.c	2005-09-12 21:39:47.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2005-09-12 21:37:41.000000000 +0200
@@ -990,9 +990,21 @@
 	else if (bsts_result)
 		printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n", bsts_result);
 
-	/* Samsung P30 has a device with a valid _HID whose INIT does not 
-	 * return anything. Catch this one and any similar here */
-	if (buffer.pointer == NULL) {
+	/* This is unlikely with implicit return */
+	if (buffer.pointer == NULL)
+		return -EINVAL;
+
+	model = (union acpi_object *) buffer.pointer;
+	/*
+	 * Samsung P30 has a device with a valid _HID whose INIT does not 
+	 * return anything. It used to be possible to catch this exception,
+	 * but the implicit return code will now happily confuse the 
+	 * driver. We assume that every ACPI_TYPE_STRING is a valid model
+	 * identifier but it's still possible to get completely bogus data.
+	 */
+	if (model->type == ACPI_TYPE_STRING) {
+		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
+	} else {
 		if (asus_info && /* Samsung P30 */
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {
 			hotk->model = P30;
@@ -1007,11 +1019,6 @@
 		return AE_OK;
 	}
 	
-	model = (union acpi_object *) buffer.pointer;
-	if (model->type == ACPI_TYPE_STRING) {
-		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
-	}
-
 	hotk->model = END_MODEL;
 	if (strncmp(model->string.pointer, "L3D", 3) == 0)
 		hotk->model = L3D;


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
