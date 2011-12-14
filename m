From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ACPI: kernel-parameters.txt : Add intel_idle.max_cstate
Date: Thu, 15 Dec 2011 01:18:52 +0900
Message-ID: <1323879532-10490-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from i118-21-156-233.s30.a048.ap.plala.or.jp ([118.21.156.233]:38889
	"EHLO rinabert.homeip.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755296Ab1LNRML (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Dec 2011 12:12:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rdunlap@xenotime.net, lenb@kernel.org, Masanari Iida <standby24x7@gmail.com>

Add missing intel_idle.max_cstate in kernel-parameters.txt

Signed-off-by Masanari Iida <standby24x7@gmail.com>
cc:Len Brown <lenb@kernel.org>
cc:Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/kernel-parameters.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 81c287f..c6a56d8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1035,6 +1035,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			By default, super page will be supported if Intel IOMMU
 			has the capability. With this option, super page will
 			not be supported.
+
+	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
+			0	disables intel_idle and fall back on acpi_idle.
+			1 to 6	specify maximum depth of C-state.
+
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
 			off	disable Interrupt Remapping
-- 
1.7.6.4

