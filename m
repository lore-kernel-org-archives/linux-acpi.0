From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 5/7] Xen / ACPI / processor: Remove unneeded NULL check in xen_acpi_processor_enable()
Date: Fri, 27 Mar 2015 22:02:26 +0800
Message-ID: <1427464948-14564-6-git-send-email-hanjun.guo@linaro.org>
References: <1427464948-14564-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427464948-14564-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Before xen_acpi_processor_enable() is called, struct acpi_processor *pr is
allocated in xen_acpi_processor_add() and checked if it's NULL, so no need
to check again when passed to xen_acpi_processor_enable(), just remove it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/xen-acpi-cpuhotplug.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/xen/xen-acpi-cpuhotplug.c b/drivers/xen/xen-acpi-cpuhotplug.c
index 5a62aa0..f4a3694 100644
--- a/drivers/xen/xen-acpi-cpuhotplug.c
+++ b/drivers/xen/xen-acpi-cpuhotplug.c
@@ -46,13 +46,7 @@ static int xen_acpi_processor_enable(struct acpi_device *device)
 	unsigned long long value;
 	union acpi_object object = { 0 };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
-	struct acpi_processor *pr;
-
-	pr = acpi_driver_data(device);
-	if (!pr) {
-		pr_err(PREFIX "Cannot find driver data\n");
-		return -EINVAL;
-	}
+	struct acpi_processor *pr = acpi_driver_data(device);
 
 	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
 		/* Declared with "Processor" statement; match ProcessorID */
-- 
1.9.1
