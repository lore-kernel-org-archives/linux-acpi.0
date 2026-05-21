Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F53D3E314D;
	Thu, 21 May 2026 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372756; cv=none; b=pmBlCYgURDa4J2q8lHD4S6SEVnykhdsAawRD5r1T9n9Vd6QTK1PN1h69F0O/2IMo5tIdp2pMlKr2GSCi2/xQfsd7octeNNwy0Zv9P9FjXY2zrhWkxmpgTLtbe00kArJOYGFrDjF4tmSC+O453gOc6K6JAlTw1XQH+VRYHzPm2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372756; c=relaxed/simple;
	bh=lirmh22xLVzQiHvZnGRWlEGFzUAiScnluVx7qHRrIuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbDbMAC9NjcWrvi7wljUQuwi8hj0+Mh5t8V6+S31+s2CN5UL1aw6vCxdzCfFcLWwg/y0c7edb1QEGVv0V0WhrShsgVPcKC3pqZWHbYJy/lfaUPnu01ZeYkKKvKUIrTRmx4sbF4vLb0c1GJI5PDe6+7cIkF9rdwcSrJtERG5z5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0xMyc5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0xMyc5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE17B1F000E9;
	Thu, 21 May 2026 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372755;
	bh=QbCWuLC4SLlfQgmp7Hsp84RlyG6DD5T4QGH1pmNYTVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0xMyc5LKWNMi3UjWVTncQgS2tW/slqZZ976MTrwVnE2SjVkKrnVVRccwHsagE7iC
	 bMb9Znn83PPqP4RY5679QJ4JBoO1O13VCFh023Xwro/oQKD1cC39PC+bph4aeEPwh6
	 B196BRstKjO/toEzrfziL+XujC81E31FiglHeKGuLXX2LBBDYA2CkKPlploavmuCe5
	 8Kn38RmRPdtACE6XEc0iVOR51PeQu1fRsrYfJ03GdJBCG5shljuPod+HzAcj/h74Bx
	 K3J0+9qCS6nyH69zlH2h/H5rjzaqik+ruhEZDcBl4gKwxiVqY/6KttcpPP2x9U5vKq
	 MHL+NGM4pEWLQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 05/17] ACPI: HED: Refine guarding against adding a second instance
Date: Thu, 21 May 2026 16:03:23 +0200
Message-ID: <2042970.PYKUYFuaPT@rafael.j.wysocki>
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

There can be only one ACPI hardware event device (HED) in use at a time,
so acpi_hed_probe() uses static variable hed_handle for guarding against
adding a second HED instance, but there is no reason for that variable
to hold an ACPI handle, so change it to a bool one.

While at it also set that variable at the end of acpi_hed_probe() to
avouid the need to clear it when installing the ACPI notify handler
fails.

Note that ACPI devices are enumerated sequentially, so there's no need
for additional locking around the accesses to that variable.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/hed.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 060e8d670f5d..4b5dc95922ea 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -22,7 +22,7 @@ static const struct acpi_device_id acpi_hed_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, acpi_hed_ids);
 
-static acpi_handle hed_handle;
+static bool hed_present;
 
 static BLOCKING_NOTIFIER_HEAD(acpi_hed_notify_list);
 
@@ -58,25 +58,25 @@ static int acpi_hed_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* Only one hardware error device */
-	if (hed_handle)
+	if (hed_present)
 		return -EINVAL;
-	hed_handle = device->handle;
 
 	err = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
 					      acpi_hed_notify, device);
 	if (err)
-		hed_handle = NULL;
+		return err;
 
-	return err;
+	hed_present = true;
+	return 0;
 }
 
 static void acpi_hed_remove(struct platform_device *pdev)
 {
 	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
+	hed_present = false;
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
 				       acpi_hed_notify);
-	hed_handle = NULL;
 }
 
 static struct platform_driver acpi_hed_driver = {
-- 
2.51.0




