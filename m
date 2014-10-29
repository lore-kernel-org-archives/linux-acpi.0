From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/2] ACPI/EC: Fix a regression caused by conflict firmware behavior between Samsung and Acer.
Date: Wed, 29 Oct 2014 11:33:49 +0800
Message-ID: <2e35401ac793fc86ba36f03e013ec35546a62d67.1414553399.git.lv.zheng@intel.com>
References: <544CE637.7000406@odi.ch> <cover.1414553399.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1414553399.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

It is reported that Samsung laptops that need to poll events are broken=
 by
the following commit:
 Commit 3afcf2ece453e1a8c2c6de19cdf06da3772a1b08
 Subject: ACPI / EC: Add support to disallow QR_EC to be issued when SC=
I_EVT isn't set

The behaviors of the 2 vendor firmwares are conflict:
1. Acer: OSPM shouldn't issue QR_EC unless SCI_EVT is set, firmware
         automatically sets SCI_EVT as long as there is event queued up=
=2E
2. Samsung: OSPM should issue QR_EC whatever SCI_EVT is set, firmware
            returns 0 when there is no event queued up.

This patch is a quick fix to distinguish the behaviors to make Acer
behavior only effective for Acer EC firmware so that the breakages on
Samsung EC firmware can be avoided.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D44161
Reported-and-tested-by: Ortwin Gl=C2=A8=C2=B9ck <odi@odi.ch>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 31b699f..5f9b74b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -126,6 +126,7 @@ static int EC_FLAGS_MSI; /* Out-of-spec MSI control=
ler */
 static int EC_FLAGS_VALIDATE_ECDT; /* ASUStec ECDTs need to be validat=
ed */
 static int EC_FLAGS_SKIP_DSDT_SCAN; /* Not all BIOS survive early DSDT=
 scan */
 static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/=
resume */
+static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EV=
T set */
=20
 /* -------------------------------------------------------------------=
-------
  *                           Transaction Management
@@ -236,13 +237,8 @@ static bool advance_transaction(struct acpi_ec *ec=
)
 		}
 		return wakeup;
 	} else {
-		/*
-		 * There is firmware refusing to respond QR_EC when SCI_EVT
-		 * is not set, for which case, we complete the QR_EC
-		 * without issuing it to the firmware.
-		 * https://bugzilla.kernel.org/show_bug.cgi?id=3D86211
-		 */
-		if (!(status & ACPI_EC_FLAG_SCI) &&
+		if (EC_FLAGS_QUERY_HANDSHAKE &&
+		    !(status & ACPI_EC_FLAG_SCI) &&
 		    (t->command =3D=3D ACPI_EC_COMMAND_QUERY)) {
 			t->flags |=3D ACPI_EC_COMMAND_POLL;
 			t->rdata[t->ri++] =3D 0x00;
@@ -1012,6 +1008,18 @@ static int ec_enlarge_storm_threshold(const stru=
ct dmi_system_id *id)
 }
=20
 /*
+ * Acer EC firmware refuses to respond QR_EC when SCI_EVT is not set, =
for
+ * which case, we complete the QR_EC without issuing it to the firmwar=
e.
+ * https://bugzilla.kernel.org/show_bug.cgi?id=3D86211
+ */
+static int ec_flag_query_handshake(const struct dmi_system_id *id)
+{
+	pr_debug("Detected the EC firmware requiring QR_EC issued when SCI_EV=
T set\n");
+	EC_FLAGS_QUERY_HANDSHAKE =3D 1;
+	return 0;
+}
+
+/*
  * On some hardware it is necessary to clear events accumulated by the=
 EC during
  * sleep. These ECs stop reporting GPEs until they are manually polled=
, if too
  * many events are accumulated. (e.g. Samsung Series 5/9 notebooks)
@@ -1085,6 +1093,9 @@ static struct dmi_system_id ec_dmi_table[] __init=
data =3D {
 	{
 	ec_clear_on_resume, "Samsung hardware", {
 	DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD.")}, NULL},
+	{
+	ec_flag_query_handshake, "Acer hardware", {
+	DMI_MATCH(DMI_SYS_VENDOR, "Acer"), }, NULL},
 	{},
 };
=20
--=20
1.7.10
