From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/11] ACPI, PCI: Change PREFIX to "PCI" from "ACPI" in
 mmconfig-shared.c
Date: Fri, 14 Aug 2009 16:38:06 -0400
Message-ID: <97512a9e5460234eabf1aa35db782e670ba3b830.1250281826.git.len.brown@intel.com>
References: <1250282295-25216-1-git-send-email-lenb@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753625AbZHNUky@vger.kernel.org>
In-reply-to: <1250282295-25216-1-git-send-email-lenb@kernel.org>
In-reply-to: <0763223ab0ef5c0016b7a179c1acccaabbefea02.1250281826.git.len.brown@intel.com>
References: <0763223ab0ef5c0016b7a179c1acccaabbefea02.1250281826.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 arch/x86/pci/mmconfig-shared.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 81d3466..b707a01 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -18,7 +18,7 @@
 #include <asm/e820.h>
 #include <asm/pci_x86.h>
 
-#define PREFIX "ACPI: "
+#define PREFIX "PCI: "
 
 /* aperture is up to 256MB but BIOS may reserve less */
 #define MMCONFIG_APER_MIN	(2 * 1024*1024)
-- 
1.6.0.6
