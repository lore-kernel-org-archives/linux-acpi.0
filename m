From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 04/21] ACPI: ibm-acpi: Implement
	direct-ec-access thermal reading modes for up to 16 sensors
Date: Sat, 25 Nov 2006 18:43:16 -0200
Message-ID: <20061125204316.6604.16439.stgit@thorin.khazad-dum.debian.net>
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

This patch extends ibm-acpi to support reading thermal sensors directly
through ACPI EC register access.  It uses a DMI match to detect ThinkPads
with a new-style embedded controller, that are known to have forward-
compatible register maps and use 0x00 to fill in non-used registers and
export thermal sensors at EC offsets 0x78-7F and 0xC0-C7.

Direct ACPI EC register access is implemented for 8-sensor and 16-sensor
new-style ThinkPad controller firmwares as an experimental feature.  The
code does some limited sanity checks on the temperatures read through EC
access, and will default to the old ACPI TMP0-7 mode if anything is amiss.

Userspace ABI is not changed for 8 sensors, but /proc/acpi/ibm/thermal is
extended for 16 sensors if the firmware supports 16 sensors.

A documentation update is also provided.

The information about the ThinkPad register map was determined by studying
ibm-acpi "ecdump" output from various ThinkPad models, submitted by
subscribers of the linux-thinkpad mailinglist.  Futher information was
gathered from the DSDT tables, as they describe the EC register map in
recent ThinkPads.

DSDT source shows that TMP0-7 access and direct register access are
actually the same thing on these firmwares, but unfortunately IBM never
did update their DSDT EC register map to export TMP8-TMP15 for the second
range of sensors.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 Documentation/ibm-acpi.txt |   55 ++++++++++++++++++++------
 drivers/acpi/ibm_acpi.c    |   93 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 14 deletions(-)

diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
index e50595b..30f09e7 100644
--- a/Documentation/ibm-acpi.txt
+++ b/Documentation/ibm-acpi.txt
@@ -398,25 +398,56 @@ Temperature sensors -- /proc/acpi/ibm/th
 
 Most ThinkPads include six or more separate temperature sensors but
 only expose the CPU temperature through the standard ACPI methods.
-This feature shows readings from up to eight different sensors. Some
-readings may not be valid, e.g. may show large negative values. For
-example, on the X40, a typical output may be:
+This feature shows readings from up to eight different sensors on older
+ThinkPads, and it has experimental support for up to sixteen different
+sensors on newer ThinkPads.  Readings from sensors that are not available
+return -128.
 
+No commands can be written to this file.
+
+EXPERIMENTAL: The 16-sensors feature is marked EXPERIMENTAL because the
+implementation directly accesses hardware registers and may not work as
+expected. USE WITH CAUTION! To use this feature, you need to supply the
+experimental=1 parameter when loading the module.  When EXPERIMENTAL
+mode is enabled, reading the first 8 sensors on newer ThinkPads will
+also use an new experimental thermal sensor access mode.
+
+For example, on the X40, a typical output may be:
 temperatures:   42 42 45 41 36 -128 33 -128
 
-Thomas Gruber took his R51 apart and traced all six active sensors in
-his laptop (the location of sensors may vary on other models):
+EXPERIMENTAL: On the T43/p, a typical output may be:
+temperatures:   48 48 36 52 38 -128 31 -128 48 52 48 -128 -128 -128 -128 -128
+
+The mapping of thermal sensors to physical locations varies depending on
+system-board model (and thus, on ThinkPad model).
+
+http://thinkwiki.org/wiki/Thermal_Sensors is a public wiki page that
+tries to track down these locations for various models.
+
+Most (newer?) models seem to follow this pattern:
 
 1:  CPU
-2:  Mini PCI Module
-3:  HDD
+2:  (depends on model)
+3:  (depends on model)
 4:  GPU
-5:  Battery
-6:  N/A
-7:  Battery
-8:  N/A
+5:  Main battery: main sensor
+6:  Bay battery: main sensor
+7:  Main battery: secondary sensor
+8:  Bay battery: secondary sensor
+9-15: (depends on model)
+
+For the R51 (source: Thomas Gruber):
+2:  Mini-PCI
+3:  Internal HDD
+
+For the T43, T43/p (source: Shmidoax/Thinkwiki.org)
+http://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_T43.2C_T43p
+2:  System board, left side (near PCMCIA slot), reported as HDAPS temp
+3:  PCMCIA slot
+9:  MCH (northbridge) to DRAM Bus
+10: ICH (southbridge), under Mini-PCI card, under touchpad
+11: Power regulator, underside of system board, below F2 key
 
-No commands can be written to this file.
 
 EXPERIMENTAL: Embedded controller register dump -- /proc/acpi/ibm/ecdump
 ------------------------------------------------------------------------
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 3a8f223..491c413 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -80,6 +80,7 @@
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
 #include <asm/uaccess.h>
+#include <linux/dmi.h>
 
 #include <acpi/acpi_drivers.h>
 #include <acpi/acnamesp.h>
@@ -221,13 +222,17 @@ enum thermal_access_mode {
 	IBMACPI_THERMAL_NONE = 0,	/* No thermal support */
 	IBMACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
 	IBMACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
+	IBMACPI_THERMAL_TPEC_8,		/* Use ACPI EC regs, 8 sensors */
+	IBMACPI_THERMAL_TPEC_16,	/* Use ACPI EC regs, 16 sensors */
 };
 
-#define IBMACPI_MAX_THERMAL_SENSORS 8	/* Max thermal sensors supported */
+#define IBMACPI_MAX_THERMAL_SENSORS 16	/* Max thermal sensors supported */
 struct ibm_thermal_sensors_struct {
 	s32 temp[IBMACPI_MAX_THERMAL_SENSORS];
 };
 
+static int ibm_thinkpad_ec_found;
+
 struct ibm_struct {
 	char *name;
 	char param[32];
@@ -1290,7 +1295,52 @@ static enum thermal_access_mode thermal_
 
 static int thermal_init(void)
 {
-	if (acpi_evalf(ec_handle, NULL, "TMP7", "qv")) {
+	u8 t, ta1, ta2;
+	int i;
+	int acpi_tmp7 = acpi_evalf(ec_handle, NULL, "TMP7", "qv");
+
+	if (ibm_thinkpad_ec_found && experimental) {
+		/*
+		 * Direct EC access mode: sensors at registers
+		 * 0x78-0x7F, 0xC0-0xC7.  Registers return 0x00 for
+		 * non-implemented, thermal sensors return 0x80 when
+		 * not available
+		 */
+
+		ta1 = ta2 = 0;
+		for (i = 0; i < 8; i++) {
+			if (likely(acpi_ec_read(0x78 + i, &t))) {
+				ta1 |= t;
+			} else {
+				ta1 = 0;
+				break;
+			}
+			if (likely(acpi_ec_read(0xC0 + i, &t))) {
+				ta2 |= t;
+			} else {
+				ta1 = 0;
+				break;
+			}
+		}
+		if (ta1 == 0) {
+			/* This is sheer paranoia, but we handle it anyway */
+			if (acpi_tmp7) {
+				printk(IBM_ERR
+				       "ThinkPad ACPI EC access misbehaving, "
+				       "falling back to ACPI TMPx access mode\n");
+				thermal_read_mode = IBMACPI_THERMAL_ACPI_TMP07;
+			} else {
+				printk(IBM_ERR
+				       "ThinkPad ACPI EC access misbehaving, "
+				       "disabling thermal sensors access\n");
+				thermal_read_mode = IBMACPI_THERMAL_NONE;
+			}
+		} else {
+			thermal_read_mode =
+			    (ta2 != 0) ?
+			    IBMACPI_THERMAL_TPEC_16 : IBMACPI_THERMAL_TPEC_8;
+		}
+	} else if (acpi_tmp7) {
 		if (acpi_evalf(ec_handle, NULL, "UPDT", "qv")) {
 			/* 600e/x, 770e, 770x */
 			thermal_read_mode = IBMACPI_THERMAL_ACPI_UPDT;
@@ -1309,12 +1359,30 @@ static int thermal_init(void)
 static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 {
 	int i, t;
+	s8 tmp;
 	char tmpi[] = "TMPi";
 
 	if (!s)
 		return -EINVAL;
 
 	switch (thermal_read_mode) {
+#if IBMACPI_MAX_THERMAL_SENSORS >= 16
+	case IBMACPI_THERMAL_TPEC_16:
+		for (i = 0; i < 8; i++) {
+			if (!acpi_ec_read(0xC0 + i, &tmp))
+				return -EIO;
+			s->temp[i + 8] = tmp * 1000;
+		}
+		/* fallthrough */
+#endif
+	case IBMACPI_THERMAL_TPEC_8:
+		for (i = 0; i < 8; i++) {
+			if (!acpi_ec_read(0x78 + i, &tmp))
+				return -EIO;
+			s->temp[i] = tmp * 1000;
+		}
+		return (thermal_read_mode == IBMACPI_THERMAL_TPEC_16) ? 16 : 8;
+
 	case IBMACPI_THERMAL_ACPI_UPDT:
 		if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
 			return -EIO;
@@ -2051,6 +2119,24 @@ static void acpi_ibm_exit(void)
 	remove_proc_entry(IBM_DIR, acpi_root_dir);
 }
 
+static int __init check_dmi_for_ec(void)
+{
+	struct dmi_device *dev = NULL;
+
+	/*
+	 * ThinkPad T23 or newer, A31 or newer, R50e or newer,
+	 * X32 or newer, all Z series;  Some models must have an
+	 * up-to-date BIOS or they will not be detected.
+	 *
+	 * See http://thinkwiki.org/wiki/List_of_DMI_IDs
+	 */
+	while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, NULL, dev))) {
+		if (strstr(dev->name, "IBM ThinkPad Embedded Controller"))
+			return 1;
+	}
+	return 0;
+}
+
 static int __init acpi_ibm_init(void)
 {
 	int ret, i;
@@ -2070,6 +2156,9 @@ static int __init acpi_ibm_init(void)
 		return -ENODEV;
 	}
 
+	/* Models with newer firmware report the EC in DMI */
+	ibm_thinkpad_ec_found = check_dmi_for_ec();
+
 	/* these handles are not required */
 	IBM_HANDLE_INIT(vid);
 	IBM_HANDLE_INIT(vid2);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
