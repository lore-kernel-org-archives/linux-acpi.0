From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: truncated output from /proc/acpi/debug_level
Date: Mon, 09 Jan 2006 23:56:10 +0000
Message-ID: <E1Ew6ry-0000QG-00@skye.ra.phy.cam.ac.uk>
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[bug #5076]

'cat /proc/acpi/debug_level' will truncate output sometimes (to
reproduce it for sure, read one byte at a time unbuffered, e.g. using
the C program in the bugzilla entry).  I submitted a patch via the
bugzilla in the 2.6.13 era, but it doesn't seem to have made it into
mainline, so I've appended it below.  It's also at

<http://bugzilla.kernel.org/attachment.cgi?id=5653&action=view>

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.


--- linux-2.6.13-rc6/drivers/acpi/debug.c~	2005-08-07 14:18:56.000000000 -0400
+++ linux-2.6.13-rc6/drivers/acpi/debug.c	2005-08-16 20:57:29.000000000 -0400
@@ -104,9 +104,6 @@ acpi_system_read_debug (
 	int 			size = 0;
 	unsigned int		i;
 
-	if (off != 0)
-		goto end;
-
 	p += sprintf(p, "%-25s\tHex        SET\n", "Description");
 
 	switch ((unsigned long) data) {
@@ -143,7 +140,6 @@ acpi_system_read_debug (
 		break;
 	}
 	
-end:
 	size = (p - page);
 	if (size <= off+count) *eof = 1;
 	*start = page + off;
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
