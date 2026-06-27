Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAE53B42EE;
	Sat, 27 Jun 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782572416; cv=none; b=DXR8bf6LFqV0jLR9U9z60UjUemMrtiOxaXhRP6YL/oy0RBgunxqjxmvKKRaYagKZUdSGke+H38+NJFYqWVpoodwKbyOvHxMBos8MY+rzxI+Br8S20dDiGJ0YRXEmF5NY2Aio5743uzok4IcY5MqZin4oRxAd4gzdCsuilVAkLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782572416; c=relaxed/simple;
	bh=/0bsZUhOhdGb3Jlfr3qplrt0CQY7IAZlWmVUzigPhgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqHk2tlJUiuzUSxnqp3rVMukfvk1G2tocId42x6hUYAdeYMQmUrbDYqMy2gVVfkDpkEU0+Fx/PhSGFPO+umQ7Hn5BXzT7BRcFpUiEj4D+g7438ij2UObkC7MBZV++FCa/l0hCbgpDtRa1SgvepsOQzvvthjis2QQEq+Q2CnZvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f28cLb3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f28cLb3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4891F00A3A;
	Sat, 27 Jun 2026 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782572413;
	bh=mzDOaAPBO96Eii4gtfM/GgHMFjSGb8exHnN4+dE11qY=;
	h=From:To:Cc:Subject:Date;
	b=f28cLb3uyG9wWbAQKIopuoZNN8k71jdMbbVxNgRGcf9/LNTz0D4028OzLyF5vxCGz
	 FF4W7MBlD3VZ0EWzJryMAlusYkeun6H4WujNHWCjoOs9H6iKIlGy4Hky4FRMt+61A2
	 4x0Vq3lkNhOoThDvIGRwMOWb5VipMdoGLAkpr8TMeOSbSAptlfFfFivLjdGkm4MH51
	 NgLR7rb0EV1Xp50807SMeCBc3Wn5RU4uN5p87cX+hYzVR9gpSSo048P4htrk9Fl60h
	 iApVnZq74QUcIxxeqMNZYkKdQOObVLi5HmdS6nrYO6VstaWX2xGwLWNJaZkSThQC0t
	 u4RgFCBsPkX3Q==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Huisong Li <lihuisong@huawei.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2] mailbox: pcc: Notify clients on polled completion
Date: Sat, 27 Jun 2026 16:00:08 +0100
Message-ID: <20260627150008.3984670-1-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
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
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
v1->v2:
	- Check if MBOX_TXDONE_BY_POLL instead of absence of pchan->plat_irq

v1: https://patch.msgid.link/20260612170225.1063902-1-sudeep.holla@kernel.org

 drivers/mailbox/pcc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index bde5e0852157..bb55f15edae3 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -490,7 +490,15 @@ static bool pcc_last_tx_done(struct mbox_chan *chan)
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

