From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] ACPI / X86: Add Dell Venue 11 Pro 7130 touchscreen to always_present_ids
Date: Sun,  9 Jul 2017 21:05:13 +0200
Message-ID: <20170709190514.3437-2-hdegoede@redhat.com>
References: <20170709190514.3437-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752467AbdGITFT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 9 Jul 2017 15:05:19 -0400
In-Reply-To: <20170709190514.3437-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

The _STA method of the Venue 11 Pro 7130 touchscreen has this ugliness:

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((SDS1 & One) == One)
                    {
                        If (RST1 == Zero)
                        {
                            Return (0x0F)
                        }
                        ElseIf (RST2 == Zero)
                        {
                            RST2 = One
                            TMRV = Timer
                        }
                        Else
                        {
                            Local0 = ((Timer - TMRV) / 0x2710)
                            If (Local0 > TMRI)
                            {
                                RST2 = Zero
                                RST1 = Zero
                            }
                        }
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

Whereby RST1 gets set by _SB.PCI0.GFX0.LCD.LCD1._ON, this means that
after RST1 has been set first _STA must be called to set TIMER and
then after enough time has elapsed _STA must be called twice more, once
to clear RST1 and once to finally return 0xf before the touchscreen will
show up. Which is just crazy.

This commit adds an always_present_ids entry for the SYNA7500 touchscreen
ACPI node, together with a DMI match for the Venue 11 Pro 7130, fixing the
touchscreen not working on this device.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index b0e16516adfd..eb6caf6f708b 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -61,6 +61,15 @@ static const struct always_present_id always_present_ids[] = {
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
 	 */
 	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
+	/*
+	 * On the Dell Venue 11 Pro 7130 the DSDT hides the touchscreen ACPI
+	 * device until a certain time after _SB.PCI0.GFX0.LCD.LCD1._ON gets
+	 * called has passed *and* _STA has been called at least 3 times since.
+	 */
+	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
+	      }),
 };
 
 bool acpi_device_always_present(struct acpi_device *adev)
-- 
2.13.0

