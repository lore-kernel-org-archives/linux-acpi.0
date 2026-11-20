Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195315;
	b=uwtROgZ4t62spdAhRxEBRBQeyyS8gOsSIVEaz+S+k/XVVYCe3gHZxPQQzsRXm/gDKazp
	 YC8pCX8Td03KQP8HjrJYwp6aFo9eGUnqGsn4PWenF2d94wOivDNDLs7i2nA/FbzN1gEir
	 FsOXxdgW5ZUsZXumWHtIY8h1DOEIEuiT4ymCdhpNAbZWqVOBzqB/JJDfaayDDS2Xf7Vab
	 VR7aCJtyZDkZyi3CsHtzMzyyFa3OZ0uWk2GFWGyBgYL3RZwQOj7XyoPe0Vng6L+Xac9Eg
	 4Tp6DHOGuq+64lrVr45UXEN2GMeHUe0EdQUM+bTWLeV3xVSaXiFHGRcC8o79KOAjYOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195315;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e45Lmst2zVLRRgQuRR+OUKKJ4pLT6Oi0ahkMpBTiPW8=;
	b=QUWCpdZgN9L7ySSuvnH29zqrWCuUFMJXMIAvE5Mk/X8jKeo52p2Vi/gS+2EnNKMqfrfT
	 LkYiL9WRBKrsBwbuVk50ncHt/4irr2cHOpEQad4LaV9VWy4oUUJKc7X3JSAOknkONrtGF
	 qZfy6R9H7eiQbswQsiYX/WCd4Fj9syb6ogCizhS+Rtis54F5ttrHhRnylxoX7x9CcgcwB
	 Y9makNKJXsHEyWdQLIbkYIa8eN4sudrIV9v/17dCAIDlbaBoh/Ka7cPG8bZT/KaNKnlrl
	 9qkmta1+VfE3w8ZZCNGWeNFNELI/hwb9TlGHvOWnLKUWpo6dsmY/giyqQxQGip9QuTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OhIZKADn;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D0606A742;
	Fri, 20 Nov 2026 17:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 265D0606A742
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OhIZKADn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195315; x=1826731315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pts6JG9+FGLpbzP21b9GAVZnO6zHcnXOWhbooQaGodI=;
  b=OhIZKADnXj2jQ0ak3Ym0twCEyMvs+gr3NDNW7XIf87JtWZRIjyzeu/AB
   ICX7hU32uQxM0ARic+S0PQrrvEJQazAqM5VgG2oD5wqO8p/nTvlOUmpue
   8N9LyZIgIv7jHkCgOuiB9QlpV9zOOWuKfpB/RDQjWJbDe21x+0XjF/jJY
   aI4q7uULxiNNFJxzoIvHEiaUxAZ5F8i0raKhvis6NIes8jyg1wFQtA2hD
   1fzgkDWwyQW9htNJ8fnBvgLnYhMvg9uVMf+k5yZu4V7QR7OHF49eMDpEd
   Cb0Iv5f/nTpL7chljVD52UQODH4L8PHZKPiCKsI/iLgyXL51HEXBVP3V8
   A==;
X-CSE-ConnectionGUID: CsNm1EBwT9epWnxw2x5SUg==
X-CSE-MsgGUID: +3DMPENzQcSkeVT2f5UNtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157554"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:44 -0800
X-CSE-ConnectionGUID: OpGJwTTjTY6WT+59rdMD2Q==
X-CSE-MsgGUID: m+dFjAx6QEGe1KqDqWXNuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868222"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:42 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/42] ACPICA: events: Fix AcpiEvClearGpeDispatchByOwner handler type processing
Date: Fri, 20 Nov 2026 18:18:54 +0100
Message-ID: <36e3df265cf6a5e85d108268c28eb4d7c4e7ab38.1795194329.git.maciej.wieczor-retman@intel.com>
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

GPEs can have different callbacks tied to them - methods, notifies and
handlers. Handlers, usually being functions called from C drivers,
override methods, but they save the pointer to them and restore them
later when handlers are unloaded.

Check and clear the methods hidden under the handler.

Link: https://github.com/acpica/acpica/commit/578d52b5d1f4
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/evgpe.c | 103 +++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 578651cde6f3..d45926ad3261 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -535,6 +535,67 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 }
 
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_dispatch_type_hidden_handler
+ *
+ * PARAMETERS:  gpe_event_info  - Struct where GPE dispatch type is stored
+ *              owner_id        - Table owner_id being unloaded that should match
+ *                                the gpe_event_info
+ *
+ * RETURN:      Return the dispatch type if it is either explicitly present or
+ *              hidden behind the handler saved method_node. The GPE has to also
+ *              match the table ID passed through owner_id to this function.
+ *              Return 0 if the above criteria aren't matched.
+ *
+ * DESCRIPTION: Check whether a passed GPE event info is of either DISPATCH,
+ *              NOTIFY or HANDLER type. Then verify it belongs to the table
+ *              ID passed as an argument and that it has a Method Node. Helper
+ *              is used for example with cleaning up after table unloading.
+ *
+ ******************************************************************************/
+static u8
+acpi_ev_dispatch_type_hidden_handler(struct acpi_gpe_event_info *gpe_event_info,
+				     acpi_owner_id owner_id)
+{
+	u8 gpe_dispatch_type = ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags);
+	struct acpi_gpe_handler_info *handler;
+
+	switch (gpe_dispatch_type) {
+	case ACPI_GPE_DISPATCH_METHOD:
+		if (!(gpe_event_info->dispatch.method_node) ||
+		    (gpe_event_info->dispatch.method_node->owner_id !=
+		     owner_id)) {
+			return 0;
+		}
+		break;
+
+	/* Method or Notify can be saved if the handler is present */
+	case ACPI_GPE_DISPATCH_HANDLER:
+	case ACPI_GPE_DISPATCH_RAW_HANDLER:
+		handler = gpe_event_info->dispatch.handler;
+		if (!(handler->method_node)) {
+			return 0;
+		}
+
+		switch (ACPI_GPE_DISPATCH_TYPE(handler->original_flags)) {
+		case ACPI_GPE_DISPATCH_METHOD:
+			if (handler->method_node->owner_id != owner_id) {
+				return 0;
+			}
+			break;
+		default:
+			return 0;
+		}
+
+		break;
+
+	default:
+		return 0;
+	}
+	return gpe_dispatch_type;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_clear_gpe_dispatch_by_owner
@@ -557,6 +618,8 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 	u32 gpe_number;
 	acpi_cpu_flags flags;
 	acpi_status status = AE_OK;
+	u32 gpe_dispatch_type;
+	struct acpi_gpe_handler_info *handler;
 
 	ACPI_FUNCTION_TRACE_U32(ev_clear_gpe_dispatch_by_owner, owner_id);
 
@@ -584,13 +647,15 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 				gpe_event_info =
 					&gpe_block->event_info[gpe_number];
 
-				if ((ACPI_GPE_DISPATCH_TYPE(
-					     gpe_event_info->flags) ==
-				     ACPI_GPE_DISPATCH_METHOD) &&
-				    (gpe_event_info->dispatch.method_node) &&
-				    (gpe_event_info->dispatch.method_node
-					     ->owner_id == owner_id)) {
-					/* GPE method belongs to table being unloaded */
+				gpe_dispatch_type =
+					acpi_ev_dispatch_type_hidden_handler(
+						gpe_event_info, owner_id);
+				switch (gpe_dispatch_type) {
+				case ACPI_GPE_DISPATCH_METHOD:
+					/*
+					 * GPE method belongs to table being unloaded. Clear
+					 * only the dispatch type, preserve other flags.
+					 */
 
 					if (gpe_event_info
 						    ->disable_for_dispatch) {
@@ -612,6 +677,30 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 							gpe_event_info,
 							ACPI_GPE_DISABLE);
 					}
+					break;
+
+				case ACPI_GPE_DISPATCH_HANDLER:
+				case ACPI_GPE_DISPATCH_RAW_HANDLER:
+
+					handler =
+						gpe_event_info->dispatch.handler;
+					gpe_dispatch_type =
+						ACPI_GPE_DISPATCH_TYPE(
+							handler->original_flags);
+
+					/* Forget the hidden method so handler removal can't restore it */
+					if (gpe_dispatch_type ==
+					    ACPI_GPE_DISPATCH_METHOD) {
+						handler->method_node = NULL;
+						handler->original_flags &=
+							~ACPI_GPE_DISPATCH_MASK; /* -> NONE */
+						handler->originally_enabled =
+							FALSE;
+					}
+					break;
+
+				default:
+					break;
 				}
 			}
 
-- 
2.56.0

