Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783D3191D3;
	Sat, 27 Jun 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578363; cv=none; b=uSjQ/SNYEkPAs+35d0H2YNytYyyyS0h31IWQU3CNvHwEBaGe3e/PBM/0/eXzU2mv1Tqm5r/EAph7kzCY9l7ypGl0H7hBXq0mj9hklreViMSUVJdE35Cb+JnSJwbAQTRqufALn+CW/e/T6si/ab5DOATk4twWehhAupcsax1QK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578363; c=relaxed/simple;
	bh=B85FEay2wxdhRzDmrWprYUcVu1QAlJe8xB4zWtEUFCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tSGcyhirSyUXdO5HKG0fIEGc/1aDZDCo4qryGl4tkwR18VpwdFdIraeRQCEIdrCHgjdC0MCXfjj0ve+hX8xMIiz+c/hD4tCHntk+aHxsJRaODQIGRPBJZAxrA1g1mA4YXU/0KlOiCEKPatre9So/zWnnV+ml651cx2QaqXqxWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmS6fupD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmS6fupD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E11B1F00A3A;
	Sat, 27 Jun 2026 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578362;
	bh=Ie01gHIY6uldLwknl/KNVVldVemesKuak3dPtk4k1Xo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hmS6fupDh30JGJ3Aqiw/eNIJOGtmVuxokUllcB+GO46JKLEKIJoDmaKIvclqYT3uC
	 Qn7DntWPN0Tu1Z2VINOBB174bvW2wYcQmxIW2PGhvArfRUORpXmK+uRuFGorMLnINs
	 c8VxgtsMQ3+mYO82KtZROGSxCPQqdhEpemjw7r43sWuXS1yJrLaAsbHwgmdRyH+rVt
	 Vgnlv5qLVql5f/FDh7M4N3YLMZWcxdtFprhudwfhDQcSZ2juAnU2Sr16p5vH/H8gR4
	 DGdHN1kqd04+2zmEPsJkN0EceesHxO9PmOCPa/fFFlnXgt1e1u8kHzv9V4aFDwgjuV
	 DpCddU60JhomQ==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Sat, 27 Jun 2026 17:37:34 +0100
Subject: [PATCH 6/6] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-acpi_pcc_signature-v1-6-c1b7268d4fdc@kernel.org>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
In-Reply-To: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: b4 0.15.2

ACPI defines a PCC OperationRegion as the shared memory fields that
follow the PCC signature. The OperationRegion length is likewise the
total size of the fields that succeed the signature in shared memory.

ACPI 6.6 adds clarification that the PCC shared memory signature is
populated by the platform and verified by OSPM.

The PCC address space handler currently copies the OperationRegion
buffer to and from the start of the PCC shared memory region. That can
overwrite or expose the signature at byte offset 0, and it also misses
the last 4 bytes of the actual PCC OperationRegion data.

Offset OperationRegion copies by the size of the signature and reject
regions that do not fit in the shared memory after that signature.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/acpi/acpi_pcc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 438c67189511..9881c9ee293d 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -28,6 +28,7 @@
  * to PCC commands
  */
 #define PCC_CMD_WAIT_RETRIES_NUM	500ULL
+#define PCC_SIGNATURE_SIZE		sizeof(u32)
 
 struct pcc_data {
 	struct pcc_mbox_chan *pcc_chan;
@@ -74,6 +75,14 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 	}
 
 	pcc_chan = data->pcc_chan;
+	if (pcc_chan->shmem_size < PCC_SIGNATURE_SIZE ||
+	    ctx->length > pcc_chan->shmem_size - PCC_SIGNATURE_SIZE) {
+		pr_err("PCC channel-%d shared memory is too small.\n",
+		       ctx->subspace_id);
+		ret = AE_AML_REGION_LIMIT;
+		goto err_free_channel;
+	}
+
 	if (!pcc_chan->mchan->mbox->txdone_irq) {
 		pr_err("This channel-%d does not support interrupt.\n",
 		       ctx->subspace_id);
@@ -97,14 +106,17 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 			       u32 bits, acpi_integer *value,
 			       void *handler_context, void *region_context)
 {
-	int ret;
 	struct pcc_data *data = region_context;
+	void __iomem *pcc_opregion;
 	u64 usecs_lat;
+	int ret;
+
+	pcc_opregion = data->pcc_chan->shmem + PCC_SIGNATURE_SIZE;
 
 	reinit_completion(&data->done);
 
-	/* Write to Shared Memory */
-	memcpy_toio(data->pcc_chan->shmem, (void *)value, data->ctx.length);
+	/* Write to the PCC OperationRegion after the shared memory signature. */
+	memcpy_toio(pcc_opregion, (void *)value, data->ctx.length);
 
 	ret = mbox_send_message(data->pcc_chan->mchan, NULL);
 	if (ret < 0)
@@ -125,7 +137,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 
 	mbox_chan_txdone(data->pcc_chan->mchan, ret);
 
-	memcpy_fromio(value, data->pcc_chan->shmem, data->ctx.length);
+	memcpy_fromio(value, pcc_opregion, data->ctx.length);
 
 	return AE_OK;
 }

-- 
2.43.0

