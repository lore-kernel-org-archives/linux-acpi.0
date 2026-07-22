Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494933B975;
	Wed, 22 Jul 2026 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726166; cv=none; b=OZjJEpECghC5FKbesduy6EuxnuOfgi/AvzBoisJaLESMvAc7KQS9V+41/NaJSpIQ/MKUO3njgCaw8+bRsCckwXMymoL5BvqzN3QCSsHYsMEjJc6bale9tn50WkwrXEINPNZcy8FtA/tvBgepmF/ko+Mn/d7GzUDqTinfjS33Mis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726166; c=relaxed/simple;
	bh=sT7JnwxSEOV4ie/UxpsmG3sbXdKGmyGOcjrOU8nR5ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7JB90VIJ3FT/r8NAND5NZqL606xTCwaugWw0axkUy2reIU07iXJqM3ycUBwcdq8KKiaw/Yru/Lb9ZO/OHNmTbEK8WiC/CrYcixXs8hstTFwgJdMw4HS8gY8O87Aym2oIWR+KBXmtNegmC9UVBcHAVR74ehBuhEEVrRTzM9MytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHlpMXi0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHlpMXi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198C41F000E9;
	Wed, 22 Jul 2026 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726163;
	bh=hjxvebf63Ss/nWcXLPFKOnntcOwBImgQMh9AB+a9ADw=;
	h=From:To:Cc:Subject:Date;
	b=gHlpMXi0V0OU+lUcFxKwUi8Lw7aRN4pRWq3azb2Fn84UNAk7tmgup08dGVeRdQk0k
	 pFEJApDqH0ByVh2QNnNX/lO2yBLVoi9j5JZl/T2X1EPdS2drfWxSjAuNNlW0L19vmd
	 I48YwEmnTactyEcAAnY8AIJT165CbrO8EPoLIAZsaHpd28XDrafH4wjtG8If+0KkXc
	 rZHO/2TpSwAj8xvu8ftJohmESOIY6ukLolmPa2Pcfi4s9rtjzbKhB/poSAGHMkl2QK
	 osO9W1JCeiG0nJFQ4nCjZKaQ/kbIppRruAezVF4ieBVVjGcaMp6g/gzoFkLkrhxVz6
	 MZsYzO+vMHhWw==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v2 0/4] ACPI/PCC: Correct PCC OperationRegion handling
Date: Wed, 22 Jul 2026 14:15:49 +0100
Message-ID: <20260722131553.2117835-1-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series corrects the handling of PCC OperationRegions and their
shared memory.

ACPI 6.3 states that a PCC OperationRegion describes the shared memory
following the PCC signature. Consequently, COMMAND fields at raw shared
memory offsets 4 and 12 appear at OperationRegion offsets 0 and 8.

The first patch corrects those offsets in ACPICA. This change has already
been submitted upstream:

  https://github.com/acpica/acpica/pull/1205

The ACPICA patch is included here only to document the complete
dependency and aid review and testing. It must enter the kernel through
the ACPICA pull/import process and will not be merged directly through
the Linux ACPI tree.

The remaining Linux patches:

- Preserve the platform-populated PCC signature when copying
  OperationRegion data.
- Release the mailbox channel and region context when ACPICA
  deactivates an OperationRegion.
- Compute and cache the command timeout during channel setup.

There is no strict build dependency in case ACPICA and other 3 changes
need to be merged at different timeline or via different branch.

v1->v2:
 - Updated the commit message to include correct example of PCC Opregion
   as the example added by original commit 77e2a04745ff ("ACPI: PCC:
   Implement OperationRegion handler for the PCC Type 3 subtype")
   incorrectly included the signature as an OperationRegion field.

Regards,
Sudeep

Sudeep Holla (4):
  ACPICA: Fix PCC OperationRegion command offsets
  ACPI: PCC: Preserve shared memory signature in OpRegion handler
  ACPI: PCC: Free channel on OpRegion deactivation
  ACPI: PCC: Cache OpRegion command timeout

 drivers/acpi/acpi_pcc.c       | 55 ++++++++++++++++++++++++++---------
 drivers/acpi/acpica/exfield.c | 11 +++----
 2 files changed, 48 insertions(+), 18 deletions(-)

-- 
2.43.0

