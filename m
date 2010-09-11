From: Jean Sacren <sakiwit@gmail.com>
Subject: [PATCH 1/1] acpi: Fix warning: 'num_cpus' may be used
 uninitialized in this function
Date: Sat, 11 Sep 2010 00:24:37 -0600
Message-ID: <20100911062437.GA18711@mail.gmail.com>
References: <20100911062254.GA18705@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58653 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0IKGYi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Sep 2010 02:24:38 -0400
Received: by pwi3 with SMTP id 3so1316139pwi.19
        for <linux-acpi@vger.kernel.org>; Fri, 10 Sep 2010 23:24:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100911062254.GA18705@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>

warning: 'num_cpus' may be used uninitialized in this function

Initialize 'num_cpus' variable to zero so that gcc doesn't complain.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 drivers/acpi/acpi_pad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index b76848c..6154f2b 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -429,7 +429,7 @@ static void acpi_pad_ost(acpi_handle handle, int stat,
 
 static void acpi_pad_handle_notify(acpi_handle handle)
 {
-	int num_cpus;
+	int num_cpus = 0;
 	uint32_t idle_cpus;
 
 	mutex_lock(&isolated_cpus_lock);
-- 
1.7.1
