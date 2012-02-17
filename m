From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH 2/2] Update documentation for parameter *notrigger* in einj.txt
Date: Fri, 17 Feb 2012 15:11:05 +0800
Message-ID: <1329462665-4040-2-git-send-email-gong.chen@linux.intel.com>
References: <1329462665-4040-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20403 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433Ab2BQHKV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Feb 2012 02:10:21 -0500
In-Reply-To: <1329462665-4040-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

Add description of parameter notrigger in the einj.txt.
One can utilize this new parameter to do some SRAR injection
test. Pay attention, the operation is highly depended on the
BIOS implementation. If no proper BIOS supports it, even if
enabling this parameter, expected result will not happen.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 Documentation/acpi/apei/einj.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/acpi/apei/einj.txt
index e7cc363..45ff681 100644
--- a/Documentation/acpi/apei/einj.txt
+++ b/Documentation/acpi/apei/einj.txt
@@ -53,6 +53,12 @@ directory apei/einj. The following files are provided.
   This file is used to set the second error parameter value. Effect of
   parameter depends on error_type specified.
 
+- notrigger
+  This file is used to set whether or not exectuing trigger action by
+  the user. When set to 1, it means trigger action is executed by
+  the user, otherwise the trigger action is executed by the kernel.
+  It is useful when injecting one SRAR in the user context situation.
+
 BIOS versions based in the ACPI 4.0 specification have limited options
 to control where the errors are injected.  Your BIOS may support an
 extension (enabled with the param_extension=1 module parameter, or
-- 
1.7.8.2.302.g17b4e

