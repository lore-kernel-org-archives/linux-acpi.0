Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DE39A072;
	Thu, 12 Mar 2026 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313577; cv=none; b=dHm+iZqoLYb3NkmXxoMHATHbU9SbU7ldEotLIANlOSxVyBYdvOFQNOkkBbkysdFtdR5UcRtBlSwXuAzACaajt9rVIq9EJhr92ZWfaKuJsMgGOYZ5NqkfCb8CslfobZHQeYghiiXVJCdtMy+zegxW5FE+coVJ425xGrxISDt41g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313577; c=relaxed/simple;
	bh=mQlyV49c3+oxjb3lZG5G83BakXpbUUk7w+TCWbh79O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYTZ3kTndlIKTtUQnnCOqC8v8dfazYrQKHDyQ50qpb+96gCDomJj+o+sAHzQEhtwoQOTtnH+kyLGWTevAFNOmIvNpclZqvg36e6B7sRk1OSdNEeTAJci1MtPSWrqBjAkHPEHWeCS3xnf/Ig2HwtGGbWgfGCqjyyuH/+I0Ym3lrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7yNPh32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7yNPh32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288F5C116C6;
	Thu, 12 Mar 2026 11:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773313576;
	bh=mQlyV49c3+oxjb3lZG5G83BakXpbUUk7w+TCWbh79O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7yNPh32np5kVDNhY35fk75hZMZIEiJP24y1JeUuRl+FEjKSnWX9pv4mFDgsXnEsc
	 m6CieCqMEroZHGnf8BMl0e7sRmBa35u9r5xKkGTjy27yp6WLzOiMLmGvlliUwG9LXC
	 zmcqnn/7eqyEtvlUlsIHqN8xT9JL2sA4qIb6UbpwbQDky6IfIpxm+kCBbTKupzoWRQ
	 9c+ZhmHkhXLOsk0wNcLp36mVB/SnKJRyRfsImcCR6GgeWfDII96ZEKv8ou53IYK9Ru
	 87FP+DX3sByi4pukP7KmQBfU7U2onoUvmaUo6IMi0dIeDP4qcOncpR3y2zyAc+8KyS
	 LgYn5uOrHJ+pw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject:
 [PATCH v1 1/2] platform/x86: dell/dell-rbtn: Register ACPI notify handler
 directly
Date: Thu, 12 Mar 2026 12:02:40 +0100
Message-ID: <2272494.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5071411.GXAFRqVoOG@rafael.j.wysocki>
References: <5071411.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/dell/dell-rbtn.c | 50 ++++++++++++++++++---------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index a415c432d4c3..9271b27abb46 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -207,7 +207,7 @@ static void rbtn_input_event(struct rbtn_data *rbtn_data)
 
 static int rbtn_add(struct acpi_device *device);
 static void rbtn_remove(struct acpi_device *device);
-static void rbtn_notify(struct acpi_device *device, u32 event);
+static void rbtn_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id rbtn_ids[] = {
 	{ "DELRBTN", 0 },
@@ -293,7 +293,6 @@ static struct acpi_driver rbtn_driver = {
 	.ops = {
 		.add = rbtn_add,
 		.remove = rbtn_remove,
-		.notify = rbtn_notify,
 	},
 };
 
@@ -382,6 +381,22 @@ EXPORT_SYMBOL_GPL(dell_rbtn_notifier_unregister);
  * acpi driver functions
  */
 
+static void rbtn_cleanup(struct acpi_device *device)
+{
+	struct rbtn_data *rbtn_data = device->driver_data;
+
+	switch (rbtn_data->type) {
+	case RBTN_TOGGLE:
+		rbtn_input_exit(rbtn_data);
+		break;
+	case RBTN_SLIDER:
+		rbtn_rfkill_exit(device);
+		break;
+	default:
+		break;
+	}
+}
+
 static int rbtn_add(struct acpi_device *device)
 {
 	struct rbtn_data *rbtn_data;
@@ -422,31 +437,32 @@ static int rbtn_add(struct acpi_device *device)
 		break;
 	}
 	if (ret)
-		rbtn_acquire(device, false);
+		goto err;
+
+	ret = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					      rbtn_notify, device);
+	if (ret) {
+		rbtn_cleanup(device);
+		goto err;
+	}
 
+	return 0;
+
+err:
+	rbtn_acquire(device, false);
 	return ret;
 }
 
 static void rbtn_remove(struct acpi_device *device)
 {
-	struct rbtn_data *rbtn_data = device->driver_data;
-
-	switch (rbtn_data->type) {
-	case RBTN_TOGGLE:
-		rbtn_input_exit(rbtn_data);
-		break;
-	case RBTN_SLIDER:
-		rbtn_rfkill_exit(device);
-		break;
-	default:
-		break;
-	}
-
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
+	rbtn_cleanup(device);
 	rbtn_acquire(device, false);
 }
 
-static void rbtn_notify(struct acpi_device *device, u32 event)
+static void rbtn_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct rbtn_data *rbtn_data = device->driver_data;
 
 	/*
-- 
2.51.0




