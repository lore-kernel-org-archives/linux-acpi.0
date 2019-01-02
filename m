From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v5 05/11] platform/x86: intel_pmc: Make PCI dependency explicit
Date: Wed,  2 Jan 2019 18:10:32 +0000
Message-ID: <20190102181038.4418-6-okaya@kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102181038.4418-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly. Code relies on PCI for execution. Specify this
in the Kconfig.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b36ea14b41ad..7afb96cb1cd6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1174,7 +1174,7 @@ config INTEL_SMARTCONNECT
 
 config INTEL_PMC_IPC
 	tristate "Intel PMC IPC Driver"
-	depends on ACPI
+	depends on ACPI && PCI
 	---help---
 	This driver provides support for PMC control on some Intel platforms.
 	The PMC is an ARC processor which defines IPC commands for communication
-- 
2.19.0
