From: Len Brown <len.brown@intel.com>
Subject: [PATCH 024/105] ACPI: ibm-acpi: kill trailing whitespace
Date: Sun, 29 Apr 2007 00:50:24 -0400
Message-ID: <1177822326583-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58359 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614AbXD2EwH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:07 -0400
In-Reply-To: <11778223251849-git-send-email-len.brown@intel.com>
Message-Id: <837ca6ddb440c186eaa8e01b69486581d3457f2c.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

I shall protect the ibm-acpi city against the invasion of the barbarian
blanks!  To the unforgiving jaws of sed s/[[:blank:]]\+$// they go!

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/ibm-acpi.txt |    6 +++---
 drivers/acpi/ibm_acpi.c    |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
index 0132d36..cdcef01 100644
--- a/Documentation/ibm-acpi.txt
+++ b/Documentation/ibm-acpi.txt
@@ -21,7 +21,7 @@ detailed description):
 
 	- Fn key combinations
 	- Bluetooth enable and disable
-	- video output switching, expansion control	
+	- video output switching, expansion control
 	- ThinkLight on and off
 	- limited docking and undocking
 	- UltraBay eject
@@ -472,7 +472,7 @@ This feature dumps the values of 256 embedded controller
 registers. Values which have changed since the last time the registers
 were dumped are marked with a star:
 
-[root@x40 ibm-acpi]# cat /proc/acpi/ibm/ecdump 
+[root@x40 ibm-acpi]# cat /proc/acpi/ibm/ecdump
 EC       +00 +01 +02 +03 +04 +05 +06 +07 +08 +09 +0a +0b +0c +0d +0e +0f
 EC 0x00:  a7  47  87  01  fe  96  00  08  01  00  cb  00  00  00  40  00
 EC 0x10:  00  00  ff  ff  f4  3c  87  09  01  ff  42  01  ff  ff  0d  00
@@ -503,7 +503,7 @@ vary. The second ensures that the fan-related values do vary, since
 the fan speed fluctuates a bit. The third will (hopefully) mark the
 fan register with a star:
 
-[root@x40 ibm-acpi]# cat /proc/acpi/ibm/ecdump 
+[root@x40 ibm-acpi]# cat /proc/acpi/ibm/ecdump
 EC       +00 +01 +02 +03 +04 +05 +06 +07 +08 +09 +0a +0b +0c +0d +0e +0f
 EC 0x00:  a7  47  87  01  fe  96  00  08  01  00  cb  00  00  00  40  00
 EC 0x10:  00  00  ff  ff  f4  3c  87  09  01  ff  42  01  ff  ff  0d  00
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index dc10966..60aaed9 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -28,7 +28,7 @@
  *  2006-11-22	0.13	new maintainer
  *  			changelog now lives in git commit history, and will
  *  			not be updated further in-file.
- *  
+ *
  *  2005-08-17  0.12	fix compilation on 2.6.13-rc kernels
  *  2005-03-17	0.11	support for 600e, 770x
  *			    thanks to Jamie Lentin <lentinj@dial.pipex.com>
@@ -38,7 +38,7 @@
  *			experimental brightness control
  *			experimental volume control
  *			experimental fan enable/disable
- *  2005-01-16	0.10	fix module loading on R30, R31 
+ *  2005-01-16	0.10	fix module loading on R30, R31
  *  2005-01-16	0.9	support for 570, R30, R31
  *			ultrabay support on A22p, A3x
  *			limit arg for cmos, led, beep, drop experimental status
@@ -161,7 +161,7 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 #ifdef CONFIG_ACPI_IBM_BAY
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
-	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */ 
+	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */
 	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
     );				/* A21e, R30, R31 */
 
-- 
1.5.2.rc0.34.gda94
