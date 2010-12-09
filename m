From: Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH 4/7] ideapad: select INPUT_SPARSEKMAP
Date: Thu,  9 Dec 2010 15:57:20 +0800
Message-ID: <1291881440-4846-1-git-send-email-ike.pan@canonical.com>
References: <1291881376-4729-1-git-send-email-ike.pan@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291881376-4729-1-git-send-email-ike.pan@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

Thanks for Dave Hansen report the problem. If CONFIG_INPUT_SPARSEKMAP is not
set, when building, you will have error message:

  ERROR: "sparse_keymap_setup" [drivers/platform/x86/ideapad-laptop.ko] undefined!
  ERROR: "sparse_keymap_free" [drivers/platform/x86/ideapad-laptop.ko] undefined!
  ERROR: "sparse_keymap_report_event" [drivers/platform/x86/ideapad-laptop.ko] undefined!

To select INPUT_SPARSEKMAP solve this issue.

Ref: http://lkml.org/lkml/2010/12/2/340

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
Signed-off-by: Ike Panhc <ike.pan@canonical.com>
---
 drivers/platform/x86/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index faec777..879d266 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -226,6 +226,7 @@ config IDEAPAD_LAPTOP
 	tristate "Lenovo IdeaPad Laptop Extras"
 	depends on ACPI
 	depends on RFKILL
+	select INPUT_SPARSEKMAP
 	help
 	  This is a driver for the rfkill switches on Lenovo IdeaPad netbooks.
 
-- 
1.7.1
