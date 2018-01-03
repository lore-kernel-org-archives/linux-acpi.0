From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / WMI: Call acpi_wmi_init() later
Date: Wed, 03 Jan 2018 12:49:29 +0100
Message-ID: <2601877.IhOx20xkUK@aspire.rjw.lan>
References: <20171208151159.urdcrzl5qpfd6jnu@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20171208151159.urdcrzl5qpfd6jnu@earth.li>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>
Cc: Jonathan McDowell <noodles@earth.li>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>, platform-driver-x86@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Calling acpi_wmi_init() at the subsys_initcall() level causes ordering
issues to appear on some systems and they are difficult to reproduce,
because there is no guaranteed ordering between subsys_initcall()
calls, so they may occur in different orders on different systems.

In particular, commit 86d9f48534e8 (mm/slab: fix kmemcg cache
creation delayed issue) exposed one of these issues where genl_init()
and acpi_wmi_init() are both called at the same initcall level, but
the former must run before the latter so as to avoid a NULL pointer
dereference.

For this reason, move the acpi_wmi_init() invocation to the
initcall_sync level which should still be early enough for things
to work correctly in the WMI land.

Link: https://marc.info/?t=151274596700002&r=1&w=2
Reported-by: Jonathan McDowell <noodles@earth.li>
Reported-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/wmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/platform/x86/wmi.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/wmi.c
+++ linux-pm/drivers/platform/x86/wmi.c
@@ -1458,5 +1458,5 @@ static void __exit acpi_wmi_exit(void)
 	class_unregister(&wmi_bus_class);
 }
 
-subsys_initcall(acpi_wmi_init);
+subsys_initcall_sync(acpi_wmi_init);
 module_exit(acpi_wmi_exit);
