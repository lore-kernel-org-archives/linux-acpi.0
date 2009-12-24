From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/34] MAINTAINERS: add maintainer for msi-wmi driver
Date: Thu, 24 Dec 2009 01:23:51 -0500
Message-ID: <0f1006b1f2b7862e35973c53cc4f99bea65d5a1d.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbZLXTbH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:07 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:30:54 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Anisse Astier <anisse@astier.eu>, Len Brown <len.brown@intel.com>

From: Anisse Astier <anisse@astier.eu>

Signed-off-by: Anisse Astier <anisse@astier.eu>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index efd2ef2..eefe439 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3644,6 +3644,11 @@ W:	http://0pointer.de/lennart/tchibo.html
 S:	Maintained
 F:	drivers/platform/x86/msi-laptop.c
 
+MSI WMI SUPPORT
+M:	Anisse Astier <anisse@astier.eu>
+S:	Supported
+F:	drivers/platform/x86/msi-wmi.c
+
 MULTIFUNCTION DEVICES (MFD)
 M:	Samuel Ortiz <sameo@linux.intel.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sameo/mfd-2.6.git
-- 
1.6.0.6

