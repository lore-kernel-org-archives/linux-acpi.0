From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: ACPI sleep: stupid bug reintroduced
Date: Tue, 1 Oct 2002 23:40:45 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021001214045.GA1178@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rusty trivial patch monkey Russell <trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

There's extremely stupid bug in sleep.c -- it will only alow user to
enter *unsupported* states. What's even worse that I remember fixing
that once before, and *it was merged to mainline*.

Please, really merge it to all copies so it is not reintroduced again.

[Oh, at it also makes S4 transition fail when SWSUSP support is not
there.]

								Pavel

--- clean/drivers/acpi/sleep.c	2002-09-22 23:46:56.000000000 +0200
+++ linux-swsusp/drivers/acpi/sleep.c	2002-10-01 23:38:48.000000000 +0200
@@ -329,8 +329,8 @@
 	state_string[count] = '\0';
 	
 	state = simple_strtoul(state_string, NULL, 0);
-	
-	if (sleep_states[state])
+
+	if (!sleep_states[state])
 		return_VALUE(-ENODEV);
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
@@ -338,7 +338,10 @@
 		software_suspend();
 		return_VALUE(count);
 	}
+#else
+	return_VALUE(-ENODEV);
 #endif
+
 	status = acpi_suspend(state);
 
 	if (ACPI_FAILURE(status))


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
