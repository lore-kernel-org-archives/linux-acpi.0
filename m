From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/6] ACPI-fan: Use devm_kcalloc() in acpi_fan_get_fps()
Date: Tue, 18 Apr 2017 18:50:10 +0200
Message-ID: <930132d9-b878-e787-a67d-71113e5c211e@users.sourceforge.net>
References: <077115e4-8ec3-9c6d-0374-8ffc5e0f85c0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:60583 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbdDRQu3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 12:50:29 -0400
In-Reply-To: <077115e4-8ec3-9c6d-0374-8ffc5e0f85c0@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Borislav Petkov <bp@suse.de>, Chun-Yi Lee <joeyli.kernel@gmail.com>, Colin Ian King <colin.king@canonical.com>, Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, Linda Knippers <linda.knippers@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Apr 2017 17:00:39 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "devm_kcalloc".

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/fan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 6cf4988206f2..92878c7c523b 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -298,8 +298,7 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 	}
 
 	fan->fps_count = obj->package.count - 1; /* minus revision field */
-	fan->fps = devm_kzalloc(&device->dev,
-				fan->fps_count * sizeof(struct acpi_fan_fps),
+	fan->fps = devm_kcalloc(&device->dev, fan->fps_count, sizeof(*fan->fps),
 				GFP_KERNEL);
 	if (!fan->fps) {
 		dev_err(&device->dev, "Not enough memory\n");
-- 
2.12.2


