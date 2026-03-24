Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02C2E8B6B;
	Tue, 24 Mar 2026 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382618; cv=none; b=CyN35UN8rX9i1bEeGz8TtnX6F/nPtEarQH41PXTUe7NeiqEXrKWjxp8KtsydEb26BxRDKfSMWC8BLHCp71bzdsZq7eHAXmcLL/Tdqi6hYCy3GNrn215xiQ9q4F8pGkUt7z+pSo0oKy2ko7wvdiaJFumun/vmB3p63jNM6clP2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382618; c=relaxed/simple;
	bh=9K6Zd0SChnPW3+Qtqv4Bw6DYNROxb/0dCK5ReRIiAEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLi9OAjGJcfx5lpRu7G4FTofxymh7vYkGPI6+tbOTHyFRsbj755oj9YCst/FvcPazBp9ng61pU7rv2yVyRVxt1TP2n++NJd3qlXKiyG+iCqa7JJedchS6fK287e4Kx0lF7eWCYmrMHK1X1lTe0IJpQXUpaKUVDgZTNKzxPQ+54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKcnx3yo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKcnx3yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5100C2BCB1;
	Tue, 24 Mar 2026 20:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774382618;
	bh=9K6Zd0SChnPW3+Qtqv4Bw6DYNROxb/0dCK5ReRIiAEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKcnx3yojc8sPiupDkFUK/oMoZ//gaBcCD+/JmyRUHeoWdQB/pIVbRR9Bqk+psmlB
	 FUq6U35BTssYE5LC42D+tnUkikYsIx0MGKSAY5PF4edgiHcLP3cLlmV+5AGUXEpkD+
	 wC9DmHYRHZIjYxNM8oEA+n40q4mB0LGjeec69zu3cv77ira+9b6GO49u3cW/tkAT5u
	 ynFUQDXq0x2K0fQKRQaIJYt+P2bIM6kEXBVt6BmZUagvauh9cyFjfU0jXLbhJrGrzD
	 e9lmes6+iYWZPCrHH6fo0icfBRDr6mMlfTTS8qk1bo/gZV4RsJTjHC6Ml0RVg85zPe
	 U7xsV3HnVTE+w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 2/7] platform/x86: toshiba_acpi: Register ACPI notify handler
 directly
Date: Tue, 24 Mar 2026 20:58:48 +0100
Message-ID: <5070377.GXAFRqVoOG@rafael.j.wysocki>
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
 drivers/platform/x86/toshiba_acpi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index fbd7b6b6b826..b839f62ec9cc 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -223,6 +223,7 @@ struct toshiba_acpi_dev {
 	unsigned int cooling_method_supported:1;
 	unsigned int battery_charge_mode_supported:1;
 	unsigned int sysfs_created:1;
+	unsigned int notify_handler_installed:1;
 	unsigned int special_functions;
 
 	bool kbd_event_generated;
@@ -3193,9 +3194,10 @@ static void print_supported_features(struct toshiba_acpi_dev *dev)
 	pr_cont("\n");
 }
 
-static void toshiba_acpi_notify(struct acpi_device *acpi_dev, u32 event)
+static void toshiba_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
+	struct toshiba_acpi_dev *dev = data;
+	struct acpi_device *acpi_dev = dev->acpi_dev;
 
 	switch (event) {
 	case 0x80: /* Hotkeys and some system events */
@@ -3261,6 +3263,10 @@ static void toshiba_acpi_remove(struct acpi_device *acpi_dev)
 
 	remove_toshiba_proc_entries(dev);
 
+	if (dev->notify_handler_installed)
+		acpi_dev_remove_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY,
+					       toshiba_acpi_notify);
+
 #if IS_ENABLED(CONFIG_HWMON)
 	if (dev->hwmon_device)
 		hwmon_device_unregister(dev->hwmon_device);
@@ -3537,6 +3543,13 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	}
 	dev->sysfs_created = !ret;
 
+	ret = acpi_dev_install_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY,
+					      toshiba_acpi_notify, dev);
+	if (ret)
+		goto error;
+
+	dev->notify_handler_installed = 1;
+
 	create_toshiba_proc_entries(dev);
 
 	toshiba_acpi = dev;
@@ -3602,7 +3615,6 @@ static struct acpi_driver toshiba_acpi_driver = {
 	.ops	= {
 		.add		= toshiba_acpi_add,
 		.remove		= toshiba_acpi_remove,
-		.notify		= toshiba_acpi_notify,
 	},
 	.drv.pm	= &toshiba_acpi_pm,
 };
-- 
2.51.0




