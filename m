From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] drivers/acpi: beautify code, pr->id is u32 which is never
 < 0
Date: Wed, 27 Feb 2013 12:27:30 +0800
Message-ID: <512D8B32.1000905@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:37066 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756920Ab3B0E1t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Feb 2013 23:27:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org


  pr->id is u32 which never < 0

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/acpi/processor_driver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index df34bd0..bec717f 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -559,7 +559,7 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		return 0;
 #endif
 
-	BUG_ON((pr->id >= nr_cpu_ids) || (pr->id < 0));
+	BUG_ON(pr->id >= nr_cpu_ids);
 
 	/*
 	 * Buggy BIOS check
-- 
1.7.7.6
