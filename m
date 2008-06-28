From: Len Brown <lenb@kernel.org>
Subject: [PATCH 53/84] ACPI: Zhang Rui maintains ACPI THERMAL and FAN
Date: Sat, 28 Jun 2008 01:43:57 -0400
Message-ID: <21ee0aba771e39d530bb41670f6ab7a3083ea2f3.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61962 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbYF1Fp0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:26 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500F1XRZJLNNB@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:20 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Reflect that Zhang-Rui has been the sub-maintainer for
ACPI THERMAL and FAN for some time now.

Also, the Chinese custom is to speak family name first,
so rather than "Rui Zhang", write "Zhang Rui",
as he does on e-mail.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f0ec46..18e5416 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -239,8 +239,8 @@ W:	http://www.lesswatts.org/projects/acpi/
 S:	Supported
 
 ACPI FAN DRIVER
-P:	Len Brown
-M:	len.brown@intel.com
+P:	Zhang Rui
+M:	rui.zhang@intel.com
 L:	linux-acpi@vger.kernel.org
 W:	http://www.lesswatts.org/projects/acpi/
 S:	Supported
@@ -252,14 +252,14 @@ L:	pcihpd-discuss@lists.sourceforge.net
 S:	Supported
 
 ACPI THERMAL DRIVER
-P:	Len Brown
-M:	len.brown@intel.com
+P:	Zhang Rui
+M:	rui.zhang@intel.com
 L:	linux-acpi@vger.kernel.org
 W:	http://www.lesswatts.org/projects/acpi/
 S:	Supported
 
 ACPI VIDEO DRIVER
-P:	Rui Zhang
+P:	Zhang Rui
 M:	rui.zhang@intel.com
 L:	linux-acpi@vger.kernel.org
 W:	http://www.lesswatts.org/projects/acpi/
-- 
1.5.6.1.89.gd544

