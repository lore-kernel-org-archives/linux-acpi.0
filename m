Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D13AC0ED;
	Tue, 29 Sep 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668054; cv=none; b=SYdJBMZdurD9M+UTtQJlkMICIoZcoK4A5xx1ZbbxPrcW7dapR8IuCS2N/ai9UwsCqjFtttmHyN1EmlbL5aYNR4Zp/1MWQEVM2pCm4S6M7/aOD9RTxHfU0O/f4E246MkHjr5EmaVuOp/7wThefkj/+vW5pq4dfehpYyzFKXMsuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668054; c=relaxed/simple;
	bh=QwSDynEDcWQm3aLun7Hfo/CqbjaZBjKkYlZmZf7yul0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMr1QxO7MLWly3RUvtMbTA6EmLbB6jnF4av7xEJCyFbH0oofjpcBj0zpSfJdjwJYyukRbANJvDlD2kvKBVCkwOkwMTUg1+fPewhjIm7NvxUQsTc47UO62fVw7tL+ACFiDN7zlHToIG0hpuzhnA6Qz3iZf1UlW1yrtj0BJs96Abg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dzLMd+0S; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dzLMd+0S"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FFD5497;
	Tue, 29 Sep 2026 00:47:27 -0700 (PDT)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F4F43F85F;
	Tue, 29 Sep 2026 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790668050; bh=QwSDynEDcWQm3aLun7Hfo/CqbjaZBjKkYlZmZf7yul0=;
	h=From:To:Cc:Subject:Date:From;
	b=dzLMd+0SqQNR08byUbRkNHnJceTvQCMpQRfBTZV6qeggNC8A2+gxOdXwMIcHyfAXD
	 gcZrVqcB0H+JEYFGAACJQrGMcQvhLpfEp6+h34FuDNPl3LP20+2KvvwViFT0eoZqPe
	 dGZ+ShgATNxHmTIcKjz650BKb8RFHi3OIqfvUXho=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Kees Cook <kees@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH 0/6] CPER: Add Memory Error Section 2 support
Date: Tue, 29 Sep 2026 09:45:59 +0200
Message-ID: <20260929074659.2587216-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Memory Error Section 2 records.

Extend cper_mem_err_compact to hold both legacy and section-2 records.
Add a common parser and convert the CPER, GHES, EDAC, extlog and x86 APEI
paths to use it.

The extlog_mem_event payload layout changes with this series.
Compatibility with existing userspace decoders still needs to be
addressed. More specifically, the rasdaemon relies on the current
struct cper_mem_err_compact definition.
Either:
A-
this patchset should not modify struct cper_mem_err_compact and
create a new structure to handle Memory Error Section 2 events,
but this would ignore the similarities of Memory Error Section (1)/2
B-
userspace should not rely on the struct cper_mem_err_compact
layout. extlog_mem_event trace events should instead emit data
that relies on the actual layout of the CPER records, as defined
in the ACPI spec.

I am looking for guidance on how to handle the above question.
Current implementation lean toward B, but emits data in the trace
event that maps the new/updated struct cper_mem_err_compact.

Pierre Gondois (6):
  ACPI: extlog: fix extlog_mem_event build issue
  cper: add Memory Error Section 2 structures
  cper: extend cper_mem_err_compact struct
  cper: add helpers to handle Memory Error Section 2
  x86/mce/apei: switch cper_sec_mem_err struct users to compact CPER
    records
  cper: make cper_mem_err_pack() static

 arch/x86/include/asm/mce.h     |   4 +-
 arch/x86/kernel/acpi/apei.c    |   2 +-
 arch/x86/kernel/cpu/mce/apei.c |   2 +-
 drivers/acpi/acpi_extlog.c     |  23 +++-
 drivers/acpi/apei/apei-base.c  |   2 +-
 drivers/acpi/apei/ghes.c       |  20 +--
 drivers/edac/ghes_edac.c       |  26 ++--
 drivers/firmware/efi/cper.c    | 219 +++++++++++++++++++++++++++------
 include/acpi/apei.h            |   2 +-
 include/linux/cper.h           |  58 +++++++--
 include/ras/ras_event.h        |   4 +-
 11 files changed, 283 insertions(+), 79 deletions(-)

--
2.43.0
