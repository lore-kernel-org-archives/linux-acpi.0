From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Interrupt routing problem
Date: Tue, 13 Jan 2004 10:00:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040113090003.GB3599@hell.org.pl>
References: <3ACA40606221794F80A5670F0AF15F8401720CC3@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CC3-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Yu, Luming:
> > (I believe
> > there was a patch I tested and found working).
> 
> What patch ?

I believe it was the one attached below -- my bookmarks went wild some time
ago and I can't tell the bugzilla no., but it's certainly there.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

diff -Bru linux-2.6.0-test8/drivers/acpi/hardware/hwgpe.c patched/drivers/acpi/hardware/hwgpe.c
--- linux-2.6.0-test8/drivers/acpi/hardware/hwgpe.c     2003-10-18 05:42:53.000000000 +0800
+++ patched/drivers/acpi/hardware/hwgpe.c       2003-10-28 16:30:34.000000000 +0800
@@ -578,3 +578,38 @@

        return (status);
 }
+
+acpi_status
+acpi_hw_enable_ec_gpes(
+       void)
+{
+
+       struct acpi_gpe_block_info      *gpe_block;
+       struct acpi_gpe_event_info      *gpe_event_info;
+       acpi_status                     status = AE_OK;
+       acpi_native_uint                i,j;
+
+       ACPI_FUNCTION_ENTRY ();
+
+       status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+
+       if(ACPI_FAILURE(status)){
+               return (status);
+       }
+
+       for (i = 0; i < ACPI_MAX_GPE_BLOCKS; i++) {
+               gpe_block = acpi_gbl_gpe_fadt_blocks[i];
+               if (gpe_block) {
+                       for ( j = 0; j < gpe_block->register_count*8; j++){
+                               gpe_event_info= &gpe_block->event_info[j];
+                               if (gpe_event_info->handler &&
+                                               gpe_event_info->context)
+                                       acpi_hw_enable_gpe(gpe_event_info);
+                       }
+               }
+       }
+
+       (void) acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+
+       return (status);
+}
diff -Bru linux-2.6.0-test8/drivers/acpi/hardware/hwsleep.c patched/drivers/acpi/hardware/hwsleep.c
--- linux-2.6.0-test8/drivers/acpi/hardware/hwsleep.c   2003-10-18 05:42:54.000000000 +0800
+++ patched/drivers/acpi/hardware/hwsleep.c     2003-10-24 18:53:10.000000000 +0800
@@ -429,6 +429,9 @@
        if (ACPI_FAILURE (status)) {
                return_ACPI_STATUS (status);
        }
+
+
+       acpi_hw_enable_ec_gpes();

        /* Disable BM arbitration */
        status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
diff -Bru linux-2.6.0-test8/include/acpi/achware.h patched/include/acpi/achware.h
--- linux-2.6.0-test8/include/acpi/achware.h    2003-10-18 05:43:18.000000000 +0800
+++ patched/include/acpi/achware.h      2003-10-24 19:01:17.000000000 +0800
@@ -156,6 +156,9 @@
 acpi_hw_enable_non_wakeup_gpes (
        void);

+acpi_status
+acpi_hw_enable_ec_gpes(
+       void);

 /* ACPI Timer prototypes */




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
