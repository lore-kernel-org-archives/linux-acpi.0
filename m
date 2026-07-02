Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676B6345CA3;
	Thu,  2 Jul 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009367; cv=none; b=tnC4uhGsFN8YDyP3qqMPvoEmeZnUfChx+SQfVOcCpJjouHxptg5bGzQ4q0E7bC/ylizbrXH2LdveAQu4LKW2eAHK6zyOBdmrWhBhR0dFNkglpO87zrEVkzfJEBFx62pJGwkFdTOICpHBF3ImLL4xslNTcdHRMI+TfWeziaOjJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009367; c=relaxed/simple;
	bh=jx+Qd7AP+X/MGpo14TPEW2DjAqmqN8QLFvZbq4wW3sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHqOq3xN17Q4cnqabTTGcYP01KuLge3wZsUY1BruZXLNjLD2aYGEE8xu8vUQ4dSW6qH8zhedXDktLs1ry6CtPe6mwpHuvT3VpD/TpcXtXJrAxAHA5xc+FdiIdOYLNfGO267JDmcQeCbmH8oaH4Lx7TJsx2uaOdPXYTDz8A/wUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=twZjVC44; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="twZjVC44"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B76D35C8;
	Thu,  2 Jul 2026 09:22:35 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B73583F673;
	Thu,  2 Jul 2026 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009359; bh=jx+Qd7AP+X/MGpo14TPEW2DjAqmqN8QLFvZbq4wW3sQ=;
	h=From:To:Cc:Subject:Date:From;
	b=twZjVC44HzKULb6/gEAEpWzlbxJONCyeiIXJDQBzbGBbo3/BLCUkjX9IRF51SApbg
	 nfZYjie6upQUpTusodB5em1enfFReEbdnYlqWf8tGGA4uJIDQSGBXX/rq+kq+iXPEk
	 5/I+M0TO8inJFj1M28XtqPtAIbsgp8d9XOrNc/fs=
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
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/15] arm_mpam: Add MPAM-Fb firmware support
Date: Thu,  2 Jul 2026 18:22:14 +0200
Message-ID: <20260702162229.4008659-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

version 2 of the MPAM-Fb code, for firmware based MSC accesses.
Major change is a rudimentary propagation of errors during the MSC
accesses, this has been split up into 11 patches, coming first in this
series. The patch to parse additional information from the ACPI table
has been dropped (former patch 1/5), as it's actually not needed for
MPAM-Fb, and the features parsed are not supported by the kernel yet.
Quite some details have been fixed in the remaining patches, thanks to
the diligent reviewers. This should address most of the comments, but
I am pretty sure this won't be the final version ;-)
Find a changelog below. Based on v7.2-rc1.

=======================
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

The first 11 patches rework all MSC access wrappers to propagate error
information. Pure MMIO based MSC accesses would never fail, but the
MPAM-Fb access can go wrong in multiple ways. The patches have been split
up purely for reviewing reasons, if the number is a problem, we could as
well squash them.
Patch 12/15 solves a nasty problem: At the moment we protect stateful MSC
register accesses (mon_sel) through a spinlock. Unfortunately the mailbox
subsystem and the slow nature of the communication through this channel
forbid MPAM-Fb access in atomic context. So this patch splits the lock
in two: the "outer" one is a mutex, and only the inner one is a
spinlock, which would need to be taken when programming MSCs inside an
interrupt handler, for instance. We just deny the latter when using
MPAM-Fb, ideally we wouldn't need that (no need to IPI another core when
the MSC access does not need to be local to one particular core), or we
simply deny that part of the functionality (access through perf).
Patch 13/15 adds the code to redirect MSC accesses through the
PCC shmem/mailbox system.
Patch 14/15 avoids the error IRQ handler to do an MSC access when using
MPAM_Fb, since those accesses cannot run in atomic context.
The final patch 15/15 then adds the code to detect and store the PCC
channel information from the ACPI tables, and eventually enables
MPAM-Fb accesses.

This would enable systems where some MSCs are not accessible via MMIO to
use those components anyway.

Please have a look and test!

Cheers,
Andre

[1] https://developer.arm.com/documentation/den0144/latest

Changelog v1 .. v2:
- add patches to add error propagation to MSC access wrappers
- drop former patch 1/5 (not needed)
- drop lock in mpam_reprogram_msc(), to avoid double lock
- add support for multiple MSCs per PCC channel
- adjust SCMI protocol code to use a PCC subtype 3 channel
- let PCC code handle the PCC channel negotiation (due to subtype 3)
- drop SCMI names in shmem offsets, and use existing PCC type 3 struct
- adjust shmem field offsets to match MPAM-Fb spec, not pure SCMI
- prevent MPAM-Fb calls inside atomic smp_call_function_any() payload
- skip all MSC accesses inside the IRQ handler when using MPAM-Fb


Andre Przywara (14):
  arm_mpam: let low level MSC read accessors return an error
  arm_mpam: propagate MSC read errors for wrapper functions
  arm_mpam: propagate MSC read errors for hw_probe functions
  arm_mpam: propagate MSC read errors for mpam_msc_read_mbwu_l()
  arm_mpam: propagate MSC read errors for msmon helpers
  arm_mpam: propagate MSC read errors for __ris_msmon_read()
  arm_mpam: propagate MSC read errors for state saving functions
  arm_mpam: let low level MSC write accessors return an error
  arm_mpam: propagate MSC write errors for ESR and part_sel wrappers
  arm_mpam: propagate MSC write errors for hardware probe functions
  arm_mpam: propagate MSC write errors for remaining MSC write users
  arm_mpam: add MPAM-Fb MSC firmware access support
  arm_mpam: prevent MPAM-Fb accesses inside IRQ handler
  arm_mpam: detect and enable MPAM-Fb PCC support

James Morse (1):
  arm_mpam: Split the locking around the mon_sel registers

 drivers/acpi/arm64/mpam.c       |   2 +
 drivers/resctrl/Makefile        |   2 +-
 drivers/resctrl/mpam_devices.c  | 630 ++++++++++++++++++++++++--------
 drivers/resctrl/mpam_fb.c       | 137 +++++++
 drivers/resctrl/mpam_fb.h       |  17 +
 drivers/resctrl/mpam_internal.h |  79 +++-
 include/linux/arm_mpam.h        |   2 +-
 7 files changed, 688 insertions(+), 181 deletions(-)
 create mode 100644 drivers/resctrl/mpam_fb.c
 create mode 100644 drivers/resctrl/mpam_fb.h


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0

