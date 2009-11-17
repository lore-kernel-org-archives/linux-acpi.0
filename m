From: akpm@linux-foundation.org
Subject: [patch for 2.6.32? 1/2] acerhdf: return temperature in milidegree instead of degree
Date: Tue, 17 Nov 2009 14:07:21 -0800
Message-ID: <200911172207.nAHM7LdI007536@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38810 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753914AbZKQWIG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 17:08:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, peter@piie.net, andi@lisas.de, petkovbb@gmail.com

=46rom: Peter Feuerer <peter@piie.net>

Return temperature in milidegree instead of degree, as sysfs-api requir=
es
the temperature in milidegree.

Signed-off-by: Peter Feuerer <peter@piie.net>
Tested-by: Borislav Petkov <petkovbb@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acerhdf.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff -puN drivers/platform/x86/acerhdf.c~acerhdf-return-temperature-in-=
milidegree-instead-of-degree drivers/platform/x86/acerhdf.c
--- a/drivers/platform/x86/acerhdf.c~acerhdf-return-temperature-in-mili=
degree-instead-of-degree
+++ a/drivers/platform/x86/acerhdf.c
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
_
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
