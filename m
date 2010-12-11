From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/15] ACPI: video: fix build for CONFIG_ACPI=n
Date: Sat, 11 Dec 2010 02:06:34 -0500
Message-ID: <b72512ed706efb26087fcbbc5f98ed64ac1230d5.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56977 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab0LKHHO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:07:14 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD90060953ZNVB2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:07:14 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Len Brown <len.brown@intel.com>

=46rom: Chris Wilson <chris@chris-wilson.co.uk>

In file included from drivers/gpu/drm/i915/intel_opregion.c:30:
include/acpi/video.h:22: warning: =E2=80=98struct acpi_device=E2=80=99 =
declared inside parameter list
=2E..
include/acpi/video.h:24: error: =E2=80=98ENODEV=E2=80=99 undeclared (fi=
rst use in this function)

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/video.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/include/acpi/video.h b/include/acpi/video.h
index 551793c..0e98e67 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -1,6 +1,10 @@
 #ifndef __ACPI_VIDEO_H
 #define __ACPI_VIDEO_H
=20
+#include <linux/errno.h> /* for ENODEV */
+
+struct acpi_device;
+
 #define ACPI_VIDEO_DISPLAY_CRT  1
 #define ACPI_VIDEO_DISPLAY_TV   2
 #define ACPI_VIDEO_DISPLAY_DVI  3
@@ -26,4 +30,3 @@ static inline int acpi_video_get_edid(struct acpi_dev=
ice *device, int type,
 #endif
=20
 #endif
-
--=20
1.7.3.3.480.g2f76a

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
