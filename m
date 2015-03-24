From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [patch v11 19/23] XEN / ACPI: Make XEN ACPI depend on X86
Date: Tue, 24 Mar 2015 22:02:52 +0800
Message-ID: <1427205776-5060-20-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, 'Stefano Stabellini' <stefano.stabellini@eu.citrix.com>, Julien Grall <julien.grall@linaro.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Vrabel <david.vrabel@c>
List-Id: linux-acpi@vger.kernel.org

When ACPI is enabled on ARM64, XEN ACPI will also compiled
into the kernel, but XEN ACPI is x86 dependent, so introduce
CONFIG_XEN_ACPI to make it depend on x86 before XEN ACPI is
functional on ARM64.

CC: 'Stefano Stabellini' <stefano.stabellini@eu.citrix.com>
CC: Julien Grall <julien.grall@linaro.org>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/xen/Kconfig  | 4 ++++
 drivers/xen/Makefile | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index b812462..a31cd29 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -253,4 +253,8 @@ config XEN_EFI
 	def_bool y
 	depends on X86_64 && EFI
 
+config XEN_ACPI
+	def_bool y
+	depends on X86 && ACPI
+
 endmenu
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 2ccd359..f4622ab 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -13,7 +13,7 @@ CFLAGS_efi.o				+= -fshort-wchar
 
 dom0-$(CONFIG_PCI) += pci.o
 dom0-$(CONFIG_USB_SUPPORT) += dbgp.o
-dom0-$(CONFIG_ACPI) += acpi.o $(xen-pad-y)
+dom0-$(CONFIG_XEN_ACPI) += acpi.o $(xen-pad-y)
 xen-pad-$(CONFIG_X86) += xen-acpi-pad.o
 dom0-$(CONFIG_X86) += pcpu.o
 obj-$(CONFIG_XEN_DOM0)			+= $(dom0-y)
-- 
1.9.1
