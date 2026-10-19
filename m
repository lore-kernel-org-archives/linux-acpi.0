Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421822;
	b=3h8O/vJfHQXGTCeeHPlPRvkjFI3Ex/3dq/zkVGT3PSvWPf1Yo66/qiHkG0/mVF3C8iRy
	 xTYxFv+OihtZ5lt5TXbl293NAZTtkWAcMi3BOEAUhgXzhVdz5l7BknwkXrpP8FobztID+
	 YKjmAtKm43jKNjq00jzihUub325/xNeZ7ZTSWiQ2M/qDTTrDhdSCI+Cd7bbHc+6QR6EiE
	 c25r+EHznO0TGdfOsGrYrpDRWskrzIsQWKZsOOfJp7NN6/Nl44DBNePdMrx8GNaSlsv5P
	 A0EbR4m6Je0GaDYljLmePcdYTOPzVSl4dgYzpDSZtydUBxOzCRnckceB5wmoyV5UViw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421822;
	h=Received:Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XFFhmkzN3gCpAVV9wNJFrGK2My1XuAXj1fxImpVBK8k=;
	b=4AVQ1SVnb9tknW/NcPFM76rUu4xxRDJEE4hx7Mzrm+UsqKYADnvg8S/EJPgVQPoluNQa
	 lJMAL8bWUGhqSsDZHINq+EVsBfVB2hsOof6Q6dCgiqCD9wVBoJZmVjDj1RFXIhCQEdd9y
	 h71aS5wLPEryC/r7i0q6nTBdYD6tcjoWVYZmwXQtwIiv0sbuWSV632r8ijNnKuv6Y0IRS
	 bdtvBowRFDi7JmWQ3rcfyiQbdLs3PUmVwX/GsrN+TTrT6V59DJWfAMdHMcdAh+eYMq9Id
	 rzGYAsi/0J8o8XOCXO23qUfuct3eLMXGQmQHy1T+bo/IVVUIU019I2vlqUYsNNnBUJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PV9btGXP;
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D16607408B;
	Mon, 19 Oct 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PV9btGXP
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329803451CE;
	Mon, 19 Oct 2026 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421822; cv=none; b=tLJI0XFjgrbHSfVKqAiiYrsl1UcoDkeIkhMCg8grs7QA33twm/P6Hn6S/6j3rISmwPauAuctmFqFxCb/iUFZXqLArvnVSiX7yG9olhHuGWaPA/7HVI4aMi5lnHTeeEvnigkl5isymNvtg364Np0mibO97O0zd53ZgY3J5+Sg5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421822; c=relaxed/simple;
	bh=wstiMUuPit29XB21u72+Sm9cipTaJpB6vDxcGcOze1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P371awcMjGWSiA2es/VRMNTvVHWcJIX51AaZW+sOQ7+IfhavU1M6riri+M5YAS1hg22vqfApo7T9r0opy36IeLzwpwnmClnfvAuz6VGIssg+zrvVaFnvUqBZxflM6P3t61jiDZzaRkJWQVwynSzkA0m/o+pchkPjiJ5UX+rGHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PV9btGXP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CEB31682;
	Mon, 19 Oct 2026 07:56:56 -0700 (PDT)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C98F3F673;
	Mon, 19 Oct 2026 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792421819; bh=wstiMUuPit29XB21u72+Sm9cipTaJpB6vDxcGcOze1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=PV9btGXPW0TQosrp57rBn61aSnEngvPMA1lmEZ+6U2btLHX4uWQIxUZu+zPNw+d0L
	 BiMzgeElPDm7ulf/S1KMvYNrhX1bzSLNQ/4bJtdB7oKylU2tpBI2R1BmPbiEECRQAj
	 2Yj3fv/A9UJz4KDiQCT9PrO8wcl4O29jAZGa+yEM=
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
Subject: [PATCH 0/6] CPER: Add Memory Error Section 2 support
Date: Mon, 19 Oct 2026 16:56:07 +0200
Message-ID: <20261019145643.1877246-1-pierre.gondois@arm.com>
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

Pierre Gondois (6):
  ACPI: extlog: fix extlog_mem_event build issue
  cper: add Memory Error Section 2 structures
  cper: use BIT_ULL() for processor and memory validation bits
  cper: add helpers to handle Memory Error Section 2
  ACPI: APEI: add separate Memory Error Section 2 handlers
  ACPI: extlog: add Memory Error Section 2 trace event

 drivers/acpi/acpi_extlog.c  |  30 +++++++-
 drivers/acpi/apei/ghes.c    |  49 +++++++++++-
 drivers/edac/ghes_edac.c    | 150 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c | 108 ++++++++++++++++++++++++++
 drivers/ras/ras.c           |   1 +
 include/acpi/ghes.h         |   2 +
 include/linux/cper.h        | 129 ++++++++++++++++++++++---------
 include/ras/ras_event.h     | 102 ++++++++++++++++++++++++
 8 files changed, 532 insertions(+), 39 deletions(-)

--
2.43.0
