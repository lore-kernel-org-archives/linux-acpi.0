From: akpm@linux-foundation.org
Subject: [patch 6/7] thinkpad-acpi: wrong thermal attribute_group removed in thermal_exit()
Date: Tue, 02 Feb 2010 14:37:58 -0800
Message-ID: <201002022237.o12Mbwo6018696@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55266 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932103Ab0BBWjL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2010 17:39:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, roel.kluin@gmail.com, ibm-acpi@hmh.eng.br

From: Roel Kluin <roel.kluin@gmail.com>

sysfs_remove_group() removed the wrong attribute_group for
thermal_read_mode TPEC_8, ACPI_TMP07 and ACPI_UPDT

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/thinkpad_acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/platform/x86/thinkpad_acpi.c~thinkpad-acpi-wrong-thermal-attribute_group-removed-in-thermal_exit drivers/platform/x86/thinkpad_acpi.c
--- a/drivers/platform/x86/thinkpad_acpi.c~thinkpad-acpi-wrong-thermal-attribute_group-removed-in-thermal_exit
+++ a/drivers/platform/x86/thinkpad_acpi.c
@@ -5771,7 +5771,7 @@ static void thermal_exit(void)
 	case TPACPI_THERMAL_ACPI_TMP07:
 	case TPACPI_THERMAL_ACPI_UPDT:
 		sysfs_remove_group(&tpacpi_sensors_pdev->dev.kobj,
-				   &thermal_temp_input16_group);
+				   &thermal_temp_input8_group);
 		break;
 	case TPACPI_THERMAL_NONE:
 	default:
_
