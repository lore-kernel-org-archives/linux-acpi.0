From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH 1/6] drivers/acpi: fix ac driver compile error when CONFIG_PM_SLEEP is undefined
Date: Wed, 12 Feb 2014 20:19:05 -0700
Message-ID: <c9ab2647da7301e3e9033e2fbe80ad6bcafb85a2.1392250669.git.shuah.kh@samsung.com>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, rui.zhang@intel.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-acpi@vger.kernel.org

ac driver defines acpi_ac_resume() when CONFIG_PM_SLEEP is defined. Thi=
s
results in the following compile error when CONFIG_PM_SLEEP is undefine=
d.

drivers/acpi/ac.c:248:8: error: =E2=80=98acpi_ac_resume=E2=80=99 undecl=
ared here (not in a function)

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/acpi/ac.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index e7515aa..6f190bc 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -243,6 +243,8 @@ static int acpi_ac_resume(struct device *dev)
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
 	return 0;
 }
+#else
+#define acpi_ac_resume NULL
 #endif
 static SIMPLE_DEV_PM_OPS(acpi_ac_pm_ops, NULL, acpi_ac_resume);
=20
--=20
1.7.10.4

