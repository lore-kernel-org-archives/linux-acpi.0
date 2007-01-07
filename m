From: malattia@linux.it
Subject: [PATCH 3/11] Fix sony_acpi_resume call
Date: Sun,  7 Jan 2007 18:54:35 +0100
Message-ID: <11681924833947-git-send-email-malattia@linux.it>
References: <1168192483500-git-send-email-malattia@linux.it> <11681924832840-git-send-email-malattia@linux.it> <1168192483207-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:46680 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932623AbXAGRzU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jan 2007 12:55:20 -0500
In-Reply-To: <1168192483207-git-send-email-malattia@linux.it>
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

