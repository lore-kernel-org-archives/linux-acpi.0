From: Qiang Zheng <zhengqiang10@huawei.com>
Subject: [PATCH] Bug fix: Clear ack of GHES table which contain wrong Error status block, let new error can fill GHES table.
Date: Mon, 30 Oct 2017 09:23:14 +0800
Message-ID: <1509326594-201050-1-git-send-email-zhengqiang10@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9473 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdJ3Ag3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Oct 2017 20:36:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: will.deacon@arm.com, tbaicar@codeaurora.org, james.morse@arm.com, shiju.jose@huawei.com, rjw@rjwysocki.net
Cc: gengdongjiu@huawei.com, wangxiongfeng2@huawei.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com

Current Error status block processing flow, if wrong format is checked,
GHES table ack is not cleared.
It will cause new error can not be filled GHES table, because UEFI
need check ack to know if error was handled by OS.

This patch solved issue, no matter Error status block format is wrong,
But GHES table format is corrected, we clear ack.

Signed-off-by: Qiang Zheng <zhengqiang10@huawei.com>
---
 drivers/acpi/apei/ghes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 077f9ba..b0e0782 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -743,6 +743,7 @@ static int ghes_proc(struct ghes *ghes)
 	}
 	ghes_do_proc(ghes, ghes->estatus);
 
+out:
 	/*
 	 * GHESv2 type HEST entries introduce support for error acknowledgment,
 	 * so only acknowledge the error if this support is present.
@@ -752,7 +753,7 @@ static int ghes_proc(struct ghes *ghes)
 		if (rc)
 			return rc;
 	}
-out:
+
 	ghes_clear_estatus(ghes);
 	return rc;
 }
-- 
1.9.1

