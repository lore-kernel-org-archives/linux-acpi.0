Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BE3DEADC;
	Fri, 17 Jul 2026 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275812; cv=none; b=dNb5tx+U5SXiyLDS7T8+TtFtrtXoFr1j2EAMZHd8fOTKMCOwnJuhe1BlI5XvD/rSGW4AWc/YQFXO65z8UEtrV/LJ+4lkdB+fqOS5R6f+vDVFcU4zANh3V7DrcF6IK1iSFLtLnDtBuSH9++8RHKi6Hu76UAhK5muUc4mgcMkvyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275812; c=relaxed/simple;
	bh=Kvq8pBUXd3SBMsFtQJvupDCkQGaQzbTYejkgqHTe8cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qo/zpoErIhN3o5NInKJjCH0J6PrWKvXYv6D3aqXCL6Nwm9BzO8S8plftGghFFOHBKUYC83vDGwdtIJ6+kBuiOEP+EFHd51nyoeotSKwnZmMb1D3RU2DjMFXc7f5vwfaKHeWuslyEHpBgL4XMp9mUlKQNH/kVskXp7s1LRIQdcBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN5BFtpt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN5BFtpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACA81F000E9;
	Fri, 17 Jul 2026 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275811;
	bh=9jYqPRqPWJvx7ZI06P13taAbeaiEKCjE8/dqxPgQSMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NN5BFtptJtSego9L3E3AqfRMyqvg1pWqjI7MPFFgqORT9AQQtStEj/Suh2dTL9Ffy
	 nGae4C+lgMxROewXejNf8K4dn3iIAALPbWtb6sbC2BS0wM/qvImJXgKQRAQQtyo5jg
	 9gJGGbV5a2D7DSwyN736S3inYlvvm/ifNI+4P0kRXTHhBx4ZtJNyrS9tj0lEDQlyYl
	 dFD1xUN+aDRBHRoeWPJy3uwYal97SW0RRWVu3JQeFZEYfobJWYTrFUZYGykR5B6y70
	 lieO09okz3x/4DcjYo2M1L/2NMO02ODob+xn4u9QOeAHXp8AvAIqNn1HQ9ZOxMmKRO
	 L+UeQL8PWhgvA==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 1/4] ACPICA: Fix PCC OperationRegion command offsets
Date: Fri, 17 Jul 2026 09:10:02 +0100
Message-ID: <20260717081005.470013-2-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717081005.470013-1-sudeep.holla@kernel.org>
References: <20260717081005.470013-1-sudeep.holla@kernel.org>
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

Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region support for AML interpreter")
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/acpi/acpica/exfield.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 9a55524ed8f4..a7fac63938b3 100644
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
+#define GENERIC_SUBSPACE_COMMAND(a)     ((a) < 2)
+#define MASTER_SUBSPACE_COMMAND(a)      (((a) - 8) < 4)
 
 /*******************************************************************************
  *
-- 
2.43.0

