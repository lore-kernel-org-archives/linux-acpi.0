From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUG 2.6.5-rc2-bk5 and 2.6.5-rc2-mm3] ACPI seems to be broken
Date: 26 Mar 2004 02:43:25 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080287004.748.187.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6523@hdsmsx402.hd.intel.com>
	 <1080278805.755.157.camel@dhcppc4>
	 <1080284583.2439.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080284583.2439.8.camel-SyLVLa/KEI9HwK5hSS5vWB2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Trond Myklebust <trond.myklebust-41N18TsMXrtuMpJDpNschA@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Trond,
Can you also try this simple patch all by itself
to see if when acpi_disable() does get invoked, if
we can possibly cause less damage to the system?

thanks,
-Len

===== drivers/acpi/events/evxfevnt.c 1.19 vs edited =====
--- 1.19/drivers/acpi/events/evxfevnt.c	Sat Jan 17 18:12:31 2004
+++ edited/drivers/acpi/events/evxfevnt.c	Fri Mar 26 02:38:17 2004
@@ -139,6 +139,8 @@
 		ACPI_DEBUG_PRINT ((ACPI_DB_INIT, "ACPI mode disabled\n"));
 	}
 
+	disable_acpi();
+
 	return_ACPI_STATUS (status);
 }
 






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
