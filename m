From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 11/21] ACPI: ibm-acpi: extend fan status functions
Date: Sat, 25 Nov 2006 18:45:37 -0200
Message-ID: <20061125204537.6604.80245.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47011 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967188AbWKYUpe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 15:45:34 -0500
In-Reply-To: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This patch fixes fan_read to return correct values for all fan access
modes.  It also implements some fan access mode status output that was
missing, and normalizes the proc fan abi to return consistent data across
all fan read/write modes.

Userspace ABI changes and extensions:
	1. Return status: enable/disable for *all* modes
	   (this actually improves compatibility with userspace utils!)
	2. Return level: auto and level: disengaged for EC 2f access mode
	3. Return level: <number> for EC 0x2f access mode
	4. Return level 0 as well as "disabled" in level-aware modes

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

 drivers/acpi/ibm_acpi.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index ccbb17c..2dc36e7 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -354,6 +354,11 @@ enum {					/* Fan control constants */
 	fan_status_offset = 0x2f,	/* EC register 0x2f */
 	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
 					 * 0x84 must be read before 0x85 */
+
+	IBMACPI_FAN_EC_DISENGAGED 	= 0x40,	/* EC mode: tachometer
+						 * disengaged */
+	IBMACPI_FAN_EC_AUTO		= 0x80, /* EC mode: auto fan
+						 * control */
 };
 
 static int ibm_thinkpad_ec_found;
@@ -1910,8 +1915,9 @@ static int fan_read(char *p)
 		if ((rc = fan_get_status(&status)) < 0)
 			return rc;
 
-		len += sprintf(p + len, "level:\t\t%d\n", status);
-
+		len += sprintf(p + len, "status:\t\t%s\n"
+			       "level:\t\t%d\n",
+			       (status != 0) ? "enabled" : "disabled", status);
 		break;
 
 	case IBMACPI_FAN_RD_TPEC:
@@ -1919,12 +1925,21 @@ static int fan_read(char *p)
 		if ((rc = fan_get_status(&status)) < 0)
 			return rc;
 
-		len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 7));
+		len += sprintf(p + len, "status:\t\t%s\n",
+			       (status != 0) ? "enabled" : "disabled");
 
 		if ((rc = fan_get_speed(&speed)) < 0)
 			return rc;
 
 		len += sprintf(p + len, "speed:\t\t%d\n", speed);
+
+		if (status & IBMACPI_FAN_EC_DISENGAGED)
+			/* Disengaged mode takes precedence */
+			len += sprintf(p + len, "level:\t\tdisengaged\n");
+		else if (status & IBMACPI_FAN_EC_AUTO)
+			len += sprintf(p + len, "level:\t\tauto\n");
+		else
+			len += sprintf(p + len, "level:\t\t%d\n", status);
 		break;
 
 	case IBMACPI_FAN_NONE:
