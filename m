From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: Re: [PATCH] HP xw6000 - loading order of SSDT tables!!!
Date: Tue, 24 Jun 2003 20:30:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306242030.07442.hrvoje.habjanic@zg.htnet.hr>
References: <200306241935.19049.hrvoje.habjanic@htnet.hr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_viJ++0xfqJB/sAB"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200306241935.19049.hrvoje.habjanic-ZeoyiJGIzEM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_viJ++0xfqJB/sAB
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Upss ... i forgot to attach patch itself ... so here it is ...

Hrvoje

On Tuesday 24 June 2003 19:35, you wrote:
> IS IMPORTANT!!!!!
>
> I've modified acpi-20030424-2.4.21-rc1 and noticed that it is loading SSDT
> tables in "normal" order - tables_id are INCREMENTING ...
>
> BUT every acpi driver after that is loading SSDT tables in DECREMENTING
> (table_id) order ... so i've made a small patch to mimic
> acpi-20030424-2.4.21-rc1 order of loading.
>
> And that was it!!!
>
> Andy, please verify this and i hope this will not broke some other things
> ...
>
> And for  dmesg's see:
> 1. modified acpi-20030424-2.4.21-rc1
> - http://free-zg.htnet.hr/HrvojeHabjanic/acpi/HP_xw6000-rc2-OK.2.dmesg
> 2. modified  acpi-20030619
> - http://free-zg.htnet.hr/HrvojeHabjanic/acpi/HP_xw6000-20030619-OK.dmesg
>
> And at the end, thanx to everyone who helped to find and fix this ... hmm
> ... bug or feature?
>
>
> Hrvoje

--Boundary-00=_viJ++0xfqJB/sAB
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="HP_xw6000-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="HP_xw6000-patch.diff"

--- linux-2.4.21/drivers/acpi/tables/tbinstal.c	2003-06-24 12:33:04.000000000 +0200
+++ linux-2.4.21.ok/drivers/acpi/tables/tbinstal.c	2003-06-24 15:19:33.000000000 +0200
@@ -271,23 +271,40 @@
 		if (list_head->next) {
 			return_ACPI_STATUS (AE_ALREADY_EXISTS);
 		}
+
+		table_desc->next = list_head->next;
+		list_head->next = table_desc;
+
+		if (table_desc->next) {
+			table_desc->next->prev = table_desc;
+		}
+		list_head->count++;
 	}
+	else
+	{
 
 	/*
 	 * Link the new table in to the list of tables of this type.
-	 * Just insert at the start of the list, order unimportant.
+	 * Just insert at the end of the list, order IS IMPORTANT.
 	 *
-	 * table_desc->Prev is already NULL from calloc()
+	 * table_desc->prev & next is already NULL from calloc()
 	 */
-	table_desc->next = list_head->next;
-	list_head->next = table_desc;
+		list_head->count++;
 
-	if (table_desc->next) {
-		table_desc->next->prev = table_desc;
+		if(!list_head->next)
+			list_head->next = table_desc;
+		else
+		{
+			table_desc->next = list_head->next;
+			while(table_desc->next->next)
+				table_desc->next=table_desc->next->next;
+
+			table_desc->next->next=table_desc;
+			table_desc->prev=table_desc->next;
+			table_desc->next=NULL;
+		}
 	}
 
-	list_head->count++;
-
 	/* Finish initialization of the table descriptor */
 
 	table_desc->type                = (u8) table_type;

--Boundary-00=_viJ++0xfqJB/sAB--



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
