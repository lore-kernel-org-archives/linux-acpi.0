From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] Fixed buffered ACPI events for a lot ASUS machines
Date: Mon, 12 Sep 2005 13:39:15 +0200
Message-ID: <432568E3.6040401@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040800010807050609030908"
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
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, jfvasconcelos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040800010807050609030908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I finally could resolve the buffering of ACPI events on
some ASUS (M6N, M6000, A3500N, A6000G, maybe more...)
when battery module is loaded.

After hours of hopeless debugging I could track it down by comparing
with Yu Luming's previously patch posted on bugzilla.kernel.org.

Yu, could you confirm that this is really fixing a bug and totally safe?

Or was this intended and could possibly lead to problems on other machines?

Thanks,

      Thomas

--------------040800010807050609030908
Content-Type: text/x-patch;
 name="acpi_fix_ASUS_M6N_bufferd_events.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_fix_ASUS_M6N_bufferd_events.diff"

--- drivers/acpi/ec.c.orig	2005-09-12 13:22:13.000000000 +0200
+++ drivers/acpi/ec.c	2005-09-12 13:22:22.000000000 +0200
@@ -840,8 +840,8 @@
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluating %s\n", object_name));
 
 	acpi_evaluate_object(ec->common.handle, object_name, NULL, NULL);
-end:	
 	atomic_dec(&ec->burst.pending_gpe);
+end:	
 	return;
 }
 

--------------040800010807050609030908--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
