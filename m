Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505489;
	b=lqwo6LK8gD02wvH+EsEz1xXGigEDL1dgYoisxsn/3lHNkQChh9s8GMR+w0nKFX3iJAVT
	 zpzSdeFf77cYm1p6wVbWtBP383NNS02pT5ABT8WDFM7p5rc3KeL2+N3WCA8CGoCplhccS
	 FfIl9eySYbij4LaXAdq5maPMmPhPML+ue2ob/XRAqzez1pQxTguoBCN23//N8l+y7MCMm
	 0vcwzwjVy6HGwuOS3CSnKyI0y32AdLyelnR76HoWKOIbytH+5MxnHdQzlChRHCfShWR/C
	 9A9FZLzo5tKWyiaSb19zoyuHWBJyA72j8aN5N46Vu8j7agWXEtJYn+fppNB0fxeraug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505489;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2xrhuaqHhuw9USkkxyT+RvqLo5JaII17uMI0LZX0h5E=;
	b=IC2vRcWmuCUEBLW2n+RKrT5lMOLrcBfqJKEm8wJ+ZdBf5vPtZBSwz6QFMAHlpyR/JvlJ
	 nBa02j9ZZnpKp3uDrW8kXftNYb1UftLUDfJb7AWBILo/kBfNliLo4vXgeD9KlpblZH9UR
	 YDMMxfyr+vlR7D5OXA4cAxuTtptgu19Z/DP7h2nBx1Rm4aoMTzUDqHFTqTXqBTHNHXXaH
	 zG3EimJ6AcPfvAdl2JIJVUnkV4YpWIN/FgTUO7JHdgIl0z+kVtQKJ0k00a4yksrV17poR
	 mlVybQ9t1gSrod1SRb6Gjfgvw2E5NEg95AaZXYfN+9dHB8/nANkkwhddBEfYeuL9AwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="B2/RhYWA";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3760A3813;
	Tue, 20 Oct 2026 14:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CF3760A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B2/RhYWA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505489; x=1824041489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vxHkPZu7+yW4N1FvnnuXYSsa357BKzvkdoYkkvsu/gY=;
  b=B2/RhYWA2XY3Nf7qsqDy2jy93iM0ib2AyKmkNucz8+ZTWjW4Z6n1R8zI
   JqQhgGUYTQz4vmVPwkdEEgEZhFwXbjXHaP+NjPV6309wKU9j8yiflvUK6
   3V0RR8dIOro7jUpQ9AcATd6z8gskUm2kVgFkXQOrNs8W6pt52Exs97wzv
   H+8AM3Q8unBZ5udMcgpunTFXGjX9GVdKAFWvSwwvNIyX8KpulQRRsuH1l
   dlzD/wE2/JP9b0YJPqprCm9zqXt+uXvOzk39DAAFonw6f+YD7w+Jss5U8
   vGLhRePkDGFw7RhRIGM1oFdHFv8VI0qJdWEDZLHQIWMk/2HapbH7lN+Lm
   w==;
X-CSE-ConnectionGUID: vZ8qyO+9QOG3c87nodZfDw==
X-CSE-MsgGUID: g1Q/pn56RmeG9xgY+DZKSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222222"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222222"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:27 -0700
X-CSE-ConnectionGUID: qGTRbSPOTkSDXkdVr1DK6Q==
X-CSE-MsgGUID: zvMLvZ03QWG9vXL7DvyUwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887933"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:25 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	ikaros <void0red@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 08/30] ACPICA: Events: Track in-flight notify handlers to prevent use-after-free on table unload
Date: Tue, 20 Oct 2026 16:10:29 +0200
Message-Id: <20261020141051.2194123-9-pawel.chmielewski@intel.com>
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

Introduce per-OwnerId notify dispatch tracking with a spinlock to gate
table unload against concurrent notify execution. Before queueing, a new
notify checks whether its owning table is being unloaded and rejects the
request if so. AcpiTbUnloadTable sets the unloading gate before namespace
deletion and aborts with AE_ABORT_METHOD if any notify handler for the
table is still running, preventing use of freed namespace nodes.

Link: https://github.com/acpica/acpica/commit/3212963b406e
Closes: https://github.com/open-acpica/acpica/issues/1162
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/acglobal.h |  7 +++++++
 drivers/acpi/acpica/aclocal.h  |  1 +
 drivers/acpi/acpica/evmisc.c   | 32 +++++++++++++++++++++++++++++++
 drivers/acpi/acpica/tbdata.c   | 35 ++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utmutex.c  |  6 ++++++
 5 files changed, 81 insertions(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index b6e31517650e..08b8270b10de 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -127,6 +127,13 @@ ACPI_GLOBAL(acpi_interface_handler, acpi_gbl_interface_handler);
 ACPI_GLOBAL(struct acpi_sci_handler_info *, acpi_gbl_sci_handler_list);
 ACPI_GLOBAL(struct acpi_ged_handler_info *, acpi_gbl_ged_handler_list);
 
+/* Notify dispatch tracking: per-owner_id counters with spinlock */
+
+#define ACPI_NOTIFY_COUNT_MAX_OWNER (ACPI_OWNER_ID_MAX + 1) /* 4096 */
+ACPI_GLOBAL(u16, acpi_gbl_notify_execute_count[ACPI_NOTIFY_COUNT_MAX_OWNER]);
+ACPI_GLOBAL(u8, acpi_gbl_notify_unloading[ACPI_NOTIFY_COUNT_MAX_OWNER]);
+ACPI_GLOBAL(acpi_spinlock, acpi_gbl_notify_lock);
+
 /* Owner ID support */
 
 ACPI_GLOBAL(u32, acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS]);
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 1ecc700f6e88..e140c27513a0 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -673,6 +673,7 @@ struct acpi_notify_info {
 	struct acpi_namespace_node *node;
 	union acpi_operand_object *handler_list_head;
 	struct acpi_global_notify_handler *global;
+	acpi_owner_id owner_id;
 };
 
 /* Generic state is union of structs above */
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 723db68626ea..8401aee6dd3e 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -72,6 +72,7 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node *node, u32 notify_value)
 	union acpi_generic_state *info;
 	u8 handler_list_id = 0;
 	acpi_status status = AE_OK;
+	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_NAME(ev_queue_notify_request);
 
@@ -128,6 +129,7 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node *node, u32 notify_value)
 	info->notify.handler_list_id = handler_list_id;
 	info->notify.handler_list_head = handler_list_head;
 	info->notify.global = &acpi_gbl_global_notify[handler_list_id];
+	info->notify.owner_id = node->owner_id;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Dispatching Notify on [%4.4s] (%s) Value 0x%2.2X (%s) Node %p\n",
@@ -136,9 +138,31 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node *node, u32 notify_value)
 			  acpi_ut_get_notify_name(notify_value, ACPI_TYPE_ANY),
 			  node));
 
+	if (node->owner_id > 0 &&
+	    node->owner_id < ACPI_NOTIFY_COUNT_MAX_OWNER) {
+		flags = acpi_os_acquire_lock(acpi_gbl_notify_lock);
+
+		/* Reject if table is being unloaded to avoid use-after-free of Node */
+
+		if (acpi_gbl_notify_unloading[node->owner_id]) {
+			acpi_os_release_lock(acpi_gbl_notify_lock, flags);
+			acpi_ut_delete_generic_state(info);
+			return (AE_OK);
+		}
+
+		acpi_gbl_notify_execute_count[node->owner_id]++;
+		acpi_os_release_lock(acpi_gbl_notify_lock, flags);
+	}
+
 	status = acpi_os_execute(OSL_NOTIFY_HANDLER,
 				 acpi_ev_notify_dispatch, info);
 	if (ACPI_FAILURE(status)) {
+		if (node->owner_id > 0 &&
+		    node->owner_id < ACPI_NOTIFY_COUNT_MAX_OWNER) {
+			flags = acpi_os_acquire_lock(acpi_gbl_notify_lock);
+			acpi_gbl_notify_execute_count[node->owner_id]--;
+			acpi_os_release_lock(acpi_gbl_notify_lock, flags);
+		}
 		acpi_ut_delete_generic_state(info);
 	}
 
@@ -162,6 +186,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
 {
 	union acpi_generic_state *info = (union acpi_generic_state *)context;
 	union acpi_operand_object *handler_obj;
+	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -187,6 +212,13 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
 
 	/* All done with the info object */
 
+	if (info->notify.owner_id > 0 &&
+	    info->notify.owner_id < ACPI_NOTIFY_COUNT_MAX_OWNER) {
+		flags = acpi_os_acquire_lock(acpi_gbl_notify_lock);
+		acpi_gbl_notify_execute_count[info->notify.owner_id]--;
+		acpi_os_release_lock(acpi_gbl_notify_lock, flags);
+	}
+
 	acpi_ut_delete_generic_state(info);
 }
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 144f15011eff..1388d484787f 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -1043,6 +1043,8 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 {
 	acpi_status status = AE_OK;
 	struct acpi_table_header *table;
+	acpi_owner_id owner_id;
+	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_TRACE(tb_unload_table);
 
@@ -1072,9 +1074,42 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 	}
 #endif /* !ACPI_REDUCED_HARDWARE */
 
+	/*
+	 * Gate notify dispatch for this table's owner_id so no new notifies
+	 * are queued against namespace nodes that are about to be freed.
+	 * If any notify dispatch is in-flight, abort the unload; the caller
+	 * must retry after the dispatch completes.
+	 */
+	owner_id = acpi_gbl_root_table_list.tables[table_index].owner_id;
+	if (owner_id > 0 && owner_id < ACPI_NOTIFY_COUNT_MAX_OWNER) {
+		flags = acpi_os_acquire_lock(acpi_gbl_notify_lock);
+		acpi_gbl_notify_unloading[owner_id] = TRUE;
+
+		if (acpi_gbl_notify_execute_count[owner_id] > 0) {
+			acpi_gbl_notify_unloading[owner_id] = FALSE;
+			acpi_os_release_lock(acpi_gbl_notify_lock, flags);
+			return_ACPI_STATUS(AE_ABORT_METHOD);
+		}
+
+		acpi_os_release_lock(acpi_gbl_notify_lock, flags);
+	}
+
 	/* Delete the portion of the namespace owned by this table */
 
 	status = acpi_tb_delete_namespace_by_owner(table_index);
+
+	/*
+	 * Clear the unloading gate. If namespace deletion failed the table
+	 * remains loaded so notifies must be allowed again. If it succeeded
+	 * the owner_id is about to be released and may be reused, so clear
+	 * the gate before release to avoid a stale flag on the new owner.
+	 */
+	if (owner_id > 0 && owner_id < ACPI_NOTIFY_COUNT_MAX_OWNER) {
+		flags = acpi_os_acquire_lock(acpi_gbl_notify_lock);
+		acpi_gbl_notify_unloading[owner_id] = FALSE;
+		acpi_os_release_lock(acpi_gbl_notify_lock, flags);
+	}
+
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 2e465e6a0ab6..36d1533ecef2 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -62,6 +62,11 @@ acpi_status acpi_ut_mutex_initialize(void)
 		return_ACPI_STATUS(status);
 	}
 
+	status = acpi_os_create_lock(&acpi_gbl_notify_lock);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
 	/* Mutex for _OSI support */
 
 	status = acpi_os_create_mutex(&acpi_gbl_osi_mutex);
@@ -111,6 +116,7 @@ void acpi_ut_mutex_terminate(void)
 	acpi_os_delete_lock(acpi_gbl_gpe_lock);
 	acpi_os_delete_raw_lock(acpi_gbl_hardware_lock);
 	acpi_os_delete_lock(acpi_gbl_reference_count_lock);
+	acpi_os_delete_lock(acpi_gbl_notify_lock);
 
 	/* Delete the reader/writer lock */
 
-- 
2.50.1

