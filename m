From: Andy Grover <agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org>
Subject: [PATCH] Make ACPI unselectable in 2.4.20-rc1
Date: Thu, 7 Nov 2002 18:20:39 -0800 (PST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0211071811450.3860-100000@dexter.groveronline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo,

My plan is to start feeding you bits of ACPI changes after 2.4.20 is 
released. However, for 2.4.20, I'd like to make sure the really old code 
in 2.4.20 doesn't bite any casual kernel builders.

Please apply,

Thanks -- Andy

===== arch/i386/config.in 1.35 vs edited =====
--- 1.35/arch/i386/config.in	Mon Aug 19 06:23:29 2002
+++ edited/arch/i386/config.in	Thu Nov  7 18:08:09 2002
@@ -298,11 +298,12 @@
 bool 'Power Management support' CONFIG_PM
 
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-   dep_bool '  ACPI support' CONFIG_ACPI $CONFIG_PM
-   
-   if [ "$CONFIG_ACPI" != "n" ]; then
-      source drivers/acpi/Config.in
-   fi
+    comment '  ACPI support disabled temporarily'
+#   dep_bool '  ACPI support' CONFIG_ACPI $CONFIG_PM
+#   
+#   if [ "$CONFIG_ACPI" != "n" ]; then
+#      source drivers/acpi/Config.in
+#   fi
 fi
 
 dep_tristate '  Advanced Power Management BIOS support' CONFIG_APM $CONFIG_PM
