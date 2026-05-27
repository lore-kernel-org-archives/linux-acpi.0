Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EC4657C8;
	Wed, 27 May 2026 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905495; cv=none; b=tKF7s/TLNq66oxDdnZx5WQLdNQv6z6AO2CbnPa0OTCx7ng+4ll3T2ePxwAuIPQAt0q8c/NzpxPp2gxWrtLx2cWKhZRcF5KHE+uvOJMGgw2Zj17EJzUQ8EpeOB3Y2UP14JpYcvkeNmILD9D2/ItIx776wtgJsY7fErx+Z4difik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905495; c=relaxed/simple;
	bh=PkHlQAHFn4P/2bd4C/M6jTHeRqFoOPejaQwfQMSsEOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPQNreTFzIhhFYCO46EmYTsk1r2Z4mFq1//VmugX2fTVO5yPpiQzRBtyQPjJQW03mKXv+DTVKbEnpP4xuQRDjV2QyTVIsQF+oi8YQdcd4rri1fYMmy1ZILIO6A8BPmQEPrHWIU2rMh1vVamCDYtGMfAsKWFlqfdmLBrjJ0hQfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4WzU6Gm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4WzU6Gm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF59D1F000E9;
	Wed, 27 May 2026 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905494;
	bh=omRNxJ+o6H6HZTBxpGFY/53ueOuIjfRQw03T48rOfgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h4WzU6GmR1vqsn1v08ymL81AkKtmZaygKg6/42XBwGWniaNWlI8tnLmpSH4QcoKYY
	 8uPyJoqclX69xlJzzwEBMBazOjrCj8vPnJ/vAM1ddkDC1W1RCaAFz1rAeKf9KHN056
	 eRsGjW/oiCi5ZTx6YY8kBYG4Z/qBKL1GsxQXCOHb8clz4zartUAKqwJ9Bigt8xrD2+
	 IyOg3AdiqGDlmijlY4lXfyWORbrp8U0uVyQEVq+VutasOixVHcg98A/5kkTbACs+Gh
	 EB8vSv92zCXVjZ2g8E2Sr3iIgPCFEHAZZYHpHeQLashoTow0vRe7eoj2NdxHtaT0yx
	 905twSoel/1SA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 26/27] ACPICA: Add package limit checks in parser functions
Date: Wed, 27 May 2026 20:09:24 +0200
Message-ID: <3212937.CbtlEUcBR6@rafael.j.wysocki>
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

Add package limit checks in parser functions to prevent out-of-bounds
access.

Link: https://github.com/acpica/acpica/commit/b31b45af2122
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/nsxfname.c |  4 ++++
 drivers/acpi/acpica/psargs.c   |  4 ++++
 drivers/acpi/acpica/psloop.c   | 25 +++++++++++++++++++++++++
 drivers/acpi/acpica/psparse.c  |  8 ++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index fabae9b08e31..b6534187cd43 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -512,6 +512,10 @@ acpi_status acpi_install_method(u8 *buffer)
 
 	parser_state.aml += acpi_ps_get_opcode_size(opcode);
 	parser_state.pkg_end = acpi_ps_get_next_package_end(&parser_state);
+	if ((parser_state.pkg_end > parser_state.aml_end) ||
+	    (parser_state.pkg_end < parser_state.aml)) {
+		return (AE_AML_PACKAGE_LIMIT);
+	}
 	path = acpi_ps_get_next_namestring(&parser_state);
 
 	method_flags = *parser_state.aml++;
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index cafd54fb5868..95d540bda4fb 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -867,6 +867,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 
 		parser_state->pkg_end =
 		    acpi_ps_get_next_package_end(parser_state);
+		if ((parser_state->pkg_end > parser_state->aml_end)
+		    || (parser_state->pkg_end < parser_state->aml)) {
+			return_ACPI_STATUS(AE_AML_PACKAGE_LIMIT);
+		}
 		break;
 
 	case ARGP_FIELDLIST:
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index e012495e2267..24a57f971c96 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -361,6 +361,13 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 					walk_state->parser_state.aml =
 					    acpi_ps_get_next_package_end
 					    (&walk_state->parser_state);
+					if ((walk_state->parser_state.aml >
+					     walk_state->parser_state.aml_end)
+					    || (walk_state->parser_state.aml <
+						walk_state->aml)) {
+						return_ACPI_STATUS
+						    (AE_AML_PACKAGE_LIMIT);
+					}
 					walk_state->aml =
 					    walk_state->parser_state.aml;
 				}
@@ -421,6 +428,14 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 					parser_state->aml =
 					    acpi_ps_get_next_package_end
 					    (parser_state);
+					if ((parser_state->aml >
+					     parser_state->aml_end)
+					    || (parser_state->aml <
+						walk_state->control_state->
+						control.aml_predicate_start)) {
+						return_ACPI_STATUS
+						    (AE_AML_PACKAGE_LIMIT);
+					}
 					walk_state->aml = parser_state->aml;
 
 					ACPI_ERROR((AE_INFO,
@@ -436,6 +451,16 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 						walk_state->parser_state.aml =
 						    acpi_ps_get_next_package_end
 						    (parser_state);
+						if ((walk_state->parser_state.
+						     aml >
+						     walk_state->parser_state.
+						     aml_end)
+						    || (walk_state->
+							parser_state.aml <
+							walk_state->aml)) {
+							return_ACPI_STATUS
+							    (AE_AML_PACKAGE_LIMIT);
+						}
 						walk_state->aml =
 						    parser_state->aml;
 					}
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index d9e4f33b6909..29b57d2c4cc4 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -300,6 +300,7 @@ acpi_ps_next_parse_state(struct acpi_walk_state *walk_state,
 {
 	struct acpi_parse_state *parser_state = &walk_state->parser_state;
 	acpi_status status = AE_CTRL_PENDING;
+	u8 *aml;
 
 	ACPI_FUNCTION_TRACE_PTR(ps_next_parse_state, op);
 
@@ -344,7 +345,14 @@ acpi_ps_next_parse_state(struct acpi_walk_state *walk_state,
 		 * Predicate of an IF was true, and we are at the matching ELSE.
 		 * Just close out this package
 		 */
+		aml = parser_state->aml;
+
 		parser_state->aml = acpi_ps_get_next_package_end(parser_state);
+		if ((parser_state->aml > parser_state->aml_end) ||
+		    (parser_state->aml < aml)) {
+			status = AE_AML_PACKAGE_LIMIT;
+			break;
+		}
 		status = AE_CTRL_PENDING;
 		break;
 
-- 
2.51.0




