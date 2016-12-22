From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v5 03/14] ACPI: ARM64: IORT: add missing comment for iort_dev_find_its_id()
Date: Thu, 22 Dec 2016 13:35:11 +0800
Message-ID: <1482384922-21507-4-git-send-email-guohanjun@huawei.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, jcm@redhat.com, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

We are missing req_id's comment for iort_dev_find_its_id(),
add it back.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 46e2d82..174e983 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -446,6 +446,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
+ * @req_id: Device's Requster ID
  * @idx: Index of the ITS identifier list.
  * @its_id: ITS identifier.
  *
-- 
1.7.12.4
