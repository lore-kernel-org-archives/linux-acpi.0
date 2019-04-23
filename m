From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH next 01/25] ACPI / DPTF: Use dev_get_drvdata()
Date: Tue, 23 Apr 2019 15:49:56 +0800
Message-ID: <20190423075020.173734-2-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Using dev_get_drvdata directly.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/dptf/dptf_power.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index e1c242568341..0c081390930a 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -31,8 +31,7 @@ static ssize_t name##_show(struct device *dev,\
 			   struct device_attribute *attr,\
 			   char *buf)\
 {\
-	struct platform_device *pdev = to_platform_device(dev);\
-	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);\
+	struct acpi_device *acpi_dev = dev_get_drvdata(dev);\
 	unsigned long long val;\
 	acpi_status status;\
 \
-- 
2.20.1
