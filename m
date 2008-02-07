From: Len Brown <lenb@kernel.org>
Subject: [PATCH 003/112] ACPI: CONFIG_CPU_IDLE=ACPI by default
Date: Thu,  7 Feb 2008 04:33:25 -0500
Message-ID: <60555e371d56a1e410d9fb6fc68f4e953f8f4109.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754176AbYBGJfV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:21 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "len.brown@intel.com" <len.brown@intel.com>

From: len.brown@intel.com <len.brown@intel.com>

In Linux-2.6.24, CPU_IDLE went upstream, default =n.
For Linux-2.6.25, enable it by default on ACPI systems.
For Linux-2.6.26, we plan to enable it always on ACPI systems.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 3bed412..7dbc4a8 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -1,13 +1,13 @@
 
 config CPU_IDLE
 	bool "CPU idle PM support"
+	default ACPI
 	help
 	  CPU idle is a generic framework for supporting software-controlled
 	  idle processor power management.  It includes modular cross-platform
 	  governors that can be swapped during runtime.
 
-	  If you're using a mobile platform that supports CPU idle PM (e.g.
-	  an ACPI-capable notebook), you should say Y here.
+	  If you're using an ACPI-enabled platform, you should say Y here.
 
 config CPU_IDLE_GOV_LADDER
 	bool
-- 
1.5.4.23.gef5b9

