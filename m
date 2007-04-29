From: Len Brown <len.brown@intel.com>
Subject: [PATCH 036/105] ACPI: thinkpad-acpi: update MAINTAINERS
Date: Sun, 29 Apr 2007 00:50:36 -0400
Message-ID: <11778223401417-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9417 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590AbXD2EwV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:21 -0400
In-Reply-To: <11778223392178-git-send-email-len.brown@intel.com>
Message-Id: <756970ad4bb93027a60da2de9b43d094b7f387a2.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update MAINTAINERS file for the ibm-acpi -> thinkpad-acpi renaming.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd6978b..7d42183 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1618,15 +1618,6 @@ W:	http://www.ia64-linux.org/
 T:	git kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
 S:	Maintained
 
-IBM ACPI EXTRAS DRIVER
-P:	Henrique de Moraes Holschuh
-M:	ibm-acpi@hmh.eng.br
-L:	ibm-acpi-devel@lists.sourceforge.net
-W:	http://ibm-acpi.sourceforge.net
-W:	http://thinkwiki.org/wiki/Ibm-acpi
-T:	git repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
-S:	Maintained
-
 SN-IA64 (Itanium) SUB-PLATFORM
 P:	Jes Sorensen
 M:	jes@sgi.com
@@ -3118,6 +3109,15 @@ P:	Chris Zankel
 M:	chris@zankel.net
 S:	Maintained
 
+THINKPAD ACPI EXTRAS DRIVER
+P:	Henrique de Moraes Holschuh
+M:	ibm-acpi@hmh.eng.br
+L:	ibm-acpi-devel@lists.sourceforge.net
+W:	http://ibm-acpi.sourceforge.net
+W:	http://thinkwiki.org/wiki/Ibm-acpi
+T:	git repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
+S:	Maintained
+
 UltraSPARC (sparc64):
 P:	David S. Miller
 M:	davem@davemloft.net
-- 
1.5.2.rc0.34.gda94
