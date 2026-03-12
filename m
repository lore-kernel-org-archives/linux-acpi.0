Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA5397E70;
	Thu, 12 Mar 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326453; cv=none; b=FpBqoEyhy2IdviGEDXWreGzWtICQazKVsP4CFbFZHbuvE/ucOC1vQaHFjUcM4lcazetnG+PL6+7aIsDSWdNYxR+gR0rYLYv8xb8BvL/ldqPi3sEtGyZZyBAw+Je31fy7OLiXY49cwSz8S4Bser8ZmTr7P9U/8wpmQLX7WAEFuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326453; c=relaxed/simple;
	bh=fZ1tWyc3LLgWGfh3LS1QvREEidBYtn0ez6LZNeywfTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZCcVitszB8mET3WSrSUrpsPBmXIYqWN4cEM0knXAgY9qbjvh/3cb6OfDWNuyVWMJdnin6yhXkSEJhOC+4mvjCP2OVLNheKfAOUnSCGvQS78jIrLuLPVBZ0R5LiYSgdupTtEnT2QveUeXQCat2iU2nkXuppEryHoPeiETaEei8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U35CIjMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U35CIjMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8ABC4CEF7;
	Thu, 12 Mar 2026 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773326452;
	bh=fZ1tWyc3LLgWGfh3LS1QvREEidBYtn0ez6LZNeywfTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U35CIjMpCOLG26cJH4DV8Wt808wsVH2+kiQiC9a6WFV1tz6GbbCS5VnbWXUgPa+x5
	 TASSzv6ttsopnb6qRpvcjcvmZYFNSxBKRMdEVsD7v4Jj/4gI5VIkUXbRnXfiYK61eC
	 e3RhOKx6gnhAssOFtZZqxc7F3e+BxIgO49tRQ9LR+Gw0AMLPeGZU8n6GFwC0/fP5Co
	 bCqB6BgooXLWD52TV8kgKySXNx2h7UhOVqrebayQkvcrbdr/ZrhSdbedQRMTetQghu
	 YKCPdpkLz9jZizvpsysF6ObHgudNxihucDbDmG/12EQmQ1u3WnFffuaGqp0kXJ0sEz
	 m1dRFDvNYZ3Ow==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 1/2] platform/x86: wireless-hotkey: Register ACPI notify handler
 directly
Date: Thu, 12 Mar 2026 15:38:37 +0100
Message-ID: <3953848.kQq0lBPeGt@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <23052072.EfDdHjke4D@rafael.j.wysocki>
References: <23052072.EfDdHjke4D@rafael.j.wysocki>
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
 drivers/platform/x86/wireless-hotkey.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index e5083c0e1515..a0ae757a277e 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -71,9 +71,9 @@ static void wireless_input_destroy(struct acpi_device *device)
 	kfree(button);
 }
 
-static void wl_notify(struct acpi_device *acpi_dev, u32 event)
+static void wl_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct wl_button *button = acpi_driver_data(acpi_dev);
+	struct wl_button *button = data;
 
 	if (event != 0x80) {
 		pr_info("Received unknown event (0x%x)\n", event);
@@ -101,6 +101,13 @@ static int wl_add(struct acpi_device *device)
 	if (err) {
 		pr_err("Failed to setup wireless hotkeys\n");
 		kfree(button);
+		return err;
+	}
+	err = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					      wl_notify, button);
+	if (err) {
+		pr_err("Failed to install ACPI notify handler\n");
+		wireless_input_destroy(device);
 	}
 
 	return err;
@@ -108,6 +115,7 @@ static int wl_add(struct acpi_device *device)
 
 static void wl_remove(struct acpi_device *device)
 {
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, wl_notify);
 	wireless_input_destroy(device);
 }
 
@@ -117,7 +125,6 @@ static struct acpi_driver wl_driver = {
 	.ops	= {
 		.add	= wl_add,
 		.remove	= wl_remove,
-		.notify	= wl_notify,
 	},
 };
 
-- 
2.51.0




