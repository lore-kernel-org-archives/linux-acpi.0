From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/16] ACPI: expand Vista blacklist to include SP1 and SP2
Date: Tue, 28 Sep 2010 23:44:35 -0400
Message-ID: <bbb7030fbb6469c46974c4736a5f90d12102f299.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56849 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab0I2DpZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:45:25 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00E27P39KDO0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:45:19 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

When we claim incompatibility with Vista,
include both Vista SP1 and SP2.

https://bugzilla.kernel.org/show_bug.cgi?id=12641

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 2bb28b9..3eda6c0 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -183,6 +183,8 @@ static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
 {
 	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
 	acpi_osi_setup("!Windows 2006");
+	acpi_osi_setup("!Windows 2006 SP1");
+	acpi_osi_setup("!Windows 2006 SP2");
 	return 0;
 }
 static int __init dmi_disable_osi_win7(const struct dmi_system_id *d)
-- 
1.7.3.2.g9027fa

