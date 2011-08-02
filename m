From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/27] ACPI: DMI workaround for Asus A8N-SLI Premium and Asus
 A8N-SLI DELUX
Date: Tue, 02 Aug 2011 16:53:23 -0400
Message-ID: <bb0c5ed6ec523199e34e81dcef8e987507553b63.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab1HBVwD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:03 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:52:01 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

=46rom: Zhang Rui <rui.zhang@intel.com>

DMI workaround for A8N-SLI Premium and A8N-SLI DELUXE
to enable the s3 suspend old ordering.
http://bugzilla.kernel.org/show_bug.cgi?id=3D9528

Tested-by: Heiko Ettelbr=C3=BCck <hbruckynews@gmx.de>
Tested-by: Brian Beardall <brian@rapsure.net>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 6c94960..3ed80b2 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -428,6 +428,22 @@ static struct dmi_system_id __initdata acpisleep_d=
mi_table[] =3D {
 		DMI_MATCH(DMI_PRODUCT_NAME, "1000 Series"),
 		},
 	},
+	{
+	.callback =3D init_old_suspend_ordering,
+	.ident =3D "Asus A8N-SLI DELUXE",
+	.matches =3D {
+		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+		DMI_MATCH(DMI_BOARD_NAME, "A8N-SLI DELUXE"),
+		},
+	},
+	{
+	.callback =3D init_old_suspend_ordering,
+	.ident =3D "Asus A8N-SLI Premium",
+	.matches =3D {
+		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+		DMI_MATCH(DMI_BOARD_NAME, "A8N-SLI Premium"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */
--=20
1.7.6.396.ge0613

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
