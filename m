From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/23] PM: Fix freezer compilation if PM_SLEEP is unset
Date: Fri, 16 Jan 2009 15:25:06 -0500
Message-ID: <33f1d7ecc6cffff3c618a02295de969ebbacd95d.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:50288 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758819AbZAPUZY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:24 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDK005R4ZE9OYZ5@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:22 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Freezer fails to compile if with the following configuration
settings:

CONFIG_CGROUPS=y
CONFIG_CGROUP_FREEZER=y
CONFIG_MODULES=y
CONFIG_FREEZER=y
CONFIG_PM=y
CONFIG_PM_SLEEP=n

Fix this by making process.o compilation depend on CONFIG_FREEZER.

Reported-by: Cheng Renquan <crquan@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 597823b..d7a1016 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -4,7 +4,8 @@ EXTRA_CFLAGS	+=	-DDEBUG
 endif
 
 obj-y				:= main.o
-obj-$(CONFIG_PM_SLEEP)		+= process.o console.o
+obj-$(CONFIG_PM_SLEEP)		+= console.o
+obj-$(CONFIG_FREEZER)		+= process.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o disk.o snapshot.o swap.o user.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
-- 
1.5.6.6

