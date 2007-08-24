From: Pavel Machek <pavel@ucw.cz>
Subject: trip points are now read-only, mark them as such
Date: Fri, 24 Aug 2007 11:45:50 +0200
Message-ID: <20070824094550.GA2869@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46209 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761202AbXHXVAw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 17:00:52 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>, ACPI mailing list <linux-acpi@vger.kernel.org>

Trip points are now read-only, mark them as such.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 7359586e3cf03be9370a495a03044677c9594ccd
tree 5d14686cdec78dc9d22be512d71f19247cf2e82f
parent cd48bb0ae3cd70fff68a09b80b3744e5f92cff86
author Pavel <pavel@amd.ucw.cz> Fri, 24 Aug 2007 11:44:14 +0200
committer Pavel <pavel@amd.ucw.cz> Fri, 24 Aug 2007 11:44:14 +0200

 drivers/acpi/thermal.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 1e06159..e532b05 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1067,9 +1067,9 @@ static int acpi_thermal_add_fs(struct ac
 		entry->owner = THIS_MODULE;
 	}
 
-	/* 'trip_points' [R/W] */
+	/* 'trip_points' [R] */
 	entry = create_proc_entry(ACPI_THERMAL_FILE_TRIP_POINTS,
-				  S_IFREG | S_IRUGO | S_IWUSR,
+				  S_IRUGO,
 				  acpi_device_dir(device));
 	if (!entry)
 		return -ENODEV;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
