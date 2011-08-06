From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] ACPI: use kstrdup()
Date: Sat, 06 Aug 2011 11:32:56 +0200
Message-ID: <1312623179.5589.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Thomas Meyer <thomas@m3y3r.de>

 Use kstrdup rather than duplicating its implementation

 The semantic patch that makes this output is available
 in scripts/coccinelle/api/kstrdup.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/acpi/scan.c b/drivers/acpi/scan.c
--- a/drivers/acpi/scan.c 2011-05-04 19:24:51.386504770 +0200
+++ b/drivers/acpi/scan.c 2011-08-01 21:02:46.489387939 +0200
@@ -1062,13 +1062,12 @@ static void acpi_add_id(struct acpi_devi
 	if (!id)
 		return;
 
-	id->id = kmalloc(strlen(dev_id) + 1, GFP_KERNEL);
+	id->id = kstrdup(dev_id, GFP_KERNEL);
 	if (!id->id) {
 		kfree(id);
 		return;
 	}
 
-	strcpy(id->id, dev_id);
 	list_add_tail(&id->list, &device->pnp.ids);
 }
 
