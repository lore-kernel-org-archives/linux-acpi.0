From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Report fan errors to user
Date: Thu, 9 Sep 2004 15:50:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040909135055.GA12244@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

I hit this on compaq evo n620c notebook... fan file would simply be
empty. Please apply,
								Pavel


--- clean-mm/drivers/acpi/fan.c	2004-08-24 09:01:53.000000000 +0200
+++ linux-mm/drivers/acpi/fan.c	2004-09-07 21:15:19.000000000 +0200
@@ -94,10 +94,10 @@
 		goto end;
 
 	if (acpi_bus_get_power(fan->handle, &state))
-		goto end;
-
-	p += sprintf(p, "status:                  %s\n",
-		!state?"on":"off");
+		p += sprintf(p, "status:                  ERROR\n");
+	else
+		p += sprintf(p, "status:                  %s\n",
+			     !state?"on":"off");
 
 end:
 	len = (p - page);


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
