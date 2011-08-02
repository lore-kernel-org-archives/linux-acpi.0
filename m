From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/19] APEI GHES: 32-bit buildfix
Date: Tue, 02 Aug 2011 18:14:51 -0400
Message-ID: <2c39c2e0b2d8414cfd8b9067ed1c3aac4ed303c1.1312323131.git.len.brown@intel.com>
References: <1312323292-2986-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:41638 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab1HBWvy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 18:51:54 -0400
In-reply-to: <1312323292-2986-1-git-send-email-lenb@kernel.org>
In-reply-to: <ca7cc5110a313a609da40ae948978a585352564b.1312323131.git.len.brown@intel.com>
References: <ca7cc5110a313a609da40ae948978a585352564b.1312323131.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

drivers/acpi/apei/ghes.c:542: warning: integer overflow in expression
drivers/acpi/apei/ghes.c:619: warning: integer overflow in expression

ghes.c:(.text+0x46289): undefined reference to `__udivdi3'
=C2=A0 in function ghes_estatus_cache_add().

Reported-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/ghes.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e92c47c..0784f99 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -65,7 +65,7 @@
=20
 #define GHES_ESTATUS_CACHES_SIZE	4
=20
-#define GHES_ESTATUS_IN_CACHE_MAX_NSEC	(10 * NSEC_PER_SEC)
+#define GHES_ESTATUS_IN_CACHE_MAX_NSEC	10000000000ULL
 /* Prevent too many caches are allocated because of RCU */
 #define GHES_ESTATUS_CACHE_ALLOCED_MAX	(GHES_ESTATUS_CACHES_SIZE * 3 /=
 2)
=20
@@ -622,7 +622,8 @@ static void ghes_estatus_cache_add(
 			break;
 		}
 		count =3D atomic_read(&cache->count);
-		period =3D duration / (count + 1);
+		period =3D duration;
+		do_div(period, (count + 1));
 		if (period > max_period) {
 			max_period =3D period;
 			slot =3D i;
--=20
1.7.6.396.ge0613

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
