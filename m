From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ACPI / dock: fix error return code in dock_add()
Date: Wed, 17 Jul 2013 08:33:25 +0800
Message-ID: <CAPgLHd-gf9cz8=z46OOsqYSzxBqk9hN=Mbmk=qQWW5JzOWhN-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:49342 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab3GQAd0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2013 20:33:26 -0400
Received: by mail-bk0-f45.google.com with SMTP id je9so498694bkc.18
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jul 2013 17:33:25 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: shaohua.li@intel.com, lenb@kernel.org, rjw@sisk.pl
Cc: yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENODEV in the acpi notify handler install error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/acpi/dock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index f601658..b527c1b 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -881,8 +881,10 @@ static int __init dock_add(acpi_handle handle)
 
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 					     dock_notify_handler, dock_station);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		ret = -ENODEV;
 		goto err_rmgroup;
+	}
 
 	dock_station_count++;
 	list_add(&dock_station->sibling, &dock_stations);

