From: naresh.bhat@linaro.org
Subject: [PATCH] ACPI/fan: Initialize acpi_state variable
Date: Thu, 27 Jun 2013 15:58:49 +0530
Message-ID: <1372328929-732-1-git-send-email-naresh.bhat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:39945 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab3F0K3C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2013 06:29:02 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so854415pab.38
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jun 2013 03:29:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, patches@linaro.org, linaro-kernel@lists.linaro.org, naresh.bhat@linaro.org

=46rom: Naresh Bhat <naresh.bhat@linaro.org>

  CC      drivers/acpi/fan.o
drivers/acpi/fan.c: In function =E2=80=98fan_get_cur_state=E2=80=99:
drivers/acpi/fan.c:96:9: warning: =E2=80=98acpi_state=E2=80=99 may be u=
sed uninitialized in this function [-Wuninitialized]
---
 drivers/acpi/fan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f815da8..f61f7fd 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -84,7 +84,7 @@ static int fan_get_cur_state(struct thermal_cooling_d=
evice *cdev, unsigned long
 {
 	struct acpi_device *device =3D cdev->devdata;
 	int result;
-	int acpi_state;
+	int acpi_state =3D 0;
=20
 	if (!device)
 		return -EINVAL;
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
