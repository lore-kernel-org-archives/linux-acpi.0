From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/34] ACPI: processor: remove _PDC object list from struct
 acpi_processor
Date: Thu, 24 Dec 2009 01:23:48 -0500
Message-ID: <e59897fe443b5b0a71e135ef4020d1937c9f8901.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbZLXTbI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:08 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:30:56 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

When we call _PDC, we get a handle to the processor, allocate the
object list buffer as needed, and free it immediately after calling
_PDC.

There's no need to drag around this object list with us everywhere
else, so let's just get rid of it.

Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/processor.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 7cc433d..0ea5ef4 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -224,8 +224,6 @@ struct acpi_processor {
 	struct acpi_processor_throttling throttling;
 	struct acpi_processor_limit limit;
 	struct thermal_cooling_device *cdev;
-	/* the _PDC objects for this processor, if any */
-	struct acpi_object_list *pdc;
 };
 
 struct acpi_processor_errata {
-- 
1.6.0.6

