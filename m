Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790264;
	b=p4eW54XCRpKx/yVireMfLlNLHgFNQd3UMDVTm877FA1CAtMdo3qU9gcn0UYRGIpnNevD
	 KMVew09+lwu115FwR/LGHzLEhnVj2cHHRdde7oe3XJYgPDLqqTLlugcrqHCV+ZHTWYZun
	 dzVWZg9O3jPS31nu3eVhE9LM9pHs1vDYdOomcwRj6lEUW3V1Cs3SkC6BmmNQgWROdSnZJ
	 AzyYvDZHxPNvHqw23Q9wJhihMP3RRSGP/QdBHiGYoGoBzmVJ+DEq5/wgizq4RPpZRffGQ
	 7fQWutvRg4g6n8Oowy1TOXQp90sBJ9tcJmHMmTCnKefV0tVSO7NdkukM4d89DtDGg+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790264;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tFaEONti7qR2pDn8HmnbO0dS90kKEmu6sZSDM59uja8=;
	b=ulj9CB4lAmI6MuPVRHx6nwpNOsxy/AALrXPXi+DlHA2o9uNU05Yd3cWvwVPEvunEzN0x
	 F82Zd48uz7wwcAwyeSJ0OTZ8voK0eXMdw4RzzBcp3drEWg0vqpcPfR1VwJFCS9+mab0zI
	 1g6wfO552pkfOwM2+5nrqDxY9D1JaNuO6oULP/d/3weJR6bkE/lPpNb3ZEv5cFBzmOzWY
	 na8SnCeOvmAHKiMmdeO/hL2B2JA+mQNX0SXPOEwPgQ+SZPealAAV4lcd8/JUAnS7kcwpm
	 6PpqoKeLhLD9O1iJ8XCzC18oltCeHAnLD64FsiLp/fL2oVJ74bXJFyy/73XDEY4zV2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Jcfy1jZi;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E305606A329;
	Wed,  4 Nov 2026 11:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E305606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Jcfy1jZi
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 290E41476;
	Wed,  4 Nov 2026 03:04:20 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.64.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31F073F632;
	Wed,  4 Nov 2026 03:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793790263; bh=gck3HT1LWj+FO3zFa4yfvcwGSuhUia/xgpZ+ELMO+sw=;
	h=From:To:Cc:Subject:Date:From;
	b=Jcfy1jZiJVo/729c9rD63+5kPzE06v4cQnNLfp/tP4F8j51VaW1br1qJFf8DHDO7a
	 PoTGpuy8NG70S9a0QMz2pVfLi9Ko4qzG/zRO9nJNCgtdlcv0YSZ2/kriws9bYYf1BO
	 jTFw17vrqvO8+U6Qa22EDiZ0y15mO+CZBQqpQ07Y=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
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
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 0/7] CPER: Add Memory Error Section 2 support
Date: Wed,  4 Nov 2026 12:03:08 +0100
Message-ID: <20261104110355.1437249-1-pierre.gondois@arm.com>
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
- _OSC support
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

Pierre Gondois (7):
  cper: use BIT_ULL() for processor and memory validation bits
  cper: add Memory Error Section 2 structures
  cper: add helpers to handle Memory Error Section 2
  EDAC/ghes: Extract error report initialization
  ACPI: APEI: Extract common memory failure handling
  ACPI: APEI: add separate Memory Error Section 2 handlers
  ACPI: extlog: add Memory Error Section 2 trace event

 drivers/acpi/acpi_extlog.c  |   6 ++
 drivers/acpi/apei/ghes.c    |  58 +++++++++--
 drivers/edac/ghes_edac.c    | 189 +++++++++++++++++++++++++++++-------
 drivers/firmware/efi/cper.c | 109 +++++++++++++++++++++
 drivers/ras/ras.c           |   1 +
 include/acpi/ghes.h         |   2 +
 include/linux/cper.h        | 129 +++++++++++++++++-------
 include/ras/ras_event.h     | 102 +++++++++++++++++++
 8 files changed, 518 insertions(+), 78 deletions(-)

--
2.43.0
