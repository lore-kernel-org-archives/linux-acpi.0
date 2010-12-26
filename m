From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/3] ACPI / ACPICA: Disable GPEs during initialization
Date: Sun, 26 Dec 2010 17:39:03 -0500
Message-ID: <5acdb1af907d5908b4942d425c0983f353dd8fc5.1293403093.git.len.brown@intel.com>
References: <1293403143-11922-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:35070 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab0LZWjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:39:32 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200GI349H35X2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:39:23 -0600 (CST)
In-reply-to: <1293403143-11922-1-git-send-email-lenb@kernel.org>
In-reply-to: <b581a7f9c3abc6c7afacd021747543d32ff17adb.1293403093.git.len.brown@intel.com>
References: <b581a7f9c3abc6c7afacd021747543d32ff17adb.1293403093.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

GPEs with corresponding _Lxx/_Exx control methods need to be disabled
during initialization in case they have been enabled by the BIOS, so
that they don't fire up until they are enabled by acpi_update_gpes().

References: https://bugzilla.kernel.org/show_bug.cgi?id=25412
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evgpeinit.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 2c7def9..4c8dea5 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -408,6 +408,9 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	/* Disable the GPE in case it's been enabled already. */
+	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
+
 	/*
 	 * Add the GPE information from above to the gpe_event_info block for
 	 * use during dispatch of this GPE.
-- 
1.7.3.3.557.gb5c17

