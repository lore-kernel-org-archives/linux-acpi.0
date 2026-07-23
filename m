Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38920440A26;
	Thu, 23 Jul 2026 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817597; cv=none; b=mGTyBm4uA5SfBDZJATgy/bLaOrCygyxCrNFGXbRfxuKFilIpGx0o/Hp5YW5HRmXR6wWDNmLYQ+nDg9w2ygrGwJCpRO2WzvaI4b4Y0Oig9IJpY4QZvxrQpjvi9bzARQD9QxCDs44ZTiMxWX6vWS9HU0qMuduZLRTiqlW54EnqUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817597; c=relaxed/simple;
	bh=2QBNKKO2SRZwALMcFZRDC1w6ApklXtdDfYPwaHFr2nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwpekD/TqhPlxUX39pmIR4y86LTWYW3CmBpXd5rN8Hxx3mB0BhmgRod/bBirPODs5kqs3lm+vawAz3bmCVOLv2IULT98kHmSLT+VgxdpKVv3DdI9uRliIKXTDunwEw6b7R2Qsuo7Th25KLl5YGxwJf07fzfN+fp8WRe0LO1TDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReE3IyJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReE3IyJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B621F00A3D;
	Thu, 23 Jul 2026 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817583;
	bh=zXpqNVMM7ESu0cT0hoZNWBS1i4qtsT9J4fhzluMciYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ReE3IyJPZAvVCC7Io1SzulDdGCJ6k5SlK2S8/UaBB+7+cnHrGBLaGLOfSIOJjv1oF
	 z8txWOSI2EhQ+8EqlE28kpgfi78bwB3g7NwMHJ31TWVDEyS8yNmo0vaHRulK/Y9Q+3
	 Hpx65JYyHv1b4VaasNCnGxIBa/L50m87de/0Mz/kzrBr4drC33uNVuH5F4syyquIHj
	 fD+YKOIBs2eVkluhBgmLe3bpprUNFtYlGw2UVlKabdpKRCAH7+1hYetDggCtFFEIFm
	 Y+fXeN3zRfgxc8AgogLCowIqT2NHmR0pMnUAZXQeY+dGjJeuhI8nbWv4SXq/0P7Bcf
	 WekrOwnuT4Xfw==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Huisong Li <lihuisong@huawei.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 1/3] mailbox: pcc: Notify clients on polled completion
Date: Thu, 23 Jul 2026 15:39:26 +0100
Message-ID: <20260723143928.2625970-2-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723143928.2625970-1-sudeep.holla@kernel.org>
References: <20260723143928.2625970-1-sudeep.holla@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCC channels without a platform interrupt rely on the mailbox
polling path to detect command completion.

That path currently only reports transmit completion to the mailbox
core, so clients that wait for their receive callback do not get
notified when the command completes.

Call mbox_chan_received_data() when polling observes completion on a
channel without a platform IRQ, matching the interrupt-driven
completion path.

Reported-by: Cristian Marussi <cristian.marussi@arm.com>
Acked-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/mailbox/pcc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 636879ae1db7..d96b8b54e77e 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -449,7 +449,15 @@ static bool pcc_last_tx_done(struct mbox_chan *chan)
 {
 	struct pcc_chan_info *pchan = chan->con_priv;
 
-	return pcc_mbox_cmd_complete_check(pchan);
+	if (!(chan->txdone_method & MBOX_TXDONE_BY_POLL))
+		return false;
+
+	if (!pcc_mbox_cmd_complete_check(pchan))
+		return false;
+
+	mbox_chan_received_data(chan, NULL);
+
+	return true;
 }
 
 /**
-- 
2.43.0

