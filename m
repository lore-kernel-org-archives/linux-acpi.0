From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/6] ACPICA: Fix memory leak in
 acpi_ev_asynch_execute_gpe_method().
Date: Mon, 17 Jan 2011 20:22:58 -0500
Message-ID: <9673b4771ec8e378f94c0ab715b40e16f58fc32f.1295313738.git.len.brown@intel.com>
References: <1295313783-3490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:48537 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab1ARBXM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jan 2011 20:23:12 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LF700MWN2IM15E1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 17 Jan 2011 19:23:11 -0600 (CST)
In-reply-to: <1295313783-3490-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jesper Juhl <jj@chaosbits.net>, Len Brown <len.brown@intel.com>

From: Jesper Juhl <jj@chaosbits.net>

We will leak the memory allocated to 'local_gpe_event_info' if
'acpi_ut_acquire_mutex()' fails or if 'acpi_ev_valid_gpe_event()' fails in
drivers/acpi/acpica/evgpe.c::acpi_ev_asynch_execute_gpe_method().

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
Reviewed-by: Rafael Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evgpe.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 7c339d3..b6de1fb 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -471,6 +471,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(local_gpe_event_info);
 		return_VOID;
 	}
 
@@ -478,6 +479,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 	if (!acpi_ev_valid_gpe_event(gpe_event_info)) {
 		status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+		ACPI_FREE(local_gpe_event_info);
 		return_VOID;
 	}
 
-- 
1.7.4.rc2

