Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BB3CF1E3;
	Fri, 17 Jul 2026 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275027; cv=none; b=M9p3BBi/+9rI95r089D8H83Ys94YGsTClfNK8FzoGoO2qIKkQ3BgOMmcmYon4qi72riz3P2iqbQKxlTmggQXQc8JA82HCNpP14LZ1CFrLgl7A004WNnX5aFAHfJEiQl1QFCx7oAV3Ioe9lG1tOV3DOiOuF3AFcvlwAgwVuvQP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275027; c=relaxed/simple;
	bh=2QBNKKO2SRZwALMcFZRDC1w6ApklXtdDfYPwaHFr2nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2y6QUqVVE3DYVtAliVaj2ZaVR1oZCKg2SCcPjzzr3R32DR8ddBGVlL97ndeQHynYFkaBafts7vODwB133zFGneFiL9Qx415rsrgRD+3FOApQW6UUPGjyy7KMwFqmLQSpnZt4MiEJZeXfyBoH1GsOspK/Frnb8Mo0mwMulXVSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeMIAqgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeMIAqgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD011F000E9;
	Fri, 17 Jul 2026 07:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275023;
	bh=zXpqNVMM7ESu0cT0hoZNWBS1i4qtsT9J4fhzluMciYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JeMIAqgUyqbWUjzNTuI336cboeS3B6qxJGHv1u9EmqX3VYhNBZGu0SItTjDsQjlF+
	 WOZ54QuxjVnYqL/7yL/3vDU1l6IhyWtiB0fd+XHhWsmqMtX10UaI1BX64NS0S3Gwg9
	 eOwffR93M6w9V+huyp6yoljABRxPZZy6K6p6kLHVOhroEys5HWalb5uZ1zTwJT08zr
	 NuqgX8naK+tDs9geO3/zUDdyga03FeP3hB7+FYgKzaZdTLdUr2dQ8qyGB3JFNT2DB9
	 EvDixAYmNlFbdIbP8yteC6zKSZHojCyidWarrZ7380NsFO7wD7kD3mwgZg1e7r16Rk
	 JuaAv/rl+G5Ug==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Huisong Li <lihuisong@huawei.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/3] mailbox: pcc: Notify clients on polled completion
Date: Fri, 17 Jul 2026 08:56:47 +0100
Message-ID: <20260717075649.467172-2-sudeep.holla@kernel.org>
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

