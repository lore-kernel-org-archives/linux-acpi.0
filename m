From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] Staging / quickstart: remove reduplicate if(acpi_disabled)
 check
Date: Sun, 22 Sep 2013 19:05:47 +0800
Message-ID: <1379847947-32366-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linaro-kernel@lists.linaro.org, Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>, patches@linaro.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

In acpi_bus_register_driver(), there is an if (acpi_disabled) check,
so the if(acpi_disabled) before it is reduplicate, remove it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/staging/quickstart/quickstart.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/quickstart/quickstart.c b/drivers/staging/quickstart/quickstart.c
index 4247d60..9f6ebdb 100644
--- a/drivers/staging/quickstart/quickstart.c
+++ b/drivers/staging/quickstart/quickstart.c
@@ -390,10 +390,6 @@ static int __init quickstart_init(void)
 {
 	int ret;
 
-	/* ACPI Check */
-	if (acpi_disabled)
-		return -ENODEV;
-
 	/* ACPI driver register */
 	ret = acpi_bus_register_driver(&quickstart_acpi_driver);
 	if (ret)
-- 
1.7.9.5
