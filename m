From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/33] Revert
 "ACPI throttling: Use this_cpu_has and simplify code"
Date: Sun, 26 Dec 2010 17:43:54 -0500
Message-ID: <95270ec41181ed1720b52bf29f6878b96f43ae4d.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51630 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab0LZW6p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:58:45 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200DX055VNMD4@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:58:45 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

This reverts commit 630c6a2603a844b3771f007224e22db8cc16a038.

b/c the build isn't ready for it yet:

drivers/acpi/processor_throttling.c: In function
=E2=80=98acpi_throttling_rdmsr=E2=80=99:
drivers/acpi/processor_throttling.c:672: error: implicit declaration of
function =E2=80=98this_cpu_has=E2=80=99
---
 drivers/acpi/processor_throttling.c |   32 ++++++++++++++++++++++-----=
-----
 1 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/process=
or_throttling.c
index 2e773d9..ff36327 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -662,14 +662,20 @@ static int acpi_processor_get_throttling_fadt(str=
uct acpi_processor *pr)
 }
=20
 #ifdef CONFIG_X86
-static int acpi_throttling_rdmsr(u64 *value)
+static int acpi_throttling_rdmsr(struct acpi_processor *pr,
+					u64 *value)
 {
+	struct cpuinfo_x86 *c;
 	u64 msr_high, msr_low;
+	unsigned int cpu;
 	u64 msr =3D 0;
 	int ret =3D -1;
=20
-	if ((this_cpu_read(cpu_info.x86_vendor) !=3D X86_VENDOR_INTEL) ||
-		!this_cpu_has(X86_FEATURE_ACPI)) {
+	cpu =3D pr->id;
+	c =3D &cpu_data(cpu);
+
+	if ((c->x86_vendor !=3D X86_VENDOR_INTEL) ||
+		!cpu_has(c, X86_FEATURE_ACPI)) {
 		printk(KERN_ERR PREFIX
 			"HARDWARE addr space,NOT supported yet\n");
 	} else {
@@ -684,13 +690,18 @@ static int acpi_throttling_rdmsr(u64 *value)
 	return ret;
 }
=20
-static int acpi_throttling_wrmsr(u64 value)
+static int acpi_throttling_wrmsr(struct acpi_processor *pr, u64 value)
 {
+	struct cpuinfo_x86 *c;
+	unsigned int cpu;
 	int ret =3D -1;
 	u64 msr;
=20
-	if ((this_cpu_read(cpu_info.x86_vendor) !=3D X86_VENDOR_INTEL) ||
-		!this_cpu_has(X86_FEATURE_ACPI)) {
+	cpu =3D pr->id;
+	c =3D &cpu_data(cpu);
+
+	if ((c->x86_vendor !=3D X86_VENDOR_INTEL) ||
+		!cpu_has(c, X86_FEATURE_ACPI)) {
 		printk(KERN_ERR PREFIX
 			"HARDWARE addr space,NOT supported yet\n");
 	} else {
@@ -702,14 +713,15 @@ static int acpi_throttling_wrmsr(u64 value)
 	return ret;
 }
 #else
-static int acpi_throttling_rdmsr(u64 *value)
+static int acpi_throttling_rdmsr(struct acpi_processor *pr,
+				u64 *value)
 {
 	printk(KERN_ERR PREFIX
 		"HARDWARE addr space,NOT supported yet\n");
 	return -1;
 }
=20
-static int acpi_throttling_wrmsr(u64 value)
+static int acpi_throttling_wrmsr(struct acpi_processor *pr, u64 value)
 {
 	printk(KERN_ERR PREFIX
 		"HARDWARE addr space,NOT supported yet\n");
@@ -741,7 +753,7 @@ static int acpi_read_throttling_status(struct acpi_=
processor *pr,
 		ret =3D 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
-		ret =3D acpi_throttling_rdmsr(value);
+		ret =3D acpi_throttling_rdmsr(pr, value);
 		break;
 	default:
 		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
@@ -774,7 +786,7 @@ static int acpi_write_throttling_state(struct acpi_=
processor *pr,
 		ret =3D 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
-		ret =3D acpi_throttling_wrmsr(value);
+		ret =3D acpi_throttling_wrmsr(pr, value);
 		break;
 	default:
 		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
--=20
1.7.3.3.557.gb5c17

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
