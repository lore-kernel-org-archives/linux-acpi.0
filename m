From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Fri, 5 Mar 2004 12:39:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040305113921.GS2869@poupinou.org>
References: <404459FD.1000406@pca.it> <20040302110946.GF2869@poupinou.org> <40448169.6090507@pca.it> <40449D8E.4060402@pca.it> <20040303103528.GG2869@poupinou.org> <40463D80.8040800@pca.it> <20040304111240.GN2869@poupinou.org> <404734E8.7080104@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <404734E8.7080104-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 04, 2004 at 02:53:44PM +0100, Luca Capello wrote:
> 
> Hello,
> 
> no problem, I forgot to advise you that I can make all the necessary tests to
> bring my new laptop to a completely ACPI working system :-)

Thanks!

> 
> > I think also that the bios will only allow C2, not C3 nor C4 if you are on AC.
> You're right, but even on battery I get only C1 & C2 (as from the attached).

Well, there is a stupid bug, I guess.

--- linux-2.6-bk/drivers/acpi/processor.c	2004/03/05 11:14:06	1.3
+++ linux-2.6-bk/drivers/acpi/processor.c	2004/03/05 11:25:58
@@ -666,7 +666,7 @@ acpi_processor_get_power_info_cst (
 	/* Get all power states */
 
 	/* Note that C0 and C1 are filled already by our caller. */
-	pr->power.count = 2;
+	pr->power.count = 1;
 	for (i = 1; i <= count; i++) {
 		union acpi_object *element;
 		union acpi_object *obj;
@@ -816,13 +816,10 @@ acpi_processor_get_power_info_cst (
 		/* All check done.  Register this power state. */
 		cx.valid = 1;
 		cx.latency_ticks = US_TO_PM_TIMER_TICKS(cx.latency);
-		memcpy(&(pr->power.states[pr->power.count]), &cx, sizeof(cx));
 		(pr->power.count)++;
+		memcpy(&(pr->power.states[pr->power.count]), &cx, sizeof(cx));
 	}
 
-	/* adjust count. */
-	(pr->power.count)--;
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d power states\n", pr->power.count));
 
 	/* Validate number of power states */
--- linux-2.6-bk/include/acpi/processor.h	2004/03/05 11:26:48	1.2
+++ linux-2.6-bk/include/acpi/processor.h	2004/03/05 11:27:39
@@ -5,7 +5,7 @@
 
 #define ACPI_PROCESSOR_BUSY_METRIC	10
 
-#define ACPI_PROCESSOR_MAX_POWER	ACPI_C_STATE_COUNT
+#define ACPI_PROCESSOR_MAX_POWER	8
 #define ACPI_PROCESSOR_MAX_C2_LATENCY	100
 #define ACPI_PROCESSOR_MAX_C3_LATENCY	1000
 

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
