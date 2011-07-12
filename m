From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: [PATCH 1/3] power_supply: scrub device pointer if registration fails
Date: Tue, 12 Jul 2011 09:03:27 +0100
Message-ID: <1310457809-2731-2-git-send-email-stefanha@linux.vnet.ibm.com>
References: <1310457809-2731-1-git-send-email-stefanha@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310457809-2731-1-git-send-email-stefanha@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

This patch makes power_supply_register() safer for callers that are not
being careful.  When the function fails it leaves the caller's psy.dev
pointer set to the stale power supply device.  A correct caller would
handle the error return and never use psy.dev but the example of
drivers/acpi/battery.c shows otherwise.

Clear the psy.dev pointer when power_supply_register() fails so the
caller either sees a valid pointer on success or NULL on failure.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
---
 drivers/power/power_supply_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 329b46b..33d4068 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -194,6 +194,7 @@ create_triggers_failed:
 kobject_set_name_failed:
 device_add_failed:
 	put_device(dev);
+	psy->dev = NULL; /* make it crystal-clear that we failed */
 success:
 	return rc;
 }
-- 
1.7.5.4
