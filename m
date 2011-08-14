From: Kevin Winchester <kjwinchester@gmail.com>
Subject: [PATCH] acpi: Fix build warnings for missing const on register_hotplug_dock_device static inline version
Date: Sun, 14 Aug 2011 12:04:03 -0300
Message-ID: <1313334243-17765-1-git-send-email-kjwinchester@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36264 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab1HNPFl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Aug 2011 11:05:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Kevin Winchester <kjwinchester@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

    commit 9c8b04be443b33939f374a811c82abeebe0a61d1
    Author: Vasiliy Kulikov <segoon@openwall.com>
    Date:   Sat Jun 25 21:07:52 2011 +0400

        ACPI: constify ops structs

missed the static inline definition in include/acpi/acpi_drivers.h
for !CONFIG_ACPI_DOCK.  This leads to warnings from:

gcc (GCC) 4.6.1

such as:

drivers/ata/libata-acpi.c: In function =E2=80=98ata_acpi_associate=E2=80=
=99:
drivers/ata/libata-acpi.c:266:11: warning: passing argument 2 of =E2=80=
=98register_hotplug_dock_device=E2=80=99 discards =E2=80=98const=E2=80=99=
 qualifier from pointer target type [enabled by default]
include/acpi/acpi_drivers.h:146:19: note: expected =E2=80=98struct acpi=
_dock_ops *=E2=80=99 but argument is of type =E2=80=98const struct acpi=
_dock_ops *=E2=80=99
drivers/ata/libata-acpi.c:275:11: warning: passing argument 2 of =E2=80=
=98register_hotplug_dock_device=E2=80=99 discards =E2=80=98const=E2=80=99=
 qualifier from pointer target type [enabled by default]
include/acpi/acpi_drivers.h:146:19: note: expected =E2=80=98struct acpi=
_dock_ops *=E2=80=99 but argument is of type =E2=80=98const struct acpi=
_dock_ops *=E2=80=99

Signed-off-by: Kevin Winchester <kjwinchester@gmail.com>
---
 include/acpi/acpi_drivers.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index e49c36d..bb145e4 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -144,7 +144,7 @@ static inline void unregister_dock_notifier(struct =
notifier_block *nb)
 {
 }
 static inline int register_hotplug_dock_device(acpi_handle handle,
-					       struct acpi_dock_ops *ops,
+					       const struct acpi_dock_ops *ops,
 					       void *context)
 {
 	return -ENODEV;
--=20
1.7.6

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
