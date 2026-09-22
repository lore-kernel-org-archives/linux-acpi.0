Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CC43DEB9;
	Tue, 22 Sep 2026 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088204; cv=none; b=UbiqQ6mjBkiYFKvLfI7jX8Hk/gQOWFJ3UwUaCqcmjC6anyKk1VO1JFt1NZhCFrOdOh463ksvxJIkMQHLZXmyc8++N4u7FedSLMR0KYA61t8Ja9r9Fju1BF4rUd370dTt3EDwc53iWYardrvC5YrOG7T3tR+vZeH6en2Oimm1e34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088204; c=relaxed/simple;
	bh=vDGO4jkVYgbdguQucCUIyH2yN1ariNn8DCcJSyEvg3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh18QiZzcGTfw7dmuDiJcnb8aeTD1IYMm2AjCBJdf6uu0bvKoXtRJjiIKon0iAEM3ogr6aVdNDTOMJx/rEyaV/M0vYALbjNJw70tqtbx7ei1XgRzhICY9J/+WEhS8nWulUZ66gcGtQgJ9JZ8e/m4C8ZEkWuFJ+ARK9bCL/SOawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPwRH4Vc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPwRH4Vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ECE1F008A0;
	Tue, 22 Sep 2026 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088202;
	bh=MKhiqHv4U+5kPiwfByYM3WQ7bJnspf8MaWtepG3bUBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NPwRH4Vc9Y6f0AOwbM+u4n3vFKgtvAQrAHvZbrn491y4XlF7HGHqq8V1+AQqBWCgx
	 xRapjD7r+4C5atSoTxtyY3mrXBW1hBPXSP1Ob+Mk2qeFJNv32uI9wJogKsVzO6Y6WV
	 r3jwI5kBabqmCmgNgWuShdcYNlmTKB9kakzNMtklD+bKVstF06smAijwqwGFPNEcTC
	 JgxmJBtteYJBT8O2zHTEJ962GLVbDi3AZTE56Feve/cXU4k+5UautaTiFFlEX19gII
	 HP2SZeOe2MCeZtCasCl+TzpBeJ60LO5FuHVxPJTH259Rn+C0cGMG4ukO5zb4MfL67I
	 vFmFiI7nWQdmg==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v3 2/4] ACPI: PCC: Preserve shared memory signature in OpRegion handler
Date: Tue, 22 Sep 2026 15:43:00 +0100
Message-ID: <20260922144302.3847593-3-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922144302.3847593-1-sudeep.holla@kernel.org>
References: <20260922144302.3847593-1-sudeep.holla@kernel.org>
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

