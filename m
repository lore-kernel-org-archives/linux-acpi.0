From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 0/4] Make video.use_native_backlight=1 work properly with nouveau
Date: Wed, 21 May 2014 15:39:52 +0200
Message-ID: <1400679596-19663-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbaEUORl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2014 10:17:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi All,

I know it has not been that long since the last send of this series, but
it has been very quiet, and I would like to see some discussion on it
(or it being applied at once, that is fine too :)

This patch-set adds backlight device (un)registration notification and
makes acpi-video listen to it, so that video.use_native_backlight=1 still
works if a raw interface gets loaded *after* acpi-video has been initialized.

It also changes nouveau to always register its raw interface, as all the other
kms drivers do, acpi_video_backlight_support() is only intended to avoid the
loading of multiple (possibly conflicting) firmware drivers, not to avoid
loading raw drivers.

In the mean time I've gotten feedback from a user with a laptop which needs
video.use_native_backlight=1 and uses nouveau, and he has confirmed that this
patch-set works as advertised, see:
https://bugzilla.redhat.com/show_bug.cgi?id=1093171

Regards,

Hans
