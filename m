From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 3/3] ACPI / bus: Add Bay Trail PWM controller to list of always-present devices
Date: Tue, 18 Apr 2017 13:54:25 +0200
Message-ID: <20170418115425.16068-3-hdegoede@redhat.com>
References: <20170418115425.16068-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752384AbdDRLyg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 07:54:36 -0400
In-Reply-To: <20170418115425.16068-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

Just like on Cherry Trail, on some Bay Trail Windows 10 tablets we
need to enable the PWM controller to get working backlight even
though _STA returns 0.

Add an entry for the the Bay Trail PWM controller to list of
always-present devices to fix backlight control not working on
some Bay Trail devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v6:
-This is a new patch in v6 of this patch-set
---
 drivers/acpi/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 6fa177c..5f9fe3f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -163,9 +163,10 @@ struct always_present_device_id {
 
 static const struct always_present_device_id always_present_device_ids[] = {
 	/*
-	 * Cherry Trail PWM directly poked by GPU driver in win10,
+	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
 	 * but Linux uses a separate PWM driver, harmless if not used.
 	 */
+	ENTRY("80860F09", "1", ICPU(INTEL_FAM6_ATOM_SILVERMONT1)),
 	ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT)),
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
-- 
2.9.3

