From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v6 10/11] x86/intel/lpss: Make PCI dependency explicit
Date: Sat,  5 Jan 2019 10:06:05 +0000
Message-ID: <20190105100606.6673-11-okaya@kernel.org>
References: <20190105100606.6673-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105100606.6673-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, "open list:X86 ARCHITECTURE 32-BIT AND
        64-BIT" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly. LPSS code relies on PCI infrastructure but this
dependency has not been explicitly called out.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a1ce34864eaf..d9b6a015d037 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -618,7 +618,7 @@ config X86_INTEL_QUARK
 
 config X86_INTEL_LPSS
 	bool "Intel Low Power Subsystem Support"
-	depends on X86 && ACPI
+	depends on X86 && ACPI && PCI
 	select COMMON_CLK
 	select PINCTRL
 	select IOSF_MBI
-- 
2.19.0
