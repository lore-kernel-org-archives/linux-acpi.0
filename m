Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822247A0A6;
	Wed, 27 May 2026 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905525; cv=none; b=fwGTe2qC06WH1KNEE35PYOlnHfdmvL3/UDxDAh9Xx/Lzfip+3O6GGP3aUB23sfFtScNFnGJM82VRMlEWHcnY5sotCuYgx8plWtdemU4wbcVslYQQgKebVC2V1tmqL21lrBOrEnq5wj5/SzpreGP2+d48uovgARepO4zah6DhYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905525; c=relaxed/simple;
	bh=klPbE8tokp5CAYtCltzsydnP3Z5YDgbltgvjtvaYZ9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C69aVsc0p2ZYNAU8DiASDG4AtdGCx1ZidSuJmBxWEw8mS2GjnUseepJu/reC+5FrIBSgd9s+ZZ+c9kEzdGcvukVL/PD6MQZHANnMG99ZhR7wdhauc3MTqobClf1Zrh+bud0iaWpliodq7GqIkP643XGn/9dJTFXf1AqdtKurCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chvtWH5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chvtWH5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10A81F00A3D;
	Wed, 27 May 2026 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905522;
	bh=PB1lywPeuQ938CbHIwb3UIV6UX6yDv432Om5DbmU5ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=chvtWH5zgg5osrAEJ8IE6x6Bqg1EWSp9+6JZoFaAZ2U7MhvvZLmRF8MXNUfCvzgO2
	 icboiTRFN4X5Vsyn6W97ReZNX1EFoUEx1j040Ncz5If5ZhGHIt0pY4vo9Ax07Lcki4
	 v6/PZlJzxi8PT5PsNNFmk9s8taqc8HHe8mP8GdJgEFDv3+bFK348finnvIp0jpbMUB
	 ewrrJDD1URLP84v+TFATP04p9jJ0/u1cRcz5X2/P0kMzHFpPOMx/KdsoVuM0nNzWH1
	 JhycVKh+J7jhU++pEFIAcq3xrBMSMf0PE2xycxku2fm0IoqjqljV+kGZVJsDPOaHlj
	 mHdXMYpWm9jbA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 17/27] ACPICA: Improve argument parsing in
 acpi_ps_get_next_simple_arg()
Date: Wed, 27 May 2026 20:02:49 +0200
Message-ID: <2008043.taCxCBeP46@rafael.j.wysocki>
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

Improve argument parsing in acpi_ps_get_next_simple_arg() to handle
remaining AML data safely.

Link: https://github.com/acpica/acpica/commit/ecbb8bcfe301
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/psargs.c | 78 +++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 3526ea109414..064652d11d9a 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -384,6 +384,8 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 	u32 length;
 	u16 opcode;
 	u8 *aml = parser_state->aml;
+	u32 remaining = (u32)ACPI_PTR_DIFF(parser_state->aml_end, aml);
+	u64 partial_value;
 
 	ACPI_FUNCTION_TRACE_U32(ps_get_next_simple_arg, arg_type);
 
@@ -393,8 +395,13 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Get 1 byte from the AML stream */
 
 		opcode = AML_BYTE_OP;
-		arg->common.value.integer = (u64) *aml;
-		length = 1;
+		if (remaining >= 1) {
+			arg->common.value.integer = (u64)*aml;
+			length = 1;
+		} else {
+			arg->common.value.integer = 0;
+			length = 0;
+		}
 		break;
 
 	case ARGP_WORDDATA:
@@ -402,8 +409,19 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Get 2 bytes from the AML stream */
 
 		opcode = AML_WORD_OP;
-		ACPI_MOVE_16_TO_64(&arg->common.value.integer, aml);
-		length = 2;
+		if (remaining >= 2) {
+			ACPI_MOVE_16_TO_64(&arg->common.value.integer, aml);
+			length = 2;
+		} else {
+			arg->common.value.integer = 0;
+			length = 0;
+			if (remaining > 0) {
+				partial_value = 0;
+				memcpy(&partial_value, aml, remaining);
+				arg->common.value.integer = partial_value;
+				length = remaining;
+			}
+		}
 		break;
 
 	case ARGP_DWORDDATA:
@@ -411,8 +429,19 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Get 4 bytes from the AML stream */
 
 		opcode = AML_DWORD_OP;
-		ACPI_MOVE_32_TO_64(&arg->common.value.integer, aml);
-		length = 4;
+		if (remaining >= 4) {
+			ACPI_MOVE_32_TO_64(&arg->common.value.integer, aml);
+			length = 4;
+		} else {
+			arg->common.value.integer = 0;
+			length = 0;
+			if (remaining > 0) {
+				partial_value = 0;
+				memcpy(&partial_value, aml, remaining);
+				arg->common.value.integer = partial_value;
+				length = remaining;
+			}
+		}
 		break;
 
 	case ARGP_QWORDDATA:
@@ -420,8 +449,19 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Get 8 bytes from the AML stream */
 
 		opcode = AML_QWORD_OP;
-		ACPI_MOVE_64_TO_64(&arg->common.value.integer, aml);
-		length = 8;
+		if (remaining >= 8) {
+			ACPI_MOVE_64_TO_64(&arg->common.value.integer, aml);
+			length = 8;
+		} else {
+			arg->common.value.integer = 0;
+			length = 0;
+			if (remaining > 0) {
+				partial_value = 0;
+				memcpy(&partial_value, aml, remaining);
+				arg->common.value.integer = partial_value;
+				length = remaining;
+			}
+		}
 		break;
 
 	case ARGP_CHARLIST:
@@ -434,10 +474,28 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Find the null terminator */
 
 		length = 0;
-		while (aml[length]) {
+		while ((length < remaining) && aml[length]) {
+			length++;
+		}
+		if (length < remaining) {
+
+			/* Account for the terminating null */
 			length++;
+		} else {
+			/*
+			 * No terminator found - add null at buffer boundary
+			 * and report a warning
+			 */
+			ACPI_WARNING((AE_INFO,
+				      "Invalid AML string: no null terminator, truncating at offset %u",
+				      (u32)(aml - parser_state->aml)));
+
+			/* Add null terminator at the boundary */
+			if (remaining > 0) {
+				aml[remaining - 1] = 0;
+				length = remaining;
+			}
 		}
-		length++;
 		break;
 
 	case ARGP_NAME:
-- 
2.51.0




