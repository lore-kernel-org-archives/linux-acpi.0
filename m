Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2E3E00A6;
	Fri, 17 Jul 2026 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275811; cv=none; b=M4jcfcqLsxAWeDnvrjJDW/MsnkpXJtY/WoJ8G+/srxdDrkbMHxmbvaiOGOh5BCAp/XngoTh/GBt2sEcMygHmuhdIo14RdiYxuHEPlr0V3HGlYjf5yelKV3eVu9T86qlJf2v9K4oKpufKLUlYPxf9eAufgibvzSvfyHPa5yIdrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275811; c=relaxed/simple;
	bh=Da2AXGVFJbSksGED4oE22PUx/yI1OATDo0VSOnym7Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvq9UVCT+vbcwX9SIJ8iXpnSzaMhbDKVD5Tv1h7TqnZ/IdA2aYILdLUqQZ37wYCUy9fVM8Ygx+Is5fVVmck5jVCt9g86OR9NtVjO+Gu0P2k4OfL653Z4lNNbFtz6KZjzxfpCQJiHOtsln2+g7h5L3RjFezanY+fmfGjtEAXxibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK6Q2afw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK6Q2afw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67781F00A3A;
	Fri, 17 Jul 2026 08:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275810;
	bh=hJKuDi7+Mg/XV2aA/qUGIAThj4AZS3oxuuDTDUqi/WI=;
	h=From:To:Cc:Subject:Date;
	b=GK6Q2afw/CHgjE5ddpxpW5ekfsANjUQyCogIsMOycZPhQ3L+5FsQ/YIzE00E5pfw7
	 xvexMmQJ1ecIe7BLDmSiN8OL7/xWxYQyzZWeokYl4lsWqwuT0NFICgHNsRQP/aCNtV
	 7giNnNfEJBNNtLgnPO1bX9/X86EccVNx/yzDaQFdLBkzZ2p58L5U/EQcxMcIAzHebz
	 TeDahPAvMhE/3F+g/iwSJkxd/ra4xJlrqQp+//n0F6eIYhrFj+72DZ5Yaip3VaCu/1
	 8iqu8eOBW2pa5wEsazpyjrJx6+r8BGkV9gFPhbIKnGj89ZvHLeKl+P20vigbKhPm2S
	 Mn32SNEYEp2PA==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 0/4] ACPI/PCC: Correct PCC OperationRegion handling
Date: Fri, 17 Jul 2026 09:10:01 +0100
Message-ID: <20260717081005.470013-1-sudeep.holla@kernel.org>
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

