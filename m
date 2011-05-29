From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/18] ACPI EC: remove redundant code
Date: Sun, 29 May 2011 05:44:13 -0400
Message-ID: <08b53f0e6b565fe8dc0b8f929960ed16d76291bd.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:55526 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1E2J5x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:57:53 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY0094DBOGA0E2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:57:53 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

ec->handle is set in ec_parse_device(), so don't bother to set it again.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b3f1d6f..ed8cf17 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -804,8 +804,6 @@ static int acpi_ec_add(struct acpi_device *device)
 			return -EINVAL;
 	}
 
-	ec->handle = device->handle;
-
 	/* Find and register all query methods */
 	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
 			    acpi_ec_register_query_methods, NULL, ec, NULL);
-- 
1.7.5.3.367.ga9930.dirty

