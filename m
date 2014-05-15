From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/4] Add backlight registration notification and use it in acpi-video
Date: Thu, 15 May 2014 20:34:22 +0200
Message-ID: <1400178866-3659-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10402 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755090AbaEOSes (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2014 14:34:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi all,

Here is a patch series to make video.use_native_backlight work on laptops
with nv gfx, at least on those were nv gfx have a raw backlight interface.

I've tried this on my own somewhat old nv equipped laptop, but that does
not have a raw backlight interface.

I'm currently doing a scratch build of the Fedora-20 kernel with this patches
for the user with an affected system to test.

Regards,

Hans
