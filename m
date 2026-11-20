Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195136;
	b=eRIPVTfdHgebN3eOiQvdLQobqbCIniQuBVoyg42mle6sqvd63+uEMu5UjdOYX8zQ67Qz
	 M4X2LJOWa9L/ouYBcTuwLawDp61Y0C9bd4BEUgLkC/mC+csbhmlIzlJTPO/y4SxtqTe2x
	 y0/c8bGToQob7JL0en++fC9rAlHiB/2ZimP0IWbEdR2HOGA0ETR3unxybxU1nMJwaiXe2
	 hH6ThWFPGAceNEgbvoIIa4Dm9T+e0jOCnmoIVvWFVqunkFl0a8IN2sF3Pqv6crF8ppi25
	 NauNBEEPhCMLWn1WaoVJlAXFChDxeDHge33x5up1O3qKsDmLA2pdxEuhuPEzKMRSEfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195136;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QIQEjm3d2yUWI7XJ5oSFB+PNWsrkD9quGMx3NyrE8X0=;
	b=hePHtb2c27fXD3Ay5ACu+dQNqWglkkscQ4D0NxzI/hUa650n52luU1GramVLWdep7RxF
	 BIiTX6kLzESt16Wq/cBs01EhkRBKfsph6O8Wml5PnvHNOBg42PEwAL6iRlINvn7AGojYk
	 7qyQLxrdFEqguTUtzoUMD1M21u0YdsBduPSvM4Y1IjNcXZhOJfcthCQ0SUPrInvSDANyA
	 /2ec+oDy/jShrFUyVefuCvmdavdRqgASp4VipMBrxjfAU5NnmbFabgaljg7fwphH1uyFT
	 i3vhUh5zkXMb5mT6DDpHiaYwgLlS1DnPmNrmx3X9mbtR6uHajl3KQQ5h2zexVRvQ2Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YqgJxxyi;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C739260A2606;
	Fri, 20 Nov 2026 17:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C739260A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YqgJxxyi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195136; x=1826731136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/1HtlNbVvYtajBQoreiIL3kcVHwbMdxKszmOsBzjyRE=;
  b=YqgJxxyiF1DKWBJtN96WEQXM1JfB6zK1nb5/NdbN1o42o5kG5NqAc3ik
   e5/3zbIyjb1vl0mqyCW45hrULWGK4jNalyvkP5BRHL0d+fEQUPy3GHLIX
   ZZSyNFTu8YU8v9iPWbhKKUe8iOy1jq/R9c2Swlx8QzfVPyaBVs3DpWCBQ
   F2hN7jGOdjUUQHHjuXjaoEd0Ow94ys8pgWU0jN0yknvuBHM4oUkKbaMc3
   avpqRiziy6JFDwEgOCQ4zhF9I1gAuFyphBDq/tVOIcbwT+6TvveyqvCc5
   xpTnH2Uefh9Ib9bWOrOoja+bJ7+OsFpNhf9gFt+xOJ/k5Xfg1g5CbKuWO
   Q==;
X-CSE-ConnectionGUID: sfLUKNGPQRS3ebbLp1FIlA==
X-CSE-MsgGUID: 1h9svnKCQ6m4korz1+y1pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4083507"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4083507"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:18:55 -0800
X-CSE-ConnectionGUID: XjeTSy/9S3a+dpzJiY3r5w==
X-CSE-MsgGUID: CovpluibRWqPAawUn0BefQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11092229"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:18:49 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: catalin.marinas@arm.com,
	pawel.chmielewski@intel.com,
	kyle.d.pelton@intel.com,
	lenb@kernel.org,
	guohanjun@huawei.com,
	maobibo@loongson.cn,
	lpieralisi@kernel.org,
	will@kernel.org,
	sudeep.holla@kernel.org,
	erik.kaneda@intel.com,
	rafael@kernel.org,
	robert.moore@intel.com,
	void0red@gmail.com,
	maciej.wieczor-retman@intel.com,
	superm1@kernel.org,
	chenhuacai@kernel.org
Cc: acpica-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v2 00/42] ACPICA: ACPICA 20260930 with follow-up fixes
Date: Fri, 20 Nov 2026 18:17:24 +0100
Message-ID: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
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

The following patches are ported from upstream ACPICA and contain the 20260930
release and some follow up fixes (so generally everything after the 20260408
release). Only source files relevant to the Linux kernel are being ported.

Changes since v1:
v1 [1] contained only commits between the 20260408 and 20260930 releases.
However sashiko.dev [2] raised some issues that needed to be either applied or
rejected. Most issues were valid and were resolved in patches that follow the
20260930 release. Things that were rejected were the whole patch [3] due to not
being a full solution to a very unlikely, debug only problem. Also the sashiko
comment related to ACPI_GPE_AUTO_ENABLED in patch [4] wasn't applied due to
not being realistically possible to happen and consequences were only an odd
looking log entry.

There are non-ACPICA changes related to constants/variable name changes
in these patches:
- ACPICA: actbl2: MPAM: adapt to MPAM ACPI spec v3.1
- ACPICA: acpica: Fix typo in the IOVT_IOMMU table definitions

The base for this patches is upstream kernel v7.4-rc3 and it consists of
the following material:

Andre Przywara (1):
      ACPICA: actbl2: MPAM: adapt to MPAM ACPI spec v3.1

Colin Ian King (2):
      ACPICA: components: Fix typo "Supress" -> "Suppress"
      ACPICA: components: Fix typo: "numer" -> "number"

Dave Jiang (2):
      ACPICA: CEDT: RDPAS: Add missing reserved field in RDPAS structure
      ACPICA: CEDT: RDPAS: Fix incorrect field positions for RDPAS

Hanjun Guo (1):
      ACPICA: add UBRT (UnifiedBus Root Table) definitions

Himanshu Chauhan (1):
      ACPICA: Introduce a new HEST notification type for RISC-V SSE events

Iurii Trukhin (1):
      ACPICA: parser: Fix parse tree memory leak on AML execution error unwind

Leonard Lausen (1):
      ACPICA: Executer: Resolve package index references used as integer operands

Maciej Strozek (1):
      ACPICA: Utilities: Fix for AcpiUtVerifyChecksum warning display

Maciej Wieczor-Retman (17):
      ACPICA: executer: Fix NULL pointer dereference in AcpiExStoreObjectToIndex()
      ACPICA: compiler: Add _Ixx GPE object
      ACPICA: namespace: Fix possible underflow and NULL pointer dereference
      ACPICA: iASL: Fix the truncated count of external control methods
      ACPICA: release: Update version to 20260930
      ACPICA: events: Add missing event mutex to AcpiEvClearGpeDispatchByOwner()
      ACPICA: events: Remove redundant code
      ACPICA: events: Fix AcpiEvClearGpeDispatchByOwner handler type processing
      ACPICA: events: Fix GPE cleanup return after changing program state
      ACPICA: events: Handle GPEs' Notify dispatch type
      ACPICA: tables: Fix wrong table unload and notify call order
      ACPICA: tables: Fix global table read missing mutex
      ACPICA: executer: Fix copying PCC source buffer data
      ACPICA: dispatcher: Fix zero size non-NULL PCC buffer pointer
      ACPICA: utilities: Clear NextObject so the outer loop doesn't read it
      ACPICA: namespace: Fix memory leak around compiler alias flag
      ACPICA: acpica: Fix typo in the IOVT_IOMMU table definitions

Mario Limonciello (AMD) (1):
      ACPICA: Add ACPI_MSG_DEBUG to set KERN_DEBUG for debug output

Pawel Chmielewski (3):
      ACPICA: ACPI 6.5 Add support for the MISC table
      ACPICA: iASL: Complete KEYP support
      ACPICA: tables: Fix table buffer leak when Load fails verification

Rong Zhang (1):
      ACPICA: parser: Set AML length for bytelist

Vidya Sagar (1):
      ACPICA: IORT: Add Root Complex PASID Flags field

ikaros (8):
      ACPICA: Events: Clear GPE dispatch by owner during table unload
      ACPICA: executer: Add bounds checking for PCC field read access
      ACPICA: Validate 4-char field names before namespace lookup
      ACPICA: Improve error handling in table loading process
      ACPICA: executer: Add bounds checking for PCC field write access
      ACPICA: tables: Fix heap-buffer-overflow in AcpiTbFindTable
      ACPICA: Fix object reference update to skip non-local notify types
      ACPICA: namespace: Recognize alias node types in detach

purofle (1):
      ACPICA: fix: build error with gcc 16: unused-but-set-variable

[1] https://lore.kernel.org/all/20261020141051.2194123-1-pawel.chmielewski@intel.com/
[2] https://sashiko.dev/#/patchset/20261020141051.2194123-1-pawel.chmielewski%40intel.com
[3] https://sashiko.dev/#/message/20261020141051.2194123-9-pawel.chmielewski%40intel.com
[4] https://sashiko.dev/#/patchset/20261020141051.2194123-1-pawel.chmielewski%40intel.com?part=7

Andre Przywara (1):
  ACPICA: actbl2: MPAM: adapt to MPAM ACPI spec v3.1

Colin Ian King (2):
  ACPICA: components: Fix typo "Supress" -> "Suppress"
  ACPICA: components: Fix typo: "numer" -> "number"

Dave Jiang (2):
  ACPICA: CEDT: RDPAS: Add missing reserved field in RDPAS structure
  ACPICA: CEDT: RDPAS: Fix incorrect field positions for RDPAS

Hanjun Guo (1):
  ACPICA: add UBRT (UnifiedBus Root Table) definitions

Himanshu Chauhan (1):
  ACPICA: Introduce a new HEST notification type for RISC-V SSE events

Iurii Trukhin (1):
  ACPICA: parser: Fix parse tree memory leak on AML execution error
    unwind

Leonard Lausen (1):
  ACPICA: Executer: Resolve package index references used as integer
    operands

Maciej Strozek (1):
  ACPICA: Utilities: Fix for AcpiUtVerifyChecksum warning display

Maciej Wieczor-Retman (17):
  ACPICA: executer: Fix NULL pointer dereference in
    AcpiExStoreObjectToIndex()
  ACPICA: compiler: Add _Ixx GPE object
  ACPICA: namespace: Fix possible underflow and NULL pointer dereference
  ACPICA: iASL: Fix the truncated count of external control methods
  ACPICA: release: Update version to 20260930
  ACPICA: events: Add missing event mutex to
    AcpiEvClearGpeDispatchByOwner()
  ACPICA: events: Remove redundant code
  ACPICA: events: Fix AcpiEvClearGpeDispatchByOwner handler type
    processing
  ACPICA: events: Fix GPE cleanup return after changing program state
  ACPICA: events: Handle GPEs' Notify dispatch type
  ACPICA: tables: Fix wrong table unload and notify call order
  ACPICA: tables: Fix global table read missing mutex
  ACPICA: executer: Fix copying PCC source buffer data
  ACPICA: dispatcher: Fix zero size non-NULL PCC buffer pointer
  ACPICA: utilities: Clear NextObject so the outer loop doesn't read it
  ACPICA: namespace: Fix memory leak around compiler alias flag
  ACPICA: acpica: Fix typo in the IOVT_IOMMU table definitions

Mario Limonciello (AMD) (1):
  ACPICA: Add ACPI_MSG_DEBUG to set KERN_DEBUG for debug output

Pawel Chmielewski (3):
  ACPICA: ACPI 6.5 Add support for the MISC table
  ACPICA: iASL: Complete KEYP support
  ACPICA: tables: Fix table buffer leak when Load fails verification

Rong Zhang (1):
  ACPICA: parser: Set AML length for bytelist

Vidya Sagar (1):
  ACPICA: IORT: Add Root Complex PASID Flags field

ikaros (8):
  ACPICA: Events: Clear GPE dispatch by owner during table unload
  ACPICA: executer: Add bounds checking for PCC field read access
  ACPICA: Validate 4-char field names before namespace lookup
  ACPICA: Improve error handling in table loading process
  ACPICA: executer: Add bounds checking for PCC field write access
  ACPICA: tables: Fix heap-buffer-overflow in AcpiTbFindTable
  ACPICA: Fix object reference update to skip non-local notify types
  ACPICA: namespace: Recognize alias node types in detach

purofle (1):
  ACPICA: fix: build error with gcc 16: unused-but-set-variable

 drivers/acpi/acpica/acevents.h  |   4 +
 drivers/acpi/acpica/acglobal.h  |   2 +-
 drivers/acpi/acpica/acpredef.h  |   1 +
 drivers/acpi/acpica/acutils.h   |   3 +
 drivers/acpi/acpica/dsfield.c   |  24 +++
 drivers/acpi/acpica/evgpe.c     | 355 ++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/exconfig.c  |   3 +-
 drivers/acpi/acpica/exconvrt.c  |   4 +-
 drivers/acpi/acpica/exfield.c   | 105 +++++++---
 drivers/acpi/acpica/exresop.c   |  26 +++
 drivers/acpi/acpica/exstore.c   |  20 +-
 drivers/acpi/acpica/extrace.c   |   2 +-
 drivers/acpi/acpica/nsaccess.c  |   2 +-
 drivers/acpi/acpica/nsobject.c  |   7 +-
 drivers/acpi/acpica/nsxfname.c  |   8 +
 drivers/acpi/acpica/psargs.c    |   8 +-
 drivers/acpi/acpica/psloop.c    |   5 +-
 drivers/acpi/acpica/psobject.c  |   1 -
 drivers/acpi/acpica/psparse.c   |  16 +-
 drivers/acpi/acpica/tbdata.c    |  32 ++-
 drivers/acpi/acpica/tbfind.c    |  16 +-
 drivers/acpi/acpica/utcksum.c   |   3 +-
 drivers/acpi/acpica/utdebug.c   |   9 +-
 drivers/acpi/acpica/utdelete.c  |   5 +
 drivers/acpi/arm64/mpam.c       |   6 +-
 drivers/acpi/loongarch/iovt.c   |   6 +-
 include/acpi/acpixf.h           |   2 +-
 include/acpi/actbl1.h           |   6 +-
 include/acpi/actbl2.h           | 200 +++++++++++++++++-
 include/acpi/platform/aclinux.h |   1 +
 30 files changed, 811 insertions(+), 71 deletions(-)

-- 
2.56.0

