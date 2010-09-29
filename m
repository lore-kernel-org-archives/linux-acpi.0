From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/16] ACPI: acpi_pad: simplify code to avoid false gcc build
 warning
Date: Tue, 28 Sep 2010 23:44:43 -0400
Message-ID: <872b72e97fb3a66044ccc45db627d010d5163c74.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:58382 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab0I2DyT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:54:19 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00JMZPI2KR79@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:54:07 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Len Brown <len.browns@intel.com>

=46rom: Len Brown <len.brown@intel.com>

acpi_pad.c:432: warning: =E2=80=98num_cpus=E2=80=99 may be used uniniti=
alized in this function

gcc 4.4.4 was unable to notice that num_cpus is always set.
Re-arrange the code to un-confuse gcc, and also make
it easier for humans to read....

Signed-off-by: Len Brown <len.browns@intel.com>
---
 drivers/acpi/acpi_pad.c |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index b76848c..6b115f6 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -382,31 +382,32 @@ static void acpi_pad_remove_sysfs(struct acpi_dev=
ice *device)
 	device_remove_file(&device->dev, &dev_attr_rrtime);
 }
=20
-/* Query firmware how many CPUs should be idle */
-static int acpi_pad_pur(acpi_handle handle, int *num_cpus)
+/*
+ * Query firmware how many CPUs should be idle
+ * return -1 on failure
+ */
+static int acpi_pad_pur(acpi_handle handle)
 {
 	struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *package;
-	int rev, num, ret =3D -EINVAL;
+	int num =3D -1;
=20
 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_PUR", NULL, &buffer))=
)
-		return -EINVAL;
+		return num;
=20
 	if (!buffer.length || !buffer.pointer)
-		return -EINVAL;
+		return num;
=20
 	package =3D buffer.pointer;
-	if (package->type !=3D ACPI_TYPE_PACKAGE || package->package.count !=3D=
 2)
-		goto out;
-	rev =3D package->package.elements[0].integer.value;
-	num =3D package->package.elements[1].integer.value;
-	if (rev !=3D 1 || num < 0)
-		goto out;
-	*num_cpus =3D num;
-	ret =3D 0;
-out:
+
+	if (package->type =3D=3D ACPI_TYPE_PACKAGE &&
+		package->package.count =3D=3D 2 &&
+		package->package.elements[0].integer.value =3D=3D 1) /* rev 1 */
+
+		num =3D package->package.elements[1].integer.value;
+
 	kfree(buffer.pointer);
-	return ret;
+	return num;
 }
=20
 /* Notify firmware how many CPUs are idle */
@@ -433,7 +434,8 @@ static void acpi_pad_handle_notify(acpi_handle hand=
le)
 	uint32_t idle_cpus;
=20
 	mutex_lock(&isolated_cpus_lock);
-	if (acpi_pad_pur(handle, &num_cpus)) {
+	num_cpus =3D acpi_pad_pur(handle);
+	if (num_cpus < 0) {
 		mutex_unlock(&isolated_cpus_lock);
 		return;
 	}
--=20
1.7.3.2.g9027fa

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
