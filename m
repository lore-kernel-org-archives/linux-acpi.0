Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54E13D503
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773117339; cv=none; b=nED+wEvUDc+wPa/Tp+a0Ok5mvsmU8ZZxQlb0SXyPK0h60iF1AO8qBS2ZP4LUqDg0IlQnaxZCbBFoTwjUQ6d4Ixctq2LYLOEa1Ghw5zDPuvcTWrW/EXGJsfRY4IDGK3Yi9iEAf6YyFhPdpb36eiDTFcKt2cAlpHEwFSpzdBmeDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773117339; c=relaxed/simple;
	bh=5jk6fgZfPyeMiFcoothIusy/R6lF/krFwpFfKrf7AWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOq2O9Pfk9fVqkIY4NdatMMZ4sHuja5pESz2ufn+9zVsmFE36mIKBKNrGansKnMIL1+m0uhFiSge3ttcyCnZdCo1t1bnGRm/0pFdXLtoQOXtS+UPpjk/cpQg75bAggR4ynP5Ptsl2AcSaRqEvBRkX0muGsTC+MhPHvNIzPjgEuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0ynFbIo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0ynFbIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773117338; x=1804653338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5jk6fgZfPyeMiFcoothIusy/R6lF/krFwpFfKrf7AWc=;
  b=h0ynFbIoHd0FdDbCalUDC5wQcb7MyJgQEBzJEyWu2WDEG1dJ0KZZGMCe
   PJcdbkSAStkzCRES3XGECe9Yl9vMiKvQgcebz0recYLh8yPoMhiIwIBZP
   ePypv6NSvxS3UyIniw3PEogT1rKH1PHeO1Tin5Y17mChz4s6uxkdFTlqg
   ucm1nkkgf4wP4GyGulPmHKwXkRwrlGyjETXQDhJ0uZUIRBCgLmfmI/3X/
   /Z/bqENME8lsq2lpUd3uxY0e1FQMW7wepVvyeret5LQ+1VlnQ7pXe8sYd
   X5Zx2d9nlw4qL7xLj12bXsrAInFbnMXjPd1kQZjCZy3vov1ODXMo0BntQ
   Q==;
X-CSE-ConnectionGUID: cJ8xo3h5TSiQ/dgck2l2Vg==
X-CSE-MsgGUID: +2ngb/zURo+Vmcu5do3y/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74074077"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="74074077"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 21:35:36 -0700
X-CSE-ConnectionGUID: dMglNcH+QzmFVC/ehNoUYg==
X-CSE-MsgGUID: 8EhWNzw/RjGO4lzryy+hNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="250437399"
Received: from nldesimo-desk.amr.corp.intel.com ([10.53.80.57])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 21:35:36 -0700
From: Nate DeSimone <nathaniel.l.desimone@intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	tony.luck@intel.com
Subject: [PATCH v2 0/2] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
Date: Mon,  9 Mar 2026 21:34:39 -0700
Message-ID: <20260310043449.1295-1-nathaniel.l.desimone@intel.com>
X-Mailer: git-send-email 2.51.2.windows.1
In-Reply-To: <20260222063028.2840-1-nathaniel.l.desimone@intel.com>
References: <20260222063028.2840-1-nathaniel.l.desimone@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI Firmware Performance Data Table (FPDT) can contain two subtables:

1. Firmware Basic Boot Performance Table (FBPT)
2. S3 Performance Table (S3PT)

The existing /sys/firmware/acpi/tables/FPDT sysfs entry
only exposes the top-level FPDT header, not the subtables themselves.

This series adds sysfs attributes at /sys/firmware/acpi/fpdt/FBPT and
/sys/firmware/acpi/fpdt/S3PT that expose the raw contents of these
subtables. This mirrors the model used by /sys/firmware/dmi/tables/DMI
for DMI/SMBIOS data, and allows userspace tools to parse newer FPDT
record types defined in recent ACPI specifications[1] (e.g. String
Event Records, Microcontroller Boot Performance Data Records, etc.)
without requiring kernel changes for each new record type.

[1]
https://uefi.org/specs/ACPI/6.6/05_ACPI_Software_Programming_Model.html#performance-event-record-types

Nate DeSimone (2):
  ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
  Documentation: ABI: add FBPT and S3PT entries to sysfs-firmware-acpi

 Documentation/ABI/testing/sysfs-firmware-acpi |  6 ++++
 drivers/acpi/acpi_fpdt.c                      | 28 +++++++++++++++++++
 2 files changed, 34 insertions(+)

--
2.34.1

