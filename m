From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Ask devices to powerdown before S3 sleep
Date: Sun, 19 Jan 2003 22:46:42 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030119214642.GA27885@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

SUSPEND_RESUME phase is needed for turning off IO-APIC. [I believe
SUSPEND_DISABLE should be so simple that errors just should not be
there, and besides we would not know how to safely enable devices from
such weird state, anyway]. Please apply,

								Pavel

--- clean/drivers/acpi/sleep.c	2003-01-05 22:58:25.000000000 +0100
+++ linux-swsusp/drivers/acpi/sleep.c	2003-01-19 21:27:00.000000000 +0100
@@ -143,6 +143,10 @@
 			return error;
 		}
 
+		error = device_suspend(state, SUSPEND_DISABLE);
+		if (error)
+			panic("Sorry, devices really should know how to disable\n");
+
 		/* flush caches */
 		ACPI_FLUSH_CPU_CACHE();

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
