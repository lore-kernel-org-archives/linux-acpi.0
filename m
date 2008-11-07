From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/21] PNP: add Bjorn Helgaas as PNP co-maintainer
Date: Thu, 06 Nov 2008 23:39:20 -0500
Message-ID: <2d59f6a73e1cb4415cdd5a0083b1196cceffa275.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:54874 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbYKGEjj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:39 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00KQE4WD4RX1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:38:38 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Update Adam's email address and add myself as PNP co-maintainer.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 808bb85..5cf7492 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3336,7 +3336,9 @@ S:	Maintained
 
 PNP SUPPORT
 P:	Adam Belay
-M:	ambx1@neo.rr.com
+M:	abelay@mit.edu
+P:	Bjorn Helgaas
+M:	bjorn.helgaas@hp.com
 S:	Maintained
 
 PNXxxxx I2C DRIVER
-- 
1.5.6.5

