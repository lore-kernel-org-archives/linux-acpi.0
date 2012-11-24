From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / QoS: Rename local variable in dev_pm_qos_add_ancestor_request()
Date: Sat, 24 Nov 2012 10:30 +0100
Message-ID: <1379506.4xjF1qmrAD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Local variable 'error' in dev_pm_qos_add_ancestor_request() need
not contain error codes only, so rename it to 'ret'.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/qos.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux/drivers/base/power/qos.c
===================================================================
--- linux.orig/drivers/base/power/qos.c
+++ linux/drivers/base/power/qos.c
@@ -542,19 +542,19 @@ int dev_pm_qos_add_ancestor_request(stru
 				    struct dev_pm_qos_request *req, s32 value)
 {
 	struct device *ancestor = dev->parent;
-	int error = -ENODEV;
+	int ret = -ENODEV;
 
 	while (ancestor && !ancestor->power.ignore_children)
 		ancestor = ancestor->parent;
 
 	if (ancestor)
-		error = dev_pm_qos_add_request(ancestor, req,
-					       DEV_PM_QOS_LATENCY, value);
+		ret = dev_pm_qos_add_request(ancestor, req,
+					     DEV_PM_QOS_LATENCY, value);
 
-	if (error < 0)
+	if (ret < 0)
 		req->dev = NULL;
 
-	return error;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_add_ancestor_request);
 

