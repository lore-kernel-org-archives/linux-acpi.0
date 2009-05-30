From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/11] drm/i915: acpi/video.c fix section mismatch warning
Date: Fri, 29 May 2009 21:37:18 -0400
Message-ID: <1fc8d33acafe68bdcc21b327d22ef3820b819727.1243647312.git.len.brown@intel.com>
References: <1243647441-31392-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36295 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbZE3Bh3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:37:29 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00HCEOIGPKY2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:37:31 -0500 (CDT)
In-reply-to: <1243647441-31392-1-git-send-email-lenb@kernel.org>
In-reply-to: <87ad57bacb25c3f24c54f142ef445f68277705f0.1243647311.git.len.brown@intel.com>
References: <87ad57bacb25c3f24c54f142ef445f68277705f0.1243647311.git.len.brown@intel.com>
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

