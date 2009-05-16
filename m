From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/19] eeepc-laptop: support for super hybrid engine (SHE)
Date: Sat, 16 May 2009 02:02:06 -0400
Message-ID: <158ca1d75dd0d6223f3b1dd741d30777da62ab80.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:10610 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbZEPGCX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:23 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ00FBN3FZEB1K@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:24 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Grigori Goronzy <greg@chown.ath.cx>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Grigori Goronzy <greg@chown.ath.cx>

The older eeepc-acpi driver allowed to control the SHE performance
preset through a ACPI function for just this purpose. SHE underclocks
and undervolts the FSB and undervolts the CPU (at preset 2,
"powersave"), or slightly overclocks the CPU (at preset 0,
"performance"). Preset 1 is the default setting with default clocks and
voltage.

The new eeepc-laptop driver doesn't support it anymore.
The attached patch adds support for it to eeepc-laptop. It's very
straight-forward and almost trivial.

Signed-off-by: Grigori Goronzy <greg@chown.ath.cx>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 57f21f0..7aaf587 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -384,11 +384,13 @@ static ssize_t show_sys_acpi(int cm, char *buf)
 EEEPC_CREATE_DEVICE_ATTR(camera, CM_ASL_CAMERA);
 EEEPC_CREATE_DEVICE_ATTR(cardr, CM_ASL_CARDREADER);
 EEEPC_CREATE_DEVICE_ATTR(disp, CM_ASL_DISPLAYSWITCH);
+EEEPC_CREATE_DEVICE_ATTR(cpufv, CM_ASL_CPUFV);
 
 static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_disp.attr,
+	&dev_attr_cpufv.attr,
 	NULL
 };
 
-- 
1.6.0.6

