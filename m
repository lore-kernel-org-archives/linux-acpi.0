From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/6] ACPI: battery: Don't return -EFAIL on broken packages.
Date: Tue, 18 Mar 2008 02:02:08 -0400
Message-ID: <b8a1bdb14940946fcf0438a6337b2a6c54294fb8.1205819948.git.len.brown@intel.com>
References: <1205820132-21689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:55486 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751081AbYCRGGa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Mar 2008 02:06:30 -0400
In-Reply-To: <1205820132-21689-1-git-send-email-lenb@kernel.org>
In-Reply-To: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
References: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Acer BIOS has a bug which is exposed when a dead battery is present.

The package template that is used to describe battery status is
over-written with sane values when the battery is live.
But when the batter is dead, a bogus reference in the template
is used.  In this case, Linux returns a fault, when instead
it should simply return that it doesn't know the missing value.

http://bugzilla.kernel.org/show_bug.cgi?id=8573
http://bugzilla.kernel.org/show_bug.cgi?id=10202

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f6215e8..d5729d5 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -293,13 +293,12 @@ static int extract_package(struct acpi_battery *battery,
 				strncpy(ptr, (u8 *)&element->integer.value,
 					sizeof(acpi_integer));
 				ptr[sizeof(acpi_integer)] = 0;
-			} else return -EFAULT;
+			} else
+				*ptr = 0; /* don't have value */
 		} else {
-			if (element->type == ACPI_TYPE_INTEGER) {
-				int *x = (int *)((u8 *)battery +
-						offsets[i].offset);
-				*x = element->integer.value;
-			} else return -EFAULT;
+			int *x = (int *)((u8 *)battery + offsets[i].offset);
+			*x = (element->type == ACPI_TYPE_INTEGER) ?
+				element->integer.value : -1;
 		}
 	}
 	return 0;
-- 
1.5.5.rc0.6.gdeda

