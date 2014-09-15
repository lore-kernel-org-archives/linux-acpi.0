From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] ACPI: Update acpi_check_dsm() comments
Date: Mon, 15 Sep 2014 19:36:53 +0800
Message-ID: <1410781013-16673-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:40683 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbaIOLOI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Sep 2014 07:14:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>

Update function comments.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/acpi/utils.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 07c8c5a..834f35c 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -661,7 +661,6 @@ EXPORT_SYMBOL(acpi_evaluate_dsm);
  * @uuid: UUID of requested functions, should be 16 bytes at least
  * @rev: revision number of requested functions
  * @funcs: bitmap of requested functions
- * @exclude: excluding special value, used to support i915 and nouveau
  *
  * Evaluate device's _DSM method to check whether it supports requested
  * functions. Currently only support 64 functions at maximum, should be
-- 
1.7.1

