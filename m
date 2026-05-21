Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96053090C2;
	Thu, 21 May 2026 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372732; cv=none; b=JjPa+FnFvVsWW+CHiNhHmKSMWQwkMSs+SVtauTXdpw3DKda4iub+2xTV4Gm1c5TLIAdz4Qdaq2XmLyDMPIqQOHBiTeMt5nPI3EOH+22caqmcH1xNsgbiNMkyjAlidL7EP4J/JinIKVtfkztJ/91Z6Kwq31Hydpupb3dRsQAEgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372732; c=relaxed/simple;
	bh=Lt0999yu/B8ee1c5tV3uzLldGsqF2n6m1wmRCPHS+/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEsaZiNL0KXejHDHDz9srHXbwBcypbh7tkx8wdZLWCc+UHo2yfTi215UB9de8AI/N2mT7BBZMOecWHnf7J9V6sddhkyfjVey7KGP462imQ8FoKwsLQwhKUv76FGEVQp2xhMNfIr448GjHXLootBltIhmCgY1tRriRP1pngq0jJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW9RFoHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW9RFoHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EF21F000E9;
	Thu, 21 May 2026 14:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372731;
	bh=V8RZL3VY/72mLVEX7rh3A1MeqlX2wAIv2GyMJei0l9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QW9RFoHZI5aDP82E4wEVDhOoVYzBS5qDOrnbkxlI7shaxTwmlqevb0KECftXvE5qA
	 8IAoQ4rqiGTrQt2hgXizjT0xw+EMWEKh6JoxNZ/7zTLf+KZV3Mz4Dr1fCsPf3ASclV
	 ZRmiq6seoQPfEtdc4qcbySrvjN6D3F8S/WK59UzAi6s+Id2OiTrSS5tjxrNSn3uZaV
	 h6ZdG8yz7QWfdj5080+OyJfIn9MXn8rg2qR3qeS6Ovn5a1KwdI29so5S2mZJ6thy12
	 LBm4PSYEH4UuZd3VixXfCR2b3rsRgi4hDbcCT9D+MZpQCOkX6XxxpUe+ilebn2KVhp
	 fVU3Pbwsghmlw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 12/17] ACPI: video: Reduce the number of auxiliary device
 dereferences
Date: Thu, 21 May 2026 16:08:16 +0200
Message-ID: <2707186.Lt9SDvczpP@rafael.j.wysocki>
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

Store the &aux_dev->dev pointer in a separate local variable in
acpi_video_bus_probe() to avoid dereferencing aux_dev many times.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 05793ddef787..bdc3f4933abf 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1978,7 +1978,8 @@ static bool acpi_video_bus_dev_is_duplicate(struct device *dev)
 static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 				const struct auxiliary_device_id *id_unused)
 {
-	struct acpi_device *device = ACPI_COMPANION(&aux_dev->dev);
+	struct device *dev = &aux_dev->dev;
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	static DEFINE_MUTEX(probe_lock);
 	struct acpi_video_bus *video;
 	static int instance;
@@ -1988,7 +1989,7 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 	/* Probe one video bus device at a time in case there are duplicates. */
 	guard(mutex)(&probe_lock);
 
-	if (!allow_duplicates && acpi_video_bus_dev_is_duplicate(&aux_dev->dev)) {
+	if (!allow_duplicates && acpi_video_bus_dev_is_duplicate(dev)) {
 		pr_info(FW_BUG
 			"Duplicate ACPI video bus devices for the"
 			" same VGA controller, please try module "
@@ -2059,7 +2060,7 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 	    !auto_detect)
 		acpi_video_bus_register_backlight(video);
 
-	error = acpi_video_bus_add_notify_handler(video, &aux_dev->dev);
+	error = acpi_video_bus_add_notify_handler(video, dev);
 	if (error)
 		goto err_del;
 
-- 
2.51.0




