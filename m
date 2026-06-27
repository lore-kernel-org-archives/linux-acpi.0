Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B531D367;
	Sat, 27 Jun 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578365; cv=none; b=Vni9nKt+ZEp4gzlDJY1xrxesFcwW6MFifZfa2ZNUjMZDd+te3GZg6n4Xu+vAVlC/XthVUSDQqNyjWLQwiXpNw0L2hvadU9p6x4DeVDH2ampJlWZVdmnXIunKCn0BQbt7kyxPcVk+n8POXZXx4/DeHIrM3Po9nnzdVywNt9NgjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578365; c=relaxed/simple;
	bh=voZ/wygq8vovV9dzMBmbL4IEj73L9FK/+B4LGPkz0w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAIC9Io/2/MPG5G3mViuhe03eYKu98xebl7ueZ7odvNVQLQ3XzVC5VknGi3Sckai4xaREL9DZH4berkWcT9cbc7yfzfyLJtMq4AGCOBybusjyaZHri/mDC+oNH8uEPltYzxAzbhezPswdEhQs5LZIgtZxBpG3G0kiaxrxZ1Ol8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCUOE1Jq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCUOE1Jq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C831F00A3E;
	Sat, 27 Jun 2026 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578361;
	bh=FTb/24/zpsWJ44xxUuk5KdinxeVfkbyqSlC2OEsWdbM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bCUOE1JqJD9naK67ujyTNHMnoTo52ZtG1lqyenQ1j8HZGltXrHRc7ZcnKwC5Nn/xQ
	 gAJ9TNSofnWlAdyCUrlkJsZ/6qlhi7xYeRbwOduxhHNXwB9iEnii4FJ9RfiasWICLH
	 dq3plhtvua8eYxUZQfz3aqjgrkvuMmdfZNfd8ZQtiLE8jej+v1SFSusEpv/udSJ9Fw
	 sa3BNpyM4wHDsnFQgI+4vgpJrQNSP0VkO2sDURS76fvTrhIDinlzTh6LHYd9N/qBpk
	 mvEAfbjPZ6LEiFU32UHskfNv+0RkseSEUf7Hi5u2I7/BcsnJ8R7BCVkFWDrrXib4y+
	 48E28OVbVb7bg==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Sat, 27 Jun 2026 17:37:33 +0100
Subject: [PATCH 5/6] soc: hisilicon: kunpeng_hccs: Preserve PCC signatures
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-acpi_pcc_signature-v1-5-c1b7268d4fdc@kernel.org>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
In-Reply-To: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Huisong Li <lihuisong@huawei.com>
X-Mailer: b4 0.15.2

ACPI specification defines the generic PCC shared memory signature as
the PCC base signature ORed with the subspace ID.

ACPI 6.6 added clarification that the signature is populated by the
platform and verified by OSPM.

The PCC mailbox controller now validates the signature when the channel
is requested. Stop copying complete local PCC headers into shared
memory and write only the mutable command, status, flags and length
fields, leaving the platform-populated signatures intact.

Cc: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 0cc2953d59a5..0e5e48e46eba 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -270,14 +270,11 @@ static inline void hccs_fill_pcc_shared_mem_region(struct hccs_dev *hdev,
 						   void __iomem *comm_space,
 						   u16 space_size)
 {
-	struct acpi_pcct_shared_memory tmp = {
-		.signature = PCC_SIGNATURE | hdev->chan_id,
-		.command = cmd,
-		.status = 0,
-	};
+	struct acpi_pcct_shared_memory __iomem *comm_base;
 
-	memcpy_toio(hdev->cl_info.pcc_chan->shmem, (void *)&tmp,
-		    sizeof(struct acpi_pcct_shared_memory));
+	comm_base = hdev->cl_info.pcc_chan->shmem;
+	iowrite16(cmd, &comm_base->command);
+	iowrite16(0, &comm_base->status);
 
 	/* Copy the message to the PCC comm space */
 	memcpy_toio(comm_space, (void *)desc, space_size);
@@ -289,15 +286,12 @@ static inline void hccs_fill_ext_pcc_shared_mem_region(struct hccs_dev *hdev,
 						       void __iomem *comm_space,
 						       u16 space_size)
 {
-	struct acpi_pcct_ext_pcc_shared_memory tmp = {
-		.signature = PCC_SIGNATURE | hdev->chan_id,
-		.flags = PCC_CMD_COMPLETION_NOTIFY,
-		.length = HCCS_PCC_SHARE_MEM_BYTES,
-		.command = cmd,
-	};
+	struct acpi_pcct_ext_pcc_shared_memory __iomem *comm_base;
 
-	memcpy_toio(hdev->cl_info.pcc_chan->shmem, (void *)&tmp,
-		    sizeof(struct acpi_pcct_ext_pcc_shared_memory));
+	comm_base = hdev->cl_info.pcc_chan->shmem;
+	iowrite32(PCC_CMD_COMPLETION_NOTIFY, &comm_base->flags);
+	iowrite32(HCCS_PCC_SHARE_MEM_BYTES, &comm_base->length);
+	iowrite32(cmd, &comm_base->command);
 
 	/* Copy the message to the PCC comm space */
 	memcpy_toio(comm_space, (void *)desc, space_size);

-- 
2.43.0

