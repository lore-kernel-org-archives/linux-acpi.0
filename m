Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576375;
	b=k54VCQ0sRuYcXWC3L/4b+hj9imMIZYapDjmKJrEJHsb5FEfAugniOaH5dp9m+HY98oOj
	 MT4X7xwTTLaf0QxHMT+qkdv9AvPiPdUSAzCejNK4R+m2l9OwsPvVTBG+9ib6OZlklPMjU
	 Jf9U/3mszUTen/MTFFGQPS+zwRa7Ccff8D1kbSY8M4U2sr925mteZdtj4SHknBD3ji2xS
	 PBtJSY/fHi+v/x9DkNj7LOIU/cOyeI/w8SzkYPr79YL3gFKIGT2Lej0awaXzpglTuR/XM
	 RMBGAQt/wcOL6hDSaTQZc+ocjb2PbQNm1ASOJFzm1rLocypEErWc7t/tG86WlAe+u9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576375;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GFBfprroMIj7lP2HR0JBsqsLFaCtGD9563ECW+hbRiQ=;
	b=neQm6PGnSw3BkFOwfbJbovo12WiGe+93DnPGwnObo82gHPSbVS1sdJ2LAxNg6nYHR71o
	 9DggzfSG2OWsDn5GioFiWdoTBsN9uyiCrcasMo5WlJOSHNY2+/HggPioRYYsCv5AnttcG
	 APQ8IBe4lpngPszjfoSXPTmbds/fZGYLqTeYVv2/z616w1UFDI8U6zt9CEegBaZOAfJhq
	 7E0iztYzZrJLO6IMoP7dCBVjbSK74h8Zl1XOGEitUny7nnyE5WBVHPC3WvuvBW9xnQhHo
	 aT5OHD6yQBKKU80wrMIexe5IleuvcSWR0tr8KQ/vzdAjHwxnisj3r8RFX8+vo1WWoVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=APvEPR0n;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FEB606A89E;
	Fri, 13 Nov 2026 13:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47FEB606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=APvEPR0n
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7421516;
	Fri, 13 Nov 2026 05:26:11 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC51D3F85F;
	Fri, 13 Nov 2026 05:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576374; bh=M/LAD+SaqRe2mHN4epjNom3PLX82QH6gyWxe6EtlDt0=;
	h=From:To:Cc:Subject:Date:From;
	b=APvEPR0nrqajNBlUqFfP/odymgnYot9m6AzGtrzrWSNUm7rzlsMM6JK3r+/Ve6sYN
	 6E3Wry4C02rrE3zOVFkJBpeMP/a//q2F1HMOypMwe8SqthOAGybJNCpG3wuGD8u4rC
	 YvVf1+SsSr8HSGa1Zo2egLRA/CerWalRStJ5VnjE=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 00/12] CPER: Add Memory Error Section 2 support
Date: Fri, 13 Nov 2026 14:24:42 +0100
Message-ID: <20261113132600.3355836-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
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

The support is mostly duplicated from Memory Error Section handling.
Other than differences coming from the content of  Memory Error
Section 1 and 2, differences in the support are:

- v2 do not rely on a compact "struct cper_mem_err_compact" struct.
This structure was used to support older versions of the Memory
Error Section (1). This is not needed for the new structure.

- The compact version is also used by the tracing framework.
To avoid relying and propagating a non-standard record format,
through trace event (cf. extlog_mem event) the new trace event
prints each field individually.

The last patch of the serie was only build-tested due to the
absence of relevant hardware. apei_mce_report_mem_error() and
arch_apei_report_mem_error() implementations were also removed since
last version.

It will also require a proper handling from the rasdaemon. Applying
this last patch without rasdaemon support will silent the reports of
Memory Error Section 2 error, cf. ras_userspace_consumers() check.

Future:
- _OSC support (if agreed)
- Addition of arm64 tracepoints
https://lore.kernel.org/lkml/20261023170405.000060b8@oss.qualcomm.com/
- Emission of lossy CPER Mem error v1 tracepoints for legacy userspace
  tools
https://lore.kernel.org/lkml/at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com/


RFC: https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t
V1:  https://lore.kernel.org/all/20261019145643.1877246-1-pierre.gondois@arm.com/
- Corrections from Jonathan's review
- New patch:
    [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
- Last patch not in RFC as it has been reviewed by Jonathan@
    [PATCH v2 6/6] ACPI: extlog: add Memory Error Section 2 trace event
V2:
- Updated ghes_edac_init_error() to ghes_edac_init_error_desc(),
  which now only acts on the input "struct edac_raw_error_desc"
  + added lockdep_assert_held() to ghes_edac_init_error_desc()
- Accumulate failures with "queued |=" in ghes_do_proc()
- New PATCH:
  [PATCH v3 5/7] ACPI: APEI: Extract common memory failure handling

V3:
- Added <linux/bits.h> include
- Used pr_warn_rate_limited()
- Removed one warn for smbios handle overflow
- Replaced __string() -> __string_len() in trace event

Added patch to us scnprintf():
- cper: Return actual bytes written by DIMM location helpers
Added patches to increase buffer size and prevent overflows:
- EDAC/ghes: Small buffer fixes for mem other_detail helpers
- efi/cper: Pass buffer length to memory location helpers
- efi/cper: Pass buffer length to DIMM location helpers

Pierre Gondois (12):
  cper: use BIT_ULL() for processor and memory validation bits
  cper: add Memory Error Section 2 structures
  cper: add helpers to handle Memory Error Section 2
  cper: Return actual bytes written by DIMM location helpers
  EDAC/ghes: Extract error report initialization
  ACPI: APEI: Extract common memory failure handling
  ACPI: APEI: add separate Memory Error Section 2 handlers
  ACPI: extlog: add Memory Error Section 2 trace event
  efi/cper: Pass buffer length to DIMM location helpers
  efi/cper: Pass buffer length to memory location helpers
  EDAC/ghes: Small buffer fixes for mem other_detail helpers
  efi/cper: Increase memory error location and detail buffer sizes

 drivers/acpi/acpi_extlog.c  |   6 +
 drivers/acpi/apei/ghes.c    |  58 ++++++++--
 drivers/edac/ghes_edac.c    | 211 ++++++++++++++++++++++++++++--------
 drivers/firmware/efi/cper.c | 137 ++++++++++++++++++++---
 drivers/ras/ras.c           |   1 +
 include/acpi/ghes.h         |   2 +
 include/linux/cper.h        | 138 ++++++++++++++++-------
 include/linux/edac.h        |   2 +-
 include/ras/ras_event.h     | 102 +++++++++++++++++
 9 files changed, 548 insertions(+), 109 deletions(-)

--
2.43.0
