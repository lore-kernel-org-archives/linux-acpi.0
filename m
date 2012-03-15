From: Chen Gong <gong.chen@linux.intel.com>
Subject: [v2 PATCH 2/2] Update documentation for parameter *notrigger* in einj.txt
Date: Thu, 15 Mar 2012 16:53:37 +0800
Message-ID: <1331801617-15882-3-git-send-email-gong.chen@linux.intel.com>
References: <1331801617-15882-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35794 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760710Ab2COIwj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2012 04:52:39 -0400
In-Reply-To: <1331801617-15882-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

Add description of parameter notrigger in the einj.txt.
One can utilize this new parameter to do some SRAR injection
test. Pay attention, the operation is highly depended on the
BIOS implementation. If no proper BIOS supports it, even if
enabling this parameter, expected result will not happen.

v2:
  Update the documentation suggested by Tony

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 Documentation/acpi/apei/einj.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/acpi/apei/einj.txt
index e7cc363..e20b6da 100644
--- a/Documentation/acpi/apei/einj.txt
+++ b/Documentation/acpi/apei/einj.txt
@@ -53,6 +53,14 @@ directory apei/einj. The following files are provided.
   This file is used to set the second error parameter value. Effect of
   parameter depends on error_type specified.
 
+- notrigger
+  The EINJ mechanism is a two step process. First inject the error, then
+  perform some actions to trigger it. Setting "notrigger" to 1 skips the
+  trigger phase, which *may* allow the user to cause the error in some other
+  context by a simple access to the cpu, memory location, or device that is
+  the target of the error injection. Whether this actually works depends
+  on what operations the BIOS actually includes in the trigger phase.
+
 BIOS versions based in the ACPI 4.0 specification have limited options
 to control where the errors are injected.  Your BIOS may support an
 extension (enabled with the param_extension=1 module parameter, or
-- 
1.7.8.2.302.g17b4e

