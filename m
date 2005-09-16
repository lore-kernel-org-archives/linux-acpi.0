From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: PATCH default C1
Date: Fri, 16 Sep 2005 21:03:36 +0200
Message-ID: <432B1708.4060403@tzi.de>
References: <432697CC.3020201@tzi.de> <20050913180219.GB9572@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020201020700080500050509"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050913180219.GB9572-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020201020700080500050509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Same patch with corrected codestyle,
please test and apply
     Janosch

Dominik Brodowski wrote:
>>+		/* We support up to ACPI_PROCESSOR_MAX_POWER. */
>>+		if (pr->power.count >= ACPI_PROCESSOR_MAX_POWER) {
>>+		printk(KERN_WARNING "Limiting number of power states to max (%d)\n", ACPI_PROCESSOR_MAX_POWER);
>>+		printk(KERN_WARNING "Please increase ACPI_PROCESSOR_MAX_POWER if needed.\n");
>>+		break;
>>+		}
> 
> 
> broken indent
> 
> 
>>+			if (cx->valid) {
>>+			  /*
>>+			   *  mark this CPU as being "idle manageable"
>>+			   */
>>+			  pr->flags.power = 1;
>>+			}
> 
> 
> same here.
> 
> 	Dominik

--------------020201020700080500050509
Content-Type: text/plain;
 name="mypatch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mypatch.patch"

--- linux-2.6.13/drivers/acpi/processor_idle.c	2005-09-02 21:49:32.000000000 +0200
+++ linux-2.6.13-patch/drivers/acpi/processor_idle.c	2005-09-14 17:16:13.000000000 +0200
@@ -513,20 +513,16 @@
 
 	if (!pr->pblk)
 		return_VALUE(-ENODEV);
-
-	for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
-		memset(pr->power.states, 0, sizeof(struct acpi_processor_cx));
+	
+	/* We got C0 an C1 by default starting at 2 */
+	for (i = 2; i < ACPI_PROCESSOR_MAX_POWER; i++)
+		memset(&(pr->power.states[i]), 0, 
+		       sizeof(struct acpi_processor_cx));
 
 	/* if info is obtained from pblk/fadt, type equals state */
-	pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
 	pr->power.states[ACPI_STATE_C2].type = ACPI_STATE_C2;
 	pr->power.states[ACPI_STATE_C3].type = ACPI_STATE_C3;
 
-	/* the C0 state only exists as a filler in our array,
-	 * and all processors need to support C1 */
-	pr->power.states[ACPI_STATE_C0].valid = 1;
-	pr->power.states[ACPI_STATE_C1].valid = 1;
-
 	/* determine C2 and C3 address from pblk */
 	pr->power.states[ACPI_STATE_C2].address = pr->pblk + 4;
 	pr->power.states[ACPI_STATE_C3].address = pr->pblk + 5;
@@ -554,10 +550,8 @@
 		memset(&(pr->power.states[i]), 0, 
 		       sizeof(struct acpi_processor_cx));
 
-	/* if info is obtained from pblk/fadt, type equals state */
+	/* set the first C-State to C1 */
 	pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
-	pr->power.states[ACPI_STATE_C2].type = ACPI_STATE_C2;
-	pr->power.states[ACPI_STATE_C3].type = ACPI_STATE_C3;
 
 	/* the C0 state only exists as a filler in our array,
 	 * and all processors need to support C1 */
@@ -581,8 +575,11 @@
 	if (nocst)
 		return_VALUE(-ENODEV);
 
-	pr->power.count = 0;
-	for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
+	/*We allready have C1 */
+	pr->power.count = 1;
+	
+	/* We don't want to delete C0 and C1 so we start at 2 */
+	for (i = 2; i < ACPI_PROCESSOR_MAX_POWER; i++)
 		memset(&(pr->power.states[i]), 0, 
 		       sizeof(struct acpi_processor_cx));
 
@@ -610,13 +607,6 @@
 		goto end;
 	}
 
-	/* We support up to ACPI_PROCESSOR_MAX_POWER. */
-	if (count > ACPI_PROCESSOR_MAX_POWER) {
-		printk(KERN_WARNING "Limiting number of power states to max (%d)\n", ACPI_PROCESSOR_MAX_POWER);
-		printk(KERN_WARNING "Please increase ACPI_PROCESSOR_MAX_POWER if needed.\n");
-		count = ACPI_PROCESSOR_MAX_POWER;
-	}
-
 	/* Tell driver that at least _CST is supported. */
 	pr->flags.has_cst = 1;
 
@@ -660,7 +650,8 @@
 		    (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO))
 			continue;
 
-		if ((cx.type < ACPI_STATE_C1) ||
+		/* We got C1 by default, so we only accept C2 and C3 states */
+		if ((cx.type < ACPI_STATE_C2) ||
 		    (cx.type > ACPI_STATE_C3))
 			continue;
 
@@ -678,6 +669,13 @@
 
 		(pr->power.count)++;
 		memcpy(&(pr->power.states[pr->power.count]), &cx, sizeof(cx));
+
+		/* We support up to ACPI_PROCESSOR_MAX_POWER. */
+		if (pr->power.count >= ACPI_PROCESSOR_MAX_POWER) {
+		        printk(KERN_WARNING "Limiting number of power states to max (%d)\n", ACPI_PROCESSOR_MAX_POWER);
+			printk(KERN_WARNING "Please increase ACPI_PROCESSOR_MAX_POWER if needed.\n");
+			break;
+		}
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d power states\n", pr->power.count));
@@ -796,6 +794,11 @@
 	 */
 	cx->valid = 1;
 	cx->latency_ticks = US_TO_PM_TIMER_TICKS(cx->latency);
+	
+	/*
+	 *  mark this CPU as being "idle manageable"
+	 */
+	pr->flags.power = 1;
 
 	return_VOID;
 }
@@ -806,16 +809,19 @@
 	unsigned int i;
 	unsigned int working = 0;
 
-	for (i=1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+	/* C1 is allways valid, starting at 2 */
+	for (i=2; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		struct acpi_processor_cx *cx = &pr->power.states[i];
 
 		switch (cx->type) {
-		case ACPI_STATE_C1:
-			cx->valid = 1;
-			break;
-
 		case ACPI_STATE_C2:
 			acpi_processor_power_verify_c2(cx);
+			if (cx->valid) {
+			        /*
+				 *  mark this CPU as being "idle manageable"
+				 */
+			        pr->flags.power = 1;
+			}
 			break;
 
 		case ACPI_STATE_C3:
@@ -833,19 +839,19 @@
 static int acpi_processor_get_power_info (
 	struct acpi_processor	*pr)
 {
-	unsigned int i;
 	int result;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_get_power_info");
 
 	/* NOTE: the idle thread may not be running while calling
 	 * this function */
-
+	
+	/* Adding C1 state */
+	acpi_processor_get_power_info_default_c1(pr);
 	result = acpi_processor_get_power_info_cst(pr);
-	if ((result) || (acpi_processor_power_verify(pr) < 2)) {
+	if ((result) || (!acpi_processor_power_verify(pr))) {
 		result = acpi_processor_get_power_info_fadt(pr);
-		if ((result) || (acpi_processor_power_verify(pr) < 2))
-			result = acpi_processor_get_power_info_default_c1(pr);
+		acpi_processor_power_verify(pr);
 	}
 
 	/*
@@ -860,17 +866,6 @@
 	if (result)
 		return_VALUE(result);
 
-	/*
-	 * if one state of type C2 or C3 is available, mark this
-	 * CPU as being "idle manageable"
-	 */
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
-		if (pr->power.states[i].valid) {
-			pr->power.count = i;
-			pr->flags.power = 1;
-		}
-	}
-
 	return_VALUE(0);
 }
 

--------------020201020700080500050509--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
