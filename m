Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195230;
	b=4QvxsPcegsAJMrWBCbvlbclHxqjpHeORcSv2Q7w9XUl8kEmr1/2uDT2brPBQQ3p5Gq3Z
	 0HgSIB7qwgFZtxG6v97bJHtir1DjaSR94I+5zq46mdnHJiiT39Esq359StwigLrB7F5N3
	 3SFPATl7FfPU0EqNy5rMUCual8F2GmN41EpRr1XRkNbYwx3/zGcCJJRMdVZZmI8lJka0t
	 73YUDyPMvraaN3/TEXoxisvOOupuaF1cBd+IjhcYJ4Q9xKD5lo4n3ETPrrjKKvNgYYq7G
	 veEfxkpqkEuwHwhzxVoEyJ8sgFzwGnBpNtRyMT2mRyFq7LIeMv0Rs92QxHouCWoyeUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195230;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7XX7Fuuc4rBjIs+yejWT+meYBShh7bzSoRAqDM+Q3fM=;
	b=N2oJW3Iv0qI/lVY2X6wA+pTv8ihuTDYigWZmbPkARBe+t4K9B9BYZtxx6ICs5cDUSoC9
	 wizi0sJlus3lXzuRM1izSUGaHztzGyKVMI8DGG0WHvGPE4ez6hPTGs8REAn5HMHUW1BUL
	 wXTA0vB8zK4ecNtCjsp0Z21TuLQ7IXqaHmKfxB+mCWWEj/KrpQvcATMM8EsgylZ0lOX5T
	 L8M43rujsvQfc2BRIljhvTHVjWQXy1P0rvGWJv4nIwhcJ5GgSwWs279oxNlI4pYu6EVTK
	 M9n5aNfubjBU807F8Utdq1Jx6bBIoPFNmRhbWRdpoFajKrH24dGF1XyYIOZyf58qvxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bxd7kd1P;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BD60A2616;
	Fri, 20 Nov 2026 17:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D7BD60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bxd7kd1P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195229; x=1826731229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8+j6oCIvnTKM4aA0EdYdluZEoioo4vXDmZR4/Nlk/1E=;
  b=bxd7kd1P9wEPUVEHhYqa3Pm/J27LI77eGaybQqCCvJAYqwNnviZtuKpH
   A91MIO1d8sNqfexJe9TwTElcmfvIh4ZlbLar9JPqaY6uqbeVpVYGjzP+t
   0582FkajTyv1LLBb/DPAM9yZbaoQPOEyAddx3sSFZhhumiRfYOqCM1///
   iH9l7xt7Yej3Zqg3gwiOUb4FPYCWEXIHCPPZLX0e/LF4xSUD2u2ZS8j55
   S4Unr8m5LHXOoK6H6b3bl97lR+DNqCAcjzSOIWC/J1UtERWEQRrtuMH67
   7qqmsUDkwimXvg3nbkVz/mRJh4TLi5n6lt7ZRt3ArkNud75xy9YLbvz1W
   Q==;
X-CSE-ConnectionGUID: Fdq2b12zQ8CX8Ekth6yeaA==
X-CSE-MsgGUID: WJ1pm/30Qoe/Ls2pJqMtWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157313"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157313"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:29 -0800
X-CSE-ConnectionGUID: wat9dpSDQ9yqs48+PTbfEQ==
X-CSE-MsgGUID: iMXILK/SSRawgFeK3/oK9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867900"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:26 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: ikaros <void0red@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/42] ACPICA: Events: Clear GPE dispatch by owner during table unload
Date: Fri, 20 Nov 2026 18:18:28 +0100
Message-ID: <5f7f5a6372c547b5c24d7ca915efdac7151d97dd.1795194329.git.maciej.wieczor-retman@intel.com>
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
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
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
2.56.0

