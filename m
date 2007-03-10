From: Len Brown <len.brown@intel.com>
Subject: [PATCH 08/20] ACPI: Add kernel-parameters hint that acpi=off doesn't work on IA64.
Date: Fri,  9 Mar 2007 22:49:26 -0500
Message-ID: <1173498585454-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48279 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837AbXCJDtq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:46 -0500
In-Reply-To: <11734985842575-git-send-email-len.brown@intel.com>
Message-Id: <03d926f82800f32642b32ba547c7a002a371a78f.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bernhard Walle <bwalle@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Bernhard Walle <bwalle@suse.de>

Signed-off-by: Bernhard Walle <bwalle@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 6e92ba6..7702e3d 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -125,7 +125,8 @@ and is between 256 and 4096 characters. It is defined in the file
 			See header of drivers/scsi/53c7xx.c.
 			See also Documentation/scsi/ncr53c7xx.txt.
 
-	acpi=		[HW,ACPI] Advanced Configuration and Power Interface
+	acpi=		[HW,ACPI,X86-64,i386]
+			Advanced Configuration and Power Interface
 			Format: { force | off | ht | strict | noirq }
 			force -- enable ACPI if default was off
 			off -- disable ACPI if default was on
-- 
1.5.0.3.310.g05ef5
