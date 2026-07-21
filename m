Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB314302E6
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616902; cv=none; b=IVg38JHG/xBepJD78AqB1LHs902G8StCXe0YatQIo3dil1nXEd3XxHxebBAeLTMrigXpuVmB45skwvSqAudhm7y74/ijOCvoUdeMX5OM9Pp7Ra640enzorDDGKkRr3rtdp425oPytpo4N+B4EtP68s2oPNHGYjS0aUyJGFxcRig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616902; c=relaxed/simple;
	bh=a0af6mRfXl6o/3aQ3C/YjqVxExTXT9xiwTDCu1uF7Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu3+zSSj5drPq02J6XvdbWlh806Lqan/YlVaEIoMdHRvYhzPtwICwpNK4Rf33OdbkjtwukR1lPNa4bAsbQDWV4xtzlhXb3WNZSl4vorN+het6/r6O/PzySP47paZWzgNG3HmRA1132TB0q5KYtjU9dpPcfv+Y86I4dnR/EHwBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NBBDrs/N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NBBDrs/N"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso81982025ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616900; x=1785221700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjG3+Srh1l1zMMK/k1OHJ2IZC5GaA1LItCzYqUBfaa0=;
        b=NBBDrs/NQavuacQelDdLBiYhlVe/vnCZtgSgZCweoqnblw2zw7vtbbK2kKVoJSCKmP
         Z9tnIvvap6QILEODnDzwAflKSsM3V0/Gk1ouNOJzHtWuWfT1cYPe/wPHsGrI2s7dpduP
         dJpZKdntutIwQsKg/AtNR+2au+rGVOJtv1lJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616900; x=1785221700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qjG3+Srh1l1zMMK/k1OHJ2IZC5GaA1LItCzYqUBfaa0=;
        b=bwPhzAqKdTNqJuNJzUR89GCMLQdrYmUEVu9U5PQOMLkn88C0wk3yAiyWVe6fLjDRHa
         FxxDU/+dvMhrVAymOI5uWfbFqV10SZwHBJflJr+67wnhrjRTsexeEH26AK82nZFp9bRu
         qA4ForVWUXtHTr21kDYmkAaA61dqMOkGZKccdBzy13XhNFMgl7Jec2UG0NASPzIhC61Y
         XcYXzhCAJECNeF93E2T1U0y+eqPxlhYFyn3R62ZiGCSzu5PT2N1RmjOtVVEhZQtHGbwy
         npAKbHv7jtGklMYtzSwyIVKq39xHG2b6C+6bYdY2yGvWH92vjhR+vyDN1T4ojkGdN8mN
         ZYmw==
X-Forwarded-Encrypted: i=1; AHgh+RoFiOPMLj/gdVAiBzMQT7LcouSFs/B4MbXFMCXvRNmfWjd+5a3ipfPjdtD5T69wxn7J/1SfzXN9SMPg@vger.kernel.org
X-Gm-Message-State: AOJu0Yytq6cSnWvTPycMghPFYG4oVmmdoOUmTzUovc2/6/nQHAgYp31y
	azL9rnBB6EAfWlVML/fSjEpS/qZr8isYa7Io9sdviLO97B7SN4oTANXajkC/sHWs4g==
X-Gm-Gg: AfdE7ckYRZW/kO1KjhYCL9H1rYVOnfJSJYym2dYiSUz3naquGEYY/vkK4eH6zgE1Mpv
	ZmeO9ufJxbE5rIOsr5XLV8sraN/T5rC6VSIuZTM60TyCERs88cz6qUbgk1+RZUHH4/IdrZhB6Hm
	89w+mmKMuEekMjI0lJx3o0cdlrLMQ58xy9KuMTjWVBQWe1p6eVnn18OkDnlyl19t1A28h7TLJlk
	2m1H8tJ6lYweC8BnhuuLWq/AXm3pWsFZajzMprP5Iizq5MIrugJO4SrUjA4ovrBYwi70cx8q9P+
	wABk7eriugeb7OZz3eDbtL8yrc9tWsX42B5SN6NKiGl7hLwvLZFq6xbKprsFz6VYNTVWGfhsTBl
	160Swn+HS74rSEVeVMn22iXtr71ZZ1TN8AYnBi1Vr5RM6XCQ/Z5SQ7NyNROZUu2WKLIbZ96IrTT
	HZa/XPuVI66NST1vCrQTGrqluE377qCtiee1ubPQXwNH/fq2rB4+k1xbBdg3w=
X-Received: by 2002:a17:903:1a90:b0:2cc:6b7a:dfcb with SMTP id d9443c01a7336-2cf349cc789mr186191295ad.33.1784616899938;
        Mon, 20 Jul 2026 23:54:59 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:54:59 -0700 (PDT)
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
Subject: [PATCH v6 05/16] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Tue, 21 Jul 2026 14:54:00 +0800
Message-ID: <20260721065413.2306137-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721065413.2306137-1-wenst@chromium.org>
References: <20260721065413.2306137-1-wenst@chromium.org>
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
index 715f26f05a31..8f8624a0d36a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1875,6 +1875,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_host_interface *desc;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -2006,14 +2007,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
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
2.55.0.229.g6434b31f56-goog

