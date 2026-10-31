Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481588;
	b=CqCKrS+MIn73vi4P7ZbJKTOyawKYUvdrgntuAEgtasIE2unm21tnDyNmni2ag6xz+MK0
	 nnJi1sl1TezT/5sv015ldv8IYkTAO7d2NePZam4G1TrnjJUSpfzguiYaTSgqp4yTGtJXh
	 GP1dSBMGBQZ809I36IHySt/cJh704EV+ZOY5tbbebrUwU8I6GR+8CPPLc8FgjkVXntgHX
	 25RiPevT/ZMJayxrD11q5oMTXSzUloVK2PEUkiUcVUU+C4URCAK/sLU3A+EnVPgi4A7JL
	 G3nTDCLLYNPFkOXjwc1AmcuZGjXJXv3KpyS0KpGXA91mgDgplnYr9sjVSxVSOKFWYMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481588;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=kFdnbNdPI5aYoVkG40GrN0pQaakXqMLdFFxXew8xCu0=;
	b=xiwMUqwGvZVDN3VCKl0Wx09H/QU7mU/3evW6EpfWJmivM/vLNF6mZfWdh6zrsEG3UWSC
	 +h82IDNITcaqMVlPZs+JBoeoQF8uPyw+cyv+oHVmNM32pQ2uiMGUdjSW/zd17ZbWbUWMr
	 fcgycSrFFE98+eKXFwwiaSlX+MGoODOHVlrjg0piGPkPQa4aOQoFoZ8RGYHnL36T0Y9RX
	 f2dWBj3xVCUkxBM1ScYrXrZBzx9mTfAg54NKQ7qaRt6vQk9sC0tSZ8IngAtblW3VN1D9G
	 fRYJwAl6W4eLbuy159iFrbmNlcGzdhxzXB7YIN6VNPbtjI+ZlCfYF0quY0cekS/9mAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hsal.es;
	spf=pass smtp.mailfrom=hsal.es;
	dkim=pass header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=GWuXbsmv;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE8606A320;
	Sat, 31 Oct 2026 21:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8FE8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=GWuXbsmv
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jH9pN3TPHz8tj4;
	Sat, 31 Oct 2026 22:19:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1793481580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kFdnbNdPI5aYoVkG40GrN0pQaakXqMLdFFxXew8xCu0=;
	b=GWuXbsmvkpkBtH4f6pZzey++DTuhDognphkuuLyVYRu6CJPwSjeauaAWVN+Pf5XfcfrNEN
	Jo9jX2iAc9l5Nm+3czZOZqSupQg1h6bdr3S8jYCJUL4MXrFZI1ATrsCghO7HNFdfe5zbT1
	5aZB3xp6FeMCtJv+tyILi0v8ZTyO1b48SVeSdHBq9pViF3aEjJ2Zii1DdLb6wOnyejmfuQ
	1Ewm5LkapekYMm3suwqp3EhaKMzPu/vFJbrN59Yb+fsoxQwKHbz2Ot29Ug6cciw7NRk8mK
	QNhstSEEKrLQ7LDKfUNlU4NznhcwmmkBcrXqkX1Fad1X7r0Y21b4koKJN6f5qg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ACPI: AC: Sleep quirk for the ASUS ROG Flow X13 GV301Q
Date: Sat, 31 Oct 2026 21:19:36 +0000
Message-ID: <20261031211938.581230-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jH9pN3TPHz8tj4

On a plug-in, the ROG Flow X13 GV301Q's EC notifies the AC adapter
before the status bit that _PSR reads is set, so the AC driver reports
the adapter offline and user space never hears that it came online. The
ThinkPad E530 has the same pattern, and the driver already handles it
with a 1s delay before evaluating _PSR.

Patch 1 renames thinkpad_e530_quirk() to ac_sleep_quirk(), since
nothing in it is ThinkPad-specific. Patch 2 adds the GV301Q to
ac_dmi_table with it.

Tested on a GV301QH. A public DSDT dump of the GV301QE has the same
handler, so this quirk is applied to any GV301Q*. The details are below
the cut in patch 2.

Hugo Sales (2):
  ACPI: AC: Rename thinkpad_e530_quirk() to ac_sleep_quirk()
  ACPI: AC: Add sleep quirk for ASUS ROG Flow X13 GV301Q

 drivers/acpi/ac.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)


base-commit: 70f331d89564126fdcaaa37f25194fe391d8f3fa
-- 
2.56.0

