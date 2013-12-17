From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 03/11] drivers: acpi: Mark the function acpi_ec_add_debugfs()
 as static in ec_sys.c
Date: Tue, 17 Dec 2013 14:46:41 +0530
Message-ID: <7969d5aae5d243a48c5b99f55e7bf2d172791672.1387271324.git.rashika.kheria@gmail.com>
References: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:33465 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab3LQJQu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2013 04:16:50 -0500
Content-Disposition: inline
In-Reply-To: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, josh@joshtriplett.org

Mark the function acpi_ec_add_debugfs() as static in
ec_sys.c because it is not used outside this file.

This eliminates the following warning in ec_sys.c:
drivers/acpi/ec_sys.c:108:5: warning: no previous prototype for =E2=80=98=
acpi_ec_add_debugfs=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/ec_sys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index 4e7b798..b4c216b 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -105,7 +105,7 @@ static const struct file_operations acpi_ec_io_ops =
=3D {
 	.llseek =3D default_llseek,
 };
=20
-int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_cou=
nt)
+static int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_dev=
ice_count)
 {
 	struct dentry *dev_dir;
 	char name[64];
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
