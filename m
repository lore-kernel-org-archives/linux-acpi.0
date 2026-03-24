Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095C316190;
	Tue, 24 Mar 2026 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382886; cv=none; b=IZpWRFlyekEo8pbN+U1UtSMAKjIWctNeMWQCHg5eIzD4yU/OK+AEIJt4TKE9ZN8KVX/soGLB0ma/zuSs5hVEe0r1XvkFLZuCwOVF/niDTGKAdtjDRqcvGFKnsvM6ixVvMSZrI6Ph7THQ/bEjgr4hx2B1pU/kZoVy8fCfdjovDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382886; c=relaxed/simple;
	bh=G3mkH+JqLu9q6cDIKy3xqWoFCjJBvb6KamqLcIfWw5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nT6jp9dK0BcLBH+w/dres6avP+H/4bxr9rcCbzUdguY2yqQ7jS1vLMHDWnqS1Uu5w9n86udli475YRq0Cbmp5bh+yOy2xB27mA/jgx3KcWwEYBM/bENWTK5xN+lesroNYUFqCKPpLHQXXdqP/bdfZk9w38tK2XRZCAvs3rZbQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVkzjuKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVkzjuKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77D4C2BC9E;
	Tue, 24 Mar 2026 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774382886;
	bh=G3mkH+JqLu9q6cDIKy3xqWoFCjJBvb6KamqLcIfWw5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=BVkzjuKet1LP+RugbJDzSzlKILToypREmI4272Eqcx3GIJuzFd/1XvTlUtaEBe+j/
	 DyWs/2zj+ZjXU8tbmoKlHHJeHvsNXlh32jOjrprjCQh7W4jCI50tVLF4nG5mB4BUQb
	 id5izCVlT5W3Vy9fbRrpagAVuXO1q+9rkVhiLE3MKWv5XSrb8S6WCz7SKGoy4ZEp0c
	 VMZptruEgH0HeA9/agoNk6OvFq4zPLp9vp3io5uzxa88hUeLnQAh8u3bOuNVWyVHwx
	 SDzlvsnSBfu0TICPZ0lDngaf6YaRMYC/wX4kgDc4tP+eBEzEMnl9Vojnl96nnDu9sf
	 OIyr9oeu/8tAQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH v1] platform/x86: thinkpad_acpi: Drop ACPI driver registration
Date: Tue, 24 Mar 2026 21:08:01 +0100
Message-ID: <3949487.kQq0lBPeGt@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

There is no point in registering an ACPI driver that only has an empty
.add() callback, which is done by the thinkpad_acpi driver, since
after binding to an ACPI device it only sits there and does nothing.

That binding only effectively causes the ACPI device's reference count
to increase, but that can be achieved by using acpi_get_acpi_dev()
instead of acpi_fetch_acpi_dev() in setup_acpi_notify(), and doing
the corresponding cleanup in ibm_exit().

Update the code accordingly and get rid of the non-functional ACPI
driver.

No intentional functional impact beyond altering sysfs content.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/lenovo/thinkpad_acpi.c | 62 ++-------------------
 1 file changed, 4 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
index 8982d92dfd97..9e1614754cd7 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -299,7 +299,6 @@ struct ibm_struct;
 
 struct tp_acpi_drv_struct {
 	const struct acpi_device_id *hid;
-	struct acpi_driver *driver;
 
 	void (*notify) (struct ibm_struct *, u32);
 	acpi_handle *handle;
@@ -322,7 +321,6 @@ struct ibm_struct {
 	struct tp_acpi_drv_struct *acpi;
 
 	struct {
-		u8 acpi_driver_registered:1;
 		u8 acpi_notify_installed:1;
 		u8 proc_created:1;
 		u8 init_called:1;
@@ -832,9 +830,9 @@ static int __init setup_acpi_notify(struct ibm_struct *ibm)
 	vdbg_printk(TPACPI_DBG_INIT,
 		"setting up ACPI notify for %s\n", ibm->name);
 
-	ibm->acpi->device = acpi_fetch_acpi_dev(*ibm->acpi->handle);
+	ibm->acpi->device = acpi_get_acpi_dev(*ibm->acpi->handle);
 	if (!ibm->acpi->device) {
-		pr_err("acpi_fetch_acpi_dev(%s) failed\n", ibm->name);
+		pr_err("acpi_get_acpi_dev(%s) failed\n", ibm->name);
 		return -ENODEV;
 	}
 
@@ -859,44 +857,6 @@ static int __init setup_acpi_notify(struct ibm_struct *ibm)
 	return 0;
 }
 
-static int __init tpacpi_device_add(struct acpi_device *device)
-{
-	return 0;
-}
-
-static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
-{
-	int rc;
-
-	dbg_printk(TPACPI_DBG_INIT,
-		"registering %s as an ACPI driver\n", ibm->name);
-
-	BUG_ON(!ibm->acpi);
-
-	ibm->acpi->driver = kzalloc_obj(struct acpi_driver);
-	if (!ibm->acpi->driver) {
-		pr_err("failed to allocate memory for ibm->acpi->driver\n");
-		return -ENOMEM;
-	}
-
-	sprintf(ibm->acpi->driver->name, "%s_%s", TPACPI_NAME, ibm->name);
-	ibm->acpi->driver->ids = ibm->acpi->hid;
-
-	ibm->acpi->driver->ops.add = &tpacpi_device_add;
-
-	rc = acpi_bus_register_driver(ibm->acpi->driver);
-	if (rc < 0) {
-		pr_err("acpi_bus_register_driver(%s) failed: %d\n",
-		       ibm->name, rc);
-		kfree(ibm->acpi->driver);
-		ibm->acpi->driver = NULL;
-	} else if (!rc)
-		ibm->flags.acpi_driver_registered = 1;
-
-	return rc;
-}
-
-
 /****************************************************************************
  ****************************************************************************
  *
@@ -11532,6 +11492,8 @@ static void ibm_exit(struct ibm_struct *ibm)
 		acpi_remove_notify_handler(*ibm->acpi->handle,
 					   ibm->acpi->type,
 					   dispatch_acpi_notify);
+		ibm->acpi->device->driver_data = NULL;
+		acpi_dev_put(ibm->acpi->device);
 		ibm->flags.acpi_notify_installed = 0;
 	}
 
@@ -11542,16 +11504,6 @@ static void ibm_exit(struct ibm_struct *ibm)
 		ibm->flags.proc_created = 0;
 	}
 
-	if (ibm->flags.acpi_driver_registered) {
-		dbg_printk(TPACPI_DBG_EXIT,
-			"%s: acpi_bus_unregister_driver\n", ibm->name);
-		BUG_ON(!ibm->acpi);
-		acpi_bus_unregister_driver(ibm->acpi->driver);
-		kfree(ibm->acpi->driver);
-		ibm->acpi->driver = NULL;
-		ibm->flags.acpi_driver_registered = 0;
-	}
-
 	if (ibm->flags.init_called && ibm->exit) {
 		ibm->exit();
 		ibm->flags.init_called = 0;
@@ -11587,12 +11539,6 @@ static int __init ibm_init(struct ibm_init_struct *iibm)
 	}
 
 	if (ibm->acpi) {
-		if (ibm->acpi->hid) {
-			ret = register_tpacpi_subdriver(ibm);
-			if (ret)
-				goto err_out;
-		}
-
 		if (ibm->acpi->notify) {
 			ret = setup_acpi_notify(ibm);
 			if (ret == -ENODEV) {
-- 
2.51.0




