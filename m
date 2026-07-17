Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110523B9D8B;
	Fri, 17 Jul 2026 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275028; cv=none; b=rjmGlLT/gboP7ATy7VL4D+iX09MljwcIHxXnbdSKTl0PCOwkPvYEc3cEG858UUTydV1zll1vFEkxj/tNcSH1hsXQMVv2TfNnK0zxEr/WCgt12s0xgZIVYWWkHULSVWQPsgoraJrk96p9X0KxDhcunQmAa9WKqF1wBVAtYCCVrIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275028; c=relaxed/simple;
	bh=AG2LRkto9w3xmViEcMhCZoTnCGM09ad2FMqFX/B0cvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKhDKC7q05ifbK8eoCh1JEui+UUuarJ4nzppAZW7hA7TN5as+TNJSFz/caBc/o2O+Ak4LGQydiJ6nXiJRBl+8btVCDnp19zg7TsbiHF4Wo8Ehkr/P4UpJpj5qUr2Sk3UOsFWwDBYcrcVRTXuYVqxAPkSgNxoL2UKfCrGj1pDcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgCXiRJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgCXiRJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11451F00A3A;
	Fri, 17 Jul 2026 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275025;
	bh=uO2/fVWZERlN2SXDU0pXLI74BtIAR6r36vIFkTbpHqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WgCXiRJ24x/09FPRB7IsMqZZ3xxQ/785QWJxyebssc1d8qIAYx6BlnmXvtPLCqYy7
	 3redyUOdTzOmSTt1NkaYHlkEOEsfhaUu4nmkoEO9Qth+ZTYg+DmajfcM0dmwA/iuo+
	 l2Q+DI8TUcjQdDwz/+Fxu4OZqxZwV9W3SR9kAa2I4KZXG8IS8vgPFWvMntn7gw8hzF
	 1T0qoIscmuICytyWeGIx6elNYO/4c6zpbP8LO6OLbU1XU9NgXTk1RIQr2guMvEHgEu
	 AFiTMG0eYhFBLKlRooGiqg0kz4mPb91SlONC9AW4TKyUhl9V3jBLPBaKOKti8KaliU
	 C585zJzAIe8YQ==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 2/3] mailbox: pcc: Check shared memory signature on request
Date: Fri, 17 Jul 2026 08:56:48 +0100
Message-ID: <20260717075649.467172-3-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717075649.467172-1-sudeep.holla@kernel.org>
References: <20260717075649.467172-1-sudeep.holla@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI 6.6 Tables 14.9 and 14.12 define the PCC shared memory
signature as the bitwise OR of 0x50434300 and the PCC subspace ID.
They also clarify that the signature is populated by the platform and
verified by OSPM. The signature is at byte offset 0 in the generic,
extended and reduced PCC shared memory layouts.

Check the signature when a client requests a PCC mailbox channel,
after mapping shared memory and before binding the mailbox client.
This keeps the check in the PCC mailbox controller instead of
duplicating it in individual clients.

Treat a signature mismatch as a warning rather than rejecting the
channel request. Making this newly added check fatal could break
existing systems whose firmware did not populate the signature
correctly even though PCC communication works. Continue to reject
shared memory that is too small to contain a signature because it
cannot be inspected safely.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/mailbox/pcc.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index d96b8b54e77e..8dfa80b0a90f 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -345,6 +345,26 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
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
+	if (signature != expected_signature)
+		pr_warn("PCC subspace %d invalid signature %#x expected %#x\n",
+			subspace_id, signature, expected_signature);
+
+	return 0;
+}
+
 /**
  * pcc_mbox_request_channel - PCC clients call this function to
  *		request a pointer to their PCC subspace, from which they
@@ -381,14 +401,20 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
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

