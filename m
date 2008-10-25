From: Len Brown <lenb@kernel.org>
Subject: [PATCH 9/9] leds-hp-disk: fix build warning
Date: Sat, 25 Oct 2008 04:13:39 -0400
Message-ID: <438f8de46bc261b35d84771ae9992cfff3ff4dd8.1224922389.git.len.brown@intel.com>
References: <1224922419-7823-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33171 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbYJYINq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 04:13:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9A0064GC6X6Q42@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 25 Oct 2008 03:13:46 -0500 (CDT)
In-reply-to: <1224922419-7823-1-git-send-email-lenb@kernel.org>
In-reply-to: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
References: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

drivers/leds/leds-hp-disk.c:59: warning: passing argument 4 of =E2=80=98=
acpi_evaluate_integer=E2=80=99 from incompatible pointer type

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/leds/leds-hp-disk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/leds/leds-hp-disk.c b/drivers/leds/leds-hp-disk.c
index 53a25b1..74645ab 100644
--- a/drivers/leds/leds-hp-disk.c
+++ b/drivers/leds/leds-hp-disk.c
@@ -49,7 +49,7 @@ static struct acpi_hpled adev;
=20
 static acpi_status hpled_acpi_write(acpi_handle handle, int reg)
 {
-	unsigned long ret; /* Not used when writing */
+	unsigned long long ret; /* Not used when writing */
 	union acpi_object in_obj[1];
 	struct acpi_object_list args =3D { 1, in_obj };
=20
--=20
1.5.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
