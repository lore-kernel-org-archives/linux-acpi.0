Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44947313E00;
	Thu, 21 May 2026 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372729; cv=none; b=dcHKAPxQiY+AE8NseyNA459BvVyQ+BO95Im2R4g0oHf+0scOXLeU7ZXuN6vnUNhtp+2lS2AlTe6XFi5zvrU4hjdiyTRmO2AVzDjW8KewWn7ABxeX/DlndxTZnEGwUbaOMAJ0ApPTrvrmxFx/C9v3QaXMPQAkIwz9lartPI1JUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372729; c=relaxed/simple;
	bh=gw2pEdbWxy/S0F8et4oGZDtsu/iDZ60l2PZhx37HTY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyNPXUilLGLCshYRh2JamrCTq2Vu7PtT+bzJS7yNzzSctO1diTUPQUUbJPoMEWzBJNUAW1U9e74wmCjaK81PB+xnyfFPBLa3qt8y/4CJZc6Y7yQdg6fljbA6U7HDcSr4Cyq6P7EWzDJFtN4raK/KtDJd3vKz4TsCNaxB3G5ZGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNNEvOYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNNEvOYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA4D1F000E9;
	Thu, 21 May 2026 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372728;
	bh=qRndLbnjZC5SFJ2UEpjsiJADmxF/rXN4Lk54dIJw7V4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RNNEvOYP90M7V8OkaHhExjh62C5Fh4tufbN554dO898yaFh9WpjDc1h/uezrxlulW
	 RUysGk6fBzcJ+Mg7PHXeRz5dyT49jmDuvh1oWCZkUaEyXEq5TLGCrzanpcmnJ8jqCe
	 +vwabNV/fTPFk35p1Nzkf+myN9xb84CaEJgT5BXvLBZQNhMOfjGB3u27QLQNpRSr65
	 2rPAxWjvSZZdtXtU5lUV65m5Eaysz3azfWswqFKVYC/5+BLDZ1E9bkc96FTHnhzevG
	 W9xMriiRZNEGfm/Ks7LEqq1JTxj/Y+Kuj3TO/hgFlhds3op+bsJ0bMCcHOXCtDKgE3
	 8M6Zf30elct8Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 13/17] ACPI: video: Rearrange probe and remove code
Date: Thu, 21 May 2026 16:08:51 +0200
Message-ID: <2276683.Mh6RI2rZIc@rafael.j.wysocki>
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

Rearrange some ACPI video bus probe and remove code so that it is more
clear that the probe and removal are carried in reverse orders, which
will also facilitate subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index bdc3f4933abf..ca2bee967946 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2002,6 +2002,9 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 	if (!video)
 		return -ENOMEM;
 
+	video->device = device;
+	device->driver_data = video;
+
 	/*
 	 * A hack to fix the duplicate name "VID" problem on T61 and the
 	 * duplicate name "VGA" problem on Pa 3553.
@@ -2016,9 +2019,6 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 
 	auxiliary_set_drvdata(aux_dev, video);
 
-	video->device = device;
-	device->driver_data = video;
-
 	acpi_video_bus_find_cap(video);
 	error = acpi_video_bus_check(video);
 	if (error)
@@ -2041,10 +2041,6 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 		acpi_device_bid(device), str_yes_no(video->flags.multihead),
 		str_yes_no(video->flags.rom), str_yes_no(video->flags.post));
 
-	mutex_lock(&video_list_lock);
-	list_add_tail(&video->entry, &video_bus_head);
-	mutex_unlock(&video_list_lock);
-
 	/*
 	 * If backlight-type auto-detection is used then a native backlight may
 	 * show up later and this may change the result from video to native.
@@ -2060,6 +2056,10 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 	    !auto_detect)
 		acpi_video_bus_register_backlight(video);
 
+	mutex_lock(&video_list_lock);
+	list_add_tail(&video->entry, &video_bus_head);
+	mutex_unlock(&video_list_lock);
+
 	error = acpi_video_bus_add_notify_handler(video, dev);
 	if (error)
 		goto err_del;
@@ -2096,15 +2096,15 @@ static void acpi_video_bus_remove(struct auxiliary_device *aux_dev)
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
 				       acpi_video_bus_notify);
 
+	acpi_video_bus_remove_notify_handler(video);
+
 	mutex_lock(&video_list_lock);
 	list_del(&video->entry);
 	mutex_unlock(&video_list_lock);
-
-	acpi_video_bus_remove_notify_handler(video);
 	acpi_video_bus_unregister_backlight(video);
 	acpi_video_bus_put_devices(video);
-
 	kfree(video->attached_array);
+
 	kfree(video);
 	device->driver_data = NULL;
 }
-- 
2.51.0




