Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E43C416B;
	Fri,  3 Jul 2026 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078724; cv=none; b=hBUUOrOO0t5r2gMhHVn7WFnCl+pxBgWLIHcbt0WIjytsF8wtWxW9aVUHAowvs1KFHt8qpz4lM4JnyJvMBRMw2J4N8faRdb+r9JO1HJWajSAlzr2uOBhe/IknPcRa+UxirfgAG/PBVwDPR1BC5482oun/vToUZxqcJhCRLdi12mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078724; c=relaxed/simple;
	bh=vdEWfp2W8zZYyy/5gOlAsLbYvMNnsVT7/VzoXV4pU7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kf3L92M2OdvmoDWsRqpeEtNBo/VRNO5IaSeSJY9OC5XAojsXyORwz4LRYGkEQV3q4IVLtblOJxk9cQsbTwrurVs/A8LhXpwgFje6cOuEh096tCzC1/QZvOEzk2GG6HbCSyZGDFjotttak/MGBFaMrBzaMSj7rFD5m6j0uWV2B/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtSS9Rz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtSS9Rz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938AE1F000E9;
	Fri,  3 Jul 2026 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078723;
	bh=+1g0a/oI7q8NS+FNjuOV9wiQn/4kU8SwMtrcV+zt1SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtSS9Rz8gBgjAVMTv168NynWaVTbZRlaa8mBtSceXVM7o5F4rTc+YC9QnGAVPqhil
	 w33d3JvxAK+Gzd54Fq5kV4ZjTjcu45JFBDcTuGNO/hRqE1fTM4beLqnf+BnLO6HJ4f
	 OVz/I5FHMLeSJWKsUvTl7Vi6fYK0DwpSlNBJgR9PpK7/LbZWwVUDxB5XtkkIdExfPd
	 QLjKZ/ql4MjkUk0GNwhE9wQb2VqA/FubNcOydC0TIysMsZuSXw8oQZqqelKZKqGNJY
	 tb9ghVVhgwjHHKLs+s+yHbJvgub84SkzQTy0Z38ntGeolJEMDhSF8QkLgiNWX2bc93
	 H/D1JhGfxIJMw==
From: "Rafael J.  Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <denis.benato@linux.dev>, Jonathan Woithe <jwoithe@just42.net>,
 Robert Gerlach <khnz@gmx.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, Mattia Dongili <malattia@linux.it>,
 Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 07/10] platform/x86: sony-laptop: Stop setting acpi_device_class()
Date: Fri, 03 Jul 2026 13:32:31 +0200
Message-ID: <9664323.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5135166.31r3eYUQgx@rafael.j.wysocki>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Since acpi_device_class() set by the driver is only used for generating
ACPI netlink events and the "sony/hotkey" string literal may as well be
used directly for this purpose, make the driver do so and stop setting
acpi_device_class() in it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/sony-laptop.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 67370967df6f..0bf4d3054e37 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1264,7 +1264,7 @@ static void sony_nc_notify(acpi_handle ah, u32 event, void *data)
 		ev_type = HOTKEY;
 		sony_laptop_report_input_event(real_ev);
 	}
-	acpi_bus_generate_netlink_event(sony_nc_acpi_device->pnp.device_class,
+	acpi_bus_generate_netlink_event("sony/hotkey",
 			dev_name(&sony_nc_acpi_device->dev), ev_type, real_ev);
 }
 
@@ -3157,8 +3157,6 @@ static int sony_nc_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	sony_nc_acpi_device = device;
-	strscpy(acpi_device_class(device), "sony/hotkey");
-
 	sony_nc_acpi_handle = device->handle;
 
 	/* read device status */
@@ -4523,7 +4521,6 @@ static int sony_pic_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	spic_dev.acpi_dev = device;
-	strscpy(acpi_device_class(device), "sony/hotkey");
 	sony_pic_detect_device_type(&spic_dev);
 	mutex_init(&spic_dev.lock);
 
-- 
2.51.0




