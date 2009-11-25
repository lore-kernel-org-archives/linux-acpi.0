From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/6] acerhdf: return temperature in milidegree instead of degree
Date: Wed, 25 Nov 2009 01:12:00 -0500
Message-ID: <7005291706341a11c094f39a756a01c9e649e5f9.1259129450.git.len.brown@intel.com>
References: <1259129520-8281-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:44672 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbZKYGMV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 01:12:21 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTN005VTIK9FSVQ@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Nov 2009 00:12:10 -0600 (CST)
In-reply-to: <1259129520-8281-1-git-send-email-lenb@kernel.org>
In-reply-to: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
References: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Peter Feuerer <peter@piie.net>, Andreas Mohr <andi@lisas.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

=46rom: Peter Feuerer <peter@piie.net>

Return temperature in milidegree instead of degree, as sysfs-api requir=
es
the temperature in milidegree.

Signed-off-by: Peter Feuerer <peter@piie.net>
Tested-by: Borislav Petkov <petkovbb@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/acerhdf.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acer=
hdf.c
index 0a8f735..ab64522 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -52,7 +52,7 @@
  */
 #undef START_IN_KERNEL_MODE
=20
-#define DRV_VER "0.5.17"
+#define DRV_VER "0.5.18"
=20
 /*
  * According to the Atom N270 datasheet,
@@ -61,7 +61,7 @@
  * measured by the on-die thermal monitor are within 0 <=3D Tj <=3D 90=
=2E So,
  * assume 89=C2=B0C is critical temperature.
  */
-#define ACERHDF_TEMP_CRIT 89
+#define ACERHDF_TEMP_CRIT 89000
 #define ACERHDF_FAN_OFF 0
 #define ACERHDF_FAN_AUTO 1
=20
@@ -69,7 +69,7 @@
  * No matter what value the user puts into the fanon variable, turn on=
 the fan
  * at 80 degree Celsius to prevent hardware damage
  */
-#define ACERHDF_MAX_FANON 80
+#define ACERHDF_MAX_FANON 80000
=20
 /*
  * Maximum interval between two temperature checks is 15 seconds, as t=
he die
@@ -85,8 +85,8 @@ static int kernelmode;
 #endif
=20
 static unsigned int interval =3D 10;
-static unsigned int fanon =3D 63;
-static unsigned int fanoff =3D 58;
+static unsigned int fanon =3D 63000;
+static unsigned int fanoff =3D 58000;
 static unsigned int verbose;
 static unsigned int fanstate =3D ACERHDF_FAN_AUTO;
 static char force_bios[16];
@@ -171,7 +171,7 @@ static int acerhdf_get_temp(int *temp)
 	if (ec_read(bios_cfg->tempreg, &read_temp))
 		return -EINVAL;
=20
-	*temp =3D read_temp;
+	*temp =3D read_temp * 1000;
=20
 	return 0;
 }
--=20
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
