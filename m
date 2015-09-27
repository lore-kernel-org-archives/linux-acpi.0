From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH] acpi/apei: apei_resources_all should be static
Date: Sun, 27 Sep 2015 22:38:40 +0800
Message-ID: <4b7c2e0e13d40d4713a7548f5cce9901c4c0d7e7.1443364529.git.geliangtang@163.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m50-134.163.com ([123.125.50.134]:35957 "EHLO m50-134.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755887AbbI0Oj2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Sep 2015 10:39:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Chen, Gong" <gong.chen@linux.intel.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Fixes the following sparse warning:

drivers/acpi/apei/apei-base.c:298:23: warning: symbol
'apei_resources_all' was not declared. Should it be static?

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/acpi/apei/apei-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index a2c8d7a..8e7600c 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -295,7 +295,7 @@ struct apei_res {
 };
 
 /* Collect all resources requested, to avoid conflict */
-struct apei_resources apei_resources_all = {
+static struct apei_resources apei_resources_all = {
 	.iomem = LIST_HEAD_INIT(apei_resources_all.iomem),
 	.ioport = LIST_HEAD_INIT(apei_resources_all.ioport),
 };
-- 
2.5.0


