From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Report errors in fan.c
Date: Mon, 4 Oct 2004 18:10:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041004161038.GA4210@elf.ucw.cz>
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
To: Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rusty trivial patch monkey Russell <trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Currently, fan.c ignores errors from acpi_bus_get_power. On compaq evo
notebook that leads to very confusing empty output. Please apply,

								Pavel

--- tmp/linux/drivers/acpi/fan.c	2004-06-22 12:36:01.000000000 +0200
+++ linux/drivers/acpi/fan.c	2004-10-02 18:38:53.000000000 +0200
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

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
