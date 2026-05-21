Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29427344024;
	Thu, 21 May 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372722; cv=none; b=kY+tEQmaKGnHCo+rgINKXPXIdH5tmE+7QIwXo3EPFkLfw88bKoXeo1VRdRYmvYH2kPT0LZeG7aUtkc1P6Rk0kHv0F2mCCBuiHjxuTZCBsQGsr/Ff+ECZD3MeYM6KoDWqlg2xFDMt4cqWGpkJaN/Pspa/BbPYuBRt4Py5lQgUyIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372722; c=relaxed/simple;
	bh=3g1OhCmXsSdx6uAdDdly2x2D7YRnHrS8YuSPt3d3KuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCFD1/77LVhgPIOyxpWTWNwplfSWd9nlrKfhA29fb2yNGiyw1PGI8MVS2irHqsB77WskKUWgQRe9U3yi4ft3lz6A0ei3dpQc5i84HB1irFF7Kxamud+3Ek48IgzipSP+sUalVbDC/kf89/Oj0pJEFSPLwM7trBLKTJdpgi/aF8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM2WWDlt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM2WWDlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AAD1F000E9;
	Thu, 21 May 2026 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372721;
	bh=oOTKKLLRh0HmayamKWT2GYcF33qTkFRU7M0eEpxoM00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GM2WWDltdAKbTzYeFrbhn+mAXbZO8/r6+tBltUXjer4TMKmfg3OYxV8qejy4cMMGr
	 zn5RrZDP9fMXBzmH7HcyAVvAxXZ0qk4vxQVxPzcWZ+JmjWRW5JpicutT2w+ayw3rej
	 siyL/lL3ltTXgdsROqeotekCSkjOZwOb9dQgTAJ3Ta6EQ6vHS5yWyLkHaI6FU6eHVq
	 qmCcGoTsDXV/sYkQkTkKYYlQke3/ViWMk8BLucyEh6pfy9gXbOxKyQ7rIlGuhH3TsG
	 NqXgoSP6ifa0zNysJ5WN+gO4yfjOOl554aUQyZBBz8LfGvXizVcA64X4WIr4S0cMmr
	 JdBGD48aTWa7A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 15/17] ACPI: video: Use devm action for freeing video devices
Date: Thu, 21 May 2026 16:10:13 +0200
Message-ID: <1932803.atdPhlSkOF@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4739447.LvFx2qVVIh@rafael.j.wysocki>
References: <4739447.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Rename acpi_video_bus_put_devices() to devm_acpi_video_bus_get_devices()
and turn acpi_video_bus_put_devices() into a devm action added by it for
freeing the video devices allocated by it and the attached_array memory.

Accordingly, remove the acpi_video_bus_put_devices() calls and
attached_array freeing from acpi_video_bus_remove() and the rollback
path in acpi_video_bus_probe().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c | 53 +++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 11dd00614f6b..a02eaf13f5d8 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1494,10 +1494,31 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 }
 EXPORT_SYMBOL(acpi_video_get_edid);
 
-static int
-acpi_video_bus_get_devices(struct acpi_video_bus *video,
-			   struct acpi_device *device)
+static void acpi_video_bus_put_devices(void *data)
+{
+	struct acpi_video_bus *video = data;
+	struct acpi_video_device *dev, *next;
+
+	mutex_lock(&video->device_list_lock);
+	list_for_each_entry_safe(dev, next, &video->video_device_list, entry) {
+		list_del(&dev->entry);
+		kfree(dev);
+	}
+	mutex_unlock(&video->device_list_lock);
+
+	kfree(video->attached_array);
+	video->attached_array = NULL;
+}
+
+static int devm_acpi_video_bus_get_devices(struct device *dev,
+					   struct acpi_video_bus *video)
 {
+	int ret;
+
+	ret = devm_add_action(dev, acpi_video_bus_put_devices, video);
+	if (ret)
+		return ret;
+
 	/*
 	 * There are systems where video module known to work fine regardless
 	 * of broken _DOD and ignoring returned value here doesn't cause
@@ -1505,7 +1526,8 @@ acpi_video_bus_get_devices(struct acpi_video_bus *video,
 	 */
 	acpi_video_device_enumerate(video);
 
-	return acpi_dev_for_each_child(device, acpi_video_bus_get_one_device, video);
+	return acpi_dev_for_each_child(video->device,
+				       acpi_video_bus_get_one_device, video);
 }
 
 /* acpi_video interface */
@@ -1939,20 +1961,6 @@ static void acpi_video_bus_remove_notify_handler(struct acpi_video_bus *video)
 	video->input = NULL;
 }
 
-static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
-{
-	struct acpi_video_device *dev, *next;
-
-	mutex_lock(&video->device_list_lock);
-	list_for_each_entry_safe(dev, next, &video->video_device_list, entry) {
-		list_del(&dev->entry);
-		kfree(dev);
-	}
-	mutex_unlock(&video->device_list_lock);
-
-	return 0;
-}
-
 static void acpi_video_bus_free(void *data)
 {
 	struct acpi_video_bus *video = data;
@@ -2039,9 +2047,9 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 	mutex_init(&video->device_list_lock);
 	INIT_LIST_HEAD(&video->video_device_list);
 
-	error = acpi_video_bus_get_devices(video, device);
+	error = devm_acpi_video_bus_get_devices(dev, video);
 	if (error)
-		goto err_put_video;
+		return error;
 
 	/*
 	 * HP ZBook Fury 16 G10 requires ACPI video's child devices have _PS0
@@ -2090,9 +2098,6 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 	list_del(&video->entry);
 	mutex_unlock(&video_list_lock);
 	acpi_video_bus_unregister_backlight(video);
-err_put_video:
-	acpi_video_bus_put_devices(video);
-	kfree(video->attached_array);
 
 	return error;
 }
@@ -2111,8 +2116,6 @@ static void acpi_video_bus_remove(struct auxiliary_device *aux_dev)
 	list_del(&video->entry);
 	mutex_unlock(&video_list_lock);
 	acpi_video_bus_unregister_backlight(video);
-	acpi_video_bus_put_devices(video);
-	kfree(video->attached_array);
 }
 
 static int __init is_i740(struct pci_dev *dev)
-- 
2.51.0




