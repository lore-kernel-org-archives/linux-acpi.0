From: Giridhar Pemmasani <giri-EX0cT3Az47bauI2f2gSDlQ@public.gmane.org>
Subject: patch: acpi-20020821 fix?
Date: Tue, 27 Aug 2002 02:55:25 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15723.8797.507913.189282@marple.lmc.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It seems that the following patch against drivers/acpi/system.c
is needed to get 'echo -n 5 > /proc/acpi/sleep' to work as
expected. 

--- system.c.orig   Tue Aug 27 02:42:17 2002
+++ system.c    Tue Aug 27 02:43:42 2002
@@ -110,7 +110,7 @@
    acpi_status status;
 
    /* only support S1 and S5 on kernel 2.4 */
-   if (state != ACPI_STATE_S1 || state != ACPI_STATE_S5)
+   if (state != ACPI_STATE_S1 && state != ACPI_STATE_S5)
        return AE_ERROR;
 
    acpi_enter_sleep_state_prep(state);


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
