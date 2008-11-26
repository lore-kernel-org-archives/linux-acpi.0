From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 5/8] acpi: system.c: use new acpi_get_gpe_device interface
Date: Wed, 26 Nov 2008 10:55:28 +0800
Message-ID: <1227668128.7702.95.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34804 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbYKZDAt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2008 22:00:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

=EF=BB=BF=EF=BB=BFacpi_get_gpe_device maps an input GPE index to a GPE =
block device.
Also added acpi_current_gpe_count to track the current number of GPEs t=
hat
are being managed by the ACPICA core (both FADT-based GPEs and the GPEs
contained in GPE block devices.)

See http://git.acpica.org/repos/?p=3Dacpica.git;a=3Dcommitdiff;h=3D320b=
444e76ae352ac4fe45dc83f56e7e23cc1c89=20

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/system.c |   63 +----------------------------------------=
-------
 1 files changed, 2 insertions(+), 61 deletions(-)

diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 6e4107f..391d035 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -192,65 +192,6 @@ static struct attribute_group interrupt_stats_attr=
_group =3D {
 };
 static struct kobj_attribute *counter_attrs;
=20
-static int count_num_gpes(void)
-{
-	int count =3D 0;
-	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
-	struct acpi_gpe_block_info *gpe_block;
-	acpi_cpu_flags flags;
-
-	flags =3D acpi_os_acquire_lock(acpi_gbl_gpe_lock);
-
-	gpe_xrupt_info =3D acpi_gbl_gpe_xrupt_list_head;
-	while (gpe_xrupt_info) {
-		gpe_block =3D gpe_xrupt_info->gpe_block_list_head;
-		while (gpe_block) {
-			count +=3D gpe_block->register_count *
-			    ACPI_GPE_REGISTER_WIDTH;
-			gpe_block =3D gpe_block->next;
-		}
-		gpe_xrupt_info =3D gpe_xrupt_info->next;
-	}
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-
-	return count;
-}
-
-static int get_gpe_device(int index, acpi_handle *handle)
-{
-	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
-	struct acpi_gpe_block_info *gpe_block;
-	acpi_cpu_flags flags;
-	struct acpi_namespace_node *node;
-
-	flags =3D acpi_os_acquire_lock(acpi_gbl_gpe_lock);
-
-	gpe_xrupt_info =3D acpi_gbl_gpe_xrupt_list_head;
-	while (gpe_xrupt_info) {
-		gpe_block =3D gpe_xrupt_info->gpe_block_list_head;
-		node =3D gpe_block->node;
-		while (gpe_block) {
-			index -=3D gpe_block->register_count *
-			    ACPI_GPE_REGISTER_WIDTH;
-			if (index < 0) {
-				acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-				/* return NULL if it's FADT GPE */
-				if (node->type !=3D ACPI_TYPE_DEVICE)
-					*handle =3D NULL;
-				else
-					*handle =3D node;
-				return 0;
-			}
-			node =3D gpe_block->node;
-			gpe_block =3D gpe_block->next;
-		}
-		gpe_xrupt_info =3D gpe_xrupt_info->next;
-	}
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-
-	return -ENODEV;
-}
-
 static void delete_gpe_attr_array(void)
 {
 	struct event_counter *tmp =3D all_counters;
@@ -309,7 +250,7 @@ static int get_status(u32 index, acpi_event_status =
*status, acpi_handle *handle)
 		goto end;
=20
 	if (index < num_gpes) {
-		result =3D get_gpe_device(index, handle);
+		result =3D acpi_get_gpe_device(index, handle);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
 				"Invalid GPE 0x%x\n", index));
@@ -436,7 +377,7 @@ void acpi_irq_stats_init(void)
 	if (all_counters)
 		return;
=20
-	num_gpes =3D count_num_gpes();
+	num_gpes =3D acpi_current_gpe_count;
 	num_counters =3D num_gpes + ACPI_NUM_FIXED_EVENTS + NUM_COUNTERS_EXTR=
A;
=20
 	all_attrs =3D kzalloc(sizeof(struct attribute *) * (num_counters + 1)=
,


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
