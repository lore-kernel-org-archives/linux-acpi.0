From: =?UTF-8?q?Mathieu=20Rh=C3=A9aume?= <mathieu@codingrhemes.com>
Subject: [PATCH] acpi: processor_driver: fixed a brace coding style issue
Date: Tue,  1 Oct 2013 05:29:39 -0400
Message-ID: <1380619779-16386-1-git-send-email-mathieu@codingrhemes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu@codingrhemes.com
Cc: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

=46ixed a brace coding style issue. (Brace not on the good line)

Signed-off-by: Mathieu Rh=C3=A9aume <mathieu@codingrhemes.com>
---
 drivers/acpi/processor_driver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_d=
river.c
index e534ba6..40fc773 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -153,8 +153,7 @@ static int acpi_cpu_soft_notify(struct notifier_blo=
ck *nfb,
 	return NOTIFY_OK;
 }
=20
-static struct notifier_block __refdata acpi_cpu_notifier =3D
-{
+static struct notifier_block __refdata acpi_cpu_notifier =3D {
 	    .notifier_call =3D acpi_cpu_soft_notify,
 };
=20
--=20
1.8.3.1
