Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B40430E0F2
	for <linux-acpi@vger.kernel.org>; Sat,  8 Aug 2026 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179591; cv=none; b=CDmHx9bBvRYQazRNH2fF0gzIiGz3KSlBWWbK2B8lr22fxwHni3pOARL3MILn5s8w98kQLsEWB8nxODy7Y+b0O8GMMoBt6hO3D5oB0hI+6YqZcsnHOW4U5FFDJj/cZ8f6SyEmZTEAYpTNKtga4Q18dS92NDxLJVtyX+lFghJCPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179591; c=relaxed/simple;
	bh=CojdOdzv1+buguz0MA8PIz0DGsTm91WNaHj5rYRAaU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J301uPTAuYR6Jjy/OCwAdTBg66/JtEF65Eez1fbU/9A/P2C1aJQuSUtieAagiBHDaSumkcceOOJm8aStENdDQbkqh2BSeuXrhZVPytBEKXbW73eH67MPhUGKOBczmGWvHUi1Yj+lPJhDIJyYeROy1OzJ3jXElm9NmfcpA3sCLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=OVLTbjJ+; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="OVLTbjJ+"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4940f053f;
	Sat, 8 Aug 2026 16:59:43 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH v2] ACPI: scan: fix bus ID cleanup on device_add() failure
Date: Sat,  8 Aug 2026 16:59:42 +0800
Message-ID: <20260808085943.526-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260804154854.1555-1-getshell@seu.edu.cn>
References: <20260804154854.1555-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fe0997da303a1kunmfaacafbd4faf4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTENMVhhLS0IZTk1OQ0hJSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktKWVdZFhoPEhUdFFlBWU9LSFVKS0hKT0
	hMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=OVLTbjJ+gcSs4HmQUJa6fHZn/ByF0a/oPTBUsoEg79xsQ/IrdyKEyS3qPBzuLenLa5QT58dn4Ib8I3JaXzGweARGeQAwhTZPqsoNp3NrIIK2Wa0TFCTufQ+VElMebWQYKkpzB6wDsUTS+iiUknBgVjvGaheY7ITjyMy33gp99R8=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=yw4MO+lR59jvnVGEOPikqFrRF35lpOl9Aigcj6/b6Yw=;
	h=date:mime-version:subject:message-id:from;

When device_add() fails after acpi_device_set_name() has allocated an
instance ID and linked a new acpi_device_bus_id into acpi_bus_id_list, the
rollback path only removes wakeup_list and detaches the ACPI handle data.

That leaves the bus-ID bookkeeping behind and keeps the allocated instance
number consumed.

Move the bus-ID cleanup and wakeup-list removal into a single helper.
Use it from both the normal device teardown path and the device_add()
rollback path. The wakeup list node is initialized before registration, so
it can be deleted without checking whether the device is wakeup-capable, as
in the original teardown path.

Found by manual review of reports from the
kernel70rc2-fail11-retry-20260801 run.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
v2:
- Fold the bus-ID cleanup and wakeup-list removal into one helper to avoid
  duplicating the same sequence in acpi_device_del() and the device_add()
  rollback path.
- Drop the wakeup.flags.valid check before list_del(&device->wakeup_list).

v1: https://lore.kernel.org/linux-acpi/20260804154854.1555-1-getshell@seu.edu.cn/

 drivers/acpi/scan.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ff7000b71fd1..a311af60d8d3 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -520,12 +520,10 @@ static void acpi_device_release(struct device *dev)
 	kfree(acpi_dev);
 }
 
-static void acpi_device_del(struct acpi_device *device)
+static void acpi_device_del_list(struct acpi_device *device)
 {
 	struct acpi_device_bus_id *acpi_device_bus_id;
 
-	mutex_lock(&acpi_device_lock);
-
 	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
 		if (!strcmp(acpi_device_bus_id->bus_id,
 			    acpi_device_hid(device))) {
@@ -540,6 +538,13 @@ static void acpi_device_del(struct acpi_device *device)
 		}
 
 	list_del(&device->wakeup_list);
+}
+
+static void acpi_device_del(struct acpi_device *device)
+{
+	mutex_lock(&acpi_device_lock);
+
+	acpi_device_del_list(device);
 
 	mutex_unlock(&acpi_device_lock);
 
@@ -800,7 +805,7 @@ int acpi_device_add(struct acpi_device *device)
 err:
 	mutex_lock(&acpi_device_lock);
 
-	list_del(&device->wakeup_list);
+	acpi_device_del_list(device);
 
 err_unlock:
 	mutex_unlock(&acpi_device_lock);
-- 
2.50.1.windows.1
