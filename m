Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034481;
	b=R4mRvJgbkU1PiJ7tmXLLFNJJqQ2aGQ/bNOkINbhvajn+aIih8Ixw2sP7Wukkd5bId1cg
	 2AF39E0NAEC9fY3h/kQoDa/7cRgbFdR+dNMPSdtyzvAmISGbOT/pAHGlW1zi51SCuiN4d
	 sn7R0U4IErQYuy0to5F+wnptbPkkosOutmiQ4eq4LC6O2sBwScmRJMEboZZ0W1J6AlkSk
	 Pin+7Q2VhAUuXVNxdtbcqvcHLZ2u7UCDG3WuQNLJenHvinnMlr+uRNcOw4afCKdiY3vZE
	 pHzZcR9SsZYWOfmCJBFzJbQOKjOpvpDEipLKFDgtYlu2UqECnh9bjXKfMUy0G7vCWEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034481;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=VPqX3Qpx3tLJzj7ULQBQQFcKcUTRQTnodWe7ZmgKeOQ=;
	b=RorSN+BKQK2ORn3rt0whKzV5kixVar8rS6x9LJvFq1c2gWyVFYnC0gPZvN54MOhUG5hj
	 ICXWDYrr/JkVtsAN7rFIgUMHioF6EIUVTcfZyrMkNSU1wuQYmoay2eJA/0AQtiEQF3eLk
	 BJoC0OxdCSnGbK0fm2NFxVV+3VoAm6tAC3b6TAjNNmKuq6ttYbKvSnPM7FVaAVTmFM/69
	 KYcuEh1HMkxBTF+xIrzFITygF3e+bbF6fmMNvXSa5qxuCLzoeh19GzAtHsKncoHwjFRQr
	 +0gZW3vZJRd1M1Pl7eDTWcLR8MZBs72MBZkdxDKTcbs7V9ulQbNwxi1bAWM6NJMGIaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=MtBjPTrL;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF269606A338;
	Sat,  7 Nov 2026 06:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF269606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=MtBjPTrL
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53d65d8f1;
	Sat, 7 Nov 2026 14:54:29 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: configfs: Fix potential table item leak on removal
Date: Sat,  7 Nov 2026 14:54:28 +0800
Message-ID: <20261107-0d0c29e10a-acpi-configfs-1@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1b4c98a5a03a1kunm00da5e4682b40
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTh4YVkxDHR9MTxlDHkNJTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0hKTE
	1DVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=MtBjPTrLKbwDQPMAtDIH/WEA8AXWvaowpxSrXviAJi2oz+7PUuKbqf+XwaS/B/IfZkhiGD/WvQDpojiUoEmfiDWodDuPSqjKAfUL+QBz92roNiO5jXjZv3jDu9XlGFSJxxeMNuAkLvYOUflSqJkKpUT/jggV6qILbuXZvjjA5xg=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=VPqX3Qpx3tLJzj7ULQBQQFcKcUTRQTnodWe7ZmgKeOQ=;
	h=date:mime-version:subject:message-id:from;

The table item type has no release callback, so dropping its last
configfs reference never frees the allocated struct acpi_table.

Add a release callback and only unload items that have a table.
Keep the AML buffer alive: ACPICA retains installed tables after
unload and requires the caller's buffer to remain valid for reload.

This issue was found by our static analysis tool under development.

Fixes: 612bd01fc6e0 ("ACPI: add support for loading SSDTs via configfs")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Validation: Changed-object compilation passed with W=1 in the recorded
configuration. No hardware/kernel runtime test or full linked-kernel
build.
OpenAI Codex assisted with source review, patch implementation and
commit-message drafting. The submitter has reviewed the changes.

 drivers/acpi/acpi_configfs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index 6071699c7165..89ef17d5d5a5 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -199,8 +199,21 @@ static struct configfs_attribute *acpi_table_attrs[] = {
 	NULL,
 };
 
+static void acpi_table_release(struct config_item *cfg)
+{
+	struct acpi_table *table = container_of(cfg, struct acpi_table, cfg);
+
+	/* ACPICA retains the table buffer for possible reload after unload. */
+	kfree(table);
+}
+
+static const struct configfs_item_operations acpi_table_item_ops = {
+	.release = acpi_table_release,
+};
+
 static const struct config_item_type acpi_table_type = {
 	.ct_owner = THIS_MODULE,
+	.ct_item_ops = &acpi_table_item_ops,
 	.ct_bin_attrs = acpi_table_bin_attrs,
 	.ct_attrs = acpi_table_attrs,
 };
@@ -224,7 +237,8 @@ static void acpi_table_drop_item(struct config_group *group,
 	struct acpi_table *table = container_of(cfg, struct acpi_table, cfg);
 
 	pr_debug("Host-directed Dynamic ACPI Table Unload\n");
-	acpi_unload_table(table->index);
+	if (table->header)
+		acpi_unload_table(table->index);
 	config_item_put(cfg);
 }
 

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
