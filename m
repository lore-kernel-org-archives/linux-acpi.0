From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/10] thinkpad-acpi: wrong thermal attribute_group removed in
 thermal_exit()
Date: Tue, 16 Feb 2010 04:46:05 -0500
Message-ID: <f04d5e012d73ea441bd39804ace39fd6d1ce5611.1266313501.git.len.brown@intel.com>
References: <1266313570-6490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:40190 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab0BPJqS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 04:46:18 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXX006VJHT4K9S5@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 03:46:16 -0600 (CST)
In-reply-to: <1266313570-6490-1-git-send-email-lenb@kernel.org>
In-reply-to: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
References: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Roel Kluin <roel.kluin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Roel Kluin <roel.kluin@gmail.com>

sysfs_remove_group() removed the wrong attribute_group for
thermal_read_mode TPEC_8, ACPI_TMP07 and ACPI_UPDT

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e67e4fe..eb603f1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -5771,7 +5771,7 @@ static void thermal_exit(void)
 	case TPACPI_THERMAL_ACPI_TMP07:
 	case TPACPI_THERMAL_ACPI_UPDT:
 		sysfs_remove_group(&tpacpi_sensors_pdev->dev.kobj,
-				   &thermal_temp_input16_group);
+				   &thermal_temp_input8_group);
 		break;
 	case TPACPI_THERMAL_NONE:
 	default:
-- 
1.6.0.6

