Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C41423C8AE;
	Tue, 24 Mar 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382610; cv=none; b=XGSs6eRK0bNo0Tl++1i4KTSCSkHyPONPwFlh/ins6wQmEstr4NnjsKL4KZaEb3WGpaLVNcmSeieZaEwLGjb8IBh9ErEj2RwhZxg1MhUKqAaq4GVwNo6LFhrY8sGowWpzjLXS4c5yFtRYs+oCroSiNsI9u9phWFGRKWIPFeBSNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382610; c=relaxed/simple;
	bh=p4tZajmHfvr9qj6hODtfrcdLSKsUNSbEMAb5xsQTXw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulHjLhBgGvnPK64UW4FncxAWJDuHqBkNKCxkUTmcmx7lHOUSGxVZk2r515ZtEpjluTLv3hQnEL9pVtGWwYamH2vlFwv1731BXRkta1Y34ftSOMO0OUfpyENF1JeL7CU6PZrS99MnOd4w8PseogJZUpv45zIPnAaOiE4C++RZx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy/TfoOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy/TfoOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB71C19424;
	Tue, 24 Mar 2026 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774382610;
	bh=p4tZajmHfvr9qj6hODtfrcdLSKsUNSbEMAb5xsQTXw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dy/TfoOos18pPVitK3df2c5M3MET76MzEMxAVNeTsVS/KhT7bvS/P/3lrG4GWTzgC
	 rto8lutcJa3OtMo+so55dZiUGHOzOr24ntS6jbF7MaE+TWA3cP50vP/L3nWH6xC8FR
	 th7LQahCftnykyFwzPP9WC9KUgIOG5D667JXU/3/t4COnA0l4Acp53KKpT32MAkqOl
	 wbuJYt3CvBd+8TVe1vf+OsgkGU1KgMZbxiJfz3op1qpUUP0dVRQgGp7tacR7SrHTUh
	 vNf1BDQWVsEAEentpxf1+hxaGuchx21o5L/H0/YrPqmZs3YMJk1HuKk7I/+ujDJV79
	 MyjtI6K1JScfg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 4/7] platform/x86: toshiba_bluetooth: Register ACPI notify handler
 directly
Date: Tue, 24 Mar 2026 21:00:50 +0100
Message-ID: <3048289.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
References: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
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
 drivers/platform/x86/toshiba_bluetooth.c | 32 ++++++++++++++++++------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index e587beef05b9..3824c2beaf11 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -37,7 +37,7 @@ struct toshiba_bluetooth_dev {
 
 static int toshiba_bt_rfkill_add(struct acpi_device *device);
 static void toshiba_bt_rfkill_remove(struct acpi_device *device);
-static void toshiba_bt_rfkill_notify(struct acpi_device *device, u32 event);
+static void toshiba_bt_rfkill_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id bt_device_ids[] = {
 	{ "TOS6205", 0},
@@ -57,7 +57,6 @@ static struct acpi_driver toshiba_bt_rfkill_driver = {
 	.ops =		{
 				.add =		toshiba_bt_rfkill_add,
 				.remove =	toshiba_bt_rfkill_remove,
-				.notify =	toshiba_bt_rfkill_notify,
 			},
 	.drv.pm =	&toshiba_bt_pm,
 };
@@ -203,9 +202,9 @@ static const struct rfkill_ops rfk_ops = {
 };
 
 /* ACPI driver functions */
-static void toshiba_bt_rfkill_notify(struct acpi_device *device, u32 event)
+static void toshiba_bt_rfkill_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct toshiba_bluetooth_dev *bt_dev = acpi_driver_data(device);
+	struct toshiba_bluetooth_dev *bt_dev = data;
 
 	if (toshiba_bluetooth_sync_status(bt_dev))
 		return;
@@ -262,8 +261,8 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 				   bt_dev);
 	if (!bt_dev->rfk) {
 		pr_err("Unable to allocate rfkill device\n");
-		kfree(bt_dev);
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto err_free_bt_dev;
 	}
 
 	rfkill_set_hw_state(bt_dev->rfk, !bt_dev->killswitch);
@@ -271,10 +270,24 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 	result = rfkill_register(bt_dev->rfk);
 	if (result) {
 		pr_err("Unable to register rfkill device\n");
-		rfkill_destroy(bt_dev->rfk);
-		kfree(bt_dev);
+		goto err_rfkill_destroy;
 	}
 
+	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+						 toshiba_bt_rfkill_notify, bt_dev);
+	if (result) {
+		pr_err("Unable to register ACPI notify handler\n");
+		goto err_rfkill_unregister;
+	}
+
+	return 0;
+
+err_rfkill_unregister:
+	rfkill_unregister(bt_dev->rfk);
+err_rfkill_destroy:
+	rfkill_destroy(bt_dev->rfk);
+err_free_bt_dev:
+	kfree(bt_dev);
 	return result;
 }
 
@@ -283,6 +296,9 @@ static void toshiba_bt_rfkill_remove(struct acpi_device *device)
 	struct toshiba_bluetooth_dev *bt_dev = acpi_driver_data(device);
 
 	/* clean up */
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       toshiba_bt_rfkill_notify);
+
 	if (bt_dev->rfk) {
 		rfkill_unregister(bt_dev->rfk);
 		rfkill_destroy(bt_dev->rfk);
-- 
2.51.0




