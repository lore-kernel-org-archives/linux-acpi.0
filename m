From: malattia@linux.it
Subject: [PATCH 3/11] Fix sony_acpi_resume call
Date: Sat, 13 Jan 2007 23:04:33 +0100
Message-ID: <11687258812417-git-send-email-malattia@linux.it>
References: <11687258812893-git-send-email-malattia@linux.it> <1168725881764-git-send-email-malattia@linux.it> <11687258811866-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:37561 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbXAMWGA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 17:06:00 -0500
In-Reply-To: <11687258811866-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

From: Andrew Morton <akpm@osdl.org>

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/acpi/sony_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index beb56b9..f323c2c 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -233,7 +233,7 @@ static int sony_acpi_write(struct file *file, const char __user *buffer,
 	return count;
 }
 
-static int sony_acpi_resume(struct acpi_device *device, int state)
+static int sony_acpi_resume(struct acpi_device *device)
 {
 	struct sony_acpi_value *item;
 
-- 
1.4.4.2

