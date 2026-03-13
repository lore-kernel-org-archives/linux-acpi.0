Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6641B4156;
	Fri, 13 Mar 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407060; cv=none; b=OT67uZUlBkvxyBTX1oiHFFr8+Ov5DMQ3iQrCdI7IHeiEuIg2a0niG0J93H15x0EcUMlgs1BloA4FQHc2ovniP1qYUoJ26W8DBMUj6aelOng0noWSdXCpRAHxwt8ifQEogdu4YBtlJF05Fn3QNP75nauuJZR6WdipFF3TPlHv/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407060; c=relaxed/simple;
	bh=QL8omcTIi7ufN3toaEjYxUNYpka4lBOGlBGiT6TVB9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZEGTLr2oO+jLC0zjJooAPuDSQZLhEkB91zbCCvXorV7YCoGwstFtm99ItVPTMmjPFtWu/iwnmYyB8BBE2ppcX5uIEFUO90vZhFUO2gmbaiWItC3JZ+cgZ4fPuEf8De8dr7vlvBS2YggqXPrrYtXm1imUOpO5tGD0qY8KYYOzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnfZjbe8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnfZjbe8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39F1C19425;
	Fri, 13 Mar 2026 13:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407059;
	bh=QL8omcTIi7ufN3toaEjYxUNYpka4lBOGlBGiT6TVB9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UnfZjbe8iDXpCC8N/jiPpm97WIBMEVmffO0dI+sJqybiLF/WQ/TQbOo0Ce5JloV2H
	 /6SWD5eUHurB6PgM1tQYDhcSJoVrX68W2cBTZq8xloVqW4p23QKt9Ak6kbeKERYJ64
	 yVCAyQLAIk3BRBlFhZL3G4OL6C9NLK946nWN0rqwKC1RXxRFyr3kA9eNw0WP9nryYU
	 wp7o/qJe2/wwk4ak/XPimdGyaT6RKS2QEWuDPLPH9QCf2atfIwL/2q6ZlJXHfPoDtb
	 wdze7KqAUXDtzB3azQHIDc7sY9RfCg58t2wgtd8C78HhcqA7obWcT2jRtsXhcQdCcZ
	 009+bFph+30rA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v2 7/8] ACPI: driver: Do not set acpi_device_class() unnecessarily
Date: Fri, 13 Mar 2026 14:00:41 +0100
Message-ID: <3706295.iIbC2pHGDl@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
References: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Several core ACPI device drivers set acpi_device_class() for the given
struct acpi_device to whatever they like, but that value is never used
unless the driver itself uses it and, sadly, they neglect to clear it on
remove.  Since the only one of them still using acpi_device_class()
after previous changes is the button driver, update the others to stop
setting it in vain.  Also drop the related device class sybmols that
become redundant.

Since the ACPI button driver continues to use acpi_device_class(), make
it clear the struct field represented by acpi_device_class() in its
remove callback.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ac.c               |    1 -
 drivers/acpi/acpi_memhotplug.c  |    2 --
 drivers/acpi/acpi_pad.c         |    5 +----
 drivers/acpi/acpi_processor.c   |    1 -
 drivers/acpi/acpi_video.c       |    3 ---
 drivers/acpi/battery.c          |    1 -
 drivers/acpi/button.c           |    2 ++
 drivers/acpi/ec.c               |    4 ----
 drivers/acpi/pci_link.c         |    2 --
 drivers/acpi/pci_root.c         |    2 --
 drivers/acpi/power.c            |    2 --
 drivers/acpi/processor_driver.c |    4 ++--
 drivers/acpi/sbs.c              |    2 --
 drivers/acpi/sbshc.c            |    4 ----
 drivers/acpi/thermal.c          |    1 -
 include/acpi/processor.h        |    1 -
 16 files changed, 5 insertions(+), 32 deletions(-)

--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -203,7 +203,6 @@ static int acpi_ac_probe(struct platform
 		return -ENOMEM;
 
 	ac->device = adev;
-	strscpy(acpi_device_class(adev), ACPI_AC_CLASS);
 
 	platform_set_drvdata(pdev, ac);
 
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -18,7 +18,6 @@
 
 #include "internal.h"
 
-#define ACPI_MEMORY_DEVICE_CLASS		"memory"
 #define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
 
 static const struct acpi_device_id memory_device_ids[] = {
@@ -296,7 +295,6 @@ static int acpi_memory_device_add(struct
 	INIT_LIST_HEAD(&mem_device->res_list);
 	mem_device->device = device;
 	mem_device->mgid = -1;
-	sprintf(acpi_device_class(device), "%s", ACPI_MEMORY_DEVICE_CLASS);
 	device->driver_data = mem_device;
 
 	/* Get the range from the _CRS */
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -23,7 +23,6 @@
 #include <asm/mwait.h>
 #include <xen/xen.h>
 
-#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"acpi_pad"
 #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
 
 #define ACPI_PROCESSOR_AGGREGATOR_STATUS_SUCCESS	0
@@ -413,7 +412,7 @@ static void acpi_pad_notify(acpi_handle
 	switch (event) {
 	case ACPI_PROCESSOR_AGGREGATOR_NOTIFY:
 		acpi_pad_handle_notify(handle);
-		acpi_bus_generate_netlink_event(ACPI_PROCESSOR_AGGREGATOR_CLASS,
+		acpi_bus_generate_netlink_event("acpi_pad",
 						dev_name(&adev->dev), event, 0);
 		break;
 	default:
@@ -426,8 +425,6 @@ static int acpi_pad_probe(struct platfor
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 
-	strscpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
-
 	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
 					       acpi_pad_notify, adev);
 }
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -438,7 +438,6 @@ static int acpi_processor_add(struct acp
 	}
 
 	pr->handle = device->handle;
-	strscpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
 	device->driver_data = pr;
 
 	result = acpi_processor_get_info(device);
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1141,8 +1141,6 @@ static int acpi_video_bus_get_one_device
 		return -ENOMEM;
 	}
 
-	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
-
 	data->device_id = device_id;
 	data->video = video;
 	data->dev = device;
@@ -2018,7 +2016,6 @@ static int acpi_video_bus_probe(struct a
 	auxiliary_set_drvdata(aux_dev, video);
 
 	video->device = device;
-	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 	device->driver_data = video;
 
 	acpi_video_bus_find_cap(video);
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1228,7 +1228,6 @@ static int acpi_battery_probe(struct pla
 	platform_set_drvdata(pdev, battery);
 
 	battery->device = device;
-	strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 
 	result = devm_mutex_init(&pdev->dev, &battery->update_lock);
 	if (result)
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -697,6 +697,8 @@ static void acpi_button_remove(struct pl
 	acpi_button_remove_fs(button);
 	input_unregister_device(button->input);
 	kfree(button);
+
+	memset(acpi_device_class(adev), 0, sizeof(acpi_device_class));
 }
 
 static int param_set_lid_init_state(const char *val,
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -35,8 +35,6 @@
 
 #include "internal.h"
 
-#define ACPI_EC_CLASS			"embedded_controller"
-
 /* EC status register */
 #define ACPI_EC_FLAG_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_FLAG_IBF	0x02	/* Input buffer full */
@@ -1680,8 +1678,6 @@ static int acpi_ec_probe(struct platform
 	struct acpi_ec *ec;
 	int ret;
 
-	strscpy(acpi_device_class(device), ACPI_EC_CLASS);
-
 	if (boot_ec && (boot_ec->handle == device->handle ||
 	    !strcmp(acpi_device_hid(device), ACPI_ECDT_HID))) {
 		/* Fast path: this device corresponds to the boot EC. */
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -29,7 +29,6 @@
 
 #include "internal.h"
 
-#define ACPI_PCI_LINK_CLASS		"pci_irq_routing"
 #define ACPI_PCI_LINK_MAX_POSSIBLE	16
 
 static int acpi_pci_link_add(struct acpi_device *device,
@@ -724,7 +723,6 @@ static int acpi_pci_link_add(struct acpi
 		return -ENOMEM;
 
 	link->device = device;
-	strscpy(acpi_device_class(device), ACPI_PCI_LINK_CLASS);
 	device->driver_data = link;
 
 	mutex_lock(&acpi_link_lock);
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -24,7 +24,6 @@
 #include <linux/platform_data/x86/apple.h>
 #include "internal.h"
 
-#define ACPI_PCI_ROOT_CLASS		"pci_bridge"
 static int acpi_pci_root_add(struct acpi_device *device,
 			     const struct acpi_device_id *not_used);
 static void acpi_pci_root_remove(struct acpi_device *device);
@@ -688,7 +687,6 @@ static int acpi_pci_root_add(struct acpi
 
 	root->device = device;
 	root->segment = segment & 0xFFFF;
-	strscpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
 
 	if (hotadd && dmar_device_add(handle)) {
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -37,7 +37,6 @@
 #include "sleep.h"
 #include "internal.h"
 
-#define ACPI_POWER_CLASS		"power_resource"
 #define ACPI_POWER_RESOURCE_STATE_OFF	0x00
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
@@ -954,7 +953,6 @@ struct acpi_device *acpi_add_power_resou
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);
-	strscpy(acpi_device_class(device), ACPI_POWER_CLASS);
 	device->power.state = ACPI_STATE_UNKNOWN;
 	device->flags.match_driver = true;
 
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -85,8 +85,8 @@ static void acpi_processor_notify(acpi_h
 		return;
 	}
 
-	acpi_bus_generate_netlink_event(ACPI_PROCESSOR_CLASS,
-					dev_name(&device->dev), event, ev_data);
+	acpi_bus_generate_netlink_event("processor", dev_name(&device->dev),
+					event, ev_data);
 }
 
 static int __acpi_processor_start(struct acpi_device *device);
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -26,7 +26,6 @@
 
 #include "sbshc.h"
 
-#define ACPI_SBS_CLASS			"sbs"
 #define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_SBS_DEVICE_NAME		"Smart Battery System"
 #define ACPI_BATTERY_DIR_NAME		"BAT%i"
@@ -648,7 +647,6 @@ static int acpi_sbs_probe(struct platfor
 
 	sbs->hc = dev_get_drvdata(pdev->dev.parent);
 	sbs->device = device;
-	strscpy(acpi_device_class(device), ACPI_SBS_CLASS);
 
 	result = acpi_charger_add(sbs);
 	if (result && result != -ENODEV)
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -18,8 +18,6 @@
 #include "sbshc.h"
 #include "internal.h"
 
-#define ACPI_SMB_HC_CLASS	"smbus_host_ctl"
-
 struct acpi_smb_hc {
 	struct acpi_ec *ec;
 	struct mutex lock;
@@ -250,8 +248,6 @@ static int acpi_smbus_hc_probe(struct pl
 		return -EIO;
 	}
 
-	strscpy(acpi_device_class(device), ACPI_SMB_HC_CLASS);
-
 	hc = kzalloc_obj(struct acpi_smb_hc);
 	if (!hc)
 		return -ENOMEM;
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -799,7 +799,6 @@ static int acpi_thermal_probe(struct pla
 
 	tz->device = device;
 	strscpy(tz->name, device->pnp.bus_id);
-	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 
 	acpi_thermal_aml_dependency_fix(tz);
 
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -14,7 +14,6 @@
 
 #include <asm/acpi.h>
 
-#define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_DEVICE_HID	"ACPI0007"
 #define ACPI_PROCESSOR_CONTAINER_HID	"ACPI0010"
 



