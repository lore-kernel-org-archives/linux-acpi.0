Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F72ED141;
	Wed, 12 Aug 2026 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538177; cv=none; b=CnJ99zUUkDY8LlbV05vdUM4Z11LL+2syfL8pxqz6HjTkAQc+O0ISOGExA1DGyl+wtSvckB4qeROH+690JfhkHFwQVghQtDbP2zDvQ+kq24R/iljEDZdcvY7wLuLXC7QXeDlDO29QdtB7RjRnLNxOTlfsJpbxhfT6ZgwfwfJ1kHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538177; c=relaxed/simple;
	bh=OKN7gBOreiuUeZnXrRogTust30Mff7NKwd9N/rTE4qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lhH9bZZ32JWU3WVSSTgi4RXO2RQMJ+nndjX5Hsqi0msgJsIVtSMn+4vd2y/K/6NS8ycMcPKZ2TXnqORx6hMw5E4T+wfa5Ju8ltDyxh0fxZh5stwWr9tBygHJqITRM5soB4uiDOKBcaV4gur8L1B3/foOz/CzD3SPOmEI6qMil2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CJGcE1lp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CJGcE1lp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=vi5x0sLYV2vCUUx/AK3tdJpKuEZ4eug3c0i9523tnpo=; b=CJGcE1lpqrnFfZrxpF233bhMAP
	puBhIrM/8GM6vp4lALqyW/d4Ss4cJmoIlK5gg8tbtMxX3nrOTb/hu4mFMF//BJrQegz2/Z0qo6zqr
	MmjVOEgd88pcEcgvj1pxWO+U46jE8Hk8sldlCnblaxXhgQeeaTw+5bnqqiaR2kUjun67/S6GUMSg2
	uN4FAAmABkyHaLsX0Uglb4uNxx8xvAKNZUnsezAVMWrmz6JOSCIBOko6Stz/Nx5ZsLvW1VRQh5BYQ
	MC51tNoCzx5mRWsfzHjzmzfnd7OLqJ3nVScxhCENBzFLjk56HnV4l9bkMsoV3ansGsnq3H7gDTmo+
	bJfgkoRA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wu8Bm-004LNx-3C;
	Wed, 12 Aug 2026 12:36:11 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Aug 2026 05:36:03 -0700
Subject: [PATCH] mailbox: pcc: Free the channel before unmapping the shared
 memory
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-pcc-v1-1-5a94d2cc26cc@debian.org>
X-B4-Tracking: v=1; b=H4sIALJofGoC/x3MTQqAIBAG0KsM31oh7d+rRAuxqWZjohBBePegd
 4D3onAWLnD0IvMtRa4IR0YRwunjwVo2OIJt7NBMxuoUgm792Jl2nqzvGYqQMu/y/Muy1voBd5X
 lWVUAAAA=
X-Change-ID: 20260812-pcc-3a7413982a5e
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Adam Young <admiyo@os.amperecomputing.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rmikey@meta.com, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=leitao@debian.org;
 h=from:subject:message-id; bh=OKN7gBOreiuUeZnXrRogTust30Mff7NKwd9N/rTE4qk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqfGi1diMGTlCn4g/dj/BYrE7949S7uG/jH/z8F
 +V4Tc7Gm22JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanxotQAKCRA1o5Of/Hh3
 bdUwEACwNwJCsFB+90USWQGcoEy4BAsvJSYM5KZP45mFv6g98FE+9OH0KfeiocwUAsgnwgJzba8
 CWRjj+QLZBlc6EOjGtY7IoRnbU4mo/9mdKe9cVtKoScj3xnCPkv90mJbJV1R2/O1ituqnlhmsWS
 Y7UJTFQPOAzkRRLqr0SwFEWVjisK6ApOuTROeXNofUQMVJzEBTmBmlEifLJkXXuZOFg1VAv+7oL
 13lyKdGnW4QDEzszdKldSnZm6Bjr4msO/7VBOO6AzeJXjFD2S8yHYjzXZbEOmPlF9PcBmuDL80N
 qzrdT9yxR+wZToZYDFTExnd++A7/Q7/Byk0fCT9paA4N9vmvh37VEtsej9eAFsiuKyNptygIyuM
 TlfPTt17OkphWDMnyBrXgY9DUI4Qdvjne+RcfxYrgTTfRC2rHA1KL72VW1QXY/kLxId3pobxK8d
 06fhfGz1aHmm1liFp+hEEnKoJkPjwFmv/dL4N3rsaq5XwJvIUsONU92JIwHO4e2CDgOVd2RJeNA
 4O/ad8xHnX+y3Tr+Eo0OPtpdFAbEIJ9ty1Kjw9FUbYHu0p8tfK3Bw6sAqQmwfXQxP3bF2fFU7Ae
 AqsKQB7RePxVFws3MI4yLw83o4x/rvvwYTCdsvDTtDf/d+O3Fx7RwFJi6XWkNfl4lFncEr/z10h
 Pt/Pe5d6lL6f5JQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

I am seeing a crash on PCC that is related to a an shared memory being
unmapped before the IRQ is disabled, and the IRQ kicks in and hits the
unmapped (NULL) address. This is a summary of what I see on my box:

	scmi_protocol scmi_dev.1: Message for 1 type 0 is not expected!
	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
	 __handle_irq_event_percpu+0x1c4/0x9e0
	 handle_irq_event+0x98/0x218
	 handle_fasteoi_irq+0x230/0x750
	 generic_handle_domain_irq+0xac/0x138
	 gic_handle_irq+0x344/0x740
	 call_on_irq_stack+0x30/0x48

The trapping store is iowrite32(SCMI_SHMEM_FLAG_INTR_ENABLED,
&shmem->header.flags), a write of 1 at offset 4 of a NULL base.

But, back to the problem, pcc_mbox_free_channel() unmaps the shared
memory and clears pchan->chan.shmem *before* freeing the IRQ (aka
calling mbox_free_channel()).

The interrupt is still live when the mapping goes away.

Free the channel first, before the memory unmap. mbox_free_channel()
calls pcc_shutdown(), which frees the platform interrupt, and then unmap
shared memory.

Fixes: 7f9e19f207be ("mailbox: pcc: Check before sending MCTP PCC response ACK")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/mailbox/pcc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 636879ae1db76..d32f170141de7 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -408,12 +408,13 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 		return;
 	pchan_info = chan->con_priv;
 	pcc_mbox_chan = &pchan_info->chan;
+
+	mbox_free_channel(chan);
+
 	if (pcc_mbox_chan->shmem) {
 		iounmap(pcc_mbox_chan->shmem);
 		pcc_mbox_chan->shmem = NULL;
 	}
-
-	mbox_free_channel(chan);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 

---
base-commit: 5e6de6a2b522f659defacb1551d0465ba6ce13cf
change-id: 20260812-pcc-3a7413982a5e

Best regards,
--  
Breno Leitao <leitao@debian.org>

