From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [patch]flush tlb when suspend
Date: Wed, 20 Oct 2004 13:47:42 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098251261.1756.5.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qdEGtW+lX1/r9fR5N+2n"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-qdEGtW+lX1/r9fR5N+2n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Possibly this patch can't resolve any problem (we didn't use low mem
when suspend), but I think it's better if we flush the tlb.

Thanks,
Shaohua

===== arch/i386/kernel/acpi/sleep.c 1.6 vs edited =====
--- 1.6/arch/i386/kernel/acpi/sleep.c	2004-10-19 13:26:45 +08:00
+++ edited/arch/i386/kernel/acpi/sleep.c	2004-10-20 13:39:58 +08:00
@@ -27,6 +27,7 @@ static void init_low_mapping(pgd_t *pgd,
 		set_pgd(pgd, *(pgd+USER_PTRS_PER_PGD));
 		pgd_ofs++, pgd++;
 	}
+	flush_tlb_all();
 }
 
 /**


--=-qdEGtW+lX1/r9fR5N+2n
Content-Disposition: attachment; filename=tlb.patch
Content-Type: text/x-patch; name=tlb.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== arch/i386/kernel/acpi/sleep.c 1.6 vs edited =====
--- 1.6/arch/i386/kernel/acpi/sleep.c	2004-10-19 13:26:45 +08:00
+++ edited/arch/i386/kernel/acpi/sleep.c	2004-10-20 13:39:58 +08:00
@@ -27,6 +27,7 @@ static void init_low_mapping(pgd_t *pgd,
 		set_pgd(pgd, *(pgd+USER_PTRS_PER_PGD));
 		pgd_ofs++, pgd++;
 	}
+	flush_tlb_all();
 }
 
 /**

--=-qdEGtW+lX1/r9fR5N+2n--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
