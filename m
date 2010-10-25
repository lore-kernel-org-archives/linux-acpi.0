From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/60] ACPI: delete dedicated MAINTAINERS entries for ACPI EC
 and BATTERY drivers
Date: Mon, 25 Oct 2010 02:20:44 -0400
Message-ID: <3a2468d0274d10916baf5318f9004a8061533370.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50524 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab0JYHLD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:03 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:02 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

We thank Alexey Starikovskiy for his significant contributions
not only to the ACPI EC and battery code, but for his profound
positive impact on the ACPICA core itself.

Alexey is busy with new challenges now, and so we'll take his
name out of MAINTAINERS to reflect that the EC and battery
are once again maintained as part part of the general ACPI
sub-system without a dedicated sub-maintainer.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7679bf3..b5e4c9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -241,21 +241,6 @@ F:	drivers/pnp/pnpacpi/
 F:	include/linux/acpi.h
 F:	include/acpi/
 
-ACPI BATTERY DRIVERS
-M:	Alexey Starikovskiy <astarikovskiy@suse.de>
-L:	linux-acpi@vger.kernel.org
-W:	http://www.lesswatts.org/projects/acpi/
-S:	Supported
-F:	drivers/acpi/battery.c
-F:	drivers/acpi/*sbs*
-
-ACPI EC DRIVER
-M:	Alexey Starikovskiy <astarikovskiy@suse.de>
-L:	linux-acpi@vger.kernel.org
-W:	http://www.lesswatts.org/projects/acpi/
-S:	Supported
-F:	drivers/acpi/ec.c
-
 ACPI FAN DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
-- 
1.7.3.2.90.gd4c43

