Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF472D2488;
	Wed, 27 May 2026 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905536; cv=none; b=ujjsLo/agFGrbX/vrCAnHGYV5TtewomPLATMYhfPgX5CyheiXyXyijN4Ct/4e1apVp+TuepR8zzsTvW1GkPWJ/Tx5J4YWA9gkfN0CXkQdwD64Wf6mr7A2xwJT0adKe+Exofd2Cu0vBeKuXitlUDbJDMifE9p0SbwMDDBRRx+vs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905536; c=relaxed/simple;
	bh=G5lNZsVyDSLWm9ZXP0ifAC5UOZwwNSEJUK5olm4aSMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/6MAnQSnkhUth/5QIeek1HLq8Um43yqkmuuQ4D0o3ElKYf16S58cM4+yN+n0Zf30xY3kj1rJqntsgEyNUfsrNb/Z6wseseDbC0sLv9/EJbhJNF6pT7Cbj3yQbVt9uLTo+M7P9BQk25j82A6e4UtVJjm68w3qnrZ82uycFf/Aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeFl82sv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeFl82sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6301F000E9;
	Wed, 27 May 2026 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905535;
	bh=Yko+gr9Itsrk+iZwB0jJ6TMx7KrRc41cdtFtD2TJ+MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GeFl82sv4bTOKv3Eadpte/5qdL5s0GDOmyYeoH58kBmR2UAAn8/a3on/exiL7P8BA
	 7EaPJB8KNPc4rU+8kIoGtXSt0c0Tdi3XzeL10Yq/UpxNmRz+UN8hCxrgFZDCVAsaSM
	 DG94sabqNzJQEsDDo0MFGR+SHy8Mvp+g3ZT94wnGX+f3XFNmWNNi4eBTQufB5WBj1i
	 fhmoe0WnA+biECEeiAhXucSHch7Yi58scaA3kuP64LfIo1y4syEX8QNU/k7S2BgnpQ
	 yst2OHaKCLF/l7G0RKZqG+4XHRCEGJPmzAEH1TdFbh1ScL1DATg363uO5ZWWuH3FFn
	 hYUkmTYKPzZmg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 13/27] ACPICA: validate byte_count in
 acpi_ps_get_next_package_length()
Date: Wed, 27 May 2026 19:59:57 +0200
Message-ID: <3616255.QJadu78ljV@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: ikaros <void0red@gmail.com>

Validate package length reading in acpi_ps_get_next_package_length().

Link: https://github.com/acpica/acpica/commit/40e03f9941e2
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/psargs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 6f6ae38ec044..87d32fbba0a6 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -48,6 +48,7 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state)
 	u32 package_length = 0;
 	u32 byte_count;
 	u8 byte_zero_mask = 0x3F;	/* Default [0:5] */
+	u32 remaining;
 
 	ACPI_FUNCTION_TRACE(ps_get_next_package_length);
 
@@ -55,7 +56,23 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state)
 	 * Byte 0 bits [6:7] contain the number of additional bytes
 	 * used to encode the package length, either 0,1,2, or 3
 	 */
+
+	/* Check if we have at least one byte to read */
+	remaining = (u32)ACPI_PTR_DIFF(parser_state->aml_end, aml);
+	if (remaining == 0) {
+		return_UINT32(0);
+	}
+
 	byte_count = (aml[0] >> 6);
+
+	/* Validate byte_count and ensure we have enough bytes to read */
+	if (byte_count >= remaining) {
+
+		/* Clamp to available bytes and advance to end */
+		parser_state->aml = parser_state->aml_end;
+		return_UINT32(0);
+	}
+
 	parser_state->aml += ((acpi_size)byte_count + 1);
 
 	/* Get bytes 3, 2, 1 as needed */
-- 
2.51.0




