Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E23812DD;
	Fri, 12 Jun 2026 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283750; cv=none; b=r/y725QLp79axI5Y4IXZK85Mz+UoAAwUVDR3YgHfWcyV3LoAbyinblP+pm5YYI4AJQI5btWL+rM+JkmPKgk8ZRy7tuu32tV+qPAkCtTCgu/oUn1Na4Md1FWpMgvhdt/ZvWlyxLUwnfvBp1oY8BrhLi6pryZmxmOjDe1s2vGPpic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283750; c=relaxed/simple;
	bh=9qt/FlIDLkPi/6r5PrQu4MgrJB0XY7TsQbqhwi8xWUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oe9Uqsty4yJ2JLgf7J9DYo5aBarfNo9sN7DwnrENeRehhqBNDVa9kz01AA1rkHbX8Mfgwu/4lciulNMTRQok5A7kv6mYcOMSrhl7juODRgZ8CFNkgr/4zWcOKVLsTuxU7GOQHHIvZ6H5WUMCyD7Bi6MWu1VUyt9MbhnsQBmf5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyErPw5p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyErPw5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD3F1F000E9;
	Fri, 12 Jun 2026 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781283749;
	bh=GcgbBpXwxf3oTZBxaEuNdFZA3mSpJoY9W/J9zZ9biYU=;
	h=From:To:Cc:Subject:Date;
	b=CyErPw5pQi1vTygkvOyBiBXBPUMUtiZlXzTr2VpNCeCEsOqJB9fImRzQ47jkMqA2j
	 jB8c1MjUmbQsVzaXEaSC/FNnBbfEL5vYq72DVHMVNUQbizzn1TRIlFkmd6gFsporLy
	 KljnCYr4+AgGy0Yo5n9KtHXjj9dQqOuC9vHy6K2NIjddIK5HkUCnfvCqhBohWCP0vY
	 TECWPSNOaSmblUaMzUErQv8bhk5KmNtk4Ey6voQhgPuIIxCIuE5zKaKwcf97d+YMMn
	 jN+WuQtceyGNuJVczgYHX7yViHGi07uDEzEqxOeIurC95JmE/voJL52NwmVWf6VzaZ
	 cFnNYHC80EevQ==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] mailbox: pcc: Notify clients on polled completion
Date: Fri, 12 Jun 2026 18:02:25 +0100
Message-ID: <20260612170225.1063902-1-sudeep.holla@kernel.org>
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
 drivers/mailbox/pcc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 636879ae1db7..7c9451ab4527 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -447,9 +447,14 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 
 static bool pcc_last_tx_done(struct mbox_chan *chan)
 {
+	bool ret;
 	struct pcc_chan_info *pchan = chan->con_priv;
 
-	return pcc_mbox_cmd_complete_check(pchan);
+	ret = pcc_mbox_cmd_complete_check(pchan);
+	if (ret && !pchan->plat_irq)
+		mbox_chan_received_data(chan, NULL);
+
+	return ret;
 }
 
 /**
-- 
2.43.0

