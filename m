From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Thu, 4 Mar 2004 12:12:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040304111240.GN2869@poupinou.org>
References: <404459FD.1000406@pca.it> <20040302110946.GF2869@poupinou.org> <40448169.6090507@pca.it> <40449D8E.4060402@pca.it> <20040303103528.GG2869@poupinou.org> <40463D80.8040800@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40463D80.8040800-wlebWZzHoyE@public.gmane.org>
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

On Wed, Mar 03, 2004 at 09:18:08PM +0100, Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> on 03/03/04 11:35, Bruno Ducrot wrote:
> > Thanks.  Sound like that I send only an half patch, sorry.
> nothing changed, well, I got one more error:
> =====
> acpi_processor-2490 [29] acpi_processor_get_inf: Invalid PBLK length [7]
> acpi_processor-0654 [31] acpi_processor_get_pow: Invalid _CST data
> ACPI: Processor [CPU1] (supports C1)
> =====
> 

Could you please try:

--- linux-2.6-bk/drivers/acpi/processor.c	2004/03/04 11:05:47	1.2
+++ linux-2.6-bk/drivers/acpi/processor.c	2004/03/04 11:09:21
@@ -649,8 +649,8 @@ acpi_processor_get_power_info_cst (
 
 	count = cst->package.elements[0].integer.value;
 
-	/* There must be at least 2 power states. */
-	if (count <= 1 || count != cst->package.count - 1) {
+	/* There must be at least one power state (some bios forgot C1), and validate count */
+	if (count < 1 || count != cst->package.count - 1) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _CST data\n"));
 		status = -EFAULT;
 		goto end;


I think also that the bios will only allow C2, not C3 nor C4 if you are on AC.

Could you then try on battery also?  Note that I have not implemented
yet the reevaluation of _CST in case of AC/battery switch...

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
