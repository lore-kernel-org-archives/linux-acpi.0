From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] intel_menlow:  don't set max_state a negative value
Date: Thu, 11 Sep 2008 10:56:00 +0800
Message-ID: <1221101760.3441.100.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49686 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186AbYIKC4P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2008 22:56:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, roel.kluin@gmail.com, sujith.thomas@intel.com

max_state is unsigned long.
don't set max_state a negative value

=EF=BB=BFCc : Thomas Sujith <sujith.thomas@intel.com>
Cc : Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/misc/intel_menlow.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/misc/intel_menlow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/misc/intel_menlow.c	2008-07-29 09:32:11.0000=
00000 +0800
+++ linux-2.6/drivers/misc/intel_menlow.c	2008-09-11 09:17:48.000000000=
 +0800
@@ -71,6 +71,9 @@
 	if (ACPI_FAILURE(status))
 		return -EFAULT;
=20
+	if (!value)
+		return -EINVAL;
+
 	*max_state =3D value - 1;
 	return 0;
 }
@@ -121,7 +124,7 @@
 	if (memory_get_int_max_bandwidth(cdev, &max_state))
 		return -EFAULT;
=20
-	if (max_state < 0 || state > max_state)
+	if (state > max_state)
 		return -EINVAL;
=20
 	arg_list.count =3D 1;


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
