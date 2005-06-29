From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Wed, 29 Jun 2005 17:50:15 +0200
Message-ID: <20050629155015.GB14659@hell.org.pl>
References: <20050618004506.GE3690@orest.greek0.net> <20050629111044.GA2910@hell.org.pl> <42C2BA01.2060806@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42C2BA01.2060806-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, Hanno =?iso-8859-2?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Carl-Daniel Hailfinger:
>> Bob, is the implicit return code supposed to trigger also when using
>> acpi_evaluate_object()? FYI, this is what we currently do:
>> 
>> write_acpi_int(hotk->handle, "INIT", 0, &buffer) (drivers/acpi/asus_acpi.c)
>> 
>> which is fine if the INIT method returns a string (the usual), but
>> apparently not if there is no return statement in the method (the P30
>> case). The old code assumed the buffer will be null in this case.
>> 
>> Is that a bug in the ACPICA or should the asus_acpi code cover for other
>> cases of buffer.type?
> 
> Will the fix for this be submitted to stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org? I can't upgrade
> to 2.6.12.1 because of this oops.

This should fix ya for now, but I can't sign it off until I get a comment
from Bob.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


--- linux-2.6.12/drivers/acpi/asus_acpi.c~	2005-06-29 17:37:29.000000000 +0200
+++ linux-2.6.12/drivers/acpi/asus_acpi.c	2005-06-29 17:45:53.000000000 +0200
@@ -990,9 +990,15 @@
 	else if (bsts_result)
 		printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n", bsts_result);
 
+	if (buffer.pointer == NULL)
+		return -EINVAL;
+	model = (union acpi_object *) buffer.pointer;
+
 	/* Samsung P30 has a device with a valid _HID whose INIT does not 
 	 * return anything. Catch this one and any similar here */
-	if (buffer.pointer == NULL) {
+	if (model->type == ACPI_TYPE_STRING) {
+		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
+	} else {
 		if (asus_info && /* Samsung P30 */
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {
 			hotk->model = P30;
@@ -1007,11 +1013,6 @@
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
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
