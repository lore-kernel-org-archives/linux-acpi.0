From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: update ACPI proc I/F removal schedule
Date: Wed, 18 Jul 2007 17:23:24 +0800
Message-ID: <1184750604.8054.16.camel@rzhang1-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38233 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbXGRJXg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jul 2007 05:23:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org, satyam.sharma@gmail.com, seife@suse.de

ACPI sysfs conversion is not finished yet and
some user space tools still depend on the ACPI proc I/F.

We plan to finish all the sysfs conversion by January 2008
and remove the ACPI proc I/F in July 2008.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/feature-removal-schedule.txt |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.22/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.22.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6.22/Documentation/feature-removal-schedule.txt
@@ -243,9 +243,10 @@ Who:	Len Brown <len.brown@intel.com>
 ---------------------------
 
 What:	ACPI procfs interface
-When:	July 2007
-Why:	After ACPI sysfs conversion, ACPI attributes will be duplicated
-	in sysfs and the ACPI procfs interface should be removed.
+When:	July 2008
+Why:	ACPI sysfs conversion should be finished by January 2008.
+	ACPI procfs interface will be removed in July 2008 so that
+	there is enough time for the user space to catch up.
 Who:	Zhang Rui <rui.zhang@intel.com>
 
 ---------------------------
