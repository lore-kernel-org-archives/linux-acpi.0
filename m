Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E384657CE;
	Wed, 27 May 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905508; cv=none; b=ERd+qqkZ8VUCX06jalGApN6tNWUmGxEdlzK44Oi5MfIhyckTfFLSTTNh4yeIClCgDtbaIeh8QyGgBMoh6tTNh/SYQIsei/GvuN4C3qN0+wOoHBzGxyqYDXb6T6DSN7+/r5R7Erm6GQYyUkSoJfTY6GQwxQBqARjFRq27sUNCvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905508; c=relaxed/simple;
	bh=PlqOTjSNTrdnYlrq2xvPW3gjSs+HLSyuPuWfZHqSGbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsR3QaUsZr70t8rUu3sWoEjH2oc51Td9he1q86B3/VP7ZWWIEVn8VRQo8nsGiSk4RDUom6GWNo6DCQwgQhFZ9UAueoiR0FSge0srDHc2a43fzWMiPKl/FBNDnR8grAAPPitzLUpBDYRL0wrWMfhnljkW/oH88TGpkDb4FsJC8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/0TmcIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/0TmcIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1530E1F000E9;
	Wed, 27 May 2026 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905507;
	bh=RczlhcfHBtt8W7K5f/lIVK2YMXn6EZI4mfnuUvqbnn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W/0TmcIWpHTlj8ba4AjDc60Y69zoqViPiwLcYi5cCuSBerxCfpgYUvDUJxDSZ6siA
	 ChzdEKlZT/CJ/IYqhLeYVElSM9G6XrrmNTQlHRJ8Or1Uf0nHiTnyaiWk0Zwqw9rdOg
	 u8Hy+i5yKlcZc4phTHOYk7lPTrCtwNobYtMA8Mer9pE0lwPCwaXAxn3Xtru3hoS9LM
	 FNiCpL13Ahho7miWzzIsBVJXuWztkhJQBEZhWr83Hk2zN7bcj0DBsfe2G9KdauVwyU
	 xfVBc16ULT7Ze1WwNFzCuardyyPBv0ObyqkHx4pbFTVED3BOuiKXCHWVLKUZffiMhC
	 ZBkmMcueNQ0UQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 22/27] ACPICA: Enhance OEM ID and Table ID validation in
 acpi_ex_load_table_op()
Date: Wed, 27 May 2026 20:06:25 +0200
Message-ID: <2230782.OBFZWjSADL@rafael.j.wysocki>
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

Enhance OEM ID and Table ID validation in acpi_ex_load_table_op() to
prevent buffer overflows.

Link: https://github.com/acpica/acpica/commit/f85a43098d65
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/exconfig.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 4d7dd0fc6b07..894695db0cf9 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -90,6 +90,8 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 	union acpi_operand_object *return_obj;
 	union acpi_operand_object *ddb_handle;
 	u32 table_index;
+	char oem_id[ACPI_OEM_ID_SIZE + 1];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 
 	ACPI_FUNCTION_TRACE(ex_load_table_op);
 
@@ -102,12 +104,32 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 	*return_desc = return_obj;
 
+	/*
+	 * Validate OEM ID and OEM Table ID string lengths.
+	 * acpi_tb_find_table expects strings that can safely read
+	 * ACPI_OEM_ID_SIZE and ACPI_OEM_TABLE_ID_SIZE bytes.
+	 */
+	if ((operand[1]->string.length > ACPI_OEM_ID_SIZE) ||
+	    (operand[2]->string.length > ACPI_OEM_TABLE_ID_SIZE)) {
+		return_ACPI_STATUS(AE_AML_STRING_LIMIT);
+	}
+
+	/*
+	 * Copy OEM strings to local buffers with guaranteed null-termination.
+	 * This prevents heap-buffer-overflow when acpi_tb_find_table reads
+	 * ACPI_OEM_ID_SIZE/ACPI_OEM_TABLE_ID_SIZE bytes.
+	 */
+	memcpy(oem_id, operand[1]->string.pointer, operand[1]->string.length);
+	oem_id[operand[1]->string.length] = 0;
+	memcpy(oem_table_id, operand[2]->string.pointer,
+	       operand[2]->string.length);
+	oem_table_id[operand[2]->string.length] = 0;
+
 	/* Find the ACPI table in the RSDT/XSDT */
 
 	acpi_ex_exit_interpreter();
 	status = acpi_tb_find_table(operand[0]->string.pointer,
-				    operand[1]->string.pointer,
-				    operand[2]->string.pointer, &table_index);
+				    oem_id, oem_table_id, &table_index);
 	acpi_ex_enter_interpreter();
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND) {
-- 
2.51.0




