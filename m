From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 18/20] clocksource / acpi: Add macro CLOCKSOURCE_ACPI_DECLARE
Date: Fri, 17 Jan 2014 20:25:12 +0800
Message-ID: <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:63494 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaAQM4d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jan 2014 07:56:33 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so389349pbc.24
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jan 2014 04:56:32 -0800 (PST)
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com, Amit Daniel Kachhap <amit.daniel@samsung.com>, Hanjun Guo <hanjun.guo@linaro.org>

From: Amit Daniel Kachhap <amit.daniel@samsung.com>

This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
name from the ACPI timer table is matched with all the registered
timer controllers and matching initialisation routine is invoked.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/asm-generic/vmlinux.lds.h |   10 ++++++++++
 include/linux/clocksource.h       |   12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bc2121f..3216bee 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -148,6 +148,15 @@
 #define CLKSRC_OF_TABLES()
 #endif
 
+#ifdef CONFIG_ACPI
+#define CLKSRC_ACPI_TABLES() . = ALIGN(8);				\
+			   VMLINUX_SYMBOL(__clksrc_acpi_table) = .;	\
+			   *(__clksrc_acpi_table)			\
+			   *(__clksrc_acpi_table_end)
+#else
+#define CLKSRC_ACPI_TABLES()
+#endif
+
 #ifdef CONFIG_IRQCHIP
 #define IRQCHIP_OF_MATCH_TABLE()					\
 	. = ALIGN(8);							\
@@ -491,6 +500,7 @@
 	MEM_DISCARD(init.rodata)					\
 	CLK_OF_TABLES()							\
 	CLKSRC_OF_TABLES()						\
+	CLKSRC_ACPI_TABLES()						\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()
 
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 67301a4..1d500cf 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -341,6 +341,8 @@ extern int clocksource_i8253_init(void);
 
 struct device_node;
 typedef void(*clocksource_of_init_fn)(struct device_node *);
+typedef void(*clocksource_acpi_init_fn)(void);
+
 #ifdef CONFIG_CLKSRC_OF
 extern void clocksource_of_init(void);
 
@@ -358,4 +360,14 @@ static inline void clocksource_of_init(void) {}
 		     .data = (fn == (clocksource_of_init_fn)NULL) ? fn : fn }
 #endif
 
+#ifdef CONFIG_ACPI
+#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)			\
+	static const struct acpi_device_id __clksrc_acpi_table_##name	\
+		__used __section(__clksrc_acpi_table)			\
+		 = { .id = compat,				\
+		     .driver_data = (kernel_ulong_t)fn }
+#else
+#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)
+#endif
+
 #endif /* _LINUX_CLOCKSOURCE_H */
-- 
1.7.9.5

