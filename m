From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Cleanup event.c and warn about bug
Date: Mon, 4 Oct 2004 14:59:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041004125921.GA2704@elf.ucw.cz>
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, Rusty trivial patch monkey Russell <trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

event.c contains some completely unneccessary gotos, and is not
reentrant as it needs to be. Fix gotos, warn about reentrancy.
Please apply,
							Pavel

Index: linux/drivers/acpi/event.c
===================================================================
--- linux.orig/drivers/acpi/event.c	2004-10-01 12:24:26.000000000 +0200
+++ linux/drivers/acpi/event.c	2004-06-22 12:37:56.000000000 +0200
@@ -24,19 +24,14 @@
 static int
 acpi_system_open_event(struct inode *inode, struct file *file)
 {
+	int retval = 0;
 	spin_lock_irq (&acpi_system_event_lock);
-
-	if(event_is_open)
-		goto out_busy;
-
-	event_is_open = 1;
-
-	spin_unlock_irq (&acpi_system_event_lock);
-	return 0;
-
-out_busy:
+	if (event_is_open)
+		retval = -EBUSY;
+	else
+		event_is_open = 1;
 	spin_unlock_irq (&acpi_system_event_lock);
-	return -EBUSY;
+	return retval;
 }
 
 static ssize_t
@@ -48,7 +43,7 @@
 {
 	int			result = 0;
 	struct acpi_bus_event	event;
-	static char		str[ACPI_MAX_STRING];
+	static char		str[ACPI_MAX_STRING];		/* That's joke, right?! What if two threads read from it at the same time? */
 	static int		chars_remaining = 0;
 	static char		*ptr;
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
