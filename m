From: Len Brown <len.brown@intel.com>
Subject: [PATCH 3/9] sony-laptop: MAINTAINERS fix entry, add L: and W:
Date: Tue, 20 Mar 2007 11:27:05 -0400
Message-ID: <11744044333328-git-send-email-len.brown@intel.com>
References: <1174404431897-git-send-email-len.brown@intel.com> <11744044323719-git-send-email-len.brown@intel.com> <11744044323692-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29156 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933808AbXCTP1c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:27:32 -0400
In-Reply-To: <11744044323692-git-send-email-len.brown@intel.com>
Message-Id: <5b18167d6b7c63e2787cd9a68f0620a9c363fc85.1174404136.git.len.brown@intel.com>
In-Reply-To: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
References: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17555bb..f3a79d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3066,11 +3066,10 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 
 SONY VAIO CONTROL DEVICE DRIVER
-P:	Stelian Pop
-M:	stelian@popies.net
 P:	Mattia Dongili
 M:	malattia@linux.it
-W:	http://popies.net/sonypi/
+L:	linux-acpi@vger.kernel.org
+W:	http://www.linux.it/~malattia/wiki/index.php/Sony_drivers
 S:	Maintained
 
 SOUND
-- 
1.5.0.3.382.g34572
