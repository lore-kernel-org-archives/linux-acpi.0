Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04922D3A75;
	Thu, 21 May 2026 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372715; cv=none; b=SRq53ePYjZf7qW50HmJran4BoBtfvfDwFPS4gHpX8x+YOafwSFPQZKozElbTNT401B9QTv4M9ctC5PeXuzzr+Vn4wtUl1vhE1UuhVcd+FNS26zepKdkN/XAlXYaRylyB2QfPTyIO7dBagl1RZQUQQeXP8m3pRqYbi8g3gdQ0V34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372715; c=relaxed/simple;
	bh=qzpPyPYIdeJr1pAfHx2wW4GoCdHuONDCpyHxWUNk/3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7JIicMkqjeseSI/61ZjHc6/j7pX5uTAbE+QhfqNhAzCbZVnp9jk7xPkE84P/tx681Tdq3JenP5B6821i1Wwr/Y7l9oW9MJp/NZlcHRn0/xchMEg9CeACW7nO0wiT6pzWeP+zrdAR7WnoMqr87toqGnSMsrXjpmN/roBAbgMHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho5CAgF2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho5CAgF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EC21F000E9;
	Thu, 21 May 2026 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372714;
	bh=vQp3Q6xtHWzu7duKObhdr5kE5UUwLyO3B76lYZd24aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ho5CAgF2rQeU06EbyYZHRhzomKhFJ+i+niaaqiC/pZK1eg0GJ4uobc4FspuK/28Ab
	 H5Iz01U0PifUUnQpECslmXbSw6q6bJzJuJMf6W/25UfkYaRoRRllWg1JO4tVE+I4Wk
	 2eGxPVMydZS9RExn0joVxTxDwvCuJ5lFhorzc2+bIPKuBbCMqH7h6ThMw+pG4rfvvM
	 yaobEEVlK0/evB39tvTZpVzgoyrrggM2dwq4po7gEFb53truilb4hqemMV+uQB7Vhv
	 QIsRHbauSOczSFjU+a7QuckIR1qbiNKTX4I+Ownbc/iqmqw29P7CBD2e0z9pDf4d9N
	 VqB/CAWZCsk6A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 17/17] ACPI: video: Switch over to devres-based resource management
Date: Thu, 21 May 2026 16:11:34 +0200
Message-ID: <2556320.jE0xQCEvom@rafael.j.wysocki>
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

Turn acpi_video_bus_remove_notify_handler() into a devm
action added by acpi_video_bus_probe() after calling
acpi_video_bus_add_notify_handler and use the newly introduced
devm_acpi_install_notify_handler() to install an ACPI notify
handler for the video bus device.

This replaces the rollback path remnant in acpi_video_bus_probe()
and allows acpi_video_bus_remove() to be dropped altogether.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index e0da168a1df3..e5a0b03f06b3 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -76,7 +76,6 @@ static DEFINE_MUTEX(video_list_lock);
 static LIST_HEAD(video_bus_head);
 static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 				const struct auxiliary_device_id *id);
-static void acpi_video_bus_remove(struct auxiliary_device *aux);
 static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
 
 /*
@@ -99,7 +98,6 @@ MODULE_DEVICE_TABLE(auxiliary, video_bus_auxiliary_id_table);
 
 static struct auxiliary_driver acpi_video_bus = {
 	.probe = acpi_video_bus_probe,
-	.remove = acpi_video_bus_remove,
 	.id_table = video_bus_auxiliary_id_table,
 };
 
@@ -1945,8 +1943,9 @@ static void acpi_video_dev_remove_notify_handler(struct acpi_video_device *dev)
 	}
 }
 
-static void acpi_video_bus_remove_notify_handler(struct acpi_video_bus *video)
+static void acpi_video_bus_remove_notify_handler(void *data)
 {
+	struct acpi_video_bus *video = data;
 	struct acpi_video_device *dev;
 
 	mutex_lock(&video->device_list_lock);
@@ -2099,28 +2098,13 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 	if (error)
 		return error;
 
-	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						acpi_video_bus_notify, video);
+	error = devm_add_action_or_reset(dev, acpi_video_bus_remove_notify_handler,
+					 video);
 	if (error)
-		goto err_remove;
-
-	return 0;
-
-err_remove:
-	acpi_video_bus_remove_notify_handler(video);
-
-	return error;
-}
-
-static void acpi_video_bus_remove(struct auxiliary_device *aux_dev)
-{
-	struct acpi_video_bus *video = auxiliary_get_drvdata(aux_dev);
-	struct acpi_device *device = ACPI_COMPANION(&aux_dev->dev);
-
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
-				       acpi_video_bus_notify);
+		return error;
 
-	acpi_video_bus_remove_notify_handler(video);
+	return devm_acpi_install_notify_handler(dev, ACPI_DEVICE_NOTIFY,
+						acpi_video_bus_notify, video);
 }
 
 static int __init is_i740(struct pci_dev *dev)
-- 
2.51.0




