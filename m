From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Tue, 03 Feb 2015 12:29:36 -0500
Message-ID: <1422984576.18187.82.camel@deneb.redhat.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
	 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
	 <2422968.Es7R0p3loO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48193 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbbBCRbH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Feb 2015 12:31:07 -0500
In-Reply-To: <2422968.Es7R0p3loO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.comMark

On Mon, 2015-02-02 at 23:14 +0100, Rafael J. Wysocki wrote:
> On Monday, February 02, 2015 08:45:30 PM Hanjun Guo wrote:
> > From: Mark Salter <msalter@redhat.com>
> > 
> > The acpi_os_ioremap() function may be used to map normal RAM or IO
> > regions. The current implementation simply uses ioremap_cache(). This
> > will work for some architectures, but arm64 ioremap_cache() cannot be
> > used to map IO regions which don't support caching. So for arm64, use
> > ioremap() for non-RAM regions.
> > 
> > CC: Rafael J Wysocki <rjw@rjwysocki.net>
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > ---
> >  include/acpi/acpi_io.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> > index 444671e..9d573db 100644
> > --- a/include/acpi/acpi_io.h
> > +++ b/include/acpi/acpi_io.h
> > @@ -1,11 +1,17 @@
> >  #ifndef _ACPI_IO_H_
> >  #define _ACPI_IO_H_
> >  
> > +#include <linux/mm.h>
> >  #include <linux/io.h>
> >  
> >  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> >  					    acpi_size size)
> >  {
> > +#ifdef CONFIG_ARM64
> > +	if (!page_is_ram(phys >> PAGE_SHIFT))
> > +		return ioremap(phys, size);
> > +#endif
> 
> I don't want to see #ifdef CONFIG_ARM64 in this file.
> 

How about something like:

From: Mark Salter <msalter@redhat.com>
Date: Tue, 3 Feb 2015 10:51:16 -0500
Subject: [PATCH] acpi: fix acpi_os_ioremap for arm64

The acpi_os_ioremap() function may be used to map normal RAM or IO
regions. The current implementation simply uses ioremap_cache(). This
will work for some architectures, but arm64 ioremap_cache() cannot be
used to map IO regions which don't support caching. So for arm64, use
ioremap() for non-RAM regions.

CC: Rafael J Wysocki <rjw@rjwysocki.net>
Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/include/asm/acpi.h | 14 ++++++++++++++
 include/acpi/acpi_io.h        |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index ea4d2b3..db82bc3 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -14,6 +14,7 @@
 
 #include <linux/irqchip/arm-gic-acpi.h>
 
+#include <linux/mm.h>
 #include <asm/smp_plat.h>
 
 /* Basic configuration for ACPI */
@@ -100,4 +101,17 @@ static inline bool acpi_psci_use_hvc(void) { return false; }
 static inline void acpi_init_cpus(void) { }
 #endif /* CONFIG_ACPI */
 
+/*
+ * ACPI table mapping
+ */
+static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
+					    acpi_size size)
+{
+	if (!page_is_ram(phys >> PAGE_SHIFT))
+		return ioremap(phys, size);
+
+       return ioremap_cache(phys, size);
+}
+#define acpi_os_ioremap acpi_os_ioremap
+
 #endif /*_ASM_ACPI_H*/
diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
index 444671e..48f504a 100644
--- a/include/acpi/acpi_io.h
+++ b/include/acpi/acpi_io.h
@@ -2,12 +2,15 @@
 #define _ACPI_IO_H_
 
 #include <linux/io.h>
+#include <asm/acpi.h>
 
+#ifndef acpi_os_ioremap
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 					    acpi_size size)
 {
        return ioremap_cache(phys, size);
 }
+#endif
 
 void __iomem *__init_refok
 acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
-- 
1.8.3.1



