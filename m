From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/5] ACPI: update feature-removal.txt to reflect deleted
 acpi=ht option
Date: Fri, 04 Jun 2010 15:47:23 -0400
Message-ID: <0a76a34ff0804f1f413807b2e2d12117c2b602ca.1275680785.git.len.brown@intel.com>
References: <1275680845-8352-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:54318 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab0FDTrn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:47:43 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I006CL9N6N6R1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:47:30 -0500 (CDT)
In-reply-to: <1275680845-8352-1-git-send-email-lenb@kernel.org>
In-reply-to: <d5a64513c6a171262082c250592c062e97a2c693.1275680785.git.len.brown@intel.com>
References: <d5a64513c6a171262082c250592c062e97a2c693.1275680785.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Per plan, acpi=ht was removed in 2.6.35-rc1.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 672be01..c268783 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -578,15 +578,6 @@ Who:	Avi Kivity <avi@redhat.com>
 
 ----------------------------
 
-What: 	"acpi=ht" boot option
-When:	2.6.35
-Why:	Useful in 2003, implementation is a hack.
-	Generally invoked by accident today.
-	Seen as doing more harm than good.
-Who:	Len Brown <len.brown@intel.com>
-
-----------------------------
-
 What:	iwlwifi 50XX module parameters
 When:	2.6.40
 Why:	The "..50" modules parameters were used to configure 5000 series and
-- 
1.6.0.6

