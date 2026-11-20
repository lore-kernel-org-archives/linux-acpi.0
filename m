Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195318;
	b=hfKcdiRcmjRGKLzXQD3BN1+eFbrnEzPEXka7Ha7wQHhWhgW/Nr3jWtN0cGK+Cdct3xVq
	 XeR+R20wV3AyfsD2uv+7zv4igWdn5UCXHKASGLl0xw6Lyxloce6SxcFx/xsqan2g7YLnU
	 kdAZd8mHpL8ryIIYU/HUdw3wmWPjA2Og4sUMgF2qtWnBRtiu7SV4sKg0RfkR+Lj7jzEK7
	 Y7S4WaN5lIBO4H28FHXAugESKv0FnkFr7bbm20uoJreDvDrmAGYNfW4c1h1VLqLdPEPiW
	 0fZ6XSa/2HTrbC45ceRdNBnklmAYvrxBCIZDSnS9Z0XfVQ697CMpaMI9A1HJvlq4G7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195318;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iy1u3+dFMDrnkVzbbtDqodu2N36DjRx9VOyWE7tzxzQ=;
	b=obfKUI+IrZzNDfiEhpROlE9lkxeM9kf5r030BsqMxUvx071MhTJqPeqMcuJmtXVUMITN
	 k2ws/UCwPIPRVDlgCdK0Ma0+psFFjODG4I0OGXZ36Ih05AVrAKXbD1lgN4wUr8uJFwW2v
	 af0O7jaTDIS85RsOiNdDrQd56n/R5MIIdGhZ0idqsHDzmTAG1255ZaAd2yssmvsFydDqH
	 J/AX/ghCEGquw9md4b7AfoOEokzbNbBepqXYtXaIZiEhfSqMlABvxy3dmzWo0S0xwE6LM
	 KnUXnJzPheQtQXkq2EVeICr9DmJUg+/BWT7OmrZgY4es/KNobnCeTSXRYZf7fuMuwNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=enOxYYKp;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF11606A333;
	Fri, 20 Nov 2026 17:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADF11606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=enOxYYKp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195317; x=1826731317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZxOBlqrtvgnSWz8BF2TTAMtMNewr0wAgGpPCzAn9vM=;
  b=enOxYYKpgPA9UValIZPVKZi/r9iV56SFC4S0h6WYiq71eMIvvF3bI/Qs
   8v+95WFjA9AmNGxRMhTRwV5iGTUW0LFv1MNSUnPz2027YWAdkjkV0socR
   gIGJneQ/aYtSGR59J7PwpIrZS3wMmsV+Q0SV1s6tSQS8yVSsJZs7vHkEm
   4xx/QqpYSxpAhAE/jIRdUqT70FLF5nvnkObpqWdrA5D02vZdaOKQnY7QR
   eea3YfzvaxU9ezKN/lDv85POD/HvVtmKIwP8wtRdANIfR/4McPC4lYp0S
   r3brx+r7XHbB7qbSWfFNfRZEo3CsimUb1sUavCnmOXmnBvGhkwW9zMB9X
   g==;
X-CSE-ConnectionGUID: sVAKo7e4RmCtbl/rVn0/TQ==
X-CSE-MsgGUID: /+rIBQp0Ti6191SftrRQ6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157560"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157560"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:47 -0800
X-CSE-ConnectionGUID: GVbYbIGhTE249mfcXBGrHw==
X-CSE-MsgGUID: Ey5tk66sR9STlGXy5G7bZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868235"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:45 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/42] ACPICA: events: Fix GPE cleanup return after changing program state
Date: Fri, 20 Nov 2026 18:18:55 +0100
Message-ID: <d6f41b8bc2c8cd92f93af27bce2634d07270bc8b.1795194329.git.maciej.wieczor-retman@intel.com>
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

If a GPE dispatch method or notify is currently getting executed or is
set to polling etc. its table can't be freed. However the original
commit ("ACPICA: Events: Clear GPE dispatch by owner during table
unload") that tried to fix this problem would check this condition while
some GPE methods already got disabled.

First parse all the GPE blocks and look if at least one element is
blocked from being freed. If so abort the cleanup operation.

Link: https://github.com/acpica/acpica/commit/97f12aaf72cc
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/evgpe.c | 49 +++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index d45926ad3261..5c283a2faaf0 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -636,6 +636,43 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 
 	/* Walk all GPE interrupt blocks */
 
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		while (gpe_block) {
+			/*
+			 * Walk all GPEs in this block to make sure none are blocked from
+			 * getting cleared with disable_for_dispatch
+			 */
+
+			for (gpe_number = 0; gpe_number < gpe_block->gpe_count;
+			     gpe_number++) {
+				gpe_event_info =
+					&gpe_block->event_info[gpe_number];
+				gpe_dispatch_type =
+					acpi_ev_dispatch_type_hidden_handler(
+						gpe_event_info, owner_id);
+				if ((gpe_dispatch_type ==
+					     ACPI_GPE_DISPATCH_METHOD ||
+				     gpe_dispatch_type ==
+					     ACPI_GPE_DISPATCH_NOTIFY) &&
+				    gpe_event_info->disable_for_dispatch) {
+					/* At least one handler is polling or executing, cannot clear */
+					status = AE_ABORT_METHOD;
+					acpi_os_release_lock(acpi_gbl_gpe_lock,
+							     flags);
+					(void)acpi_ut_release_mutex(
+						ACPI_MTX_EVENTS);
+					return_ACPI_STATUS(status);
+				}
+			}
+
+			gpe_block = gpe_block->next;
+		}
+
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+
 	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
 	while (gpe_xrupt_info) {
 		gpe_block = gpe_xrupt_info->gpe_block_list_head;
@@ -656,17 +693,10 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 					 * GPE method belongs to table being unloaded. Clear
 					 * only the dispatch type, preserve other flags.
 					 */
-
-					if (gpe_event_info
-						    ->disable_for_dispatch) {
-						/* Handler is executing, cannot clear */
-						status = AE_ABORT_METHOD;
-					} else {
-						/* Clear only the dispatch type, preserve other flags */
 						gpe_event_info->flags &=
 							~ACPI_GPE_DISPATCH_MASK;
-						gpe_event_info->dispatch
-							.method_node = NULL;
+					gpe_event_info->dispatch.method_node =
+						NULL;
 
 						/*
 						 * Hardware-disable the GPE so a late interrupt
@@ -676,7 +706,6 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 						(void)acpi_hw_low_set_gpe(
 							gpe_event_info,
 							ACPI_GPE_DISABLE);
-					}
 					break;
 
 				case ACPI_GPE_DISPATCH_HANDLER:
-- 
2.56.0

