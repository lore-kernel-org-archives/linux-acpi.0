Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A475505D5;
	Tue, 22 Sep 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088198; cv=none; b=igyHBZeq13oXTqzJxe2vIYGCgQenh1YScODFkCiFu2HzFldxw2JnAEPyYxMYkuRuKqQH/rGx4RQf1JHCGDcz1ab6/HQUKfJ985u9UB+5GYhzfKOiJF7cyoLv+/HMf13FkzPjo+lFt/ykRkiZbhBkMuv0fR4JUMmA7qXPgmVh9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088198; c=relaxed/simple;
	bh=JZJVIPZZoKsa1rpY9XVt5M445g7Lk4mF4ToVMYP/bXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlPQxW2+vB3LqWopDtLfKB5aOLiRfnfsyJvzVnsahPjjx3WSa9Y8qT+Hlw1h9Ju0pS/E5LNrzqmP1jlP5SrLhfg/u4DCOJaJYupZhoAypr+jRgJYTRd1cWPTDByMv4DjpBQtyR9R9xs5By+KUNRNIpBQ8dC9AIvooDOdWr8m1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzQF3V+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzQF3V+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C581F00899;
	Tue, 22 Sep 2026 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088196;
	bh=qbYBkOOlxLNZZu0j/59r3TALf3s/98MgaNlvJtSmRmA=;
	h=From:To:Cc:Subject:Date;
	b=JzQF3V+Gb+L47zONt108exNmBnNxnU8KYxX84jqjDtNI3hWwWw08NOnUJ08e+Erwh
	 FXmnXz4FyWij+k5N6C6bufqJAgYMc8b9uJcSIiEVAYOA74Xusf8GhbwMHd3kWZ4BDo
	 Yq9gXmlM02IxYDguVb/mAA83YtvwdKfSRPPNBae5x2rv0jSprRDtQa/RFp3z1w4nv1
	 5asKtbO8w4BleZi6WCNYD+sfF2x7NRb768CC2db1SvI53Tn4qYAmaWlw0KHLTXjl9/
	 QODqC41aRuVMHtwK6BJVaRkw1cO+795hmGGxxJEH3Hb1DjPeRv1d4pDM5mKngTMXes
	 uAFB2SrEkKLVQ==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v3 0/4] ACPI/PCC: Correct PCC OperationRegion handling
Date: Tue, 22 Sep 2026 15:42:58 +0100
Message-ID: <20260922144302.3847593-1-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series corrects the handling of PCC OperationRegions and their
shared memory.

ACPI 6.3 states that a PCC OperationRegion describes the shared memory
following the PCC signature. Consequently, COMMAND fields at raw shared
memory offsets 4 and 12 appear at OperationRegion offsets 0 and 8.

The first patch corrects those offsets in ACPICA. This change has already
been submitted upstream:

  https://github.com/acpica/acpica/pull/1205

The ACPICA patch is included here only to document the complete
dependency and aid review and testing. It must enter the kernel through
the ACPICA pull/import process and will not be merged directly through
the Linux ACPI tree.

The remaining Linux patches:

- Preserve the platform-populated PCC signature when copying
  OperationRegion data.
- Release the mailbox channel and region context when ACPICA
  deactivates an OperationRegion.
- Compute and cache the command timeout during channel setup.

There is no strict build dependency in case ACPICA and other 3 changes
need to be merged at different timeline or via different branch.

Regards,
Sudeep

---

Changes in v3:
 - Updated the ACPICA patch to the version accepted as part of
   https://github.com/acpica/acpica/pull/1205
 - Rebased other patches to v7.3-rc4
 - v2: https://lore.kernel.org/all/20260722131553.2117835-1-sudeep.holla@kernel.org/

Changes in v2:
 - Updated the commit message to include correct example of PCC Opregion
   as the example added by original commit 77e2a04745ff ("ACPI: PCC:
   Implement OperationRegion handler for the PCC Type 3 subtype")
   incorrectly included the signature as an OperationRegion field.
 - v1: https://lore.kernel.org/all/20260717081005.470013-1-sudeep.holla@kernel.org/

Sudeep Holla (4):
  ACPICA: Fix PCC OperationRegion command offsets
  ACPI: PCC: Preserve shared memory signature in OpRegion handler
  ACPI: PCC: Free channel on OpRegion deactivation
  ACPI: PCC: Cache OpRegion command timeout

 drivers/acpi/acpi_pcc.c       | 55 ++++++++++++++++++++++++++---------
 drivers/acpi/acpica/exfield.c | 11 +++----
 2 files changed, 48 insertions(+), 18 deletions(-)

-- 
2.43.0

