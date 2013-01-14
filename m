From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/3] x86: enable common clk on x86
Date: Mon, 14 Jan 2013 16:46:26 +0200
Message-ID: <1358174788-24439-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1358174788-24439-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358174788-24439-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Mike Turquette <mturquette@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We are starting to see traditional SoC peripherals also in the x86 world,
things like UART, I2C and SPI controllers that might already have a working
device driver. These drivers typically take advantage of the Linux clk
framework to control and retrieve information about the peripheral clock.

There hasn't been a standard way on x86 to pass the clock rate from
whatever configuration system is used to the driver, but instead different
variations have emerged, like adding this information to the platform data.

In order to use the standard Linux way we enable the common clk subsystem
also on x86. This allows us to re-use the drivers with little or no
modification wrt. clock API usage.

This patch was originally proposed by Mark Brown.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 arch/x86/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 79795af..decda04 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -114,6 +114,7 @@ config X86
 	select MODULES_USE_ELF_RELA if X86_64
 	select CLONE_BACKWARDS if X86_32
 	select GENERIC_SIGALTSTACK
+	select COMMON_CLK
 
 config INSTRUCTION_DECODER
 	def_bool y
-- 
1.7.10.4
