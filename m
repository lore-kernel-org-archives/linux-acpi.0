From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH RFC v2 1/3] drivers/platform/x86: add cpu physically hotplug driver
Date: Thu, 6 Jun 2013 09:40:33 +0800
Message-ID: <1370482835-764-2-git-send-email-lig.fnst@cn.fujitsu.com>
References: <1370482835-764-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370482835-764-1-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, liguang <lig.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

this driver will support cpu phyical add/removal automatically
after online/offline. if cpu hotpluged, cpu will not
online automatically, and for cpu offline, we try to
do actually eject if allowed for cpu like
"echo 1 > /sys/bus/acpi/devices/LNXCPU\:0X/eject"
this "echo ..." is only present for recent kernel
(sorry, can't figure out since when), for a little
older kernel, there's not such approach AFAICS.

Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 drivers/platform/x86/Kconfig              |    8 ++++
 drivers/platform/x86/Makefile             |    1 +
 drivers/platform/x86/cpu_physic_hotplug.c |   60 +++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/x86/cpu_physic_hotplug.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 8577261..39b2392 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -789,4 +789,12 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config QEMU_CPU_PHYSIC_HOTPLUG
+	tristate "physically add/remove cpu after cpu onlined/offlined"
+	depends on ACPI_HOTPLUG_CPU
+	---help---
+	  This driver will support physically remove a cpu after
+	  it offlined for QEMU automatically. someone may require this feature
+	  to do a physically removal for a cpu.
+
 endif # X86_PLATFORM_DEVICES
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index ef0ec74..2e669b0 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
 obj-$(CONFIG_CHROMEOS_LAPTOP)	+= chromeos_laptop.o
 
 obj-$(CONFIG_PVPANIC)           += pvpanic.o
+obj-$(CONFIG_QEMU_CPU_PHYSIC_HOTPLUG)	+= cpu_physic_hotplug.o
diff --git a/drivers/platform/x86/cpu_physic_hotplug.c b/drivers/platform/x86/cpu_physic_hotplug.c
new file mode 100644
index 0000000..a52c042
--- /dev/null
+++ b/drivers/platform/x86/cpu_physic_hotplug.c
@@ -0,0 +1,60 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
+#include <acpi/processor.h>
+
+MODULE_AUTHOR("Li Guang");
+MODULE_DESCRIPTION("CPU physically hot-plug/unplug Driver");
+MODULE_LICENSE("GPL");
+
+static int cpu_logic_hotplug_notify(struct notifier_block *nfb,
+				unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	struct acpi_processor *pr = per_cpu(processors, cpu);
+
+	if (pr) {
+		switch (action) {
+		case CPU_ONLINE:
+			break;
+		case CPU_DEAD:
+			break;
+		default:
+			break;
+		}
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpu_logic_hotplug_notifier =
+{
+	.notifier_call = cpu_logic_hotplug_notify,
+};
+
+static int cpu_physic_hotplug_notify(struct notifier_block *nfb,
+				 unsigned char *s)
+{
+}
+
+static struct notifier_block cpu_physic_hotplug_notifier =
+{
+	.notifier_call = cpu_physic_hotplug_notify,
+};
+
+static int __init cpu_qemu_hotplug_init(void)
+{
+	register_hotcpu_notifier(&cpu_logic_hotplug_notifier);
+	register_ec_gpe_notifier(&cpu_physic_hotplug_notifier);
+	return 0;
+}
+
+static void __exit cpu_qemu_hotplug_exit(void)
+{
+	unregister_hotcpu_notifier(&cpu_logic_hotplug_notifier);
+	unregister_ec_gpe_notifier(&cpu_physic_hotplug_notifier);
+}
+
+module_init(cpu_qemu_hotplug_init);
+module_exit(cpu_qemu_hotplug_exit);
-- 
1.7.2.5
