Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8E541E75;
	Tue, 22 Sep 2026 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088202; cv=none; b=YXM65whkuAXIxhxvghC0rFnvZcNc+hdMus9LJbN0wo8wIfUwP+6zeD8BOfBWiTbhsju9HH6KrwSLg3dxeeAn15k1q+odNncuNB7MXmQjvJAHS5lHwFfLcTj6V+suXM9YhEE6eyoqUxsgyERyATqA2VevGqKJ95aZhG29UKCWwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088202; c=relaxed/simple;
	bh=pLPnqFLcynT1BOiqoEAlB1OAxwBqqxr0L8FF6ripdvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0O+vsShIe19kwBMwcalUHcCTts0HAFDw5KzQHi27hiOXsseLEa2g1EGnX8Tddp3HiYLNJBSCkZgtf76JU8AESG3Ka19o1jvM71btxcjBebriYl66h1TRhv5H5YIn4hAkRcGOI5q7Sh6l1JlsYhjVuY/29djwsmnIMnr4e+/7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzPydhTd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzPydhTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619211F00893;
	Tue, 22 Sep 2026 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088201;
	bh=k1F5xSUM54UoGD1Xm5fjSbFOiSkAkrYtmMVgD3VjAzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QzPydhTdYJgum7d70BzYNneetvTdHALbFaIIrrwHzrKcXRCMsMpxk9tEBF/UEqnSf
	 nyUFqgbvUNAyAWCQWNQ71YsImZ/i9RDbh3e9CknDniaA1VL/8E6cVs0zEHMUEdiuTS
	 oHffC70Ul0CMgDlpxIn/TV6OLPIvnQZWL3kk6LKKRR/9BV/CXQAIvDM7I/qJ3XL+9F
	 gZoejP1pieT0qwihmzOBHv2tRoKt8Vzw9IOKof5H3t3KHE82UpalSyz+/WaYMdSHgj
	 5t2OMlOZlCyg+oR8jvqhlAmHoy8Ug/gvLeWY1OLWrJeKvPfNk5pwxwz4lR6KNBfaDc
	 g2GHRlxb1Rfcw==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v3 1/4] ACPICA: Fix PCC OperationRegion command offsets
Date: Tue, 22 Sep 2026 15:42:59 +0100
Message-ID: <20260922144302.3847593-2-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922144302.3847593-1-sudeep.holla@kernel.org>
References: <20260922144302.3847593-1-sudeep.holla@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI 6.3, section 5.5.2.4.7.3, states that the PCC Operation
Region is associated with the region of shared memory that follows the
PCC signature.

The generic and extended PCC shared memory layouts include the 4-byte
signature at offset 0, so their raw shared memory COMMAND fields are at
offsets 4 and 12 respectively. Since AML field offsets for the PCC
OperationRegion are relative to the region after that signature, ACPICA
must look for those COMMAND fields at OperationRegion offsets 0 and 8.

Adjust the generic and master subspace command checks to use those
OperationRegion-relative offsets. Otherwise writes to the COMMAND field
can fail to invoke the PCC address space handler at the offset described
by the PCC OperationRegion definition.

Link: https://github.com/open-acpica/acpica/pull/1205
Fixes: a4849944e80f ("ACPI 6.3: add PCC operation region support for AML interpreter")
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/acpi/acpica/exfield.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 9a55524ed8f4..50317fe0cbd5 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -45,12 +45,13 @@ static const u8 acpi_protocol_lengths[] = {
 
 /*
  * The following macros determine a given offset is a COMD field.
- * According to the specification, generic subspaces (types 0-2) contains a
- * 2-byte COMD field at offset 4 and master subspaces (type 3) contains a 4-byte
- * COMD field starting at offset 12.
+ * According to the specification, the PCC OperationRegion begins after
+ * the PCC signature. The raw shared memory COMD offsets of 4 for generic
+ * subspaces (types 0-2) and 12 for master subspaces (type 3) therefore
+ * appear at OperationRegion offsets 0 and 8.
  */
-#define GENERIC_SUBSPACE_COMMAND(a)     (4 == a || a == 5)
-#define MASTER_SUBSPACE_COMMAND(a)      (12 <= a && a <= 15)
+#define GENERIC_SUBSPACE_COMMAND(a)     (0 == a || a == 1)
+#define MASTER_SUBSPACE_COMMAND(a)      (8 <= a && a <= 11)
 
 /*******************************************************************************
  *
-- 
2.43.0

