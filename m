From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: [PATCH] ACPI 2.5.45 relies on Software Suspend for S4
Date: Sun, 3 Nov 2002 17:30:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103173035.A2570@brodo.de>
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
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

... and so only claim S4 support when it's available (NB: software suspend
doesn't work at the moment. But will hopefully work again soon)

	Dominik

--- linux/drivers/acpi/sleep.c.original	Sun Nov  3 17:26:04 2002
+++ linux/drivers/acpi/sleep.c	Sun Nov  3 17:28:20 2002
@@ -227,7 +227,7 @@
 	acpi_status status;
 
 	/* get out if state is invalid */
-	if (state < ACPI_STATE_S1 || state > ACPI_STATE_S5)
+	if (state < ACPI_STATE_S1 || state > ACPI_STATE_S5 || (state == ACPI_STATE_S4))
 		return AE_ERROR;
 
 	freeze_processes();		/* device_suspend needs processes to be stopped */
@@ -706,10 +706,15 @@
 		pm_power_off = acpi_power_off;
 		register_sysrq_key('o', &sysrq_acpi_poweroff_op);
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 		/* workaround: some systems don't claim S4 support, but they
                    do support S5 (power-down). That is all we need, so
 		   indicate support. */
 		sleep_states[ACPI_STATE_S4] = 1;
+#else
+		/* we rely on SOFTWARE_SUSPEND to use S4. */
+		sleep_states[ACPI_STATE_S4] = 0;
+#endif
 	}
 
 	return_VALUE(0);


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
