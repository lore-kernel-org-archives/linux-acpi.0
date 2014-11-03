From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/6] ACPI/EC: Add reference counting for query handlers.
Date: Mon,  3 Nov 2014 13:16:25 +0800
Message-ID: <a2f86ca94eb1bd2a0e1a06ba9486d5daafba7e8b.1414988981.git.lv.zheng@intel.com>
References: <cover.1414988981.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1414988981.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds reference counting for query handlers in order to elimi=
nate
kmalloc()/kfree() usage.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Steffen Weber <steffen.weber@gmail.com>
Tested-by: Ortwin Gl=C3=BCck <odi@odi.ch>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   47 +++++++++++++++++++++++++++++++++++++--------=
--
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9a51f7a..69e4f35 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -106,6 +106,7 @@ struct acpi_ec_query_handler {
 	acpi_handle handle;
 	void *data;
 	u8 query_bit;
+	struct kref kref;
 };
=20
 struct transaction {
@@ -120,6 +121,10 @@ struct transaction {
 	u8 flags;
 };
=20
+static struct acpi_ec_query_handler *
+acpi_ec_get_query_handler(struct acpi_ec_query_handler *handler);
+static void acpi_ec_put_query_handler(struct acpi_ec_query_handler *ha=
ndler);
+
 struct acpi_ec *boot_ec, *first_ec;
 EXPORT_SYMBOL(first_ec);
=20
@@ -619,6 +624,27 @@ static int acpi_ec_query_unlocked(struct acpi_ec *=
ec, u8 *data)
 /* -------------------------------------------------------------------=
-------
                                 Event Management
    -------------------------------------------------------------------=
------- */
+static struct acpi_ec_query_handler *
+acpi_ec_get_query_handler(struct acpi_ec_query_handler *handler)
+{
+	if (handler)
+		kref_get(&handler->kref);
+	return handler;
+}
+
+static void acpi_ec_query_handler_release(struct kref *kref)
+{
+	struct acpi_ec_query_handler *handler =3D
+		container_of(kref, struct acpi_ec_query_handler, kref);
+
+	kfree(handler);
+}
+
+static void acpi_ec_put_query_handler(struct acpi_ec_query_handler *ha=
ndler)
+{
+	kref_put(&handler->kref, acpi_ec_query_handler_release);
+}
+
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data)
@@ -634,6 +660,7 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u=
8 query_bit,
 	handler->func =3D func;
 	handler->data =3D data;
 	mutex_lock(&ec->mutex);
+	kref_init(&handler->kref);
 	list_add(&handler->node, &ec->list);
 	mutex_unlock(&ec->mutex);
 	return 0;
@@ -643,15 +670,18 @@ EXPORT_SYMBOL_GPL(acpi_ec_add_query_handler);
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	struct acpi_ec_query_handler *handler, *tmp;
+	LIST_HEAD(free_list);
=20
 	mutex_lock(&ec->mutex);
 	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
 		if (query_bit =3D=3D handler->query_bit) {
-			list_del(&handler->node);
-			kfree(handler);
+			list_del_init(&handler->node);
+			list_add(&handler->node, &free_list);
 		}
 	}
 	mutex_unlock(&ec->mutex);
+	list_for_each_entry(handler, &free_list, node)
+		acpi_ec_put_query_handler(handler);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
=20
@@ -667,14 +697,14 @@ static void acpi_ec_run(void *cxt)
 	else if (handler->handle)
 		acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
 	pr_debug("##### Query(0x%02x) stopped #####\n", handler->query_bit);
-	kfree(handler);
+	acpi_ec_put_query_handler(handler);
 }
=20
 static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data)
 {
 	u8 value =3D 0;
 	int status;
-	struct acpi_ec_query_handler *handler, *copy;
+	struct acpi_ec_query_handler *handler;
=20
 	status =3D acpi_ec_query_unlocked(ec, &value);
 	if (data)
@@ -685,15 +715,12 @@ static int acpi_ec_sync_query(struct acpi_ec *ec,=
 u8 *data)
 	list_for_each_entry(handler, &ec->list, node) {
 		if (value =3D=3D handler->query_bit) {
 			/* have custom handler for this bit */
-			copy =3D kmalloc(sizeof(*handler), GFP_KERNEL);
-			if (!copy)
-				return -ENOMEM;
-			memcpy(copy, handler, sizeof(*copy));
+			handler =3D acpi_ec_get_query_handler(handler);
 			pr_debug("##### Query(0x%02x) scheduled #####\n",
 				 handler->query_bit);
-			return acpi_os_execute((copy->func) ?
+			return acpi_os_execute((handler->func) ?
 				OSL_NOTIFY_HANDLER : OSL_GPE_HANDLER,
-				acpi_ec_run, copy);
+				acpi_ec_run, handler);
 		}
 	}
 	return 0;
--=20
1.7.10
