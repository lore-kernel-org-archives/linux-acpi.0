Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195235;
	b=Zd3hLpK7ybT3c2prOY2KS0QmAPSKT8/h+XPiHTY+HN+PSvyaP3McO2zVFMCtEVBhgG8p
	 syekYVRgm9OspQdbAwq0MXGmuNzGoKitSlQ3dgbsy91lpqfk0/2QoJusST8ypqSrgIkM0
	 fB7r6x42oai80UJrI6tfOooSDLt+Dd0kVIcnDshIgZLX4lXjO22/nO68N/qxphO72T1kX
	 qqUajIJdC03bzl1UGwhTBabKQK2sE2TcIp0EdikRK36PRTvytW6AI8Uh8Tcp+LRtNe2xy
	 uBFKXS/uevfPvhpOT1Q8p35CZgBmFn4/Km2SMbjsZ/CCrRUwAW4ugtZQy0b0s45V+/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195235;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z5YH1mLu6AiuE5q2vboZZTHQXRely9pZScmfJdjJ8f4=;
	b=hwW22BZS06qt1sPK4exMbQsTKyz2r7UTX8AS3X2DtT70SyS4StAOBA1CTWicBpR2gQEQ
	 37ujyUwi4LuizcBcMrxdNaEW1tipUzwOw46TW2CizVCEWm5bctwYbkLzJM1oLvTh03erL
	 AR/dkDypQ8DjvDScsOZcI1CF3yt39W1me+OQInCfcQVP1si6INeNvgE7xZ5pJyt1KrHTv
	 R2UpXpYCgqdgOkfBLTpZ4/s/W4iyCfYay7L1bEHC8K1gfaUUhPAiEEPu5ebuC/oqEbkpv
	 4S9qxN6E/NdWvughMlgp0Qa3NBvRGkl2aB3kljMHypNvtDAxcC+Up7Y0l3l/mYwo3dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RJ1kfn9+;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704BA60A5BCB;
	Fri, 20 Nov 2026 17:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 704BA60A5BCB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RJ1kfn9+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195235; x=1826731235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V0b+83kH70uAecpWYgjvRgHVZGlgfURI3o0r16vunAI=;
  b=RJ1kfn9+Ur7Mwf2N8d6033x2xCcM4Mjkd2MbOlIblnz4b6xRtn+tnrl9
   WKS4gGHJiqa05nKvK2zukQhpQ917sFA5dR1umxq4GwMrWbJVCJOzFuR/d
   DUz2x8LIOjXFHHOftq6cx+5rWfwLzrvBGGzxVuO2OXlU6Whuv9cTL1rmA
   PNcTYj68Vh3tHbY8UmLMhEqhp2BSIj/gzRlgWI93yEU/HwBQ6R8lGukZ8
   VyuKLplIU4fkzaQ9xqb5IkNgaf2GelmgGqtSmmDJUs4dxAWZM1svzUjFb
   t0UoKAqwoMoPC1QwvAmx2Lle8WN5ERe3GRZUhhZcoy0R4nc+uy3No10CY
   g==;
X-CSE-ConnectionGUID: 5zJZQBC2TlqzkO4/dUA+bg==
X-CSE-MsgGUID: 6zoZGn+WTX60NUTQpVQLIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157334"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157334"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:35 -0800
X-CSE-ConnectionGUID: DrbmC1dvSF64AdPHBd2waw==
X-CSE-MsgGUID: CGuTLZ4WROq9n8hGsaU1Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867930"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:32 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: ikaros <void0red@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/42] ACPICA: Validate 4-char field names before namespace lookup
Date: Fri, 20 Nov 2026 18:18:30 +0100
Message-ID: <c7ee9e92a0f5f776da4deb838e7699a66371ed5e.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
References: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: ikaros <void0red@gmail.com>

acpi_ds_get_field_names() and acpi_ds_init_field_objects() pass the
4-byte name of a named field (arg->named.name) to acpi_ns_lookup()
without checking it first. acpi_ns_lookup() treats its argument as an
AML name string. If malformed AML makes the first byte of the field name
AML_DUAL_NAME_PREFIX (0x2E) or AML_MULTI_NAME_PREFIX (0x2F),
acpi_ns_lookup() reads more name segments past the 4-byte name. That is
past the end of the parse object, which is a heap out-of-bounds read.

Before calling acpi_ns_lookup(), check that the field name is a valid
ACPI name segment. Return AE_BAD_CHARACTER if it is not.

Link: https://github.com/acpica/acpica/commit/cd05b72db519
Closes: https://github.com/open-acpica/acpica/issues/1171
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/dsfield.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index f7e503bf57c8..5d0dfe4ff8e8 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -374,6 +374,12 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 
 		case AML_INT_NAMEDFIELD_OP:
 
+			/* Validate the 4-char name to prevent OOB read in acpi_ns_lookup */
+
+			if (!acpi_ut_valid_nameseg((char *)&arg->named.name)) {
+				return_ACPI_STATUS(AE_BAD_CHARACTER);
+			}
+
 			/* Lookup the name, it should already exist */
 
 			status = acpi_ns_lookup(walk_state->scope_info,
@@ -630,6 +636,12 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 		 * in the field names in order to enter them into the namespace.
 		 */
 		if (arg->common.aml_opcode == AML_INT_NAMEDFIELD_OP) {
+			/* Validate the 4-char name to prevent OOB read in acpi_ns_lookup */
+
+			if (!acpi_ut_valid_nameseg((char *)&arg->named.name)) {
+				return_ACPI_STATUS(AE_BAD_CHARACTER);
+			}
+
 			status = acpi_ns_lookup(walk_state->scope_info,
 						(char *)&arg->named.name, type,
 						ACPI_IMODE_LOAD_PASS1, flags,
-- 
2.56.0

