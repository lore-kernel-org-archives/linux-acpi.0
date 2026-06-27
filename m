Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C33195FD;
	Sat, 27 Jun 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578357; cv=none; b=Wv0cOeg2oe0dn2N87L7VvX7Z+dlKI+htycprTuni0XDN/dLhy0FJozE+Di8NF7Y+g3z8mKJkFxkorC8RvTrj/iobdXUk3DJm/fLK8WzQktEi9AuO/RkFl6GjmqLaR/PHRKwA7JPOIYr0R9zLw5ov7FhHbJH7bZxgKTYj2repFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578357; c=relaxed/simple;
	bh=5NNuYjBO/Gb7RKz/z6fCnsmR/IAKVxP5jFnnBzT2Ong=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7aTLhG0V43+8juhI9SVXINj3MoxRjFIk8acz6n+Yok9xjfGc1xhjLI13G02s+1n3OUQByPmsawSLoYPrsAzzgKa1afZWhZ86M4EthT+l1mtqEd9nY3LspLNv1I0K6ypGcQCun3lY9Sb8QzvL6bs/9Ea9n9okCDCSYQKTLyWIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nvro3t8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nvro3t8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F121F00A3A;
	Sat, 27 Jun 2026 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578356;
	bh=5tNKaAqHxt5BsClRBPY4p9Q6x/WHrC3Qloehr5fl1LY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Nvro3t8/S5UwqjZPwTaZZYB1TpZfpP55IF610ZpX8ZIusm53C3UBKi2xvD6BclDsJ
	 +6oGSL0UWrahhptR7maAyuzOHcXkALBBsmJHPXWh5hd444Uon0b/0j13gCmMG65vYA
	 QVOl0MOsQxjSBuBFOCwfZkm6sUeEYQfAHHmgcPwcC+Q2m/+aX2F1A7oXEt8xFjGMit
	 NyBc6rSKLDX639BIzTPwIoU5PK7WRN0oaOrW7IPeU5WkmiHUSs7kpcgHVieWNvFfc4
	 5pOycj9nDQhjyT4iiKj9tNlQ+1P2+QHAAjRY6OgsGv81Wyb9qRmGX6y+6rcGKFJz92
	 HvHuAGlh/NWAg==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Sat, 27 Jun 2026 17:37:29 +0100
Subject: [PATCH 1/6] mailbox: pcc: Validate shared memory signature on
 request
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-acpi_pcc_signature-v1-1-c1b7268d4fdc@kernel.org>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
In-Reply-To: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>
X-Mailer: b4 0.15.2

ACPI defines the PCC shared memory signature as the bitwise OR of
0x50434300 and the PCC subspace ID. The signature is located at byte
offset 0 for the generic, extended and reduced PCC shared memory region
layouts.

Validate the signature when a client requests a PCC mailbox channel, after
mapping the shared memory and before binding the mailbox client. This
keeps PCC shared memory validation in the PCC mailbox controller instead
of duplicating it in individual clients.

ACPI 6.6 added clarification that the signature is populated by the
platform and verified by OSPM.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/mailbox/pcc.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 636879ae1db7..6fbc17d41774 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -345,6 +345,28 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int pcc_mbox_validate_signature(struct pcc_mbox_chan *pcc_mchan,
+				       int subspace_id)
+{
+	u32 expected_signature = PCC_SIGNATURE | subspace_id;
+	u32 signature;
+
+	if (pcc_mchan->shmem_size < sizeof(signature)) {
+		pr_err("PCC subspace %d shared memory is too small\n",
+		       subspace_id);
+		return -EINVAL;
+	}
+
+	signature = ioread32(pcc_mchan->shmem);
+	if (signature != expected_signature) {
+		pr_err("PCC subspace %d has invalid signature: %#x expected %#x\n",
+		       subspace_id, signature, expected_signature);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * pcc_mbox_request_channel - PCC clients call this function to
  *		request a pointer to their PCC subspace, from which they
@@ -381,14 +403,20 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	if (!pcc_mchan->shmem)
 		return ERR_PTR(-ENXIO);
 
+	rc = pcc_mbox_validate_signature(pcc_mchan, subspace_id);
+	if (rc)
+		goto err_unmap_shmem;
+
 	rc = mbox_bind_client(chan, cl);
-	if (rc) {
-		iounmap(pcc_mchan->shmem);
-		pcc_mchan->shmem = NULL;
-		return ERR_PTR(rc);
-	}
+	if (rc)
+		goto err_unmap_shmem;
 
 	return pcc_mchan;
+
+err_unmap_shmem:
+	iounmap(pcc_mchan->shmem);
+	pcc_mchan->shmem = NULL;
+	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
 

-- 
2.43.0

