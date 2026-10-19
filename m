Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442380;
	b=zZD/CMCAlimVuytmvTYyBO6p4SvYBelIRh9cTHJggWzZpwKHBFikHN1V25wrNrGKTDyy
	 4yzH6bdD3u5urDJILU4R2fLlvZtSLNyetzuTyh1Ge8/3GiD3iO0kIqisAbAld8Am0ACcN
	 KAm2m2gp8MXk6Fafj/lWbNPv9zN5A+bBld2omIBlBU4cGN2rmPtJMkVRSp7CXtlbg22oX
	 pXEHoQedOL+x7FFXswGuJ26CD6QrpMD/RjmiugY0SkJqKCb5c1A0/fBL/5NvFrHeTVduE
	 vGjfYClhfW5mq6eZmEn0qpJyyir08qeeEnVTx79wvWXEeoCX1PggWf2oBNjqFKqIEdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442380;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pqMiLt/n76lw/NQSmL8rmpyIMn6sIGIC+6t7TWmzylw=;
	b=fBZz9uCxQFict4yy+28Od7/djJQiNNcOETaoG5/hkTgRaeyWbqIGH0KSVbyf5Ra51aGF
	 IsX7dH/NbiNNCXJxtPxVLEMcQ0MGbwQbR06tRy+6sTO4/vAjikAjEYw9XNQAJMjYcZiyK
	 4IZ0gEP6kSb08n+xwnu+ZIpIVmUS+Elt1nLG4IJmC2kzZk4NxAsxfv647RIeYOHhLblHp
	 4Hm45j2BX5K/m/atNR9pFngSlyyuYQJ2e4m+WMdqdRhlC+P7KaycEwr2j/1UgpzPHVNVU
	 a+8If5DmdkSc8z/V9BgXq3HPTBH6g21VdDvWgHHb2tpljgLsiBMwxavzaP9vxNeOdjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=D+CrqcTQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC2606A31E;
	Mon, 19 Oct 2026 20:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2BC2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=D+CrqcTQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7166620E3;
	Mon, 19 Oct 2026 13:39:29 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.53.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 45F983F673;
	Mon, 19 Oct 2026 13:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792442367; bh=SplbOjcjh7m4xhvSRbXKCSQTOAH6GX/OFPq1KWKbaBk=;
	h=From:To:Cc:Subject:Date:From;
	b=D+CrqcTQABGSJNW/eMjG9r2pnQhqaTWiv2qWr7clJsX7sxsGRW5O7g4dcMi1PDcYM
	 FCEWlgqwDPccHKB5zDPAALwoE1J+GZ7LwJOXQkk8bj1xVEBRP2Rsg9Wbb7o+MPKcHB
	 051JuaLo1yzNIFPE/tPfuLfSQk/mXaF+x3kCtakQ=
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
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
Date: Mon, 19 Oct 2026 22:38:39 +0200
Message-ID: <20261019203915.2019037-1-pierre.gondois@arm.com>
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

RFC: https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t
V1:  https://lore.kernel.org/all/20261019145643.1877246-1-pierre.gondois@arm.com/
- Corrections from Jonathan's review
- New patch:
    [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
- Last patch not in RFC as it has been reviewed by Jonathan@
    [PATCH v2 6/6] ACPI: extlog: add Memory Error Section 2 trace event

Pierre Gondois (6):
  cper: use BIT_ULL() for processor and memory validation bits
  cper: add Memory Error Section 2 structures
  cper: add helpers to handle Memory Error Section 2
  EDAC/ghes: Extract error report initialization
  ACPI: APEI: add separate Memory Error Section 2 handlers
  ACPI: extlog: add Memory Error Section 2 trace event

 drivers/acpi/acpi_extlog.c  |   6 ++
 drivers/acpi/apei/ghes.c    |  49 +++++++++-
 drivers/edac/ghes_edac.c    | 184 ++++++++++++++++++++++++++++++------
 drivers/firmware/efi/cper.c | 109 +++++++++++++++++++++
 drivers/ras/ras.c           |   1 +
 include/acpi/ghes.h         |   2 +
 include/linux/cper.h        | 129 ++++++++++++++++++-------
 include/ras/ras_event.h     | 102 ++++++++++++++++++++
 8 files changed, 514 insertions(+), 68 deletions(-)

--
2.43.0
