From: Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Subject: [2.5 patch] remove unused reset_videobios_after_s3
Date: Sun, 8 Jun 2003 12:47:37 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030608104737.GA16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: pavel-AlSwsSmVLrQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

reset_videobios_after_s3 is used nowhere inside 2.5.70-mm6. Unless there 
are plans to use it in the near future I suggest the patch below to 
remove it.

I've tested the compilation with 2.5.70-mm6.

cu
Adrian


--- linux-2.5.70-mm6/arch/i386/kernel/dmi_scan.c.old	2003-06-08 12:42:41.000000000 +0200
+++ linux-2.5.70-mm6/arch/i386/kernel/dmi_scan.c	2003-06-08 12:43:01.000000000 +0200
@@ -482,12 +482,6 @@
 	return 0;
 }
 
-static __init int reset_videobios_after_s3(struct dmi_blacklist *d)
-{
-	extern long acpi_video_flags;
-	acpi_video_flags |= 1;
-	return 0;
-}
 #endif
 
 /*
