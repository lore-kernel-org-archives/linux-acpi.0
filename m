Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F764D2EDC;
	Thu, 23 Jul 2026 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817593; cv=none; b=CBJ8Tsje75RO49VB5Nc3Ecr4O1ZWChX/4eNdDmrP/QmCKmKOf2IH8AGg4ayK6G9wmsHkRZ1blFonyIcCsGOmiKskh7iByJ/WuMXUTMMs1ZjfaJMJYNWa89+jQWe0ldm55npU7Nvt5YxKj3uxkycPVrkoLf0kf/KwWNxifCOazuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817593; c=relaxed/simple;
	bh=yAajlLG9sjulzqhK21I0O/LOhpPPCJvQO9xQPwEpc/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpJKW0F+dmzLw9sBEEA8jItJokFmGnS4tro+6kzE+v+2lmxvK/o/XIJ3sFEgXk7mz28ESfRxJXQP0U0K8/sDYfPIyOpkZxcw0Bs4o1pbHvGtWJxfauZu/p3ppJgUnOIoLfYIeDjrOH73+RAzAl6fIi7gt/MeHRUd62YAQuOa0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8+Pj+eV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8+Pj+eV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D01C1F00A3A;
	Thu, 23 Jul 2026 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817582;
	bh=t8JdxiTXKQPEJ2GqZOxZCKLPTI9feT9NT38oRkoWWTo=;
	h=From:To:Cc:Subject:Date;
	b=F8+Pj+eV5E6/A0PtaR4SzmgGln6TCZn3lSQ4/twU4ncENwQdZiGY8/82LrRKdj3xd
	 iv/7boIkwJ+7JuFHt2di4F4NAzAu+hm5Wg8+HkN/jBLRgltEgfoVZ0KVfjuNOT714e
	 Ygxnm/a7I0guLA1dicjSmWUfUxoeJIhWx9iuBCUGnsHrJK3MrWHKwVFjlrxNSPD0xk
	 yhbSQ/PZtK8mAXdKwidiS1/bAv6CO03oJS4k2NLGYv5xizwOzHEceZMjOc2LE4kCeq
	 2lo5wGAiGExcvTK02/Z9Zk07hmt7/44K4iVHAYziLiQY0H/4Fu85xLygO6wKpU3TL2
	 mRvkG8fn9FtSw==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v2 0/3] mailbox: pcc: Improve completion handling and validation
Date: Thu, 23 Jul 2026 15:39:25 +0100
Message-ID: <20260723143928.2625970-1-sudeep.holla@kernel.org>
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

Changes in v2:
- Reworked to keep chan_in_use set after a successful doorbell write
  and clear it only when the write fails.
- Clarified that ordering is provided by the ordered I/O accessor,
  covering both MMIO and port I/O doorbells.
- Clarified the cross-CPU flag access and interrupt-side clearing
  before the mailbox core can submit another transfer.
- Link to v1: https://lore.kernel.org/all/20260717075649.467172-1-sudeep.holla@kernel.org

Huisong Li (1):
  mailbox: pcc: Fix command timeout due to missed interrupt

Sudeep Holla (2):
  mailbox: pcc: Notify clients on polled completion
  mailbox: pcc: Check shared memory signature on request

 drivers/mailbox/pcc.c | 87 +++++++++++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 20 deletions(-)

-- 
2.43.0

