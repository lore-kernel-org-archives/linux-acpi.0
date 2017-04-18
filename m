From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 2/3] ACPI / bus: Add INT0002 to list of always-present devices
Date: Tue, 18 Apr 2017 13:54:24 +0200
Message-ID: <20170418115425.16068-2-hdegoede@redhat.com>
References: <20170418115425.16068-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752384AbdDRLyc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 07:54:32 -0400
In-Reply-To: <20170418115425.16068-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

The INT0002 device is necessary to clear wakeup interrupt sources
on Cherry Trail devices, without it we get nobody cared IRQ msgs
and some systems don't properly resume at all without it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v6:
-This is a new patch in v6 of this patch-set
---
 drivers/acpi/bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index eb30630..6fa177c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -167,6 +167,11 @@ static const struct always_present_device_id always_present_device_ids[] = {
 	 * but Linux uses a separate PWM driver, harmless if not used.
 	 */
 	ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT)),
+	/*
+	 * The INT0002 device is necessary to clear wakeup interrupt sources
+	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
+	 */
+	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT)),
 };
 #endif
 
-- 
2.9.3

