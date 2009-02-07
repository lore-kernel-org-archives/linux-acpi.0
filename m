From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/30] ACPI: Fix crash on ASUS laptops
Date: Sat, 07 Feb 2009 01:41:11 -0500
Message-ID: <4312495f7db63d27ef52ec83dab55f14a8c43827.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:12159 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbZBGGls (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:48 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEO00KAFNX8GUA2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:33 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Tero Roponen <tero.roponen@gmail.com>, Len Brown <len.brown@intel.com>

From: Tero Roponen <tero.roponen@gmail.com>

This patch fixes the crash I experienced in 2.6.29-rc2.
Tested on ASUS M50vm.

Signed-off-by: Tero Roponen <tero.roponen@gmail.com>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a2b82c9..5c2f5d3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -982,7 +982,7 @@ int __init acpi_ec_ecdt_probe(void)
 		saved_ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
 		if (!saved_ec)
 			return -ENOMEM;
-		memcpy(&saved_ec, boot_ec, sizeof(saved_ec));
+		memcpy(saved_ec, boot_ec, sizeof(*saved_ec));
 	/* fall through */
 	}
 	/* This workaround is needed only on some broken machines,
-- 
1.5.6.6

