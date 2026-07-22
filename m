Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B927F017;
	Wed, 22 Jul 2026 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726173; cv=none; b=Sn8ZdA+G+xQp3oYDm/wh01PWdETn2oX0B/IfdzkSjoWBgx9s0F8OJJt/8AQBq6ANE9ah7XgjuRd2nZ62WNkmIblaQGnOpogbiRBDeyq/dmoFotodpQERaiTKku7L68NXa1Elax8JVj0WdTvVam4bR1P8LZxe2o6UFKDITvHZiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726173; c=relaxed/simple;
	bh=vDGO4jkVYgbdguQucCUIyH2yN1ariNn8DCcJSyEvg3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBgRdHJFn6WIoMi2+9yOA8W8Q5rJUh21j57qMsHN7yUTMu9FGFXVRRfw32KpYz8hl0HP8ZLxjxN8GP1AXhnBbtHd+o1NBrkFcEsPElWofHp84Ld1BBoTeKnzYz9EzvI9SjfD7PSSUIU/yobXfYM2GIZVH3v7MG8gkLjtDxSgoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdDtk8gL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdDtk8gL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B59E1F00A3A;
	Wed, 22 Jul 2026 13:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726166;
	bh=MKhiqHv4U+5kPiwfByYM3WQ7bJnspf8MaWtepG3bUBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RdDtk8gLSfWP3iYp4f8Cc/shtnPEGHZocvdMzKnm+nt100325Q3s4HELVuEL8lnoJ
	 DRIO6p9hyk76VVJHoScknU3DjeeVYF8TuewwlNAKR3Od4C5iGIpb/cgsViYLxFsLEm
	 g75LpcgiWeErH6pFoyOqjEDDrrHJ4QmawmQNnWp+JH7prIYfelh/iAyk52QrpLKH9K
	 84fKWczijedZ1tFRH2u+ny9LZrAF9d6CtoCKRbXISBohnfm8GibTaA0A+dLJNGMhdf
	 F7tRIwk60NN85ma23F2XEffPxTZTEuJppt/hxsT27CGgr1OkJ8GCc8VHMu/AQ9vLHB
	 8H2pbJd6Q5Iuw==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v2 2/4] ACPI: PCC: Preserve shared memory signature in OpRegion handler
Date: Wed, 22 Jul 2026 14:15:51 +0100
Message-ID: <20260722131553.2117835-3-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722131553.2117835-1-sudeep.holla@kernel.org>
References: <20260722131553.2117835-1-sudeep.holla@kernel.org>
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
region of PCC subspace that succeeds the PCC signature. Its length
therefore excludes the 4-byte signature.

The PCC address space handler currently copies the OperationRegion
buffer to and from the start of the shared memory. This overwrites or
exposes the platform-populated signature and omits the final four bytes
of the OperationRegion.

Offset the copies by the size of the signature and reject an
OperationRegion that does not fit in the remaining shared memory.

The example added by commit 77e2a04745ff ("ACPI: PCC: Implement
OperationRegion handler for the PCC Type 3 subtype") incorrectly
included the signature as an OperationRegion field. A Type 3
OperationRegion containing a 100-byte communication area is declared
as follows:

OperationRegion (PFRM, PCC, 2, 0x70)
Field (PFRM, ByteAcc, NoLock, Preserve)
{
    FLGS,   32,
    LEN,    32,
    CMD,    32,
    DATA,   800
}

This contains three 32-bit fields followed by a 100-byte DATA field.
The fields correspond to the Type 3 shared memory layout in ACPI 6.3,
Table 14-372, after excluding its 4-byte signature.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
Reviewed-by: Huisong Li <lihuisong@huawei.com>
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

