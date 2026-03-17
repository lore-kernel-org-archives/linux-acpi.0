Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1372381B16;
	Tue, 17 Mar 2026 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776706; cv=none; b=FiXNk/0hr7sE4/MxEqT4cIYs2I2iYm+ICNTmtV+kwpwapoRgPjbJlZOmSGFNUJcLS5HgNB+BgUTZXlFM6MqH9bpb+aVlKMAA+7ze9gQ04NSudh0R5/zBIYWCWtQY4S3knm/LqXjrQ8upTm1QMy+EX4sXfzxA/RYjSy0EeMf2qlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776706; c=relaxed/simple;
	bh=95QicZihXqI2vMrUdI2ltp0bbKwAHCWjWrBihwd1LDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYKH/AmhE/JMPJE3r99/MKjeodvxFguSyv5nxSgmyE6YdQ0GKLqfYbPDlgKzEqsI31L0Vxug364H+H9xkZOt1uWkz/eJk1BWzFdynZrSXOGw7vYRAGXkEt7vLul97HOvKq1CFSAnvAUm01OhEuwcfTwLsI4yBquHRIxIu5Ab5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pbyjux4e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pbyjux4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D532C2BCAF;
	Tue, 17 Mar 2026 19:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773776706;
	bh=95QicZihXqI2vMrUdI2ltp0bbKwAHCWjWrBihwd1LDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pbyjux4ewfaMVZDpiS1iQJ12lEtr4lmEhDIGxCWD2SE3RerE1Oj5L8WH1YZMBSzNX
	 X7RiKrty0DE6MAj+lQfoWJF7K6QV1o8cNrFhPgCVMZNUZi1HtGzC7FL25nx6948Atf
	 +9LrM4Q+Y2TVHa3S1IXe6pCB5BcR5vNIQ1/lK1jkWv6aI6oV0cYZD2TSJ67DoZ1YgG
	 RneXYykwvQzKmQbOACjCYrOGQ3BTtHOHBmjuPAh099uZ5cwcUDyX2DdOJjXxnTPUhQ
	 rUtBtyIrSv/edzmb1Gic8Cf4HqKcaI3Dl8Ks3XJM0XITzsESEGRx/srUniBlWCcebe
	 NKBnIx+KseEqQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v3 3/5] platform/x86: fujitsu: Register ACPI notify handlers directly
Date: Tue, 17 Mar 2026 20:42:09 +0100
Message-ID: <3035290.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5085647.31r3eYUQgx@rafael.j.wysocki>
References: <5085647.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to using struct
platform_driver instead of struct acpi_driver, make it install its ACPI
notify handlers directly instead of using struct acpi_driver .notify()
callbacks.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Jonathan Woithe <jwoithe@just42.net>
---

v2 -> v3: Rearrange the acpi_fujitsu_laptop_add() rollback path with a new
   label (Ilpo)

v1 -> v2: Call fujitsu_laptop_platform_remove() in acpi_fujitsu_laptop_add()
   error code path if notify handler registration fails (Ilpo)

---
 drivers/platform/x86/fujitsu-laptop.c | 32 ++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 1adce90ae3e6..88fdc4fce05c 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -502,8 +502,9 @@ static int fujitsu_backlight_register(struct acpi_device *device)
 
 /* Brightness notify */
 
-static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
+static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct fujitsu_bl *priv = acpi_driver_data(device);
 	int oldb, newb;
 
@@ -558,7 +559,18 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
-	return fujitsu_backlight_register(device);
+	ret = fujitsu_backlight_register(device);
+	if (ret)
+		return ret;
+
+	return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					       acpi_fujitsu_bl_notify, device);
+}
+
+static void acpi_fujitsu_bl_remove(struct acpi_device *device)
+{
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_fujitsu_bl_notify);
 }
 
 /* ACPI device for hotkey handling */
@@ -941,8 +953,9 @@ static void acpi_fujitsu_laptop_release(struct acpi_device *device)
 	}
 }
 
-static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
+static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
 	unsigned long flags;
 	int scancode, i = 0;
@@ -1056,12 +1069,19 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	if (ret)
 		goto err_free_fifo;
 
+	ret = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					      acpi_fujitsu_laptop_notify, device);
+	if (ret)
+		goto err_platform_remove;
+
 	ret = fujitsu_battery_charge_control_add(device);
 	if (ret < 0)
 		pr_warn("Unable to register battery charge control: %d\n", ret);
 
 	return 0;
 
+err_platform_remove:
+	fujitsu_laptop_platform_remove(device);
 err_free_fifo:
 	kfifo_free(&priv->fifo);
 
@@ -1074,6 +1094,9 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
 
 	fujitsu_battery_charge_control_remove(device);
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_fujitsu_laptop_notify);
+
 	fujitsu_laptop_platform_remove(device);
 
 	kfifo_free(&priv->fifo);
@@ -1092,7 +1115,7 @@ static struct acpi_driver acpi_fujitsu_bl_driver = {
 	.ids = fujitsu_bl_device_ids,
 	.ops = {
 		.add = acpi_fujitsu_bl_add,
-		.notify = acpi_fujitsu_bl_notify,
+		.remove = acpi_fujitsu_bl_remove,
 		},
 };
 
@@ -1108,7 +1131,6 @@ static struct acpi_driver acpi_fujitsu_laptop_driver = {
 	.ops = {
 		.add = acpi_fujitsu_laptop_add,
 		.remove = acpi_fujitsu_laptop_remove,
-		.notify = acpi_fujitsu_laptop_notify,
 		},
 };
 
-- 
2.51.0




