From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/2] IPMI: Change link order
Date: Thu, 20 Sep 2012 17:46:13 -0400
Message-ID: <1348177573-7537-2-git-send-email-mjg@redhat.com>
References: <1348177573-7537-1-git-send-email-mjg@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348177573-7537-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yakui.zhao@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, cminyard@mvista.com, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

IPMI must be initialised before ACPI in order to ensure that any IPMI
services are available before ACPI driver initialisation attempts to use
any IPMI operation regions.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/Makefile      | 4 ++++
 drivers/char/Makefile | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 5b42184..c2b527a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -14,6 +14,10 @@ obj-$(CONFIG_PARISC)		+= parisc/
 obj-$(CONFIG_RAPIDIO)		+= rapidio/
 obj-y				+= video/
 obj-y				+= idle/
+
+# IPMI must come before ACPI in order to provide IPMI opregion support
+obj-$(CONFIG_IPMI_HANDLER)	+= char/ipmi
+
 obj-$(CONFIG_ACPI)		+= acpi/
 obj-$(CONFIG_SFI)		+= sfi/
 # PnP must come after ACPI since it will eventually need to check if acpi
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index d0b27a3..7ff1d0d 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_TELCLOCK)		+= tlclk.o
 obj-$(CONFIG_MWAVE)		+= mwave/
 obj-$(CONFIG_AGP)		+= agp/
 obj-$(CONFIG_PCMCIA)		+= pcmcia/
-obj-$(CONFIG_IPMI_HANDLER)	+= ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER)	+= hangcheck-timer.o
 obj-$(CONFIG_TCG_TPM)		+= tpm/
-- 
1.7.11.4
