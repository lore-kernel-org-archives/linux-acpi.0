From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: seq_file damage still not fixed in 2.5.63
Date: Mon, 24 Feb 2003 23:50:28 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030224225028.GA16141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, andy-SXfmanCb7nbrBKCeMvbIDA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

...this patch was dropped on the floor somewhere. Please apply,

							Pavel

--- clean/drivers/acpi/processor.c	2003-02-15 18:51:17.000000000 +0100
+++ linux/drivers/acpi/processor.c	2003-02-15 18:52:17.000000000 +0100
@@ -1356,7 +1356,8 @@
         loff_t			*data)
 {
 	int			result = 0;
-	struct acpi_processor	*pr = (struct acpi_processor *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_processor	*pr = (struct acpi_processor *)m->private;
 	char			state_string[12] = {'\0'};
 
 	ACPI_FUNCTION_TRACE("acpi_processor_write_throttling");
@@ -1418,7 +1419,8 @@
 	loff_t			*data)
 {
 	int			result = 0;
-	struct acpi_processor	*pr = (struct acpi_processor *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_processor	*pr = (struct acpi_processor *)m->private;
 	char			limit_string[25] = {'\0'};
 	int			px = 0;
 	int			tx = 0;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
