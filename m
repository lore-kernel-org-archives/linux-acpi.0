From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] acpi/processor: fix for !CONFIG_CPU_IDLE
Date: Thu, 24 Jun 2010 15:40:41 +0100
Message-ID: <4C238A8902000078000080B1@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

The conditional modified (to have an 'else' portion) in commit
2671717265ae6e720a9ba5f13fbec3a718983b65 degenerates to an
unconditional NULL dereference when CONFIG_CPU_IDLE is off, as
cpuidle_register_driver() returns non-zero in this case, and
cpu_idle_get_driver() returns NULL. The simplest solution is to make
the whole construct depend on CONFIG_CPU_IDLE bein defined.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/acpi/processor_driver.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.35-rc3/drivers/acpi/processor_driver.c
+++ 2.6.35-rc3-acpi-no-cpuidle/drivers/acpi/processor_driver.c
@@ -922,6 +922,7 @@ static int __init acpi_processor_init(vo
 		return -ENOMEM;
 #endif
 
+#ifdef CONFIG_CPU_IDLE
 	if (!cpuidle_register_driver(&acpi_idle_driver)) {
 		printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
 			acpi_idle_driver.name);
@@ -929,6 +930,7 @@ static int __init acpi_processor_init(vo
 		printk(KERN_DEBUG "ACPI: acpi_idle yielding to %s",
 			cpuidle_get_driver()->name);
 	}
+#endif
 
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0)



