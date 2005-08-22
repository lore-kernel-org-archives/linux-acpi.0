From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: [patch] only compile kernel/power when neccessary
Date: Mon, 22 Aug 2005 10:26:49 +0200
Message-ID: <20050822082649.GA5614@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Only compile kernel/power if sleep support is going to be used.

Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>

---
commit 847ddd5de8a88b2d47e759bc94186a77140bc673
tree 5b7cb15723ef57e4cf3f72124c92176e394566b0
parent 790df7223ac29afec81e7201adc879973311f27e
author <pavel@amd.(none)> Mon, 22 Aug 2005 10:25:05 +0200
committer <pavel@amd.(none)> Mon, 22 Aug 2005 10:25:05 +0200

 drivers/acpi/Kconfig |    1 +
 kernel/Makefile      |    2 +-
 kernel/power/Kconfig |    7 ++++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -57,6 +57,7 @@ config ACPI_SLEEP
 	bool "Sleep States (EXPERIMENTAL)"
 	depends on X86 && (!SMP || SUSPEND_SMP)
 	depends on EXPERIMENTAL && PM
+	select SLEEP
 	default y
 	---help---
 	  This option adds support for ACPI suspend states. 
diff --git a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_SMP) += cpu.o spinlock.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
-obj-$(CONFIG_PM) += power/
+obj-$(CONFIG_SLEEP) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -18,6 +18,10 @@ config PM
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
+config SLEEP
+	bool
+	depends on PM
+
 config PM_DEBUG
 	bool "Power Management Debug Support"
 	depends on PM
@@ -28,7 +32,8 @@ config PM_DEBUG
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on EXPERIMENTAL && PM && SWAP && ((X86 && SMP) || ((FVR || PPC32 || X86) && !SMP))
+	depends on PM && SWAP && (X86 || ((FVR || PPC32) && !SMP))
+	select SLEEP
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.

-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
