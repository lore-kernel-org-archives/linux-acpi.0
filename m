From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/13] ACPI: EC: add leading zeros to debug messages
Date: Thu, 24 Jan 2008 00:06:53 -0500
Message-ID: <86dae0154a49b67c908faffeb33ba37eddceba74.1201150939.git.len.brown@intel.com>
References: <1201151215-11203-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:60323 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751272AbYAXFHA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jan 2008 00:07:00 -0500
In-Reply-To: <1201151215-11203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <d1154be3004e9db2d61533e16bb2cf85dd27a8cb.1201150939.git.len.brown@intel.com>
References: <d1154be3004e9db2d61533e16bb2cf85dd27a8cb.1201150939.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: =?utf-8?q?M=C3=A1rton=20N=C3=A9meth?= <nm127@freemail.hu>, Len Brown <len.brown@intel.com>

=46rom: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

Add leading zeros to pr_debug() calls. For example if x=3D0x0a, the for=
mat
"0x%2x" will result the string "0x a", the format "0x%2.2x" will result=
 "0x0a".

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8917d75..06c9f35 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -139,26 +139,26 @@ static struct acpi_ec {
 static inline u8 acpi_ec_read_status(struct acpi_ec *ec)
 {
 	u8 x =3D inb(ec->command_addr);
-	pr_debug(PREFIX "---> status =3D 0x%2x\n", x);
+	pr_debug(PREFIX "---> status =3D 0x%2.2x\n", x);
 	return x;
 }
=20
 static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
 {
 	u8 x =3D inb(ec->data_addr);
-	pr_debug(PREFIX "---> data =3D 0x%2x\n", x);
+	pr_debug(PREFIX "---> data =3D 0x%2.2x\n", x);
 	return inb(ec->data_addr);
 }
=20
 static inline void acpi_ec_write_cmd(struct acpi_ec *ec, u8 command)
 {
-	pr_debug(PREFIX "<--- command =3D 0x%2x\n", command);
+	pr_debug(PREFIX "<--- command =3D 0x%2.2x\n", command);
 	outb(command, ec->command_addr);
 }
=20
 static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 {
-	pr_debug(PREFIX "<--- data =3D 0x%2x\n", data);
+	pr_debug(PREFIX "<--- data =3D 0x%2.2x\n", data);
 	outb(data, ec->data_addr);
 }
=20
--=20
1.5.4.rc4.14.g6fc74

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
