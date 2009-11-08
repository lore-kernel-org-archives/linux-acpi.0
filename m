From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/12] thermal: sysfs-api.txt - document passive attribute for
 thermal zones
Date: Sat, 07 Nov 2009 21:57:12 -0500
Message-ID: <29226ed3c3b5cd0b2b0b1fb40ffeac3f796b80e9.1257648660.git.len.brown@intel.com>
References: <1257649034-7494-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:15988 "EHLO
	vms173001.mailsrvcs.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753150AbZKHC5X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 21:57:23 -0500
Received: from localhost.localdomain ([unknown] [74.104.150.83])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KSR00IN0S7NA171@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Nov 2009 20:57:28 -0600 (CST)
In-reply-to: <1257649034-7494-1-git-send-email-lenb@kernel.org>
In-reply-to: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
References: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Frans Pop <elendil@planet.nl>

Signed-off-by: Frans Pop <elendil@planet.nl>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thermal/sysfs-api.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 895337f..a87dc27 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -199,6 +199,15 @@ cdev[0-*]_trip_point
 	point.
 	RO, Optional
 
+passive
+	Attribute is only present for zones in which the passive cooling
+	policy is not supported by native thermal driver. Default is zero
+	and can be set to a temperature (in millidegrees) to enable a
+	passive trip point for the zone. Activation is done by polling with
+	an interval of 1 second.
+	Unit: millidegrees Celsius
+	RW, Optional
+
 *****************************
 * Cooling device attributes *
 *****************************
-- 
1.6.0.6

