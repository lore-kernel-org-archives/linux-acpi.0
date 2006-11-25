From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 12/21] ACPI: ibm-acpi: fix and extend fan
	enable
Date: Sat, 25 Nov 2006 18:45:57 -0200
Message-ID: <20061125204557.6604.78866.stgit@thorin.khazad-dum.debian.net>
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

This patch fix fan enable to attempt to do the right thing and not slow
down the fan if it is forced to the maximum speed.  It also extends fan
enable to work on older thinkpads.

ABI changes:
	1.  Support enable/disable for all level-based write access modes

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 drivers/acpi/ibm_acpi.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 2dc36e7..001a5e9 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1820,7 +1820,8 @@ static int fan_init(void)
 	if (sfan_handle) {
 		/* 570, 770x-JL */
 		fan_control_access_mode = IBMACPI_FAN_WR_ACPI_SFAN;
-		fan_control_commands |= IBMACPI_FAN_CMD_LEVEL;
+		fan_control_commands |=
+		    IBMACPI_FAN_CMD_LEVEL | IBMACPI_FAN_CMD_ENABLE;
 	} else {
 		if (!gfan_handle) {
 			/* gfan without sfan means no fan control */
@@ -1980,10 +1981,34 @@ static int fan_set_level(int level)
 
 static int fan_set_enable(void)
 {
+	u8 s;
+	int rc;
+
 	switch (fan_control_access_mode) {
 	case IBMACPI_FAN_WR_ACPI_FANS:
 	case IBMACPI_FAN_WR_TPEC:
-		if (!acpi_ec_write(fan_status_offset, 0x80))
+		if ((rc = fan_get_status(&s)) < 0)
+			return rc;
+
+		/* Don't go out of emergency fan mode */
+		if (s != 7)
+			s = IBMACPI_FAN_EC_AUTO;
+
+		if (!acpi_ec_write(fan_status_offset, s))
+			return -EIO;
+		break;
+
+	case IBMACPI_FAN_WR_ACPI_SFAN:
+		if ((rc = fan_get_status(&s)) < 0)
+			return rc;
+
+		s &= 0x07;
+
+		/* Set fan to at least level 4 */
+		if (s < 4)
+			s = 4;
+
+		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", s))
 			return -EIO;
 		break;
 
@@ -2002,6 +2027,11 @@ static int fan_set_disable(void)
 			return -EIO;
 		break;
 
+	case IBMACPI_FAN_WR_ACPI_SFAN:
+		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", 0x00))
+			return -EIO;
+		break;
+
 	default:
 		return -ENXIO;
 	}

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
