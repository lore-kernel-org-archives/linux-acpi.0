From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 3/3] ACPI / scan: use kstrdup_const in acpi_add_id()
Date: Wed,  9 Sep 2015 23:59:43 +0200
Message-ID: <1441835983-15197-3-git-send-email-linux@rasmusvillemoes.dk>
References: <1441835983-15197-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441835983-15197-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Empirically, acpi_add_id is mostly called with string literals, so
using kstrdup_const for initializing struct acpi_hardware_id::id saves
a little run-time memory and a string copy.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/acpi/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a3eaf2080707..afaac47eefb4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1184,7 +1184,7 @@ static void acpi_add_id(struct acpi_device_pnp *pnp, const char *dev_id)
 	if (!id)
 		return;
 
-	id->id = kstrdup(dev_id, GFP_KERNEL);
+	id->id = kstrdup_const(dev_id, GFP_KERNEL);
 	if (!id->id) {
 		kfree(id);
 		return;
@@ -1322,7 +1322,7 @@ void acpi_free_pnp_ids(struct acpi_device_pnp *pnp)
 	struct acpi_hardware_id *id, *tmp;
 
 	list_for_each_entry_safe(id, tmp, &pnp->ids, list) {
-		kfree(id->id);
+		kfree_const(id->id);
 		kfree(id);
 	}
 	kfree(pnp->unique_id);
-- 
2.1.3
