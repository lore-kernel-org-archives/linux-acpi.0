From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: mem= option for broken bioses
Date: Wed, 26 Feb 2003 21:38:42 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030226203841.GC346@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

I've seen broken bios that did not mark acpi tables in e820
tables. This allows user to override it. Please apply,

							Pavel

--- linux/arch/i386/kernel/setup.c	2003-02-11 17:50:57.000000000 +0100
+++ linux-tablet/arch/i386/kernel/setup.c	2003-02-20 18:03:03.000000000 +0100
@@ -546,6 +546,12 @@
 				if (*from == '@') {
 					start_at = memparse(from+1, &from);
 					add_memory_region(start_at, mem_size, E820_RAM);
+				} else if (*from == '#') {
+					start_at = memparse(from+1, &from);
+					add_memory_region(start_at, mem_size, E820_ACPI);
+				} else if (*from == '$') {
+					start_at = memparse(from+1, &from);
+					add_memory_region(start_at, mem_size, E820_RESERVED);
 				} else {
 					limit_regions(mem_size);
 					userdef=1;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
