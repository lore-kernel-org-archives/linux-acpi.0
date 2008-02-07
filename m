From: Len Brown <lenb@kernel.org>
Subject: [PATCH 112/112] ACPI: fix build warning
Date: Thu,  7 Feb 2008 04:35:14 -0500
Message-ID: <b7143156c9ceee1a072c57aac8729d2dec5b3bf1.1202376825.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:56770 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758623AbYBGJhE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:37:04 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

drivers/acpi/system.c:360: warning: ignoring return value of =E2=80=98s=
ysfs_create_group=E2=80=99, declared with attribute warn_unused_result

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/system.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index ce88171..55cf4c0 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -357,8 +357,8 @@ void acpi_irq_stats_init(void)
 	}
=20
 	interrupt_stats_attr_group.attrs =3D all_attrs;
-	sysfs_create_group(acpi_kobj, &interrupt_stats_attr_group);
-	return;
+	if (!sysfs_create_group(acpi_kobj, &interrupt_stats_attr_group))
+		return;
=20
 fail:
 	delete_gpe_attr_array();
--=20
1.5.4.23.gef5b9

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
