From: Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
Subject: Re: Using an external DSDT file with 2.4.19?
Date: 05 Sep 2002 14:02:54 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031248975.3371.3.camel@p2710>
References: <1031247708.3011.50.camel@jtsdell>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1031247708.3011.50.camel-gH4hS+xkl8U@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: John M Trostel <john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org>
Cc: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I just went through this on the weekend, here is what I did.

change the name of the newly compiled DSDT.hex file to acpi_dsdt.c and
place it in the kernel tree under ../drivers/acpi/tables.

Then apply the following patch:
***BEGIN***
--- /usr/src/linux-2.4.19-acpi-20020821/drivers/acpi/osl.c.orig	Sun Sep  1 11:16:04 2002
+++ /usr/src/linux-2.4.19-acpi-20020821/drivers/acpi/osl.c	Sun Sep  1 11:16:54 2002
@@ -70,6 +70,7 @@
 static OSD_HANDLER acpi_irq_handler = NULL;
 static void *acpi_irq_context = NULL;
 
+extern unsigned char AmlCode[];
 
 acpi_status
 acpi_os_initialize(void)
@@ -221,7 +222,10 @@
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;
 
-	*new_table = NULL;
+	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
+		*new_table = (acpi_table_header*)AmlCode;
+	else
+		*new_table = NULL;
 	return AE_OK;
 }
 
***END***

This worked very well for me with kernel 2.4.19.

Best Regards
- Troy





On Thu, 2002-09-05 at 13:41, John M Trostel wrote:
> I am now trying to use an external DSDT file (file.hex) to override what
> was written in the BIOS.  Unfortunately, I can't quite figure out how to
> get this file read rather than BIOS.  I see :
> 
>  http://www.cpqlinux.com/acpi-howto.html
> 
> but don't see how this will apply against the current 2.4.19 stuff.
> 
> -- 
> John M. Trostel
> Senior Software Engineer
> Quantum Corp.
> john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: OSDN - Tired of that same old
> cell phone?  Get a new here for FREE!
> https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
