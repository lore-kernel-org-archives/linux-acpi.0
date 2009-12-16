From: "Youquan,Song" <youquan.song@linux.intel.com>
Subject: [PATCH]acpi cpuidle: Fix kernel oops when tickless is not enabled
Date: Wed, 16 Dec 2009 09:17:22 -0500
Message-ID: <20091216141721.GA27614@youquan-linux.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:10961 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932378AbZLPGl5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 01:41:57 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: venkatesh.pallipadi@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, jane.lv@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org

Current kernel, if tickless is disabled,cpuidle governor ladder is built in,
 the kernel will boot oops on Boxboro-EX. 

After check in driver/cpuidle/Kconfig, menu governor built in kernel depends 
on tickless,but ladder governor has no such dependency.

This patch add depnencey for ladder governor, so when tickless is disabled,
 ladder governor will not be built in.

This is workround patch and the complete fix need be done at tickless. 

Signed-off-by: Youquan, Song <youquan.song@intel.com>
---

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 7dbc4a8..78d6d74 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -11,7 +11,7 @@ config CPU_IDLE
 
 config CPU_IDLE_GOV_LADDER
 	bool
-	depends on CPU_IDLE
+	depends on CPU_IDLE && NO_HZ
 	default y
 
 config CPU_IDLE_GOV_MENU
