Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B153CBE7A;
	Fri,  3 Jul 2026 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078754; cv=none; b=seoCdiLPAc01iCbipemTWxVKBMCU0iaKem079do4FkHSgeUxT5NznuHemptwlnFkMxk6Sf4oK1MULYiDIz0qWZiZwX6dO+BXHMqexTSVnAPz+DhNTONSZUbtxf0eUiJJfl9tW81k9OtVBYcoHfNuRsC3ANonI21bdIEy4WW2NyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078754; c=relaxed/simple;
	bh=2CjO7Lm/sizU0fMJRsVHZiu4TCaLbbZE++EI1orKRvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttNfE9qdUnfLW9CzLrbvox60sYmICD8SGfhkl6+YNjMrJw8L/XUtKayo4r/+TzZQuGs0hLvobl13GOULB+TJWpyZK8TW9HQpPSZtEu6zfW4wzyQSSNN8OOY1mE4VV/g2hGingSU4ATHIzPrTiSRbgGOjZzHbBMvtourLxUOkKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiCOI+Ml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiCOI+Ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C33F1F00A3A;
	Fri,  3 Jul 2026 11:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078752;
	bh=V1QwAd6IMRAyqU0LtmkfaRAM+5PJjWpxTwOMH+XexfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JiCOI+Ml8xqjeYa1sbh8Kin4OXcpsdBmxr7KEC8q1NjmwO85SCezRkOr7D5+H1CVN
	 uITtZIq9QN5SPhMxHgaDrMER/i9Rwo9VgAtv7SvemUlpxYQIkiXSOIJd/Hnd/QapZL
	 iwnulex7vunenmVl2+D/JvyeOH0V89a+tH7ld3uYSJ1IoUdPyfWDQJUrX7B3snU/Gn
	 VxLECWE8rDZQyvDAxqo2E0uj1xLuGAM2mI/9rOIz1gUfMx51kRaFpwQ/2V53lS2KMf
	 f0CMxw43+52qReFd90PxQxLBRPAc0eAMb2/GItpGE0V9+NXSUYzuYnWGSjJyzp2r5C
	 GFzsGcYzULqNw==
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
 [PATCH v1 01/10] platform/x86: asus-laptop: Stop setting
 acpi_device_name/class()
Date: Fri, 03 Jul 2026 13:19:59 +0200
Message-ID: <5106055.GXAFRqVoOG@rafael.j.wysocki>
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

The driver sets acpi_device_name() which is never read afterward,
so make it stop doing that and drop the symbol defined specifically
for this purpose.

Likewise, acpi_device_class() set by the driver is only used for
generating ACPI netlink events, but the "hotkey" string literal may
as well be used directly for that, so make the driver do so and stop
setting acpi_device_class(), and drop the symbol defined specifically
for this purpose.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/asus-laptop.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 140ac8a10537..449addd1ac7a 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -42,8 +42,6 @@
 #define ASUS_LAPTOP_VERSION	"0.42"
 
 #define ASUS_LAPTOP_NAME	"Asus Laptop Support"
-#define ASUS_LAPTOP_CLASS	"hotkey"
-#define ASUS_LAPTOP_DEVICE_NAME	"Hotkey"
 #define ASUS_LAPTOP_FILE	KBUILD_MODNAME
 #define ASUS_LAPTOP_PREFIX	"\\_SB.ATKD."
 
@@ -1524,9 +1522,8 @@ static void asus_acpi_notify(acpi_handle handle, u32 event, void *data)
 
 	/* TODO Find a better way to handle events count. */
 	count = asus->event_count[event % 128]++;
-	acpi_bus_generate_netlink_event(asus->device->pnp.device_class,
-					dev_name(&asus->device->dev), event,
-					count);
+	acpi_bus_generate_netlink_event("hotkey", dev_name(&asus->device->dev),
+					event, count);
 
 	if (event >= ATKD_BRNUP_MIN && event <= ATKD_BRNUP_MAX)
 		event = ATKD_BRNUP;
@@ -1840,8 +1837,6 @@ static int asus_acpi_probe(struct platform_device *pdev)
 	if (!asus)
 		return -ENOMEM;
 	asus->handle = device->handle;
-	strscpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
-	strscpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
 	asus->device = device;
 
 	asus_dmi_check();
-- 
2.51.0




