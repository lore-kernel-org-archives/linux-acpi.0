From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] ACPI / APEI: use setup_deferrable_timer
Date: Sat, 11 Mar 2017 08:46:55 +0800
Message-ID: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34397 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932599AbdCKArJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Mar 2017 19:47:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@suse.de>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Use setup_deferrable_timer() instead of init_timer_deferrable() to
simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/acpi/apei/ghes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b192b42..33ca196 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1005,9 +1005,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	switch (generic->notify.type) {
 	case ACPI_HEST_NOTIFY_POLLED:
-		ghes->timer.function = ghes_poll_func;
-		ghes->timer.data = (unsigned long)ghes;
-		init_timer_deferrable(&ghes->timer);
+		setup_deferrable_timer(&ghes->timer, ghes_poll_func,
+				       (unsigned long)ghes);
 		ghes_add_timer(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_EXTERNAL:
-- 
2.9.3

