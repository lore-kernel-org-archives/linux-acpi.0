From: naresh.bhat@linaro.org
Subject: [PATCH] ACPI/fan: Initialize acpi_state variable
Date: Fri, 28 Jun 2013 01:17:43 +0530
Message-ID: <1372362463-4186-1-git-send-email-naresh.bhat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:58123 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910Ab3F0Tr7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2013 15:47:59 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so1336971pbc.2
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jun 2013 12:47:58 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, patches@linaro.org, linaro-kernel@lists.linaro.org, naresh.bhat@linaro.org, linux-kernel@vger.kernel.org, rjw@sisk.pl

=46rom: Naresh Bhat <naresh.bhat@linaro.org>

  CC      drivers/acpi/fan.o
drivers/acpi/fan.c: In function =E2=80=98fan_get_cur_state=E2=80=99:
drivers/acpi/fan.c:96:9: warning: =E2=80=98acpi_state=E2=80=99 may be u=
sed uninitialized in this function [-Wuninitialized]
---
 drivers/acpi/fan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f815da8..f961435 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -84,7 +84,7 @@ static int fan_get_cur_state(struct thermal_cooling_d=
evice *cdev, unsigned long
 {
 	struct acpi_device *device =3D cdev->devdata;
 	int result;
-	int acpi_state;
+	int acpi_state =3D ACPI_STATE_D0;
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
