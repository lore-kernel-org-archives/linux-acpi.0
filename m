Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505488;
	b=OBjr9Za1J36o75xbzY/Y4VdVPNQwG3FOc/ktOfpC69Z4i6Q2XU36/kvckx7ANrbIx9kR
	 K+oRehB453Uy/Hm7mQYWUtHijGyyO9oLBTDW4+EHJGqGXVzSGZlebPZCMtbPtwl1TKEZ1
	 aVQ8lEZkGbngBDq5eWYg7138l5dmRXz2KnnnJN79PmsfmNkeaisoSywerpHnNQ2nZ9a0A
	 qL67RCsmN8oCJoomfLRAfaDue7Iw1H/3ja1Tcj58Mf8+UDMYnZnLiQZ3f9oClCXeFluw8
	 xsrrsZkIRsjT9qpcfGT6Axy2kdVlt9TDwVLFPf6UKcLunyp4qmMl1+0ZQIk/ozC6Z5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505488;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q80DG+MWsP9PBJSAur8gjaAcavWL+Ct9LC0MCPz1iD0=;
	b=2cCm/A11kAVAWzfXC+KjvbcdRBBq623U2g/abaGXMi/ykxfvI2X2JQ4pmHLCd97Ko771
	 zpoYNdTLvurFHBTtrv/y/NvAqyLTrrj1/fzgw8RD0EegOnRZOjL0jRL/WQRg+2dCPrV3V
	 mPg7QEBmZwdSigauJv/8Wf4jnUt6QrbGdKnMsiARIzqGxAGXAP0YqjZJPSeA/7SQ5lw2p
	 EWZTVxiho4S/aVJCrQ9AIZMNII2hNzQ1W8cHELwkN0cEfbutxyD/4CAo5I7JQ2hCzuUrq
	 yTODUIZQVypIrKVJtXSNl69zmhQSFi/FCBVhsFY3tNJgFuERGK/PwD48mErIQt8D3gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W9jtCmSL;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E93A60A3808;
	Tue, 20 Oct 2026 14:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E93A60A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W9jtCmSL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505488; x=1824041488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LxT7XmVxHuSlSO5vGvDQfgebXOq+IrfX95lWICDhMWs=;
  b=W9jtCmSLJjvP83tqz995kJJLaVSE4fb9gpX1ryuTb9BpfBgr3ehuc/sg
   29gXz2TjEGmyQUM4bM5asYW6VXhFY8jyAJMM7xYBzYWELoWy3cFbM/oZs
   UHb4OjbJg5mQNxE3v9HL0979lIlv11xOdPrqVhQy1y6AaIxwwROE+vJbC
   4uyIs62xS3uJ/XgSY+jN5Klszayrz4qc4kBxgvJO1qJH/UeuKcbsN3Q3s
   ZWKwLrIc5HBhhWzuOpYfTiIx9d3H35agTXvrRPxGTz9clDZSM5kUNVb+l
   s6/V6aDCojLhsV3alfMI6u2qKcmgUFsCVlaAGQnGIYdyceR1Tagt3BjL3
   Q==;
X-CSE-ConnectionGUID: 2OaAwy6MQDCsyqJO/7RiGA==
X-CSE-MsgGUID: E/K8sN/WSnK6CiMttipP4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222220"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222220"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:27 -0700
X-CSE-ConnectionGUID: u8p47tMWTO2z50dYofuoCg==
X-CSE-MsgGUID: DbHSegjUQ+W+SBtPOpHAXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887929"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:22 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	ikaros <void0red@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 07/30] ACPICA: Events: Clear GPE dispatch by owner during table unload
Date: Tue, 20 Oct 2026 16:10:28 +0200
Message-Id: <20261020141051.2194123-8-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
References: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
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

When a table is unloaded, its GPE method handlers must be cleared to
prevent use-after-free. Add AcpiEvClearGpeDispatchByOwner() which walks
all GPE blocks and clears dispatch info for methods owned by the
unloading table. If a matching GPE is currently dispatching,
AE_ABORT_METHOD is returned and the unload is aborted.

Also add a dispatch-type re-check in AcpiEvAsynchExecuteGpeMethod to
handle the case where dispatch was cleared between scheduling and
execution.

Link: https://github.com/acpica/acpica/commit/13dcd9b19a46
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/acevents.h |  4 ++
 drivers/acpi/acpica/evgpe.c    | 97 ++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/tbdata.c   | 13 +++++
 3 files changed, 114 insertions(+)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index ccdc3725c773..4fe26c190c57 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -122,6 +122,10 @@ acpi_status acpi_ev_gpe_initialize(void);
 ACPI_HW_DEPENDENT_RETURN_VOID(void
 			      acpi_ev_update_gpes(acpi_owner_id table_owner_id))
 
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id
+								    owner_id))
+
 acpi_status
 acpi_ev_match_gpe_method(acpi_handle obj_handle,
 			 u32 level, void *context, void **return_value);
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 53b52efc7c2b..93e205c0709e 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -489,6 +489,18 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 	case ACPI_GPE_DISPATCH_METHOD:
 
+		/*
+		 * Re-check dispatch type. The table may have been unloaded
+		 * and its GPE dispatch cleared while we were waiting.
+		 */
+		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
+		    ACPI_GPE_DISPATCH_METHOD) {
+			ACPI_DEBUG_PRINT(
+				(ACPI_DB_EVENTS,
+				 "GPE method dispatch cleared during wait\n"));
+			goto error_exit;
+		}
+
 		/* Allocate the evaluation information block */
 
 		info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
@@ -535,6 +547,91 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 }
 
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_clear_gpe_dispatch_by_owner
+ *
+ * PARAMETERS:  owner_id        - Table owner_id being unloaded
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Clear GPE dispatch info for methods belonging to the table
+ *              being unloaded. If any matching GPE is currently dispatching,
+ *              it is not cleared and AE_ABORT_METHOD is returned.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
+{
+	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
+	struct acpi_gpe_block_info *gpe_block;
+	struct acpi_gpe_event_info *gpe_event_info;
+	u32 gpe_number;
+	acpi_cpu_flags flags;
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_TRACE_U32(ev_clear_gpe_dispatch_by_owner, owner_id);
+
+	if (owner_id == 0) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Walk all GPE interrupt blocks */
+
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		while (gpe_block) {
+			/* Walk all GPEs in this block */
+
+			for (gpe_number = 0; gpe_number < gpe_block->gpe_count;
+			     gpe_number++) {
+				gpe_event_info =
+					&gpe_block->event_info[gpe_number];
+
+				if ((ACPI_GPE_DISPATCH_TYPE(
+					     gpe_event_info->flags) ==
+				     ACPI_GPE_DISPATCH_METHOD) &&
+				    (gpe_event_info->dispatch.method_node) &&
+				    (gpe_event_info->dispatch.method_node
+					     ->owner_id == owner_id)) {
+					/* GPE method belongs to table being unloaded */
+
+					if (gpe_event_info
+						    ->disable_for_dispatch) {
+						/* Handler is executing, cannot clear */
+						status = AE_ABORT_METHOD;
+					} else {
+						/* Clear only the dispatch type, preserve other flags */
+						gpe_event_info->flags &=
+							~ACPI_GPE_DISPATCH_MASK;
+						gpe_event_info->dispatch
+							.method_node = NULL;
+
+						/*
+						 * Hardware-disable the GPE so a late interrupt
+						 * cannot fire and land in the "no handler" default
+						 * branch with disable_for_dispatch stuck at TRUE.
+						 */
+						(void)acpi_hw_low_set_gpe(
+							gpe_event_info,
+							ACPI_GPE_DISABLE);
+					}
+				}
+			}
+
+			gpe_block = gpe_block->next;
+		}
+
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_asynch_enable_gpe
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 07af035aa4de..144f15011eff 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -1059,6 +1059,19 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 		acpi_tb_notify_table(ACPI_TABLE_EVENT_UNLOAD, table);
 	}
 
+#if (!ACPI_REDUCED_HARDWARE)
+	/*
+	 * Clear GPE dispatch for methods owned by the table being unloaded.
+	 * If any matching GPE is currently dispatching, AE_ABORT_METHOD is
+	 * returned and the unload cannot proceed.
+	 */
+	status = acpi_ev_clear_gpe_dispatch_by_owner(
+		acpi_gbl_root_table_list.tables[table_index].owner_id);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+#endif /* !ACPI_REDUCED_HARDWARE */
+
 	/* Delete the portion of the namespace owned by this table */
 
 	status = acpi_tb_delete_namespace_by_owner(table_index);
-- 
2.50.1

