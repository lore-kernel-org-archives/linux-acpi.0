From: Sinan Kaya <okaya@kernel.org>
Subject: [for next][PATCH 2/2] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI is enabled
Date: Mon, 21 Jan 2019 23:19:58 +0000
Message-ID: <20190121231958.28255-2-okaya@kernel.org>
References: <20190121231958.28255-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121231958.28255-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, "open list:X86 ARCHITECTURE 32-BIT AND
        64-BIT" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly.

PCI_LOCKLESS_CONFIG depends on PCI but this dependency has not been
mentioned in the Kconfig.

Add an explicit dependency here.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 568f339595ed..0519da6f8ee4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -199,7 +199,7 @@ config X86
 	select IRQ_FORCED_THREADING
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
-	select PCI_LOCKLESS_CONFIG
+	select PCI_LOCKLESS_CONFIG		if PCI
 	select PERF_EVENTS
 	select RTC_LIB
 	select RTC_MC146818_LIB
-- 
2.19.0
