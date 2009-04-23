From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/29] ec.c: Fix ACPI EC resume non-query interrupt message
Date: Thu, 23 Apr 2009 02:23:36 -0400
Message-ID: <bd52a2b58af9095ce409abf58715978b347e0c59.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:54737 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbZDWGYP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:15 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ000FHJ43FFKP@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:08 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Almer S. Tigelaar" <almer@gnome.org>, Mattia Dongili <malattia@linux.it>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Almer S. Tigelaar <almer@gnome.org>

When resuming from standby (on a laptop) I see the following message in
my kernel.log:
"ACPI: EC: non-query interrupt received, switching to interrupt mode"
This apparently prevented sony-laptop to properly restore the brightness
level on resume.

The cause: In drivers/acpi/ec.c the acpi_ec_suspend function clears the
GPE mode bit, but this is not restored in acpi_ec_resume (the function
below it). The patch below fixes this by properly restoring the GPE_MODE
bit. Tested and confirmed to work.

Signed-off-by: Almer S. Tigelaar <almer@gnome.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 04e9044..391f331 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1065,6 +1065,7 @@ static int acpi_ec_resume(struct acpi_device *device)
 	struct acpi_ec *ec = acpi_driver_data(device);
 	/* Enable use of GPE back */
 	clear_bit(EC_FLAGS_NO_GPE, &ec->flags);
+	set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	acpi_enable_gpe(NULL, ec->gpe);
 	return 0;
 }
-- 
1.6.0.6

