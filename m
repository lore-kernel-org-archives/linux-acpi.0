From: Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Subject: [2.4 patch] add three ACPI Configure.help entries
Date: Sat, 21 Jun 2003 02:05:50 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030621000550.GP29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The patch below adds Configure.help entries for three ACPI options added 
in 2.4.22-pre1 (help texts stolen from 2.5).

Please apply
Adrian


--- linux-2.4.22-pre1-full/Documentation/Configure.help.old	2003-06-21 01:51:34.000000000 +0200
+++ linux-2.4.22-pre1-full/Documentation/Configure.help	2003-06-21 02:00:54.000000000 +0200
@@ -18691,6 +18691,20 @@
   down the system.  Until then, you can cat it, and see output when
   a button is pressed.
 
+CONFIG_ACPI_BATTERY
+  This driver adds support for battery information through
+  /proc/acpi/battery. If you have a mobile system with a battery, 
+  say Y.
+
+CONFIG_ACPI_FAN
+  This driver adds support for ACPI fan devices, allowing user-mode 
+  applications to perform basic fan control (on, off, status).
+
+CONFIG_ACPI_PROCESSOR
+  This driver installs ACPI as the idle handler for Linux, and uses
+  ACPI C2 and C3 processor states to save power, on systems that
+  support it.
+
 ACPI AC Adapter
 CONFIG_ACPI_AC
   This driver adds support for the AC Adapter object, which indicates
