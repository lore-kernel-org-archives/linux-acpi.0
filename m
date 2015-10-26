From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] ACPI/PAD: power_saving_thread() is not freezable
Date: Mon, 26 Oct 2015 04:02:01 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1510260358500.21100@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43814 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692AbbJZDCD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Oct 2015 23:02:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

power_saving_thread() calls try_to_freeze(), but the thread doesn't mark
itself freezable through set_freezable(), so the try_to_freeze()
call is useless.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/acpi/acpi_pad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index ae307ff..8ea8211 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -148,8 +148,6 @@ static int power_saving_thread(void *data)
 	while (!kthread_should_stop()) {
 		unsigned long expire_time;
 
-		try_to_freeze();
-
 		/* round robin to cpus */
 		expire_time = last_jiffies + round_robin_time * HZ;
 		if (time_before(expire_time, jiffies)) {
-- 
Jiri Kosina
SUSE Labs
