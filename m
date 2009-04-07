From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/17] NULL noise: drivers/platform/x86/panasonic-laptop.c
Date: Tue, 07 Apr 2009 19:04:12 -0400
Message-ID: <a3c270561ea4455cbcea0ac2b53335655d9fc805.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:32254 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbZDGXEf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:35 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR003XL6RKB1MC@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:33 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Hannes Eder <hannes@hanneseder.net>, Len Brown <len.brown@intel.com>

From: Hannes Eder <hannes@hanneseder.net>

Fix this sparse warning:
  drivers/platform/x86/panasonic-laptop.c:273:70: warning: Using plain integer as NULL pointer

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/panasonic-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index a5ce4bc..41cf3e7 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -271,7 +271,7 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc, u32 *sinf)
 	union acpi_object *hkey = NULL;
 	int i;
 
-	status = acpi_evaluate_object(pcc->handle, METHOD_HKEY_SINF, 0,
+	status = acpi_evaluate_object(pcc->handle, METHOD_HKEY_SINF, NULL,
 				      &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-- 
1.6.0.6

