Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195292;
	b=QV0jmOAHNZVQPepAN7l1phUbQRZK/AvFjJekQZ723oOXM0lcBdCm4eqI4v4xx+Vhin+V
	 h/13oWLCdvXXTeZ6pKMcjqb7Fm5R/uZcmBaxrgQwNRbDpmgNXeF5jzLvJVaYeZKq54pl8
	 YrPHIplaYuGtJDBv6gecPMV22AoojwLRwePFZqG03wBKmAWwa3l8ynmz+Cp5dpkv7vluZ
	 90Tj671qN239Y24y59ayOH6aAJN0GOxzTaATe9d0Ovi/EM5DQLggyp8SxPfHj19D36IM7
	 T5cwdMzPoUFBrnLQV7q0HG0/MDxDLFbBoCqw9Co9PFfDPMqHuiUTSCuCzNG5eMZJ6sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195292;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hKo9oQqUcBiElmRMU75xxTtQbMqGR9T0DnABQus5l9A=;
	b=TRH7ZeEUU45Uw5BgbdKdDrFpuWYb0j/6wzWwVnD+dJ5o5JmW9vPoLd3sPHqybj3VY8O/
	 jeNY6bluQBYV/QaKAZcNDxhkWRf9QCZA0GowUH+ts3LFfl927wJRr2M4JdO/h/e+d+MR7
	 aCO+ariuaA8UDU5cBTIo5pwv/BMkYKh/6hH9WbggO14J9eUdIiXF6ierZaDMfY79b0owd
	 nSSd/J2LABAYlPbXFXq5gL3Io+zxudWL4FIaL12eaYU6F31PzhpfzYZ7Qv6YcsAvV2Vdr
	 LoJDXgxdcBZMw1CrmPPvIQc64DaMfjyRnL9T4HR1D39yB8OcrYXHSACsQVdOt+/WKSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="d2D/XLI8";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED2606A74F;
	Fri, 20 Nov 2026 17:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9ED2606A74F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d2D/XLI8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195288; x=1826731288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/r2n44oTBiyBypS7ziJQCY2efDXhtPhcvXbxJ6KD4sU=;
  b=d2D/XLI8KH7/BE9McYsxn6A7o/Wmi8mqBRQ+BvslaG0yFs5UW1Nwvvaq
   Xtq+f+wF/NRtu2lk8JmcD6H0hhQBJ3ttqLy8Rq00k/YNHv1JoemnC0JWm
   FHwlgCpeF6CqKDbRfaTmAtlL3z8k9ZXsjMHxq4Xmc7c4VjPJYFrCtVFVG
   iBp+S4/4WQQ+GDREsFBDypxBrz4bzxZXOI0NkSyvau31tMgu0aMCJxCuM
   HYKuVUpxhf9pt+9InuiHS8UfittGo6/QkZf+Td6yWAV6untGRYgA/3/bH
   UUB+rOEKOwcjZhpA/mFbB9bKu2ofqG85ZxWpCiK1Nwf7aQcZOWuWeAyJr
   Q==;
X-CSE-ConnectionGUID: eOA97LTWS4iPBVwBZJu7nQ==
X-CSE-MsgGUID: 7LS7aBmCSEe/Fk4SxcwSyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157493"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157493"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:27 -0800
X-CSE-ConnectionGUID: tqTPscSfTX2Naix5qLPZYg==
X-CSE-MsgGUID: XwArdKxZTqiYlHidIJJrWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868165"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:24 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Leonard Lausen <leonard@lausen.nl>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/42] ACPICA: Executer: Resolve package index references used as integer operands
Date: Fri, 20 Nov 2026 18:18:48 +0100
Message-ID: <1874837cbfb6cf86ad54b4f64fab3a3255521a7e.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Leonard Lausen <leonard@lausen.nl>

Resolving a Local or Arg retrieves its stored object but does not resolve
an Index reference stored there to the referenced package element. When
that reference is used as an integer operand, implicit conversion rejects
it with AE_AML_OPERAND_TYPE.

This prevents FAN0._FST on the Samsung Galaxy Book 930XDB from returning
status whenever the fan is running. The method stores an Index reference
into its fan-speed table in Local1 and then uses Add (Local1, 10, Local1).

Resolve a remaining package Index reference before integer conversion.
Release the replaced reference inside AcpiExResolveObjectToValue() - it
seems to be missing there with even a comment mentioning the
non-existant reference removal. Limit this to integer operands so Store,
CopyObject and method calls continue to preserve references. Leave
Increment and Decrement's synthetic operand resolution unchanged; their
reference-target handling requires a separate fix.

Add a standalone ASL regression covering local and argument inputs,
integer conversion, reference preservation, target replacement and invalid
operands. The extracted fan method also returns the expected status for
all defined fan states with this change.

Link: https://github.com/acpica/acpica/commit/aaa58f4b62a9
Link: https://github.com/open-acpica/acpica/issues/908
Signed-off-by: Leonard Lausen <leonard@lausen.nl>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/exresop.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 8127d4046d0b..87d04b74e13e 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -375,6 +375,32 @@ acpi_ex_resolve_operands(u16 opcode,
 			 */
 		case ARGI_INTEGER:
 
+			/*
+			 * Resolving an Arg or Local can leave an Index reference to a
+			 * package element. Resolve that element before integer conversion,
+			 * without changing reference-preserving operands such as Store.
+			 * Leave the synthetic operand resolution used by Increment and
+			 * Decrement unchanged; those operators also need reference-target
+			 * handling when writing their result.
+			 */
+			if ((walk_state->opcode != AML_INCREMENT_OP) &&
+			    (walk_state->opcode != AML_DECREMENT_OP) &&
+			    (obj_desc->common.type ==
+			     ACPI_TYPE_LOCAL_REFERENCE) &&
+			    (obj_desc->reference.class ==
+			     ACPI_REFCLASS_INDEX) &&
+			    (obj_desc->reference.target_type ==
+			     ACPI_TYPE_PACKAGE)) {
+				status = acpi_ex_resolve_to_value(stack_ptr,
+								  walk_state);
+				if (ACPI_FAILURE(status)) {
+					return_ACPI_STATUS(status);
+				}
+
+				acpi_ut_remove_reference(obj_desc);
+				obj_desc = *stack_ptr;
+			}
+
 			/*
 			 * Need an operand of type ACPI_TYPE_INTEGER, but we can
 			 * implicitly convert from a STRING or BUFFER.
-- 
2.56.0

