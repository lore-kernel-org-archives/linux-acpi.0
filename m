Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505473;
	b=GYeC1CyrMKg8IT2lW8nhRXsh0Pi95mMH37fp4fxW6fErkiKpFB60zisrKBIxOPvej3DE
	 YbieIo7e+AVa8VqEU5Xk5yJx6KEPfiKh5N7D0AemPC4QIiaM9UkfBFVMIuIvZgZ5E7Gs0
	 pckjLXXHsz6XlEas06HbPVm0qTOvAwyh0H95CeZw0+M9zpNJZbw0j/INFadX0tAU2ZyE3
	 uo8FMP4BfRCHeni1GS8RAkf+jeDCGHZ9bBBFNMCsE9KlNQwKDC8JieFraPbXzAGsgUvsE
	 0PUScVqdjC/l/yh1hOc/NFcsQ0SD0Q1Goec7v3ms0J29kL0wRI7tfvoN4rs3BWoMgiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505473;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Y2JcVezqFnTQugVCZlvf0sBNJfh0Ea+Zkk096hNC2PA=;
	b=RK2vns73Z72hflahZiZeNLqya8yrn+nwPosIBDugWkm4RUt1uO59GV4F769iOdBefah4
	 qWt0Uh5PPzGLR2xYEvt76UkKqJOy/5bnjsWmzHF6zsCEil/oHi+CmrJpZTTBZejNed0cg
	 xPyzhmD7XsVd8KlmoK+I4g1HXNFbSi+tGEzmTgLzydlGEKRimyUbdfcrS/BIFdVUU3vgL
	 ruPE3XWxzIIV4luz/KodhSuyCfPCCXP6siy7+lDiHyTkp0rpxlxZCnys7srpaBYh1aD8p
	 Xg9y/4JUcv5YpcMbvK4BObRVCnOL5R7fZZO5H5pDxmf5JjwTIpLEwwlgsYlmi4p/Plw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IRo7Sblp;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5734B606A31A;
	Tue, 20 Oct 2026 14:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5734B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IRo7Sblp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505473; x=1824041473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0RyK57UWr9Sk/7D8ExrW5M6io5ZelHMVyVVMWoTX+5A=;
  b=IRo7SblpWcWkUSam+f+4eXk/C80BBB2CUFtglTEuPWn3+rZuajLjACib
   t1wPYXKvRf69cPwCVAAnVsDtA7RZxyVX077Ad8kMiC1MXaw5MqWr23Ekr
   hjPEGw6lC/27X4hJjqWIstjOQ2m0W90o/C7z6usEVo2KfOUdLDRdXASyE
   I118992jB7/Ikj5ARorSDHGtOftbx0HKJ6G7RlyDXoG+HDtCr0l6JUfuO
   wz7GhzbaPdvyqxp0P2qYueh1xh1ILmhMPAbAfMpzwMp5hLDYWjv8XDU2W
   zUBtqmg0a+h2/r2I+f1jJ27IGifmKqi1McJrcBm5RvZQ8drRqB0hqHi++
   w==;
X-CSE-ConnectionGUID: vE/VHGrgToixLo3OlHCFpQ==
X-CSE-MsgGUID: R7fJZ+oiQhqJ0FOUfnbZdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222189"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222189"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:11 -0700
X-CSE-ConnectionGUID: wwfiFsDmRrWV1kVT33dIlw==
X-CSE-MsgGUID: 4wpxifbTSMSiGFSJ0LfUaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887901"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:09 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 00/30] ACPICA: ACPICA 20260930
Date: Tue, 20 Oct 2026 16:10:21 +0200
Message-Id: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.39.5
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

Hi
This series contains code ported from upstream ACPICA that was introduced
between the 20260408 and 20260930 releases. Only source files relevant
to the Linux kernel are being ported.

The series contains the following material:

Breno Leitao (1):
  ACPICA: dispatcher: Allocate the PCC internal buffer only once per
    region

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

Ivan Hu (1):
  ACPICA: Namespace: Initialize ParserState.AmlEnd in AcpiInstallMethod

Maciej Strozek (1):
  ACPICA: Utilities: Fix for AcpiUtVerifyChecksum warning display

Maciej Wieczor-Retman (5):
  ACPICA: executer: Fix NULL pointer dereference in
    AcpiExStoreObjectToIndex()
  ACPICA: compiler: Add _Ixx GPE object
  ACPICA: namespace: Fix possible underflow and NULL pointer dereference
  ACPICA: iASL: Fix the truncated count of external control methods
  ACPICA: release: Update version to 20260930

Mario Limonciello (AMD) (1):
  ACPICA: Add ACPI_MSG_DEBUG to set KERN_DEBUG for debug output

Pawel Chmielewski (2):
  ACPICA: ACPI 6.5 Add support for the MISC table
  ACPICA: iASL: Complete KEYP support

Rong Zhang (1):
  ACPICA: parser: Set AML length for bytelist

Sudeep Holla (1):
  ACPICA: Fix PCC OperationRegion command offsets

Xianglai Li (1):
  ACPICA: actbl2: Add bit constants of the Flags field in the IOVT IOMMU
    structure

ikaros (9):
  ACPICA: Events: Clear GPE dispatch by owner during table unload
  ACPICA: Events: Track in-flight notify handlers to prevent
    use-after-free on table unload
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
 drivers/acpi/acpica/acglobal.h  |   9 +-
 drivers/acpi/acpica/aclocal.h   |   1 +
 drivers/acpi/acpica/acpredef.h  |   1 +
 drivers/acpi/acpica/acutils.h   |   3 +
 drivers/acpi/acpica/dsfield.c   |  15 ++-
 drivers/acpi/acpica/evgpe.c     |  97 ++++++++++++++++
 drivers/acpi/acpica/evmisc.c    |  32 ++++++
 drivers/acpi/acpica/exconfig.c  |   9 +-
 drivers/acpi/acpica/exconvrt.c  |   4 +-
 drivers/acpi/acpica/exfield.c   |  53 +++++++--
 drivers/acpi/acpica/exstore.c   |  20 +++-
 drivers/acpi/acpica/extrace.c   |   2 +-
 drivers/acpi/acpica/nsaccess.c  |   2 +-
 drivers/acpi/acpica/nsobject.c  |   4 +-
 drivers/acpi/acpica/nsxfname.c  |   9 ++
 drivers/acpi/acpica/psargs.c    |   8 +-
 drivers/acpi/acpica/tbdata.c    |  54 +++++++++
 drivers/acpi/acpica/tbfind.c    |  16 ++-
 drivers/acpi/acpica/utcksum.c   |   3 +-
 drivers/acpi/acpica/utdebug.c   |   9 +-
 drivers/acpi/acpica/utdelete.c  |   4 +
 drivers/acpi/acpica/utmutex.c   |   6 +
 include/acpi/acpixf.h           |   2 +-
 include/acpi/actbl1.h           |   6 +-
 include/acpi/actbl2.h           | 196 ++++++++++++++++++++++++++++++++
 include/acpi/platform/aclinux.h |   1 +
 27 files changed, 537 insertions(+), 33 deletions(-)

-- 
2.50.1

