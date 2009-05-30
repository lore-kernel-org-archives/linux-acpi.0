From: Len Brown <lenb@kernel.org>
Subject: [PATCH 62/65] drm/i915: acpi/video.c fix section mismatch warning
Date: Fri, 29 May 2009 21:42:40 -0400
Message-ID: <1fc8d33acafe68bdcc21b327d22ef3820b819727.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61730 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626AbZE3BnC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:02 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00J2GORSXEP2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:05 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jaswinder Singh Rajput <jaswinder@kernel.org>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, Len Brown <len.brown@intel.com>

From: Jaswinder Singh Rajput <jaswinder@kernel.org>

Currently acpi_video_exit() is exported as well as using __exit which causes:

  WARNING: drivers/acpi/video.o(__ksymtab+0x0): Section mismatch in reference from the variable __ksymtab_acpi_video_exit to the function .exit.text:acpi_video_exit()
  The symbol acpi_video_exit is exported and annotated __exit
  Fix this by removing the __exit annotation of acpi_video_exit or drop the export.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 810cca9..a79b885 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2334,7 +2334,7 @@ static int __init acpi_video_init(void)
 	return acpi_video_register();
 }
 
-void __exit acpi_video_exit(void)
+void acpi_video_exit(void)
 {
 
 	acpi_bus_unregister_driver(&acpi_video_bus);
-- 
1.6.0.6

