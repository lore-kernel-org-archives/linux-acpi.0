From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/49] hp_accel: convert to module_acpi_driver()
Date: Sat,  6 Oct 2012 16:09:47 -0400
Message-ID: <46f6471c2c5ed68694df8f453794d5de664e70af.1349554106.git.len.brown@intel.com>
References: <1349554210-29978-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349554210-29978-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

=46rom: Mika Westerberg <mika.westerberg@linux.intel.com>

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/hp_accel.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_=
accel.c
index 6b9af98..18d74f2 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -382,31 +382,8 @@ static struct acpi_driver lis3lv02d_driver =3D {
 	},
 	.drv.pm =3D HP_ACCEL_PM,
 };
-
-static int __init lis3lv02d_init_module(void)
-{
-	int ret;
-
-	if (acpi_disabled)
-		return -ENODEV;
-
-	ret =3D acpi_bus_register_driver(&lis3lv02d_driver);
-	if (ret < 0)
-		return ret;
-
-	pr_info("driver loaded\n");
-
-	return 0;
-}
-
-static void __exit lis3lv02d_exit_module(void)
-{
-	acpi_bus_unregister_driver(&lis3lv02d_driver);
-}
+module_acpi_driver(lis3lv02d_driver);
=20
 MODULE_DESCRIPTION("Glue between LIS3LV02Dx and HP ACPI BIOS and suppo=
rt for disk protection LED.");
 MODULE_AUTHOR("Yan Burman, Eric Piel, Pavel Machek");
 MODULE_LICENSE("GPL");
-
-module_init(lis3lv02d_init_module);
-module_exit(lis3lv02d_exit_module);
--=20
1.8.0.rc0.18.gf84667d
