From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 10/21] ACPI: ibm-acpi: document fan control
Date: Sat, 25 Nov 2006 18:45:17 -0200
Message-ID: <20061125204516.6604.85019.stgit@thorin.khazad-dum.debian.net>
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

This patch documents the ThinkPad fan control strategies.  Source of the
data:

0. ibm-acpi source
1. DSDTs for various ThinkPads (770, X31, X40, X41, T43, A21m, T22)
2. http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
3. http://thinkwiki.org/wiki/How_to_control_fan_speed
4. Various threads about windows fan control utilities in thinkpads.com

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 drivers/acpi/ibm_acpi.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 5258994..ccbb17c 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -205,7 +205,7 @@ IBM_HANDLE(led, ec, "SLED",	/* 570 */
 IBM_HANDLE(beep, ec, "BEEP");	/* all except R30, R31 */
 IBM_HANDLE(ecrd, ec, "ECRD");	/* 570 */
 IBM_HANDLE(ecwr, ec, "ECWR");	/* 570 */
-IBM_HANDLE(fans, ec, "FANS");	/* X31, X40 */
+IBM_HANDLE(fans, ec, "FANS");	/* X31, X40, X41 */
 
 IBM_HANDLE(gfan, ec, "GFAN",	/* 570 */
 	   "\\FSPD",		/* 600e/x, 770e, 770x */
@@ -231,6 +231,106 @@ struct ibm_thermal_sensors_struct {
 	s32 temp[IBMACPI_MAX_THERMAL_SENSORS];
 };
 
+/*
+ * FAN ACCESS MODES
+ *
+ * IBMACPI_FAN_RD_ACPI_GFAN:
+ * 	ACPI GFAN method: returns fan level
+ *
+ * 	see IBMACPI_FAN_WR_ACPI_SFAN
+ * 	EC 0x2f not available if GFAN exists
+ *
+ * IBMACPI_FAN_WR_ACPI_SFAN:
+ * 	ACPI SFAN method: sets fan level, 0 (stop) to 7 (max)
+ *
+ * 	EC 0x2f might be available *for reading*, but never for writing.
+ *
+ * IBMACPI_FAN_WR_TPEC:
+ * 	ThinkPad EC register 0x2f (HFSP): fan control loop mode Supported
+ * 	on almost all ThinkPads
+ *
+ * 	Fan speed changes of any sort (including those caused by the
+ * 	disengaged mode) are usually done slowly by the firmware as the
+ * 	maximum ammount of fan duty cycle change per second seems to be
+ * 	limited.
+ *
+ * 	Reading is not available if GFAN exists.
+ * 	Writing is not available if SFAN exists.
+ *
+ * 	Bits
+ *	 7	automatic mode engaged;
+ *  		(default operation mode of the ThinkPad)
+ * 		fan level is ignored in this mode.
+ *	 6	disengage mode (takes precedence over bit 7);
+ *		not available on all thinkpads.  May disable
+ *		the tachometer, and speeds up fan to 100% duty-cycle,
+ *		which speeds it up far above the standard RPM
+ *		levels.  It is not impossible that it could cause
+ *		hardware damage.
+ *	5-3	unused in some models.  Extra bits for fan level
+ *		in others, but still useless as all values above
+ *		7 map to the same speed as level 7 in these models.
+ *	2-0	fan level (0..7 usually)
+ *			0x00 = stop
+ * 			0x07 = max (set when temperatures critical)
+ * 		Some ThinkPads may have other levels, see
+ * 		IBMACPI_FAN_WR_ACPI_FANS (X31/X40/X41)
+ *
+ *	FIRMWARE BUG: on some models, EC 0x2f might not be initialized at
+ *	boot. Apparently the EC does not intialize it, so unless ACPI DSDT
+ *	does so, its initial value is meaningless (0x07).
+ *
+ *	For firmware bugs, refer to:
+ *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
+ *
+ * 	----
+ *
+ *	ThinkPad EC register 0x84 (LSB), 0x85 (MSB):
+ *	Main fan tachometer reading (in RPM)
+ *
+ *	This register is present on all ThinkPads with a new-style EC, and
+ *	it is known not to be present on the A21m/e, and T22, as there is
+ *	something else in offset 0x84 according to the ACPI DSDT.  Other
+ *	ThinkPads from this same time period (and earlier) probably lack the
+ *	tachometer as well.
+ *
+ *	Unfortunately a lot of ThinkPads with new-style ECs but whose firwmare
+ *	was never fixed by IBM to report the EC firmware version string
+ *	probably support the tachometer (like the early X models), so
+ *	detecting it is quite hard.  We need more data to know for sure.
+ *
+ *	FIRMWARE BUG: always read 0x84 first, otherwise incorrect readings
+ *	might result.
+ *
+ *	FIRMWARE BUG: when EC 0x2f bit 6 is set (disengaged mode), this
+ *	register is not invalidated in ThinkPads that disable tachometer
+ *	readings.  Thus, the tachometer readings go stale.
+ *
+ *	For firmware bugs, refer to:
+ *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
+ *
+ * IBMACPI_FAN_WR_ACPI_FANS:
+ *	ThinkPad X31, X40, X41.  Not available in the X60.
+ *
+ *	FANS ACPI handle: takes three arguments: low speed, medium speed,
+ *	high speed.  ACPI DSDT seems to map these three speeds to levels
+ *	as follows: STOP LOW LOW MED MED HIGH HIGH HIGH HIGH
+ *	(this map is stored on FAN0..FAN8 as "0,1,1,2,2,3,3,3,3")
+ *
+ * 	The speeds are stored on handles
+ * 	(FANA:FAN9), (FANC:FANB), (FANE:FAND).
+ *
+ * 	There are three default speed sets, acessible as handles:
+ * 	FS1L,FS1M,FS1H; FS2L,FS2M,FS2H; FS3L,FS3M,FS3H
+ *
+ * 	ACPI DSDT switches which set is in use depending on various
+ * 	factors.
+ *
+ * 	IBMACPI_FAN_WR_TPEC is also available and should be used to
+ * 	command the fan.  The X31/X40/X41 seems to have 8 fan levels,
+ * 	but the ACPI tables just mention level 7.
+ */
+
 enum fan_status_access_mode {
 	IBMACPI_FAN_NONE = 0,		/* No fan status or control */
 	IBMACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
@@ -1722,7 +1822,7 @@ static int fan_init(void)
 			/* all other models implement TP EC 0x2f control */
 
 			if (fans_handle) {
-				/* X31, X40 */
+				/* X31, X40, X41 */
 				fan_control_access_mode =
 				    IBMACPI_FAN_WR_ACPI_FANS;
 				fan_control_commands |=
@@ -1742,6 +1842,9 @@ static int fan_get_status(u8 *status)
 {
 	u8 s;
 
+	/* TODO:
+	 * Add IBMACPI_FAN_RD_ACPI_FANS ? */
+
 	switch (fan_status_access_mode) {
 	case IBMACPI_FAN_RD_ACPI_GFAN:
 		/* 570, 600e/x, 770e, 770x */
@@ -1950,6 +2053,9 @@ static int fan_write_cmd_speed(const cha
 {
 	int speed;
 
+	/* TODO:
+	 * Support speed <low> <medium> <high> ? */
+
 	if (sscanf(cmd, "speed %d", &speed) != 1)
 		return 0;
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
