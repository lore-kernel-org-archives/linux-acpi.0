From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: Taint kernel on ACPI table override (format corrected)
Date: Wed,  6 Feb 2008 20:12:50 -0500
Message-ID: <1202346773-1893-3-git-send-email-lenb@kernel.org>
References: <47AA4F9D.7010601@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:56088 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758325AbYBGBXI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 20:23:08 -0500
In-Reply-To: <47AA4F9D.7010601@tremplin-utc.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: =?utf-8?q?=C3=89ric=20Piel?= <Eric.Piel@tremplin-utc.net>, Eric Piel <eric.piel@tremplin-utc.net>, Len Brown <len.brown@intel.com>

=46rom: =C3=89ric Piel <Eric.Piel@tremplin-utc.net>

When an ACPI table is overridden (for now this can happen only for DSDT=
)
display a big warning and taint the kernel with flag A.

Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c     |    7 +++++++
 include/linux/kernel.h |    1 +
 kernel/panic.c         |    5 +++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 131936e..bbd8360 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -392,6 +392,13 @@ acpi_os_table_override(struct acpi_table_header * =
existing_table,
 			*new_table =3D initrd_table;
 	}
 #endif
+	if (*new_table !=3D NULL) {
+		printk(KERN_WARNING PREFIX "Override [%4.4s-%8.8s], "
+			   "this is unsafe: tainting kernel\n",
+		       existing_table->signature,
+		       existing_table->oem_table_id);
+		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
+	}
 	return AE_OK;
 }
=20
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 18222f2..9e01f37 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -243,6 +243,7 @@ extern enum system_states {
 #define TAINT_BAD_PAGE			(1<<5)
 #define TAINT_USER			(1<<6)
 #define TAINT_DIE			(1<<7)
+#define TAINT_OVERRIDDEN_ACPI_TABLE	(1<<8)
=20
 extern void dump_stack(void) __cold;
=20
diff --git a/kernel/panic.c b/kernel/panic.c
index d9e90cf..24af9f8 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -161,7 +161,7 @@ const char *print_tainted(void)
 {
 	static char buf[20];
 	if (tainted) {
-		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c%c%c",
+		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c%c%c%c",
 			tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
 			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
 			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ',
@@ -169,7 +169,8 @@ const char *print_tainted(void)
 			tainted & TAINT_MACHINE_CHECK ? 'M' : ' ',
 			tainted & TAINT_BAD_PAGE ? 'B' : ' ',
 			tainted & TAINT_USER ? 'U' : ' ',
-			tainted & TAINT_DIE ? 'D' : ' ');
+			tainted & TAINT_DIE ? 'D' : ' ',
+			tainted & TAINT_OVERRIDDEN_ACPI_TABLE ? 'A' : ' ');
 	}
 	else
 		snprintf(buf, sizeof(buf), "Not tainted");
--=20
1.5.4.23.gef5b9

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
