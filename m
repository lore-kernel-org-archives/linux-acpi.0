Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B0407CC8
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591080; cv=none; b=ZCXjKS9psDPpp9Z9O1GrV60ULLC3Efro9YQAPHIea6Sr/0CJudAprZBKbqDdLPnqiDOOlJXbWc2/VCjB3qxxl8noYmPInkHn7Ryx9kZrtP4xgG02JaGl9NLKSFsyeh2Z1r0ip8PrYg7kauqSP0tESoTq2eP7O7aG3kuO5TU6Hk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591080; c=relaxed/simple;
	bh=8mYc+Nbjm6+sQSrADVmvWRSMeKKljH7evJpSSNXklR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blN3DHP2hleYOayHkFadsOZN4JKua7JAbKn0jjT153PkXqM9oBna7VlqasPZXRdldSwt3Wrmku7HRBL3eFzU+6CUotl0Mi4e1oJiVB8MBtRFZtfDa9SebvUwMmDeDsKkSCLyeyvULzyLkKoB67cFs3QzqO2QMTECBNJJby985nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cDYIfjw0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cDYIfjw0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacf197759so26005905ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591078; x=1784195878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZO05xNK1Hbq+tmP+bxjD79MnCLqnvQlOFToHRwo4P0Q=;
        b=cDYIfjw0tctxjV3LHr28wZw9HbFx0L59CuLb636tk53eH0xU2HiwPhvAuL8JzpDcrU
         XeZJOnKHysmF3AnmritDPjyvF7sF8zPc1FkSLZXuos3fWoIPowIJWcTT/B4bTw0UQ9nR
         f9Zjs5VWNq9gbpVMDZqmQLs7n+FlXIL88kkGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591078; x=1784195878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZO05xNK1Hbq+tmP+bxjD79MnCLqnvQlOFToHRwo4P0Q=;
        b=h141wmZ+ZkTTh+z+5m9H11dNaKoIWH/Hc3h+9PkZ69EEeePdsGHIoDmVAtHKrCfjKI
         6Z6ugpCiutHj+BQKrAZ1rD67IgKANtSwpL7XEIFlvksHNQaevz70nj+1eaNGcHFH4jRS
         0zThaFD/eBbvP4GX6IiplJ7xh7z8johTUens1BKYn1C4Wgpn4ZnZ3wsLn/Lad7F3Xcet
         zvQy8cexq0njP2wqQ8PsxjzhSW6cMzbKzOxjP+atpVbANCeBizSDppiCz05Gdco5ZVWu
         uKXe8m/iT188L3BN5rUjiWtdixVXw/v2PLGFJd2WfZ3olABCO3dodLbe0NGaBT0Enjke
         8TKQ==
X-Forwarded-Encrypted: i=1; AHgh+RqF6tUUnUbAQsAwgadRVOI9VXx7l/E3xHPmBuMU/R36Jsh7H/kDGK0xb3RX+luJ5JV586oBiFwTSw5l@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1h0ZvhG0y3d+krkmGdG6LR3rndoT13/WsUMBDnIi2kQQlXOtL
	XHboeWypDSO5KoomjN84c6Uipcni6FhRPvP8nGMqVDBRcFf2Z+neOLDGaCC25Wac7Q==
X-Gm-Gg: AfdE7cnvokxm0ivdKBWq5CnRiqc0a3papAhrI79zNv7J5+lpzZdiz4ZyNTYLvPt58R2
	Jd/21nnBlMDPBQDcDY7NKNuKKhDec9oDyTYFQW6T6h9s62VVg5HJeh7F4tqZds7QDRjkQFKrHax
	chYmFMobAEgdAwvf8xE+fC9hJ0t3KP6Z70JAbPddAo9xzyjokxrzj7HntzvXUhztIPOmGfT67UF
	nCSNdD0Rfis0YPlPvexWc9SoWlBQajtIX0FzdLgbpeeUmtJmeqOMFvH8/J7I74IwMYkc8ChT6A9
	FJSALPNQ3g/6qCqYaptM8kk/sH3H6zNioymLuvtA/Ii5R9bYUf/tM3Cyb8u5GbwtaqU6oafBE0X
	3aPFY1O6cKy3aRd9u+cGg1cAmaLWWNoeV5/Fuh9DeTkRovGWakoLvmJI6J5PKOLS1AZfjI1Gbmq
	rjJIWt3c3W/wM4bt4mQW/iRkSXHH6e11VJwk6siN+MallsrvKbCE4BAhDnkWknKDU4+GFBTw==
X-Received: by 2002:a17:902:e78e:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2ccea1a4d4cmr66175845ad.0.1783591077993;
        Thu, 09 Jul 2026 02:57:57 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:57:57 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 04/14] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Thu,  9 Jul 2026 17:57:09 +0800
Message-ID: <20260709095726.704448-5-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260709095726.704448-1-wenst@chromium.org>
References: <20260709095726.704448-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addition of power sequencing descriptor handling in the USB hub code
requires dealing with deferred probing from pwrseq_get(). The power
sequencing provider may not yet be available when the USB hub probes.

Return the actual error code from hub_configure() when it fails, so that
the driver core can notice the deferred probe request.

Also rewrite this section into the standard error handling pattern:

    if (error) {
        # handle error
        return error;
    }

    # do more work
    return 0;

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Rewrite into standard error handling pattern

Changes since v1:
- Moved "int ret" declaration in hub_configure() over here from the next
  patch
---
 drivers/usb/core/hub.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 13264e86bc6d..fe10d72ef39d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1874,6 +1874,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_host_interface *desc;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -2005,14 +2006,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		usb_set_interface(hdev, 0, 0);
 	}
 
-	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0) {
-		onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
-
-		return 0;
+	ret = hub_configure(hub, &desc->endpoint[0].desc);
+	if (ret < 0) {
+		hub_disconnect(intf);
+		return ret;
 	}
 
-	hub_disconnect(intf);
-	return -ENODEV;
+	onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
+
+	return 0;
 }
 
 static int
-- 
2.55.0.795.g602f6c329a-goog

