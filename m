Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8B3E1D0B;
	Fri, 17 Jul 2026 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275814; cv=none; b=ifIOJ4c7Ve01aADPG/A7D7iVBRpoT9VmTcb/k1e/BNUdLHu17rOamsuvdjZrGPj8DYJmJQPu6npDUojabn8zl3hY9vpVZN8W5f13cn+q009J25+Qdzk1OuLjmbjUW4Rnkww1CFJvmJrgGtfaF9UYBTJLsS0uNu4fpowCIY3CBvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275814; c=relaxed/simple;
	bh=Yuqa9q0jsrYddRslOfOdEVoCVy3IgWWB+234NiGqkoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5JPKwnCfJEi1VSJ1EH8BaPvAzdjL42N/nwD55MfmhyESGF4HZxg8TtFrysU7YmmL/9WIwRdAxOp3p82m08/Bv3z3OXxNrrIYrVV4L24S2QWfeH9xYTBKyz/vDLcaGx5DwcVFM6VqV36NH/d8WZXIfnjuirXWfp7447CmG9ZJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG1gnnxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG1gnnxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AF81F00A3A;
	Fri, 17 Jul 2026 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275813;
	bh=QdlqjIC+9mifni0x/50H8jxPTVWrHgCMVy6gkeAIqII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BG1gnnxdtn0yKI8wsezbFiOcUbcNqeM1QXu5Kwo1MI3suM2Hja+Gl+coI8AK3a+wy
	 93vH+G6FBRqsbNRZD0ScllpiY3ClGnELnR4EE0HJSVI7GXhWfWcJObRy1XoK6oH1ID
	 /QF2uLVoLM8YyRJCPYCtnpwndQq1SyoY2EJFDuNZbGRweO3jK77SVYp2Y9IyOOo8m4
	 64C0BBc3X+YlYiWlbGBJcqMJKT7Wn5ukAzr0281Z+ryhdjK3HVuol8f5mYzckXBY+Z
	 dcM/4uvd/yR00cNUJNkXgfN2KIxiBjpM92w4M2ZLstW8eVUPjgz+3uRRBGGLeQd/6h
	 VPAKtlYGMVr+A==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 2/4] ACPI: PCC: Preserve shared memory signature in OpRegion handler
Date: Fri, 17 Jul 2026 09:10:03 +0100
Message-ID: <20260717081005.470013-3-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717081005.470013-1-sudeep.holla@kernel.org>
References: <20260717081005.470013-1-sudeep.holla@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI 6.3 introduced PCC OperationRegions. Section 5.5.2.4.7.3,
"Declaring message fields within a PCC OperationRegion", states that,
for all PCC subspace types, the PCC Operation Region pertains to the
region of PCC subspace that succeeds the PCC signature.

The PCC address space handler currently copies the OperationRegion
buffer to and from the start of the PCC shared memory region. That can
overwrite or expose the signature at byte offset 0, and it also misses
the last 4 bytes of the actual PCC OperationRegion data.

Offset OperationRegion copies by the size of the signature and reject
regions that do not fit in the shared memory after that signature. AML
that sizes the PCC OperationRegion to include the signature is not
conforming to the PCC OperationRegion definition.

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

