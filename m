Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C7383993;
	Thu, 21 May 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372726; cv=none; b=h7T0EXjO15JHUak/aP44UIIxWJLOOG2A/yNwLefNbNZFmImr7mleLlVmR7xRkJOojXqwKK8JrnigZ5Sgdx3y+lL501ggnJrpGbXHSuhuSEcnVC/54WgGmT4UxTLyB3weQ7CtgYpG4sYntH7Xmk9a+qi18W8LF6nPRisf7Er0MAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372726; c=relaxed/simple;
	bh=IZk7TYsEQJ738nSUoRUj+MBIawLa1nktPCgabuONi1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjW0Y6xlhUBAOFd7Eur+xM07K6p0PFL4mDEzrX/uXpJ4PvsYgZJvlQqBChxw4LANDiVBck4rd4gJ4CMyKKRt+Mg92TJQlSTzv8qaTuxJKiHNaN5FBC1qednddMDaiulfYYF2Qfu8WLbgqKCVBmTBnh1lEvu28lKPODx7dW5Kn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv29qCdS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv29qCdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5736C1F000E9;
	Thu, 21 May 2026 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372724;
	bh=abIl4Q2S8mi17WsciCREITaiE3k75gAuSfdeWfQI+sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hv29qCdSHczvcb9CrlWQYfIxY7K8twMCX0IvghCtZBv/pPv994APLnWRaWmB0jBxU
	 tLjvWwKFcpCaDNZoB71IeLVHHC52BJusyzF9o0rnttaVkLy58yNbYkH+3ihxdMM4IN
	 Ka1RiuqgNheQPpSJrymd/t5vkH8ssV11Bq28GOxoq1mm6NWBUG/qKVBYyKlZ6oVw7u
	 f+obzWl0PQ6aIROlKnkicIfJP9atM3AhleOQsig2MF+C/srsafpN6Q+DkwT7ymvgT2
	 XMDBaKerZkOu0aVI53+ojS/gNRQjF2l//5hzeOO7vjD2ujt0jZyVL5DhBnqEMP9OUG
	 fL1adMr6I7vZA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 14/17] ACPI: video: Use devm action for video bus object cleanup
Date: Thu, 21 May 2026 16:09:35 +0200
Message-ID: <3892168.MHq7AAxBmi@rafael.j.wysocki>
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

Introduce acpi_video_bus_free() for freeing video bus object memory
and reversing changes related to it made during ACPI video bus device
probe, modify acpi_video_bus_probe() to add acpi_video_bus_free() as
a devm action, and remove the code superseded by it from
acpi_video_bus_remove().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index ca2bee967946..11dd00614f6b 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1953,6 +1953,14 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 	return 0;
 }
 
+static void acpi_video_bus_free(void *data)
+{
+	struct acpi_video_bus *video = data;
+
+	video->device->driver_data = NULL;
+	kfree(video);
+}
+
 static int duplicate_dev_check(struct device *sibling, void *data)
 {
 	struct acpi_video_bus *video;
@@ -2005,6 +2013,10 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 	video->device = device;
 	device->driver_data = video;
 
+	error = devm_add_action_or_reset(dev, acpi_video_bus_free, video);
+	if (error)
+		return error;
+
 	/*
 	 * A hack to fix the duplicate name "VID" problem on T61 and the
 	 * duplicate name "VGA" problem on Pa 3553.
@@ -2022,7 +2034,7 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 	acpi_video_bus_find_cap(video);
 	error = acpi_video_bus_check(video);
 	if (error)
-		goto err_free_video;
+		return error;
 
 	mutex_init(&video->device_list_lock);
 	INIT_LIST_HEAD(&video->video_device_list);
@@ -2081,9 +2093,6 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 err_put_video:
 	acpi_video_bus_put_devices(video);
 	kfree(video->attached_array);
-err_free_video:
-	kfree(video);
-	device->driver_data = NULL;
 
 	return error;
 }
@@ -2104,9 +2113,6 @@ static void acpi_video_bus_remove(struct auxiliary_device *aux_dev)
 	acpi_video_bus_unregister_backlight(video);
 	acpi_video_bus_put_devices(video);
 	kfree(video->attached_array);
-
-	kfree(video);
-	device->driver_data = NULL;
 }
 
 static int __init is_i740(struct pci_dev *dev)
-- 
2.51.0




