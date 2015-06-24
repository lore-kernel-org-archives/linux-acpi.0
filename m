From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] acpi/video: Inline acpi_video_set_dmi_backlight_type
Date: Wed, 24 Jun 2015 12:01:49 +0200
Message-ID: <1435140109-2241-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40915 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbbFXKCB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2015 06:02:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org

=46rom: Borislav Petkov <bp@suse.de>

=2E.. and kill this:

  In file included from drivers/gpu/drm/radeon/radeon_acpi.c:29:0:
  include/acpi/video.h:46:13: warning: =E2=80=98acpi_video_set_dmi_back=
light_type=E2=80=99 defined but not used [-Wunused-function]
   static void acpi_video_set_dmi_backlight_type(enum acpi_backlight_ty=
pe type)
               ^

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org
Cc: devel@acpica.org
Cc: linux-kernel@vger.kernel.org
---
 include/acpi/video.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/video.h b/include/acpi/video.h
index a7d7f1043e9c..e840b294c6f5 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -43,7 +43,7 @@ static inline enum acpi_backlight_type acpi_video_get=
_backlight_type(void)
 {
 	return acpi_backlight_vendor;
 }
-static void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type=
 type)
+static inline void acpi_video_set_dmi_backlight_type(enum acpi_backlig=
ht_type type)
 {
 }
 #endif
--=20
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
