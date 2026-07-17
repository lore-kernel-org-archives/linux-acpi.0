Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70843AA4F1;
	Fri, 17 Jul 2026 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275019; cv=none; b=sG4/3f81jmUDhvtsvVK79U6xrMJFXL8bFhrUGphcUDJ1TTqYtTv3ss9mOt2vfo6jpmho+lj6hUTnfj6kPggObN3U0WiC91jryNOPdK+mTf0OIgGIwrvgNtsPITX8W17p8lSCmqLWTP9OiI6WqmP6yd9xcRuY2EI1NTVVh54VkFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275019; c=relaxed/simple;
	bh=T8+j0xXCdA8diBiZfbkGTxb78EBicHP4Bz6VuIhKKzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEj0KB6RhcRyDna/mWXdkXKLwrqEqsR01wMR1na4W6AAphQSbGp1fRoHUf4KpQRJdYOS9sMpnoBsZtjj60i6NUUaapRElQFNO6hjZjGGNvl1+dnMuX2tkqIpxo1maP7qivSebKdd/lDlcIuHZpRkA7S2fed7ts5ewkl03Fl/fkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDwlNmU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDwlNmU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242CA1F000E9;
	Fri, 17 Jul 2026 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275017;
	bh=sR5LAwQm5J0eEdoJ/pCj/evB01j4KZOLP5jvQ3hfk54=;
	h=From:To:Cc:Subject:Date;
	b=nDwlNmU4/YfS51nQH3tlvHt5ZKu7V+o0lVb2eMMHlB7m2vcmZpG5JjKG1eGMUiSRE
	 fhRnVLPzsLxbUfcJ9wzfPNhpMXE1Y5qPOLC/cpV9noCEsE7GC8AOuFeXlOT5TYEqNK
	 MbXLYbUu3Hd7rbPk5M9YPcBfkiENivQAqyB+L2Bu9st50AZAhWCIh+ETdlxjpqwz1R
	 uyrrCLZN4xQE5zjp/qB6EvlUxd91qBNSyMz9abeucuNY3QL80xFqmpgWIyBYZElX10
	 Z6gbeG9vH2QAjZmDAeB7ibE+JHoeIUZQpq4C1WQ2Rln7wEyObYjE13nN1O4HbfMwE3
	 f4i6qFGrM/4Ow==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 0/3] mailbox: pcc: Improve completion handling and validation
Date: Fri, 17 Jul 2026 08:56:46 +0100
Message-ID: <20260717075649.467172-1-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jassi,

This series addresses three issues in the PCC mailbox controller which
are on the list for a while and discussed/reviewed. Please pick them
for v7.3 or let me know if you prefer pull request.

First, notify clients through their receive callback when a command
completes through polling, matching the interrupt-driven completion
path.

Second, centralize PCC shared memory signature checking in the mailbox
controller. Invalid signatures are reported without rejecting otherwise
working firmware, while mappings too small to contain a signature remain
fatal.

Finally, fix a race where a fast platform can signal command completion
before the channel is marked in use, causing a shared interrupt to be
ignored and the command to time out. Publish the channel state before
ringing the doorbell and use READ_ONCE()/WRITE_ONCE() for the lockless
flag accesses.

Regards,
Sudeep

Huisong Li (1):
  mailbox: pcc: Fix command timeout due to missed interrupt

Sudeep Holla (2):
  mailbox: pcc: Notify clients on polled completion
  mailbox: pcc: Check shared memory signature on request

 drivers/mailbox/pcc.c | 85 +++++++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 19 deletions(-)

-- 
2.43.0

