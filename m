From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 2/4] ACPI: Make acpi_dev_get_resources() method agnostic
Date: Thu, 20 Jul 2017 15:45:14 +0100
Message-ID: <20170720144517.32529-3-lorenzo.pieralisi@arm.com>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Feng Kan <fkan@apm.com>, Jon Masters <jcm@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Nate Watterson <nwatters@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

The function acpi_dev_get_resources() is completely generic and
can be used to parse resource objects that are not necessarily
coming from the _CRS method but also from other objects eg _DMA
that have the same _CRS resource format.

Create an acpi_dev_get_resources() helper, internal to the ACPI
resources parsing compilation unit, acpi_dev_get_resources_method(),
that takes a char* parameter to detect which ACPI method should be
called to retrieve the resources list and make acpi_dev_get_resources()
call it with a method name _CRS leaving the API behaviour unchanged.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/resource.c | 54 +++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index cd4c427..2b20a09 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -573,6 +573,36 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
 	return AE_OK;
 }
 
+static
+int acpi_dev_get_resources_method(struct acpi_device *adev,
+				  struct list_head *list,
+				  int (*preproc)(struct acpi_resource *, void *),
+				  void *preproc_data, char *method)
+{
+	struct res_proc_context c;
+	acpi_status status;
+
+	if (!adev || !adev->handle || !list_empty(list))
+		return -EINVAL;
+
+	if (!acpi_has_method(adev->handle, method))
+		return 0;
+
+	c.list = list;
+	c.preproc = preproc;
+	c.preproc_data = preproc_data;
+	c.count = 0;
+	c.error = 0;
+	status = acpi_walk_resources(adev->handle, method,
+				     acpi_dev_process_resource, &c);
+	if (ACPI_FAILURE(status)) {
+		acpi_dev_free_resource_list(list);
+		return c.error ? c.error : -EIO;
+	}
+
+	return c.count;
+}
+
 /**
  * acpi_dev_get_resources - Get current resources of a device.
  * @adev: ACPI device node to get the resources for.
@@ -601,28 +631,8 @@ int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
 			   int (*preproc)(struct acpi_resource *, void *),
 			   void *preproc_data)
 {
-	struct res_proc_context c;
-	acpi_status status;
-
-	if (!adev || !adev->handle || !list_empty(list))
-		return -EINVAL;
-
-	if (!acpi_has_method(adev->handle, METHOD_NAME__CRS))
-		return 0;
-
-	c.list = list;
-	c.preproc = preproc;
-	c.preproc_data = preproc_data;
-	c.count = 0;
-	c.error = 0;
-	status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
-				     acpi_dev_process_resource, &c);
-	if (ACPI_FAILURE(status)) {
-		acpi_dev_free_resource_list(list);
-		return c.error ? c.error : -EIO;
-	}
-
-	return c.count;
+	return acpi_dev_get_resources_method(adev, list, preproc,
+					     preproc_data, METHOD_NAME__CRS);
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_resources);
 
-- 
2.10.0
