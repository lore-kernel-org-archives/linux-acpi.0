From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: ASUS ACPI driver patches
Date: Fri, 13 Jun 2003 20:33:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030613183305.GA9001@hell.org.pl>
References: <F760B14C9561B941B89469F59BA3A847E96F66@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96F66-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Julien Lerouge <julien.lerouge-GANU6spQydw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Grover, Andrew:
> on compiling 2.4 version:
> 
> asus_acpi.c:137:1: warning: "S1X_PREFIX" redefined
> asus_acpi.c:134:1: warning: this is the location of the previous
> definition
> asus_acpi.c: In function `asus_hotk_get_info':
> asus_acpi.c:720: warning: unused variable `status'
> 
> You don't need to send me a new patch, but which line should I keep (137
> or 134) and can I delete that unused var?

Gosh, I have no idea how could I mess it up that way. Please apply the
patch below.

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

--- asus_core.c~        2003-06-12 15:55:04.000000000 +0200
+++ asus_core.c 2003-06-13 20:30:01.000000000 +0200
@@ -139,7 +139,7 @@
 #define S1X_PREFIX "\\_SB.PCI0.PX40."
 #define L1X_PREFIX S1X_PREFIX
 #define A1X_PREFIX "\\_SB.PCI0.ISA.EC0."
-#define S1X_PREFIX A1X_PREFIX
+#define J1X_PREFIX A1X_PREFIX

 static struct model_data model_conf[END_MODEL] = {
         /*
@@ -178,8 +178,8 @@
        {"A1X", "MLED", "\\MAIL", NULL, NULL, A1X_PREFIX "_Q10", "\\BKLI",
         A1X_PREFIX "_Q0E", A1X_PREFIX "_Q0F", NULL, NULL, NULL, NULL, NULL},

-       {"J1X", "MLED", "\\MAIL", NULL, NULL, S1X_PREFIX "_Q10", "\\BKLI",
-        S1X_PREFIX "_Q0B", S1X_PREFIX "_Q0A", NULL, NULL, NULL, NULL, NULL}
+       {"J1X", "MLED", "\\MAIL", NULL, NULL, J1X_PREFIX "_Q10", "\\BKLI",
+        J1X_PREFIX "_Q0B", J1X_PREFIX "_Q0A", NULL, NULL, NULL, NULL, NULL}
 };

 /* procdir we use */
@@ -722,7 +722,6 @@
 {
        struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
        union acpi_object *model = NULL;
-       acpi_status status = AE_OK;

        /*
         * We have to write 0 on init this far for all ASUS models



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
