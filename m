From: "Shay Elkin" <shayel-NSemkxREmS1YZAO8hgG6+w@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: Wed, 25 Sep 2002 18:51:38 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2002.09.25.15.51.37.71290@cs.huji.ac.il>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com> <200209192208.40254.jbr.1@gmx.net> <200209192215.g8JMEv306270@pfn1.pefnos> <200209221321.g8MDLb009922@pfn1.pefnos> <20020922005310.B35@toy.ucw.cz> <20020923150937.GA12513@dutidad.twi.tudelft.nl> <20020922043148.B35@toy.ucw.cz> <20020924213334.GB22018@dutidad.twi.tudelft.nl> <pan.2002.09.25.15.26.32.102013@cs.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 25 Sep 2002 18:26:32 +0300, Shay Elkin wrote:

> Is something along the attached patch is okay, or should it be done in
> acpi_suspend() instead? (I don't think acpi_suspend is called from
> anywhere else but acpi_system_write_sleep()).

I forogot to include the patch. Here:

=== cut here ===

--- drivers/acpi/system.c.orig  2002-09-25 18:14:11.000000000 +0300
+++ drivers/acpi/system.c       2002-09-25 18:09:34.000000000 +0300
@@ -510,10 +511,22 @@
        if (!system->states[state])
                return_VALUE(-ENODEV);
 
-       status = acpi_suspend(state);
-       if (ACPI_FAILURE(status))
-               return_VALUE(-ENODEV);
-
+       switch (state) {
+       case ACPI_STATE_S4:
+#ifdef CONFIG_SOFTWARE_SUSPEND
+               software_suspend_pending();
+               break;
+#endif 
+       case ACPI_STATE_S3:
+               printk("unsupported sleep mode %d", state);
+               break;
+       default:
+               status = acpi_suspend(state);
+               if (ACPI_FAILURE(status))
+                       return_VALUE(-ENODEV);
+               break;
+       }
+
        return_VALUE(count);
 }
 
=== cut here ===

	Shay.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
