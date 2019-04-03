From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 02/11] software node: Simplify software_node_release() function
Date: Wed,  3 Apr 2019 19:45:28 +0300
Message-ID: <20190403164537.24643-3-heikki.krogerus@linux.intel.com>
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

It's possible to release the node ID immediately when
fwnode_remove_software_node() is called, no need to wait for
software_node_release() with that. This change has no
functional effect.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 30077454eb68..7b321bf8424c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -557,13 +557,6 @@ static void software_node_release(struct kobject *kobj)
 {
 	struct software_node *swnode = kobj_to_swnode(kobj);
 
-	if (swnode->parent) {
-		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
-		list_del(&swnode->entry);
-	} else {
-		ida_simple_remove(&swnode_root_ids, swnode->id);
-	}
-
 	ida_destroy(&swnode->child_ids);
 	property_entries_free(swnode->properties);
 	kfree(swnode);
@@ -610,9 +603,6 @@ fwnode_create_software_node(const struct property_entry *properties,
 	INIT_LIST_HEAD(&swnode->children);
 	swnode->parent = p;
 
-	if (p)
-		list_add_tail(&swnode->entry, &p->children);
-
 	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
 				   p ? &p->kobj : NULL, "node%d", swnode->id);
 	if (ret) {
@@ -626,6 +616,9 @@ fwnode_create_software_node(const struct property_entry *properties,
 		return ERR_PTR(ret);
 	}
 
+	if (p)
+		list_add_tail(&swnode->entry, &p->children);
+
 	kobject_uevent(&swnode->kobj, KOBJ_ADD);
 	return &swnode->fwnode;
 }
@@ -638,6 +631,13 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 	if (!swnode)
 		return;
 
+	if (swnode->parent) {
+		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
+		list_del(&swnode->entry);
+	} else {
+		ida_simple_remove(&swnode_root_ids, swnode->id);
+	}
+
 	kobject_put(&swnode->kobj);
 }
 EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
-- 
2.20.1
