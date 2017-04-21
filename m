From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v8 2/2] ACPI / bus: Add INT0002 to list of always-present devices
Date: Fri, 21 Apr 2017 12:47:41 +0200
Message-ID: <20170421104741.17185-2-hdegoede@redhat.com>
References: <20170421104741.17185-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1037976AbdDUKrv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Apr 2017 06:47:51 -0400
In-Reply-To: <20170421104741.17185-1-hdegoede@redhat.com>
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
Changes in v7:
-Adjust for the always present devices table being moved to
 drivers/acpi/x86/x86_utils.c
---
 drivers/acpi/x86/x86_utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/x86/x86_utils.c b/drivers/acpi/x86/x86_utils.c
index 74f1237..98d875a 100644
--- a/drivers/acpi/x86/x86_utils.c
+++ b/drivers/acpi/x86/x86_utils.c
@@ -49,6 +49,11 @@ static const struct always_present_id always_present_ids[] = {
 	 */
 	ENTRY("80860F09", "1", ICPU(INTEL_FAM6_ATOM_SILVERMONT1)),
 	ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT)),
+	/*
+	 * The INT0002 device is necessary to clear wakeup interrupt sources
+	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
+	 */
+	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT)),
 };
 
 bool acpi_device_always_present(struct acpi_device *adev)
-- 
2.9.3

