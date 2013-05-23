From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH 2/2 V3] ACPI/APEI: Update einj documentation for param1/param2
Date: Wed, 22 May 2013 22:32:03 -0400
Message-ID: <1369276323-31436-3-git-send-email-gong.chen@linux.intel.com>
References: <1369276323-31436-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58050 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757003Ab3EWCis (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 May 2013 22:38:48 -0400
In-Reply-To: <1369276323-31436-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

To ensure EINJ working well when injecting errors via EINJ
table, add some attentions for param1/param2.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 Documentation/acpi/apei/einj.txt |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/acpi/apei/einj.txt
index e20b6da..3b08e62 100644
--- a/Documentation/acpi/apei/einj.txt
+++ b/Documentation/acpi/apei/einj.txt
@@ -47,11 +47,15 @@ directory apei/einj. The following files are provided.
 
 - param1
   This file is used to set the first error parameter value. Effect of
-  parameter depends on error_type specified.
+  parameter depends on error_type specified. For example, if error
+  type is memory related type, the param1 should be a valid physical
+  memory address.
 
 - param2
   This file is used to set the second error parameter value. Effect of
-  parameter depends on error_type specified.
+  parameter depends on error_type specified. For example, if error
+  type is memory related type, the param2 should be a valid physical
+  memory address mask, say, 0xfffffffffffff000.
 
 - notrigger
   The EINJ mechanism is a two step process. First inject the error, then
-- 
1.7.10.4

