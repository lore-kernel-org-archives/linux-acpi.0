From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/5] ACPI: Remove the ops field from struct acpi_device
Date: Mon, 14 Jan 2013 22:37:28 +0100
Message-ID: <4366378.jvoXLv5QGr@vostro.rjw.lan>
References: <3885603.ydrrB7OEKf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3885603.ydrrB7OEKf@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ops field in struct acpi_device is not used anywhere, so remove
it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acpi_bus.h |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -271,7 +271,6 @@ struct acpi_device {
 	struct acpi_device_wakeup wakeup;
 	struct acpi_device_perf performance;
 	struct acpi_device_dir dir;
-	struct acpi_device_ops ops;
 	struct acpi_driver *driver;
 	void *driver_data;
 	struct device dev;
