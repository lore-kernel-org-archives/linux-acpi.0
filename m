From: rzhang1 <rui.zhang@intel.com>
Subject: [PATCH] ACPI: update ACPI_PROCFS removal schedule
Date: Thu, 12 Jul 2007 18:20:34 +0800
Message-ID: <1184235634.6286.2.camel@rzhang1-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3584 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbXGLKUq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jul 2007 06:20:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org

From: Zhang Rui <rui.zhang@intel.com>

ACPI sysfs conversion is not finished yet and
some user space tools still depend on the ACPI procfs I/F.

The ACPI_PROCFS removal schedule is changed to Jan 08.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/feature-removal-schedule.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.22/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.22.orig/Documentation/feature-removal-schedule.txt	2007-07-12 17:50:46.000000000 +0800
+++ linux-2.6.22/Documentation/feature-removal-schedule.txt	2007-07-12 18:03:31.000000000 +0800
@@ -243,7 +243,7 @@
 ---------------------------
 
 What:	ACPI procfs interface
-When:	July 2007
+When:	January 2008
 Why:	After ACPI sysfs conversion, ACPI attributes will be duplicated
 	in sysfs and the ACPI procfs interface should be removed.
 Who:	Zhang Rui <rui.zhang@intel.com>
