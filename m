From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 07/21] ACPI: ibm-acpi: clean up fan_read
Date: Sat, 25 Nov 2006 18:44:16 -0200
Message-ID: <20061125204416.6604.62583.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20061125204155.6604.35338.stgit-H32KNTuDSMjdPi8JTuvWk31TOOPCyuNQ5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>

This patch cleans up fan_read so that it is much easier to read and
extend.

The patch fixes the userspace ABI to return "status: not supported" (like
all other ibm-acpi functions) when neither fan status or fan control are
possible.

It also fixes the userspace ABI to return EIO if ACPI access to the EC
fails, instead of returning "status: unreadable" or "speed: unreadable".

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 drivers/acpi/ibm_acpi.c |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 4c836e2..ef8ac01 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1741,40 +1741,48 @@ static int fan_init(void)
 static int fan_read(char *p)
 {
 	int len = 0;
-	int s;
 	u8 lo, hi, status;
 
-	if (gfan_handle) {
+	switch (fan_status_access_mode) {
+	case IBMACPI_FAN_RD_ACPI_GFAN:
 		/* 570, 600e/x, 770e, 770x */
-		if (!acpi_evalf(gfan_handle, &s, NULL, "d"))
+		if (unlikely(!acpi_evalf(gfan_handle, &status, NULL, "d")))
 			return -EIO;
 
-		len += sprintf(p + len, "level:\t\t%d\n", s);
-	} else {
+		len += sprintf(p + len, "level:\t\t%d\n", status);
+
+		break;
+
+	case IBMACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
-		if (!acpi_ec_read(fan_status_offset, &status))
-			len += sprintf(p + len, "status:\t\tunreadable\n");
+		if (unlikely(!acpi_ec_read(fan_status_offset, &status)))
+			return -EIO;
 		else
 			len += sprintf(p + len, "status:\t\t%s\n",
 				       enabled(status, 7));
 
-		if (!acpi_ec_read(fan_rpm_offset, &lo) ||
-		    !acpi_ec_read(fan_rpm_offset + 1, &hi))
-			len += sprintf(p + len, "speed:\t\tunreadable\n");
+		if (unlikely(!acpi_ec_read(fan_rpm_offset, &lo) ||
+			     !acpi_ec_read(fan_rpm_offset + 1, &hi)))
+			return -EIO;
 		else
 			len += sprintf(p + len, "speed:\t\t%d\n",
 				       (hi << 8) + lo);
+
+		break;
+
+	case IBMACPI_FAN_NONE:
+	default:
+		len += sprintf(p + len, "status:\t\tnot supported\n");
 	}
 
-	if (sfan_handle)
-		/* 570, 770x-JL */
+	if (fan_control_commands & IBMACPI_FAN_CMD_LEVEL)
 		len += sprintf(p + len, "commands:\tlevel <level>"
 			       " (<level> is 0-7)\n");
-	if (!gfan_handle)
-		/* all except 570, 600e/x, 770e, 770x */
+
+	if (fan_control_commands & IBMACPI_FAN_CMD_ENABLE)
 		len += sprintf(p + len, "commands:\tenable, disable\n");
-	if (fans_handle)
-		/* X31, X40 */
+
+	if (fan_control_commands & IBMACPI_FAN_CMD_SPEED)
 		len += sprintf(p + len, "commands:\tspeed <speed>"
 			       " (<speed> is 0-65535)\n");
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
