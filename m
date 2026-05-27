Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2F478E20;
	Wed, 27 May 2026 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905533; cv=none; b=WFaZBDinPYaG1AksWpx2DfwqWryWoc4R6osXJ2l443FhmoeCdrXCn1o7nPNmeHjJpbOjWIXaMMeI3870U/ZIyfRAJPaXnZGhLad4XysvmGPXLuh4/5DpBX411B6o2cjWVY3bpm72EuA4kVDqBykx8Vyu+DzJnx2d6oOXuRyJSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905533; c=relaxed/simple;
	bh=QOkf+BDfVXpuegB2RrRJjVLkWT/ca+OHvGuKfo2bkx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+ninKT4FLgq5qlK2uh0cbv1BW9jxQB/6uGlqHRSBTO8TbQTBFb0fgjm/8Ah50/tyl8aOqhRo7vK/6WU/IVxGs29nXcYD+maVqAWFIi9mOQTcKrtWkobrE6sdJGw1o1clW6sueIbsddR5NyjVbasZ/MBJSSUBHqxX22UNP8OM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALChMsI7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALChMsI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD9E1F000E9;
	Wed, 27 May 2026 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905532;
	bh=7AVJ2Uscgj6/zqznYJX+bwoU5vw/TRPl5SU0uDk03lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ALChMsI74V/Bv/WbeyTu3Ei/42c+AnKk/6DlqA01RrH3QLpjd85HbKa/m7YMJH8L4
	 xGPsCNTH2+4At3Rh+0bqF/drCwX+FrnQnrqurJcBQUGc1FoZU7YLriaqYB4QaxtZo/
	 Ri9fcqLGJYv4InDiDraLrJYEDld0Ho3rWUqW0BvEftvmtUojREMh2vNjC4Du+aJ2we
	 xXlKYkbtHeNtNo+wwqwLlBRpPQjpTBBq7zUn4P9Lfk29gEKRrkOVMoKnaE8mFNkKGa
	 yk54s0Vby5Co2Zi9+UY7kdNWMVlIQHIZVH/JU9Do28rw8vF6KnHtkAJRTNRJviSaF9
	 GD7PSUCv3pANQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 14/27] ACPICA: add boundary checks in acpi_ps_get_next_field()
Date: Wed, 27 May 2026 20:00:39 +0200
Message-ID: <24388159.6Emhk5qWAg@rafael.j.wysocki>
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

Add boundary checks in acpi_ps_get_next_field() to prevent out-of-bounds
access.

Link: https://github.com/acpica/acpica/commit/c39183ea84bc
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/psargs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 87d32fbba0a6..3526ea109414 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -491,6 +491,10 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 	ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 	aml = parser_state->aml;
 
+	if (aml >= parser_state->aml_end) {
+		return_PTR(NULL);
+	}
+
 	/* Determine field type */
 
 	switch (ACPI_GET8(parser_state->aml)) {
@@ -539,6 +543,11 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 		/* Get the 4-character name */
 
+		if ((parser_state->aml + ACPI_NAMESEG_SIZE) >
+		    parser_state->aml_end) {
+			acpi_ps_free_op(field);
+			return_PTR(NULL);
+		}
 		ACPI_MOVE_32_TO_32(&name, parser_state->aml);
 		acpi_ps_set_name(field, name);
 		parser_state->aml += ACPI_NAMESEG_SIZE;
@@ -584,6 +593,10 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 		/* Get the two bytes (Type/Attribute) */
 
+		if ((parser_state->aml + 2) > parser_state->aml_end) {
+			acpi_ps_free_op(field);
+			return_PTR(NULL);
+		}
 		access_type = ACPI_GET8(parser_state->aml);
 		parser_state->aml++;
 		access_attribute = ACPI_GET8(parser_state->aml);
@@ -595,6 +608,10 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 		/* This opcode has a third byte, access_length */
 
 		if (opcode == AML_INT_EXTACCESSFIELD_OP) {
+			if (parser_state->aml >= parser_state->aml_end) {
+				acpi_ps_free_op(field);
+				return_PTR(NULL);
+			}
 			access_length = ACPI_GET8(parser_state->aml);
 			parser_state->aml++;
 
-- 
2.51.0




