Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E53F9F47
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858546; cv=none; b=PoO4g5KasPbtXCDYVDmiJZe4/c/P2xWjjhhFW4R8yQsc5wjhNucA74Qpqb7lWPyudYTLiTIVB49MQsnBy4g866tc6PJtBnUU6ov2r/OLkzpF5hrZB/5+nEbIOTByBQQP6fZRpTWCssHacQy1e4n2zu/l7QxCErdTh5+HpTOMaHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858546; c=relaxed/simple;
	bh=FRzu+vZLRlVbfz4PxPC4vXEsGuoU4sGIsRJy4YzwKD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOzX9dBZzBhXR0IN+eK4Dh60+1/tMu+gnFb/m0heggILfKYlZ+bjaoAdz7pPwYlYn+2JRaDHItozeen1tRC8/bX4TNgcK0buBzKfUOF/oqbHEi/VAFFP0X4L7rwUNjwScH/OOmpvBvdBeE+VppNUtn0XiwxOWivDJ6dKEWLOOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hgEY7Y9R; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hgEY7Y9R"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 48bf56b04;
	Tue, 4 Aug 2026 23:48:55 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] ACPI: scan: fix bus ID cleanup on device_add() failure
Date: Tue,  4 Aug 2026 23:48:53 +0800
Message-ID: <20260804154854.1555-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fcd76acc903a1kunm1415e8a323eb9c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTRpCVkNIQxkYQkoaH0pJSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hgEY7Y9R93EWkWWSNYQd+Jxx1rgQbiiVKIk3JQTG+2XpDfs2T8o9Ibc1+x5Zxsdauqzv9KZFc0WMIqlloYU6jw2JpA0PMVTHiUNQjIIdnObu537nVH4Nmjgd1TgjO28b0BfKcCQp4xxCqY6ZJxMGQTSvBiWgaML22tR8aflHR2E=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=m9zOgtWaO5/5lZheoh7K4V9++0wHbDWQ0jeq0x5m+g4=;
	h=date:mime-version:subject:message-id:from;

When device_add() fails after acpi_device_set_name() has allocated an
instance ID and linked a new acpi_device_bus_id into
acpi_bus_id_list, the rollback path only removes wakeup_list and
detaches the ACPI handle data.

That leaves the bus-ID bookkeeping behind and keeps the allocated
instance number consumed.

Factor the bus-ID removal into a helper, use it from both the normal
device teardown path and the device_add() rollback path, and only drop
wakeup_list when it was actually linked.

Found by manual review of reports from the
kernel70rc2-fail11-retry-20260801 run.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/acpi/scan.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ff7000b71..852682436 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -520,12 +520,10 @@ static void acpi_device_release(struct device *dev)
 	kfree(acpi_dev);
 }
 
-static void acpi_device_del(struct acpi_device *device)
+static void acpi_device_remove_bus_id(struct acpi_device *device)
 {
 	struct acpi_device_bus_id *acpi_device_bus_id;
 
-	mutex_lock(&acpi_device_lock);
-
 	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
 		if (!strcmp(acpi_device_bus_id->bus_id,
 			    acpi_device_hid(device))) {
@@ -538,8 +536,16 @@ static void acpi_device_del(struct acpi_device *device)
 			}
 			break;
 		}
+}
 
-	list_del(&device->wakeup_list);
+static void acpi_device_del(struct acpi_device *device)
+{
+	mutex_lock(&acpi_device_lock);
+
+	acpi_device_remove_bus_id(device);
+
+	if (device->wakeup.flags.valid)
+		list_del(&device->wakeup_list);
 
 	mutex_unlock(&acpi_device_lock);
 
@@ -800,7 +806,9 @@ int acpi_device_add(struct acpi_device *device)
 err:
 	mutex_lock(&acpi_device_lock);
 
-	list_del(&device->wakeup_list);
+	acpi_device_remove_bus_id(device);
+	if (device->wakeup.flags.valid)
+		list_del(&device->wakeup_list);
 
 err_unlock:
 	mutex_unlock(&acpi_device_lock);
-- 
2.50.1.windows.1

