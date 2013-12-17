From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 09/11] drivers: acpi: Remove unused function in ec.c and add
 prototype declaration in header file internal.h
Date: Tue, 17 Dec 2013 15:02:14 +0530
Message-ID: <5cb8c4062f65223dbde9e595af87bea0fc690b85.1387271324.git.rashika.kheria@gmail.com>
References: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, josh@joshtriplett.org
List-Id: linux-acpi@vger.kernel.org

Adds the prototype declarations of functions acpi_ec_add_query_handler(=
)
and acpi_ec_remove_query_handler() in header file internal.h and remove=
s
unused functions ec_burst_enable() and ec_burst_disable() in ec.c.

This eliminates the following warnings in ec.c:
drivers/acpi/ec.c:393:5: warning: no previous prototype for =E2=80=98ec=
_burst_enable=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/ec.c:402:5: warning: no previous prototype for =E2=80=98ec=
_burst_disable=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/ec.c:531:5: warning: no previous prototype for =E2=80=98ac=
pi_ec_add_query_handler=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/ec.c:552:6: warning: no previous prototype for =E2=80=98ac=
pi_ec_remove_query_handler=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/ec.c       |   25 -------------------------
 drivers/acpi/internal.h |    9 +++++++++
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ba5b56d..5391e02 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -91,10 +91,6 @@ static unsigned int ec_storm_threshold  __read_mostl=
y =3D 8;
 module_param(ec_storm_threshold, uint, 0644);
 MODULE_PARM_DESC(ec_storm_threshold, "Maxim false GPE numbers not cons=
idered as GPE storm");
=20
-/* If we find an EC via the ECDT, we need to keep a ptr to its context=
 */
-/* External interfaces use first EC only, so remember */
-typedef int (*acpi_ec_query_func) (void *data);
-
 struct acpi_ec_query_handler {
 	struct list_head node;
 	acpi_ec_query_func func;
@@ -387,27 +383,6 @@ static int acpi_ec_write(struct acpi_ec *ec, u8 ad=
dress, u8 data)
 	return acpi_ec_transaction(ec, &t);
 }
=20
-/*
- * Externally callable EC access functions. For now, assume 1 EC only
- */
-int ec_burst_enable(void)
-{
-	if (!first_ec)
-		return -ENODEV;
-	return acpi_ec_burst_enable(first_ec);
-}
-
-EXPORT_SYMBOL(ec_burst_enable);
-
-int ec_burst_disable(void)
-{
-	if (!first_ec)
-		return -ENODEV;
-	return acpi_ec_burst_disable(first_ec);
-}
-
-EXPORT_SYMBOL(ec_burst_disable);
-
 int ec_read(u8 addr, u8 *val)
 {
 	int err;
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index a29739c..8ef9787 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -127,12 +127,21 @@ struct acpi_ec {
=20
 extern struct acpi_ec *first_ec;
=20
+/* If we find an EC via the ECDT, we need to keep a ptr to its context=
 */
+/* External interfaces use first EC only, so remember */
+typedef int (*acpi_ec_query_func) (void *data);
+
 int acpi_ec_init(void);
 int acpi_ec_ecdt_probe(void);
 int acpi_boot_ec_enable(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
 void acpi_ec_unblock_transactions_early(void);
+int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
+			      acpi_handle handle, acpi_ec_query_func func,
+			      void *data);
+void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
+
=20
 /*--------------------------------------------------------------------=
------
                                   Suspend/Resume
--=20
1.7.9.5
