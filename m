From: "Sourav K. Mandal" <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: Compaq 1720US, 2.4.18, acpi-7,24 - Help
Date: 13 Aug 2002 00:46:15 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1029213980.18063.3.camel@anodyne.mandal>
References: <Pine.GSO.4.21.0208122148460.7266-100000@sediment.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.GSO.4.21.0208122148460.7266-100000-Bq+f90TzBY23n+kRt3O4EA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Prabhakar Reddy Gudla Venkata Siva <reddyg-3+M4TpyeDAP2fBVCVOL8/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2002-08-12 at 23:02, Prabhakar Reddy Gudla Venkata Siva wrote:

> Is there some step that I am missing ? Do I need to change something in
> the acpi code to override the new dsdt table ? Any help appreciated.

This might already be done in the newest ACPI, but I had to change osl.c
in the acpi directory, reflected in the patch below:

===============================================================

@@ -71,6 +71,9 @@
 static void *acpi_irq_context = NULL;
 
 
+#include "dsdt.hex"
+acpi_table_header *myDST = (acpi_table_header *) AmlCode;
+
 acpi_status
 acpi_os_initialize(void)
 {
@@ -221,7 +224,11 @@
        if (!existing_table || !new_table)
                return AE_BAD_PARAMETER;
 
-       *new_table = NULL;
+       /* *new_table = NULL; */
+       if (!strncmp(existing_table->signature, DSDT_SIG, 4))
+         *new_table = myDST;
+       else
+         *new_table = NULL ;
        return AE_OK;
 }
 
===============================================================


Good luck,

Sourav



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
