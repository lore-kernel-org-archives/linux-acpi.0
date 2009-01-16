From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/23] ACPI: rename main.c to sleep.c
Date: Fri, 16 Jan 2009 15:25:11 -0500
Message-ID: <d08ca2ca743f324eceba59e93188f9439e966bce.1232137453.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:43575 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759684AbZAPUZg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:36 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDK00FTBZECQLS7@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:24 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile            |    2 +-
 drivers/acpi/{main.c => sleep.c} |    0 
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename drivers/acpi/{main.c => sleep.c} (100%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d80f4cc..65d90c7 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -19,7 +19,7 @@ obj-y				+= osl.o utils.o reboot.o\
 
 # sleep related files
 obj-y				+= wakeup.o
-obj-y				+= main.o
+obj-y				+= sleep.o
 obj-$(CONFIG_ACPI_SLEEP)	+= proc.o
 
 
diff --git a/drivers/acpi/main.c b/drivers/acpi/sleep.c
similarity index 100%
rename from drivers/acpi/main.c
rename to drivers/acpi/sleep.c
-- 
1.5.6.6

