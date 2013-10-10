From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] MAINTAINERS / ACPI: Update links to the Linux-ACPI project web page
Date: Thu, 10 Oct 2013 23:12:01 +0200
Message-ID: <2537172.WAToVyMzMe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60260 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756200Ab3JJVAR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2013 17:00:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Zhang Rui <rui.zhang@intel.com>, Sujith Thomas <sujith.thomas@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The Linux-ACPI project web page is now hosted by 01.org, so update
MAINTAINERS to reflect that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -270,21 +270,21 @@ F:	include/acpi/
 ACPI FAN DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
-W:	http://www.lesswatts.org/projects/acpi/
+W:	https://01.org/linux-acpi
 S:	Supported
 F:	drivers/acpi/fan.c
 
 ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
-W:	http://www.lesswatts.org/projects/acpi/
+W:	https://01.org/linux-acpi
 S:	Supported
 F:	drivers/acpi/*thermal*
 
 ACPI VIDEO DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
-W:	http://www.lesswatts.org/projects/acpi/
+W:	https://01.org/linux-acpi
 S:	Supported
 F:	drivers/acpi/video.c
 
@@ -4353,7 +4353,7 @@ F:	drivers/video/i810/
 INTEL MENLOW THERMAL DRIVER
 M:	Sujith Thomas <sujith.thomas@intel.com>
 L:	platform-driver-x86@vger.kernel.org
-W:	http://www.lesswatts.org/projects/acpi/
+W:	https://01.org/linux-acpi
 S:	Supported
 F:	drivers/platform/x86/intel_menlow.c
 

