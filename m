From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/8] ACPI button: don't try to use a non-existent lid device
Date: Thu, 15 Oct 2009 00:59:43 -0400
Message-ID: <2c907b72db4dd4e8af6dccb6e0ac122d78627b8d.1255582742.git.len.brown@intel.com>
References: <1255582783-16088-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:53061 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbZJOFAu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 01:00:50 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KRJ00A91HVVK3AH@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 14 Oct 2009 23:59:56 -0500 (CDT)
In-reply-to: <1255582783-16088-1-git-send-email-lenb@kernel.org>
In-reply-to: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
References: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <len.brown@intel.com>

From: Jesse Barnes <jbarnes@virtuousgeek.org>

If a call comes in to check the lid state but there's no lid device
present, we should return -ENODEV.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9335b87..0c9c6a9 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -251,6 +251,9 @@ int acpi_lid_open(void)
 	acpi_status status;
 	unsigned long long state;
 
+	if (!lid_device)
+		return -ENODEV;
+
 	status = acpi_evaluate_integer(lid_device->handle, "_LID", NULL,
 				       &state);
 	if (ACPI_FAILURE(status))
-- 
1.6.0.6

