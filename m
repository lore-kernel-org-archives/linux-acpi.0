From: jbarnes-sJ/iWh9BUns@public.gmane.org (Jesse Barnes)
Subject: [PATCH] handle fadt->si_cmd == 0
Date: Fri, 6 Jun 2003 10:17:30 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030606171730.GD1349@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

In reading the spec, it looks like if a particular ACPI implementation
leaves fadt->si_cmd equal to 0, that means the platform doesn't support
system management mode, which seems legal.  I needed this patch for my
system.  With the patch applied, I'm able to see /proc/acpi and the
interpreter appears to start.  Is this legal?

Thanks,
Jesse


--- /usr/tmp/TmpDir.30375-0/linux/drivers/acpi/hardware/hwacpi.c_1.10	Fri Jun  6 10:24:23 2003
+++ linux/drivers/acpi/hardware/hwacpi.c	Tue Jun  3 10:48:31 2003
@@ -180,6 +180,10 @@
 
 	ACPI_FUNCTION_TRACE ("Hw_get_mode");
 
+	/* If there's no smi_cmd port, then it's ACPI only hw */
+	if (!acpi_gbl_FADT->smi_cmd)
+		return_VALUE (ACPI_SYS_MODE_ACPI);
+
 	status = acpi_get_register (ACPI_BITREG_SCI_ENABLE, &value, ACPI_MTX_LOCK);
 	if (ACPI_FAILURE (status)) {
 		return_VALUE (ACPI_SYS_MODE_LEGACY);


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
