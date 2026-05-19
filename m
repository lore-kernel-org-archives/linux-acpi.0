Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59711A682A;
	Tue, 19 May 2026 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171234; cv=none; b=fNtOuNoqssc+R/Rx9ocQlK26pr1czBhJ8mWhQT7ngrpO0rxI6WnA/+R5MxLX1KX30FKjBYr1xDSrmeeNH4K4iO/mxZYSz1pvScw6EgggsOTEPvU8BtLCZhvrhibAbu4ZYQZ8axeLL3fyZi3zGsXPW3Nmz+nbayKyE82OD4TyUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171234; c=relaxed/simple;
	bh=eDdypLMdh0ABr1jXAwg8jwfBuFdkrNrWgQDaQkjnNC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9JvV2aYXwfu8I/qsWIvhoC5bzB063uNWPX8IwztReoCCcA5r60HfNuGFKDJM6DlseGdaQTLIkp+dVqWRuPzDJgBZGYtClcCtM/C8zKCRX5oxlku1jDebxQmIsQWA9D8J4ZRHw9/f92Tma+vo0dF3r/PhRramJ1b3GPDaV0sP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go93WtE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go93WtE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D55C2BCB3;
	Tue, 19 May 2026 06:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779171234;
	bh=eDdypLMdh0ABr1jXAwg8jwfBuFdkrNrWgQDaQkjnNC0=;
	h=From:To:Cc:Subject:Date:From;
	b=go93WtE3I1mjggb2znt6NfuRg0nGZlaSlTbx8FhNDkk0Gpr6til29QgDJO63ydlw2
	 wEjqN5hGTOzgsFyeq++wC32Sw7SGULtor58RhAI+8AIcwJH644OhpXZJclashP92s3
	 VrrW3uD2BDjhA0fBSeYQTjYWCgWN3D9U7iCYzMxORpAv7jGUcq3SkN4z4YwayLFn5S
	 3szWlGPCj7/ItQZTr8ZoeT/iVwHXrnq1Q8fO32f5jFOXzRAQnfSfriiYNn0n5wau+t
	 GFRsIazCB1R9jg0Y9BibzcFJa0NyrgzazjRqWuCcJv0569oLs1bAAm/faz8QkOkvNF
	 1H0FTcJOBvEqg==
From: Jisheng Zhang <jszhang@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ACPI: Use LIST_HEAD() to initialize on stack list head
Date: Tue, 19 May 2026 13:54:45 +0800
Message-ID: <20260519055445.13122-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use LIST_HEAD to initialize on stack list head. No intentional
functional impact.

Change generated with below coccinelle script:

@@
identifier name;
@@
- struct list_head name;
+ LIST_HEAD(name);
... when != name
- INIT_LIST_HEAD(&name);

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/acpi/acpi_apd.c   | 3 +--
 drivers/acpi/arm64/amba.c | 3 +--
 drivers/acpi/resource.c   | 3 +--
 drivers/acpi/scan.c       | 3 +--
 drivers/acpi/x86/lpss.c   | 3 +--
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index bed0791c17fc..fa28acc541fe 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -68,14 +68,13 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	struct platform_device *clkdev;
 	struct fch_clk_data *clk_data;
 	struct resource_entry *rentry;
-	struct list_head resource_list;
+	LIST_HEAD(resource_list);
 	int ret;
 
 	clk_data = devm_kzalloc(&adev->dev, sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_memory_resources(adev, &resource_list);
 	if (ret < 0)
 		return -ENOENT;
diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 1350083bce5f..ec342404306b 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -39,7 +39,7 @@ static int amba_handler_attach(struct acpi_device *adev,
 	struct acpi_device *parent = acpi_dev_parent(adev);
 	struct amba_device *dev;
 	struct resource_entry *rentry;
-	struct list_head resource_list;
+	LIST_HEAD(resource_list);
 	bool address_found = false;
 	int irq_no = 0;
 	int ret;
@@ -55,7 +55,6 @@ static int amba_handler_attach(struct acpi_device *adev,
 		return -ENOMEM;
 	}
 
-	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
 	if (ret < 0)
 		goto err_free;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index bc8050d8a6f5..ff78311c136b 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -1118,11 +1118,10 @@ EXPORT_SYMBOL_GPL(acpi_dev_filter_resource_type);
 
 static int acpi_dev_consumes_res(struct acpi_device *adev, struct resource *res)
 {
-	struct list_head resource_list;
+	LIST_HEAD(resource_list);
 	struct resource_entry *rentry;
 	int ret, found = 0;
 
-	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
 	if (ret < 0)
 		return 0;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 530547cda8b2..bd599d0a9348 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1738,7 +1738,7 @@ static bool acpi_is_indirect_io_slave(struct acpi_device *device)
 
 static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 {
-	struct list_head resource_list;
+	LIST_HEAD(resource_list);
 	bool is_serial_bus_slave = false;
 	static const struct acpi_device_id ignore_serial_bus_ids[] = {
 	/*
@@ -1792,7 +1792,6 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	if (!acpi_match_device_ids(device, ignore_serial_bus_ids))
 		return false;
 
-	INIT_LIST_HEAD(&resource_list);
 	acpi_dev_get_resources(device, &resource_list,
 			       acpi_check_serial_bus_slave,
 			       &is_serial_bus_slave);
diff --git a/drivers/acpi/x86/lpss.c b/drivers/acpi/x86/lpss.c
index 0171eef00484..d33dc34a2894 100644
--- a/drivers/acpi/x86/lpss.c
+++ b/drivers/acpi/x86/lpss.c
@@ -615,7 +615,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	const struct lpss_device_desc *dev_desc;
 	struct lpss_private_data *pdata;
 	struct resource_entry *rentry;
-	struct list_head resource_list;
+	LIST_HEAD(resource_list);
 	struct platform_device *pdev;
 	int ret;
 
@@ -627,7 +627,6 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	if (!pdata)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_memory_resources(adev, &resource_list);
 	if (ret < 0)
 		goto err_out;
-- 
2.53.0

