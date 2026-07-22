Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B2307AE3;
	Wed, 22 Jul 2026 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726170; cv=none; b=lfYQtkSL++4j+mFonjWaxfsOKu0v5iGdp0hzMX9WPnAJ70Ft9aeBs2Qsikkw18RUf3ljaSwjZzBkbaz40aCJMmoensp7ZHLX12GUbX58/UT05qyzUh/tv3pDINLYGwoAyEibWGwZSS0ciSJZdFZNOPVMYDEicaZCsoJ/XRFs6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726170; c=relaxed/simple;
	bh=Kvq8pBUXd3SBMsFtQJvupDCkQGaQzbTYejkgqHTe8cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIgXuG74UNT4Sh5IFPvza84XgomlE+imQr4YzybbVy2ZWkhiEEyc8hmF0K6YzNyIx1iPqCmXckVDi4g5iiKvIgthn3WoZ0DwgFhs6GE1V9KMcFwBXbGjp7DhC0K320PbTHcWTg/DnHOToK6Y6Kgx3PISLWjAqNZYj6tdDScFSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFdFfvRN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFdFfvRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4CA1F00A3E;
	Wed, 22 Jul 2026 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726164;
	bh=9jYqPRqPWJvx7ZI06P13taAbeaiEKCjE8/dqxPgQSMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bFdFfvRNNd6u3G5CYOcSwlRx50icWAnYzWSUudwmZkD9LgAmJmaZC7eUQMW1GS6Fc
	 8Ycr0CW2kzh7tnjP+nY6yOGSXYsXHNdDpKEwF1W0SnU0uBkymhA9LNXDJKIpYHtw1o
	 m7/Dxh1uc00KDvYLdA9q9h82mAnhsOrCYeCoywVP5KrOAlly+oI/aMVt+qO8+CW6YE
	 Krt9oe5w139VXsT77EgGSRHWvttB7m4D0jjVhZSJFv/4c0hpvqY+Jt+M1wJ7Lbo8pj
	 B60R9QgcTfx2V6XvMubSKyUShZ43EHUQlSQb2NNlku9HRMfr+f366G9ju8Xm3MRllJ
	 KpF80qIS/VYhA==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v2 1/4] ACPICA: Fix PCC OperationRegion command offsets
Date: Wed, 22 Jul 2026 14:15:50 +0100
Message-ID: <20260722131553.2117835-2-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722131553.2117835-1-sudeep.holla@kernel.org>
References: <20260722131553.2117835-1-sudeep.holla@kernel.org>
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

