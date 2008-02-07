From: Len Brown <lenb@kernel.org>
Subject: [PATCH 070/112] ACPI: fan: build fix for CONFIG_ACPI_PROCFS=n
Date: Thu,  7 Feb 2008 04:34:32 -0500
Message-ID: <3c602840528cf1aa835e6e32d76a0a45936b8e4c.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758199AbYBGJg3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:29 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

drivers/acpi/fan.c:340: error: =E2=80=98acpi_fan_dir=E2=80=99 undeclare=
d (first use in this function)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/fan.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f6e8165..48cb705 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -337,10 +337,12 @@ static int __init acpi_fan_init(void)
 	int result =3D 0;
=20
=20
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_fan_dir =3D proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
 	if (!acpi_fan_dir)
 		return -ENODEV;
 	acpi_fan_dir->owner =3D THIS_MODULE;
+#endif
=20
 	result =3D acpi_bus_register_driver(&acpi_fan_driver);
 	if (result < 0) {
--=20
1.5.4.23.gef5b9

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
