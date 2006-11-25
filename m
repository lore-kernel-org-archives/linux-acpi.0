From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 08/21] ACPI: ibm-acpi: break fan_read into
	separate functions
Date: Sat, 25 Nov 2006 18:44:36 -0200
Message-ID: <20061125204436.6604.29730.stgit@thorin.khazad-dum.debian.net>
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

This patch breaks fan_read mechanics into a generic function to get fan
status and speed, and leaves only the procfs interface code in fan_read.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 drivers/acpi/ibm_acpi.c |   78 ++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index ef8ac01..834485b 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1738,36 +1738,90 @@ static int fan_init(void)
 	return 0;
 }
 
-static int fan_read(char *p)
+static int fan_get_status(u8 *status)
 {
-	int len = 0;
-	u8 lo, hi, status;
+	u8 s;
 
 	switch (fan_status_access_mode) {
 	case IBMACPI_FAN_RD_ACPI_GFAN:
 		/* 570, 600e/x, 770e, 770x */
-		if (unlikely(!acpi_evalf(gfan_handle, &status, NULL, "d")))
+
+		if (unlikely(!acpi_evalf(gfan_handle, &s, NULL, "d")))
 			return -EIO;
 
-		len += sprintf(p + len, "level:\t\t%d\n", status);
+		if (likely(status))
+			*status = s & 0x07;
 
 		break;
 
 	case IBMACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
-		if (unlikely(!acpi_ec_read(fan_status_offset, &status)))
+		if (unlikely(!acpi_ec_read(fan_status_offset, &s)))
 			return -EIO;
-		else
-			len += sprintf(p + len, "status:\t\t%s\n",
-				       enabled(status, 7));
 
+		if (likely(status))
+			*status = s;
+
+		break;
+
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int fan_get_speed(unsigned int *speed)
+{
+	u8 hi, lo;
+
+	switch (fan_status_access_mode) {
+	case IBMACPI_FAN_RD_TPEC:
+		/* all except 570, 600e/x, 770e, 770x */
 		if (unlikely(!acpi_ec_read(fan_rpm_offset, &lo) ||
 			     !acpi_ec_read(fan_rpm_offset + 1, &hi)))
 			return -EIO;
-		else
-			len += sprintf(p + len, "speed:\t\t%d\n",
-				       (hi << 8) + lo);
 
+		if (likely(speed))
+			*speed = (hi << 8) | lo;
+
+		break;
+
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int fan_read(char *p)
+{
+	int len = 0;
+	int rc;
+	u8 status;
+	unsigned int speed = 0;
+
+	switch (fan_status_access_mode) {
+	case IBMACPI_FAN_RD_ACPI_GFAN:
+		/* 570, 600e/x, 770e, 770x */
+		if ((rc = fan_get_status(&status)) < 0)
+			return rc;
+
+		len += sprintf(p + len, "level:\t\t%d\n", status);
+
+		break;
+
+	case IBMACPI_FAN_RD_TPEC:
+		/* all except 570, 600e/x, 770e, 770x */
+		if ((rc = fan_get_status(&status)) < 0)
+			return rc;
+
+		len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 7));
+
+		if ((rc = fan_get_speed(&speed)) < 0)
+			return rc;
+
+		len += sprintf(p + len, "speed:\t\t%d\n", speed);
 		break;
 
 	case IBMACPI_FAN_NONE:

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
