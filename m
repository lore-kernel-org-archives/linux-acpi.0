From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH resend] x86, olpc-xo15-sci: enable EC wakeup capability
Date: Sun, 24 Jul 2011 18:34:30 +0100 (BST)
Message-ID: <20110724173430.BE03C9D401C__5098.60817478529$1311530438$gmane$org@zog.reactivated.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, dilinger@queued.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Some recent changes to the way that ACPI handles wakeup flags means
that the XO15EC ACPI device is not wakeup-capable by default so
device_set_wakeup_enable() does nothing.

Use device_init_wakeup() to mark the device as wakeup capable, and to
enable wakeups.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index a5990eb..2b235b7 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -120,7 +120,7 @@ static int xo15_sci_add(struct acpi_device *device)
 
 	/* Enable wake-on-EC */
 	if (device->wakeup.flags.valid)
-		device_set_wakeup_enable(&device->dev, true);
+		device_init_wakeup(&device->dev, true);
 
 	return 0;
 }
-- 
1.7.6
