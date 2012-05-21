From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/3] gma500: Fix Poulsbo suspend/resume crash on devices with
 SDVO ports
Date: Mon, 21 May 2012 15:27:44 +0100
Message-ID: <20120521142740.18168.59650.stgit@bluebook>
References: <20120521142145.18168.28248.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53258 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab2EUN17 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 May 2012 09:27:59 -0400
In-Reply-To: <20120521142145.18168.28248.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

=46rom: Alan Cox <alan@linux.intel.com>

Reported-by: Guillaume Cl=C3=A9ment <guillaume@baobob.org>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Cc: <stable@kernel.org>
---

 drivers/gpu/drm/gma500/psb_device.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_device.c b/drivers/gpu/drm/gma5=
00/psb_device.c
index 2a3e2da..eff039b 100644
--- a/drivers/gpu/drm/gma500/psb_device.c
+++ b/drivers/gpu/drm/gma500/psb_device.c
@@ -197,7 +197,8 @@ static int psb_save_display_registers(struct drm_de=
vice *dev)
 	}
=20
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head=
)
-		connector->funcs->save(connector);
+		if (connector->funcs->save)
+			connector->funcs->save(connector);
=20
 	mutex_unlock(&dev->mode_config.mutex);
 	return 0;
@@ -235,7 +236,8 @@ static int psb_restore_display_registers(struct drm=
_device *dev)
 			crtc->funcs->restore(crtc);
=20
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head=
)
-		connector->funcs->restore(connector);
+		if (connector->funcs->restore)
+			connector->funcs->restore(connector);
=20
 	mutex_unlock(&dev->mode_config.mutex);
 	return 0;

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
