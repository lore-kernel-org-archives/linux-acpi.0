From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH v2, 6/7] ACPI / container: Use hotplug profile user space interface
Date: Tue, 26 Feb 2013 23:49:30 +0100
Message-ID: <3039534.sEGVFlJ6ZD@vostro.rjw.lan>
References: <3260206.bhaAobGhpZ@vostro.rjw.lan> <3171747.TOMjvVkWL1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3171747.TOMjvVkWL1@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Jiang Liu <liuj97@gmail.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the ACPI container driver register its ACPI scan handler object
using acpi_scan_add_handler_with_hotplug() to allow user space to
manipulate its hotplug profile 'enabled' attribute.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/container.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: test/drivers/acpi/container.c
===================================================================
--- test.orig/drivers/acpi/container.c
+++ test/drivers/acpi/container.c
@@ -49,7 +49,7 @@ static int container_device_attach(struc
 	return 1;
 }
 
-static struct acpi_scan_handler container_device_handler = {
+static struct acpi_scan_handler container_handler = {
 	.ids = container_device_ids,
 	.attach = container_device_attach,
 	.hotplug = {
@@ -60,5 +60,5 @@ static struct acpi_scan_handler containe
 
 void __init acpi_container_init(void)
 {
-	acpi_scan_add_handler(&container_device_handler);
+	acpi_scan_add_handler_with_hotplug(&container_handler, "container");
 }
