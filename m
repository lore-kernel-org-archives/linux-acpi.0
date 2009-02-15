From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] thinkpad-acpi: fix module autoloading for older models
Date: Sun, 15 Feb 2009 10:25:51 -0300
Message-ID: <1234704351-24093-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59605 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753828AbZBONZy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Feb 2009 08:25:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Mathieu Chouquet-Stringer <mchouque@free.fr>, stable@kernel.org

From: Mathieu Chouquet-Stringer <mchouque@free.fr>

Looking at the source, there seems to be a missing * to match my DMI
string.  I mean for newer IBM and Lenovo's laptops you match either one
of the following:
MODULE_ALIAS("dmi:bvnIBM:*:svnIBM:*:pvrThinkPad*:rvnIBM:*");
MODULE_ALIAS("dmi:bvnLENOVO:*:svnLENOVO:*:pvrThinkPad*:rvnLENOVO:*");

While for older Thinkpads, you do this (for instance):
IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");

with IBM_BIOS_MODULE_ALIAS being MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW")

Note there's no * terminating the string.  As result, udev doesn't load
anything because modprobe cannot find anything matching this (my
machine actually):

udevtest: run: '/sbin/modprobe dmi:bvnIBM:bvr1IET71WW(2.10):bd06/16/2006:svnIBM:pn236621U:pvrNotAvailable:rvnIBM:rn236621U:rvrNotAvailable:cvnIBM:ct10:cvrNotAvailable:'

Signed-off-by: Mathieu Chouquet-Stringer <mchouque@free.fr>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: stable@kernel.org
---
 drivers/platform/x86/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


Len, please consider this for 2.6.29.  It is an obvious one-liner.

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 91ae159..d218ecb 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7524,7 +7524,7 @@ MODULE_ALIAS(TPACPI_DRVR_SHORTNAME);
  * if it is not there yet.
  */
 #define IBM_BIOS_MODULE_ALIAS(__type) \
-	MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW")
+	MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW*")
 
 /* Non-ancient thinkpads */
 MODULE_ALIAS("dmi:bvnIBM:*:svnIBM:*:pvrThinkPad*:rvnIBM:*");
-- 
1.5.6.5

