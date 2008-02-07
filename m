From: Len Brown <lenb@kernel.org>
Subject: [PATCH 087/112] ACPI: remove duplicated warning message
Date: Thu,  7 Feb 2008 04:34:49 -0500
Message-ID: <e76d5f7e831a3f33dd6fa8eb94533b0b4cb22b6f.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754552AbYBGJgu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:50 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: =?utf-8?q?Miguel=20Bot=C3=B3n?= <mboton@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

=46rom: Miguel Bot=C3=B3n <mboton@gmail.com>

Remove duplicated warning message in acpi_power_transition()

ACPI: Transitioning device [%s] to D%d\n

This warning message is printed by acpi_bus_set_power() so we don't
need to print it again.

Signed-off-by: Miguel Bot=C3=B3n <mboton@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index af1769a..76bf6d9 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -458,11 +458,9 @@ int acpi_power_transition(struct acpi_device *devi=
ce, int state)
 	}
=20
      end:
-	if (result) {
+	if (result)
 		device->power.state =3D ACPI_STATE_UNKNOWN;
-		printk(KERN_WARNING PREFIX "Transitioning device [%s] to D%d\n",
-			      device->pnp.bus_id, state);
-	} else {
+	else {
 	/* We shouldn't change the state till all above operations succeed */
 		device->power.state =3D state;
 	}
--=20
1.5.4.23.gef5b9

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
