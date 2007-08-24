From: Len Brown <len.brown@intel.com>
Subject: [PATCH 25/25] ACPI: fix ia64 allnoconfig build
Date: Fri, 24 Aug 2007 03:21:12 -0400
Message-ID: <1187940102401-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
 <11879400892741-git-send-email-len.brown@intel.com>
 <11879400903190-git-send-email-len.brown@intel.com>
 <11879400911609-git-send-email-len.brown@intel.com>
 <11879400921598-git-send-email-len.brown@intel.com>
 <11879400933976-git-send-email-len.brown@intel.com>
 <1187940094867-git-send-email-len.brown@intel.com>
 <11879400951708-git-send-email-len.brown@intel.com>
 <11879400963954-git-send-email-len.brown@intel.com>
 <11879400972603-git-send-email-len.brown@intel.com>
 <11879400984017-git-send-email-len.brown@intel.com>
 <11879401002195-git-send-email-len.brown@intel.com>
 <11879401012161-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23132 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755184AbXHXHVn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:43 -0400
In-Reply-To: <11879401012161-git-send-email-len.brown@intel.com>
Message-Id: <3e069ee0c30d6f28b79e409ef2df1ffa427897ae.1187939443.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

drivers/acpi/event.c:238: error: conflicting types for =E2=80=98acpi_bu=
s_generate_netlink_event=E2=80=99
include/acpi/acpi_bus.h:324: error: previous declaration of =E2=80=98ac=
pi_bus_generate_netlink_event=E2=80=99 was here

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/event.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index cf6d516..a2b9304 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -233,8 +233,9 @@ static int acpi_event_genetlink_init(void)
 }
=20
 #else
-int acpi_bus_generate_netlink_event(struct acpi_device *device, u8 typ=
e,
-				      int data)
+int acpi_bus_generate_netlink_event(const char *device_class,
+				      const char *bus_id,
+				      u8 type, int data)
 {
 	return 0;
 }
--=20
1.5.3.rc6.17.g1911
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
