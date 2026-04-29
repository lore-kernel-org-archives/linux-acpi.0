Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3773FE355;
	Wed, 29 Apr 2026 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472079; cv=none; b=AYFI8wewc1DIftFFa7HT6PCoQPbYGcqdfZlh8XprlxjcwY/OHCWuGXf9XCmfut3kOYDD1QP2LwcntCaZNbv5AMLjDv4ep5kQCExiwyL+aRhzbeDBOMWvhgUnI6+iXWn1ciP0cv8CMSNUu0qkQnbs9hmtq37K2b49Pxg9ZDkKiQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472079; c=relaxed/simple;
	bh=Nm1JJiUwtF2SIt4FxjyGKG7BQYGelRR8KSdWEBQmk+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMDIralEpaDaNTKBkGsxW2NsntZV57xB1kjunrWyuwsYprBI/rA6vJhnsjkeQcrOyiM7JShIIfzzvdI8+L7OZSLmcjw68RE1vTQxGFSaPAn1pi0T33675ViphdxYnS0k3PgWDvf58UE//PCoxsSccKwlXT4umrfi7TxT/M1N5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AJiMTIvf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AJiMTIvf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2B1D1BCB;
	Wed, 29 Apr 2026 07:14:31 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04B953F62B;
	Wed, 29 Apr 2026 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777472077; bh=Nm1JJiUwtF2SIt4FxjyGKG7BQYGelRR8KSdWEBQmk+s=;
	h=From:To:Cc:Subject:Date:From;
	b=AJiMTIvfYgjBuIFs8gz+fwIaYmaFii7/ZThE9mDsSCaNNIHOIiIG5cBU6BWbCCQkP
	 JHIzzKWgMw80DuPUzM6ESYMSNIr8JEm77JPf0jgn+HBiAOrrkZ4U35TxDjhr/ZgpMN
	 ZDcKtHeZso+KUF9ychGXkLe2VuoQU4K9BLfQTd3k=
From: Andre Przywara <andre.przywara@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm_mpam: Add MPAM-Fb firmware support
Date: Wed, 29 Apr 2026 16:13:34 +0200
Message-ID: <20260429141339.3171205-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arm MPAM specification defines Memory System Components (MSCs),
which are devices that are programmed through an MMIO register frame. In
some occasions this turned out to be too limiting: the MSC might be
located behind a separate bus system (for instance inside an on-board
controller), it might be mapped secure-only, or in a different processor
socket without direct MMIO mapping. Also the MMIO access might be too slow
or it would need to be filtered or otherwise access controlled. Finally
there might be bugs in the MSC integration, which require a mediating
firmware to be accessible.

To accommodate all those different use cases, the MPAM-Fb specification
[1] describes an alternative way to access MSCs. Accesses to an MSC
would be wrapped in a message and communicated to the system using a
shared-memory/mailbox system mostly mimicking the Arm SCMI spec.
For ACPI systems, this would be abstracted through an ACPI PCC channel,
which provides the shared-memory region and the mailbox trigger. We can
lean on existing ACPI parsing code to register with these two
subsystems, but cannot rely on the existing SCMI code in the kernel.
This means we somewhat need to open code a very simplified SCMI handler,
which just provides enough functionality for the very basic subset of
SCMI that the MPAM-Fb spec requires.

Patch 1/5 adds more ACPI parsing code, to be able to learn all the
information we need.
Patch 2/5 solves a nasty problem: At the moment we protect stateful MSC
register accesses (mon_sel) through a spinlock. Unfortunately the mailbox
subsystem and the slow nature of the communication through this channel
forbid MPAM-Fb access in atomic context. So this patch splits the lock
in two: the "outer" one is a mutex, and only the inner one is a
spinlock, which would need to be taken when programming MSCs inside an
interrupt handler, for instance. We just deny the latter when using
MPAM-Fb, ideally we wouldn't need that (no need to IPI another core when
the MSC access does not need to be local to one particular core), or we
simply deny that part of the functionality (access through perf).
Patch 3/5 adds the code to redirect MSC accesses through the
shmem/mailbox system.
Patch 4/5 avoids the error IRQ handler to do an MSC access when using
MPAM_Fb, since those accesses cannot run in atomic context.
The final patch 5/5 then adds the code to detect and store the PCC
channel information from the ACPI tables, and eventually enables
MPAM-Fb accesses.

This would enable systems where some MSCs are not accessible via MMIO to
use those components anyway.

Please have a look and test!

Cheers,
Andre

[1] https://developer.arm.com/documentation/den0144/latest

Andre Przywara (3):
  arm_mpam: add MPAM-Fb MSC firmware access support
  arm_mpam: prevent MPAM-Fb accesses inside IRQ handler
  arm_mpam: detect and enable MPAM-Fb PCC support

James Morse (2):
  arm_mpam: Parse the rest of the ACPI table
  arm_mpam: Split the locking around the mon_sel registers

 drivers/acpi/arm64/mpam.c       |  93 ++++++++++++++++++-
 drivers/resctrl/Makefile        |   2 +-
 drivers/resctrl/mpam_devices.c  | 148 ++++++++++++++++++++++++------
 drivers/resctrl/mpam_fb.c       | 158 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_fb.h       |  17 ++++
 drivers/resctrl/mpam_internal.h |  72 +++++++++++----
 include/linux/arm_mpam.h        |   2 +-
 7 files changed, 439 insertions(+), 53 deletions(-)
 create mode 100644 drivers/resctrl/mpam_fb.c
 create mode 100644 drivers/resctrl/mpam_fb.h

-- 
2.43.0

