From: Len Brown <len.brown@intel.com>
Subject: [PATCH 6/7] ACPI: update MAINTAINERS
Date: Thu, 11 Jan 2007 04:11:47 -0500
Message-ID: <11685067152996-git-send-email-len.brown@intel.com>
References: <11685067081383-git-send-email-len.brown@intel.com> <11685067091916-git-send-email-len.brown@intel.com> <11685067101245-git-send-email-len.brown@intel.com> <11685067113037-git-send-email-len.brown@intel.com> <11685067121393-git-send-email-len.brown@intel.com> <11685067141577-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45388 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030246AbXAKJL4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jan 2007 04:11:56 -0500
In-Reply-To: <11685067141577-git-send-email-len.brown@intel.com>
Message-Id: <8b59a454c421542a51c391f542c80d165f7547a0.1168506584.git.len.brown@intel.com>
In-Reply-To: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
References: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

s/Maintained/Supported/
and document some sub-maintainers for ACPI drivers.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS |   39 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f6d13b..d1f454c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -207,16 +207,45 @@ S:	Supported
 ACPI
 P:	Len Brown
 M:	len.brown@intel.com
+M:	lenb@kernel.org
 L:	linux-acpi@vger.kernel.org
 W:	http://acpi.sourceforge.net/
 T:	git kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
-S:	Maintained
+S:	Supported
+
+ACPI BATTERY DRIVERS
+P:	Vladimir P. Lebedev
+M:	vladimir.p.lebedev@intel.com
+L:	linux-acpi@vger.kernel.org
+W:	http://acpi.sourceforge.net/
+S:	Supported
+
+ACPI EC DRIVER
+P:	Alexey Starikovskiy
+M:	alexey.y.starikovskiy@linux.intel.com
+L:	linux-acpi@vger.kernel.org
+W:	http://acpi.sourceforge.net/
+S:	Supported
+
+ACPI FAN DRIVER
+P:	Konstantin A. Karasyov
+M:	konstantin.a.karasyov@intel.com
+L:	linux-acpi@vger.kernel.org
+W:	http://acpi.sourceforge.net/
+S:	Supported
 
 ACPI PCI HOTPLUG DRIVER
 P:	Kristen Carlson Accardi
 M:	kristen.c.accardi@intel.com
 L:	pcihpd-discuss@lists.sourceforge.net
-S:	Maintained
+S:	Supported
+
+ACPI THERMAL DRIVER
+P:	Konstantin A. Karasyov
+M:	konstantin.a.karasyov@intel.com
+L:	linux-acpi@vger.kernel.org
+W:	http://acpi.sourceforge.net/
+S:	Supported
 
 AD1816 SOUND DRIVER
 P:	Thorsten Knabe
@@ -1071,7 +1100,7 @@ DOCKING STATION DRIVER
 P:	Kristen Carlson Accardi
 M:	kristen.c.accardi@intel.com
 L:	linux-acpi@vger.kernel.org
-S:	Maintained
+S:	Supported
 
 DOUBLETALK DRIVER
 P:	James R. Van Zandt
@@ -2521,7 +2550,7 @@ PCIE HOTPLUG DRIVER
 P:	Kristen Carlson Accardi
 M:	kristen.c.accardi@intel.com
 L:	pcihpd-discuss@lists.sourceforge.net
-S:	Maintained
+S:	Supported
 
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
@@ -3015,7 +3044,7 @@ SHPC HOTPLUG DRIVER
 P:	Kristen Carlson Accardi
 M:	kristen.c.accardi@intel.com
 L:	pcihpd-discuss@lists.sourceforge.net
-S:	Maintained
+S:	Supported
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE DRIVER
 P:	Pierre Ossman
-- 
1.4.4.4.ge05d
