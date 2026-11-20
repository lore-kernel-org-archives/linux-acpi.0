Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195317;
	b=1UL6zIcZiHxeNq1Eke5AwPOG4Fv7eTOlcFmg+GxZJrpcGskZpH8jK3YxZNv+qi+v7ARF
	 P8OnvW0lku7aYgdwkInEXKteT8EOR2WWaRk2TLJRFCGgwJlUEmlv9cqvUOKXPl6uBsalP
	 XHvs5LeMf/IhhElIfZBxQklmyAFFi2q7/z4rFKJEoCjghb+f3HTZGR98oWhTTabFFlKnS
	 yjBJnVwPZ7GWXKyYfUTfniRjch+666rmyb/6AYACD6xzB1LkztFGe+3v/XZGlbvqyewqc
	 udTCmoMZlK4GWzv4IiZOweiEi6TNBouiPjk4Nh/PQOOtmb3c3fswGeEKZ2/1/JKAvlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195317;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eNJi32jsOUeI0a+mS+BuIXo9uhP1MNfPB9zj3Flf6JI=;
	b=n+9sQVR6hNYz3bG2dzM2KM68a091ofe1NqHlUs6j3EyNxGHTdWooNAz8zcw3JyN/dL35
	 g2ltxW7W0Yp33L9optlUS34x7GEDzH/k4HrA3HV8PtWTDF+eoUen26haHZOUSqclk0xOc
	 Zbwx7JvMbAMj5XLyNN9OGYejv7Oz766a5g/tj385HnDQfLfEIiGleY0ez4UsT8o3jApD3
	 JNeFpvuK2gAwJOnyvpduxCFmxc3wq1e44vSeJ4Vd3zcbk64RyBlbcRhPCd/wEWRoRCDW9
	 wwCNGDXJHCXguSfINwvuIEPsVxLShSBAha+R2/NsrgZfHp5rx+At+kg6oukLtgZD3Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZAY+a6Wc;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF8760A3830;
	Fri, 20 Nov 2026 17:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF8760A3830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZAY+a6Wc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195316; x=1826731316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OtgaCOIPcBtG72QPC3w1ZxGpufev+KmP9NUxb6QjjiM=;
  b=ZAY+a6WcZrIHikHK95kBA0AGMIaHwPNPvX1lEd5CcPzuMABsuB92n0Kj
   joSAS1zUsabVB4RIwLWxlj+ffMdc5BHoa4n5VqKpjC0ZNrLj3dDAXtKAV
   BbWjCIOlrZNhk6+z2INzDN3FSY3V3TbqgrKwBrGIVx8PUk5ETdMmLS+qk
   VJ8CjahPsAP4+LpdVjkMfJuA5fqItrPWKT1BUm3f8Ht4T65ulk4GFQHOF
   q2+UsTLu3yafs3Kh6u+xadLU7nshSbd8HOUdHPIP8+f/unsKSaeWwPIKJ
   jY8lVz/cM8mxqSM8QJtopddrcEI9MFp3Dm2Z0VKYMsZ2dUGwuTzquxKEN
   A==;
X-CSE-ConnectionGUID: z0abGijuTPKPIUngfxKFdw==
X-CSE-MsgGUID: Wppbu06eTYemfYVnb4gzfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157564"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157564"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:50 -0800
X-CSE-ConnectionGUID: kKaMaBx4TPKiSmeb9Y6+XQ==
X-CSE-MsgGUID: jW6musAvSKWh2Sd6ej5LzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868244"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:47 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/42] ACPICA: events: Handle GPEs' Notify dispatch type
Date: Fri, 20 Nov 2026 18:18:56 +0100
Message-ID: <89657fbf116a900dccae0594c675fb0259032d8f.1795194329.git.maciej.wieczor-retman@intel.com>
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

The NotifyList is a list of devices that are tied to a single GPE. All
devices on the list shall be notified if the GPE fires. Devices can have
different parent tables - for example a DSDT can own some devices while
a separate SSDT can own a couple of different ones.

GPE dispatch can be of the Notify type. When it is, the cleanup consists
of removing devices from the GPE's device NotifyList - but only the ones
that match the ID of the table that is getting unloaded. One also has to
check the option of the NotifyList being stored away in the handler
MethodNode pointer, similar to how the Method type is treated.

Freeing the GPE notify info entries tied to device nodes taken off the
NotifyList should happen after the spinlock is released as some
platforms can't handle freeing/allocating when holding spinlocks.

Link: https://github.com/acpica/acpica/commit/c0a1faa4e478
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/evgpe.c | 146 ++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 5c283a2faaf0..be48b8d1837f 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -535,6 +535,96 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 }
 
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_notify_list_has_owner
+ *
+ * PARAMETERS:  notify          - List of notify dispatch events
+ *              owner_id        - Table owner_id being unloaded that should match
+ *                                one of the notify device nodes on the list
+ *
+ * RETURN:      Return TRUE if at least one of the device nodes matches the
+ *              passed owner_id. Return FALSE if all notify list objects don't
+ *              match the passed owner_id.
+ *
+ * DESCRIPTION: Check whether at least on object on the notify list matches its
+ *              owner_id to the one passed as a function parameter. That means
+ *              that at least one device has ownership over an object on this
+ *              notify list.
+ *
+ ******************************************************************************/
+static u8 acpi_ev_notify_list_has_owner(struct acpi_gpe_notify_info *notify,
+					acpi_owner_id owner_id)
+{
+	while (notify) {
+		if (notify->device_node->owner_id == owner_id) {
+			return (TRUE);
+		}
+		notify = notify->next;
+	}
+	return (FALSE);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_unlink_notify_list_dev_id
+ *
+ * PARAMETERS:  owner_id        - Table owner_id being unloaded that should match
+ *                                the devices on the notify_list.
+ *              notify_list     - Address of the notify_list from the GPE
+ *              to_free_list    - Address of a struct acpi_gpe_notify_info pointer that
+ *                                will later be used to free the device objects
+ *                                from the list that match the owner_id
+ *
+ * RETURN:      Return TRUE if the original notify_list was emptied after the
+ *              unlinking is done. Return FALSE otherwise.
+ *
+ * DESCRIPTION: Helper in processing the notify_list during table unloading.
+ *              notify_list can contain devices from other tables. Only devices
+ *              from the table currently getting unloaded should be cleared from
+ *              this list. This helper parses the list and moves nodes that
+ *              match the unloaded table's ID to a separate single linked list.
+ *              That list shall be later freed node by node. It shouldn't be
+ *              freed immediately as freeing/allocating should be avoided on
+ *              some system when the global spinlock is held.
+ *
+ ******************************************************************************/
+static u8
+acpi_ev_unlink_notify_list_dev_id(acpi_owner_id owner_id,
+				  struct acpi_gpe_notify_info **notify_list,
+				  struct acpi_gpe_notify_info **to_free_list)
+{
+	/* Cursor pointer that will move through all notify_list nodes addresses */
+	struct acpi_gpe_notify_info **notify_pointer = notify_list;
+	/* Currently looked at structure in the loop iteration */
+	struct acpi_gpe_notify_info *node = *notify_pointer;
+
+	/*
+	 * Go through all Notify structures to find devices matching the owner_id
+	 * that is getting unloaded
+	 */
+	while (node) {
+		if (node->device_node->owner_id == owner_id) {
+			/* Modify original list by unlinking Node */
+			*notify_pointer = node->next;
+			/* Link the unlinked node to the to-be-freed list */
+			node->next = *to_free_list;
+			*to_free_list = node;
+		} else {
+			/* Move the cursor one node further */
+			notify_pointer = &node->next;
+		}
+		/* Grab the next node or NULL if there is no more */
+		node = *notify_pointer;
+	}
+
+	/*
+	 * If the original list was emptied return TRUE so that the caller knows to
+	 * move the dispatch type from Notify to None
+	 */
+	return (*notify_list == NULL);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_dispatch_type_hidden_handler
@@ -560,6 +650,7 @@ acpi_ev_dispatch_type_hidden_handler(struct acpi_gpe_event_info *gpe_event_info,
 {
 	u8 gpe_dispatch_type = ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags);
 	struct acpi_gpe_handler_info *handler;
+	struct acpi_gpe_notify_info *notify;
 
 	switch (gpe_dispatch_type) {
 	case ACPI_GPE_DISPATCH_METHOD:
@@ -570,6 +661,13 @@ acpi_ev_dispatch_type_hidden_handler(struct acpi_gpe_event_info *gpe_event_info,
 		}
 		break;
 
+	case ACPI_GPE_DISPATCH_NOTIFY:
+		notify = gpe_event_info->dispatch.notify_list;
+		if (!acpi_ev_notify_list_has_owner(notify, owner_id)) {
+			return 0;
+		}
+		break;
+
 	/* Method or Notify can be saved if the handler is present */
 	case ACPI_GPE_DISPATCH_HANDLER:
 	case ACPI_GPE_DISPATCH_RAW_HANDLER:
@@ -584,6 +682,14 @@ acpi_ev_dispatch_type_hidden_handler(struct acpi_gpe_event_info *gpe_event_info,
 				return 0;
 			}
 			break;
+		case ACPI_GPE_DISPATCH_NOTIFY:
+			if (!acpi_ev_notify_list_has_owner(
+				    ACPI_CAST_PTR(struct acpi_gpe_notify_info,
+						  handler->method_node),
+				    owner_id)) {
+				return 0;
+			}
+			break;
 		default:
 			return 0;
 		}
@@ -620,6 +726,8 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 	acpi_status status = AE_OK;
 	u32 gpe_dispatch_type;
 	struct acpi_gpe_handler_info *handler;
+	struct acpi_gpe_notify_info *list;
+	struct acpi_gpe_notify_info *free_list = NULL;
 
 	ACPI_FUNCTION_TRACE_U32(ev_clear_gpe_dispatch_by_owner, owner_id);
 
@@ -708,6 +816,20 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 							ACPI_GPE_DISABLE);
 					break;
 
+				case ACPI_GPE_DISPATCH_NOTIFY:
+					if (acpi_ev_unlink_notify_list_dev_id(
+						    owner_id,
+						    &gpe_event_info->dispatch
+							     .notify_list,
+						    &free_list)) {
+						gpe_event_info->flags &=
+							~ACPI_GPE_DISPATCH_MASK;
+						(void)acpi_hw_low_set_gpe(
+							gpe_event_info,
+							ACPI_GPE_DISABLE);
+					}
+					break;
+
 				case ACPI_GPE_DISPATCH_HANDLER:
 				case ACPI_GPE_DISPATCH_RAW_HANDLER:
 
@@ -725,6 +847,22 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 							~ACPI_GPE_DISPATCH_MASK; /* -> NONE */
 						handler->originally_enabled =
 							FALSE;
+					} else if (gpe_dispatch_type ==
+						   ACPI_GPE_DISPATCH_NOTIFY) {
+						list = ACPI_CAST_PTR(
+							struct acpi_gpe_notify_info,
+							handler->method_node);
+						if (acpi_ev_unlink_notify_list_dev_id(
+							    owner_id, &list,
+							    &free_list)) {
+							handler->original_flags &=
+								~ACPI_GPE_DISPATCH_MASK;
+							handler->originally_enabled =
+								FALSE;
+						}
+						handler->method_node = ACPI_CAST_PTR(
+							struct acpi_namespace_node,
+							list);
 					}
 					break;
 
@@ -740,6 +878,14 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 	}
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
+	/* Free the free_list elements from the Notify path */
+	while (free_list) {
+		list = free_list->next;
+		ACPI_FREE(free_list);
+		free_list = list;
+	}
+
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
-- 
2.56.0

