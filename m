Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4C3115A5;
	Thu, 21 May 2026 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372719; cv=none; b=DWItRY2AmOFl1Xdw6EmVuioyMG3pYWdOuKzLokYKzO6W7flNWMr0ZMqzjsht883UPCgLOAZuUJ67fZpi5jHvbMvSbWnx0ZlDDzQTFwdpnjR6MgLUzNIBhithCnPYdxcRVLT2LEEdLaUqLvn/7/mSigRrECqVMU0Q7Z44kLP3eGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372719; c=relaxed/simple;
	bh=7AhAxOMJWRWNIlMJkOZRPJTtEv3Nmu90tXktGIjgPUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0T/M9cFhj/nNXI0x6PWov/f85nbjd9EkSGZ9ANfV3BVBVsbCs54QxY9hUEhpsjJxSZGL0xJkIpi26dbPcbmqkNeejDaFZPCRfoZmdEn088glZtc1B7bZ3DVkN5N6IdtkA2wXkNXO066tTOahHT1MSDl2AtA7MHM6cgda/MaS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG7W2bfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG7W2bfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796101F000E9;
	Thu, 21 May 2026 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372717;
	bh=g/N3HlwCvnDeNTAPLa+2QE+cnpfQCcw/DVKgbAwKJPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MG7W2bfMRNty8IVV4ltrU50TaZ0pzOnV0g0g3YVHaBL8gi5QVZh8e0ZfWn6GVrZVb
	 nLhbBUqHndh1Ex7Wib8kCDdC5mIwzrUvBnhy6u2gXsjWhEWMWR0FMTYxNZ4e4In5SJ
	 tM93F1Kp5Ptw8U+YosLK6z40z1QtA3xZYLEP1lCPGjdconaNuv5MKFEzLM+xSsIzS7
	 G7DGqotMOkVBtvvR3z1EkMMYMUEoMHGhsUTPbDqtcE3TV48ruYLI20IbrElk/4SlZg
	 jqro6bNVMQsMp/oQbS0EW7pKpL9hfbDHTHMEdhY10HPUzcSjDlspHxufhfzo6mO0Xe
	 FqJo1IWj7267w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 16/17] ACPI: video: Use devm for video->entry and backlight cleanup
Date: Thu, 21 May 2026 16:10:55 +0200
Message-ID: <2279582.Icojqenx9y@rafael.j.wysocki>
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

Introduce acpi_video_bus_del() for removing the video bus object
from the video_bus_head list and unregistering backlight and make
acpi_video_bus_probe() add it as a devm action after adding the
video bus object to the video_bus_head list.

Accordingly, remove the code superseded by it from
acpi_video_bus_remove() and from the rollback path in
acpi_video_bus_probe().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index a02eaf13f5d8..e0da168a1df3 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1969,6 +1969,17 @@ static void acpi_video_bus_free(void *data)
 	kfree(video);
 }
 
+static void acpi_video_bus_del(void *data)
+{
+	struct acpi_video_bus *video = data;
+
+	mutex_lock(&video_list_lock);
+	list_del(&video->entry);
+	mutex_unlock(&video_list_lock);
+
+	acpi_video_bus_unregister_backlight(video);
+}
+
 static int duplicate_dev_check(struct device *sibling, void *data)
 {
 	struct acpi_video_bus *video;
@@ -2080,9 +2091,13 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 	list_add_tail(&video->entry, &video_bus_head);
 	mutex_unlock(&video_list_lock);
 
+	error = devm_add_action_or_reset(dev, acpi_video_bus_del, video);
+	if (error)
+		return error;
+
 	error = acpi_video_bus_add_notify_handler(video, dev);
 	if (error)
-		goto err_del;
+		return error;
 
 	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
 						acpi_video_bus_notify, video);
@@ -2093,11 +2108,6 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 
 err_remove:
 	acpi_video_bus_remove_notify_handler(video);
-err_del:
-	mutex_lock(&video_list_lock);
-	list_del(&video->entry);
-	mutex_unlock(&video_list_lock);
-	acpi_video_bus_unregister_backlight(video);
 
 	return error;
 }
@@ -2111,11 +2121,6 @@ static void acpi_video_bus_remove(struct auxiliary_device *aux_dev)
 				       acpi_video_bus_notify);
 
 	acpi_video_bus_remove_notify_handler(video);
-
-	mutex_lock(&video_list_lock);
-	list_del(&video->entry);
-	mutex_unlock(&video_list_lock);
-	acpi_video_bus_unregister_backlight(video);
 }
 
 static int __init is_i740(struct pci_dev *dev)
-- 
2.51.0




