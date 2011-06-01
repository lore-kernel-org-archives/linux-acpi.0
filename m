From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH v2] ACPI: Fixes device power states array overflow
Date: Wed, 01 Jun 2011 23:54:02 +0800
Message-ID: <1306943642.2873.10.camel@hp6530s>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:34432 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757412Ab1FAOyi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jun 2011 10:54:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Dan Carpenter <error27@gmail.com>, Old <oldium.pro@seznam.cz>

Commit 28c2103 added new state ACPI_STATE_D3_COLD, so the device power
states array must be expanded by one also.

v2: Use ACPI_D_STATE_COUNT instead of number 5 for the array size.

Reported-by: Dan Carpenter <error27@gmail.com>
Suggested-by: Old=C5=99ich Jedli=C4=8Dka <oldium.pro@seznam.cz>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpi_bus.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3a10ef5..6cd5b64 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -210,7 +210,7 @@ struct acpi_device_power_state {
 struct acpi_device_power {
 	int state;		/* Current state */
 	struct acpi_device_power_flags flags;
-	struct acpi_device_power_state states[4];	/* Power states (D0-D3) */
+	struct acpi_device_power_state states[ACPI_D_STATE_COUNT];	/* Power s=
tates (D0-D3Cold) */
 };
=20
 /* Performance Management */
--=20
1.7.2.3



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
