From: Len Brown <lenb@kernel.org>
Subject: [PATCH 40/60] ACPI dock: move some functions to .init.text
Date: Mon, 25 Oct 2010 02:20:48 -0400
Message-ID: <d38a5edf812c2f715242aa20b6beb785939a0096.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab0JYHLK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:10 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:08 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Len Brown <len.brown@intel.com>

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

find_dock and find_bay are only called by dock_init which lives in
=2Einit.text dock_add is only called by find_dock and find_bay.  So all
three functions can be moved to .init.text, too.

This fixes:

        WARNING: vmlinux.o(.text+0x2134b7): Section mismatch in referen=
ce from the function dock_add() to the function .init.text:platform_dev=
ice_register_resndata()
        The function dock_add() references
        the function __init platform_device_register_resndata().
        This is often because dock_add lacks a __init
        annotation or the annotation of platform_device_register_resnda=
ta is wrong.

for a build with unset CONFIG_MODULES.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 3fe29e9..2b16563 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -929,7 +929,7 @@ static struct attribute_group dock_attribute_group =
=3D {
  * allocated and initialize a new dock station device.  Find all devic=
es
  * that are on the dock station, and register for dock event notificat=
ions.
  */
-static int dock_add(acpi_handle handle)
+static int __init dock_add(acpi_handle handle)
 {
 	int ret, id;
 	struct dock_station ds, *dock_station;
@@ -1023,7 +1023,7 @@ static int dock_remove(struct dock_station *ds)
  *
  * This is called by acpi_walk_namespace to look for dock stations.
  */
-static acpi_status
+static __init acpi_status
 find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	if (is_dock(handle))
@@ -1032,7 +1032,7 @@ find_dock(acpi_handle handle, u32 lvl, void *cont=
ext, void **rv)
 	return AE_OK;
 }
=20
-static acpi_status
+static __init acpi_status
 find_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	/* If bay is a dock, it's already handled */
--=20
1.7.3.2.90.gd4c43

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
