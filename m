Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1368414A04;
	Mon,  6 Jul 2026 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341208; cv=none; b=ba7kKQomqyBjO1TvG0Ipa4koyrGr6KAFEfCY+eDLJj1nZJx6o4E/4kgddKX1Bymp8LSeCX4etFi/rjNyqp0btA0qweqgkQmt5pcZ1vSGzje4KjRf7iGO/EzNNckkTyrsRsVALlOqK+B6nm3PNpJ0rgMjUgu56K2OLahXyjKIEog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341208; c=relaxed/simple;
	bh=IZwmi8Dh5dC52ztDQBstSi8jpZvhUbFjaLZ+lzlijiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UjAzJeb9MbtbB0BProEA0/MGVjPzdziSb/qCytweIDpf1zECSxwCcsR3O+k1KKSRQP+vyv/oxUXaI6uyWK//Z4IJxLOKbThvxGBeXEPpgVS14i6H7NAq3ufz+lzEP3AEeKvuH9L4qR3AOvEYyGKZ3IUgwHByo9Cqh+Cx5zgcY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkZQDUe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkZQDUe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED481F000E9;
	Mon,  6 Jul 2026 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783341206;
	bh=janF2X2dIHPCZDye4lc7EkaV6cFt55A8vWTTLJeaFx4=;
	h=From:To:Cc:Subject:Date;
	b=fkZQDUe7ohGU8ikQrO8CPZAQQBqGSPIdEzX01viUDQvpGusGLVBCsY0D36+r7j1tL
	 Fe0n7/W7/jqQc4+f3r4Jf9IsNHio/BQZ68VJ0qqAq0Ul6pYM8CIWmEIUZIa9G4XmU7
	 jfBxjVejkognWYIsHBx2uzNr6SupB41LlqT/wGoNM8ldQDRYhjVbi6q9gV745S3HVN
	 Ys/b7OMgfVVDgVxBykGSMgkwOso79aSOPLw8FyvEXrMgcRGmWFJAARb/FQNPhLdYq8
	 5VQeXCu5TLQAIySIQtcKNOT0rKfNUx2bJIHTfszdfNJ29u+T1OUqwlwOnIwF7MSsag
	 WXmIPBqgnIblA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: loongarch@lists.linux.dev, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1] platform/loongarch: laptop: Stop setting acpi_device_class()
Date: Mon, 06 Jul 2026 14:33:23 +0200
Message-ID: <2444678.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The driver populates acpi_device_class() which is never read afterward,
so make it stop doing that and drop the symbol defined specifically for
this purpose.

No intentional functional impact.

This will facilitate the removal of device_class from struct
acpi_device_pnp in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/loongarch/loongson-laptop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index 61b18ac206c9..f2dcc6d78051 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -30,7 +30,6 @@
 #define LOONGSON_ACPI_HKEY_HID	"LOON0000"
 
 #define ACPI_LAPTOP_NAME "loongson-laptop"
-#define ACPI_LAPTOP_ACPI_EVENT_PREFIX "loongson"
 
 #define MAX_ACPI_ARGS			3
 #define GENERIC_HOTKEY_MAP_MAX		64
@@ -167,8 +166,6 @@ static int __init setup_acpi_notify(struct generic_sub_driver *sub_driver)
 	}
 
 	sub_driver->device->driver_data = sub_driver;
-	sprintf(acpi_device_class(sub_driver->device), "%s/%s",
-		ACPI_LAPTOP_ACPI_EVENT_PREFIX, sub_driver->name);
 
 	status = acpi_install_notify_handler(*sub_driver->handle,
 			sub_driver->type, dispatch_acpi_notify, sub_driver);
-- 
2.51.0




