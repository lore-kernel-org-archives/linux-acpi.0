From: Daniel Machon <dmachon.dev@gmail.com>
Subject: [PATCH 2/2] ACPI: battery.c: Fixed flying pointer mark issue. Coding
 style issue.
Date: Sun, 5 Jul 2015 19:39:01 +0200
Message-ID: <20150705173858.GA10338@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:34156 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbGERiX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Jul 2015 13:38:23 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, danielmachon@live.dk

Fixed coding style issue.

Signed-off-by: Daniel Machon <dmachon.dev@gmail.com>
---
 drivers/acpi/battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b3628cc..0447c6a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -918,8 +918,8 @@ static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 }
 
 static ssize_t acpi_battery_write_alarm(struct file *file,
-					const char __user * buffer,
-					size_t count, loff_t * ppos)
+					const char __user *buffer,
+					size_t count, loff_t *ppos)
 {
 	int result = 0;
 	char alarm_string[12] = { '\0' };
-- 
2.1.4

