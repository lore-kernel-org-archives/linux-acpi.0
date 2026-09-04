Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427C3F1AC5
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511452; cv=none; b=VT//Rc8PL4/yns8nhOTzLeBaKJmGB1FBbyyBGmyq3XlfCfjAb85qSKe+L3NRdpTroiF+6Fj/FmVOE4o7TvPeTFMVSDoffHJQB8f/7uUF0G2CwekRaA68ZkhcLMgnnuwFqMuu5RXG2IdJ/HzbkTeuDOb3BPSq7jkuzrDC8/7O3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511452; c=relaxed/simple;
	bh=GKxlf1sAAAtK88H6DAU3sh0iIYsWYsT2IYOx5SXsE3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjT1Gydm7ZxmXsIWQFepPLbUJKM84JETKcI0jmjhNryaD41dngI8116BMa7UDLZuo5ZIRVwpZGuHwNP+rwhNSkQIbQ4am3tRR/25jKOQJsJWokE1kS4e2c4BxXLIrsWn9+IfouknrJobOdJMo1xrUuVUyIw8wL6BoANM95t7JIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VdY0iG85; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VdY0iG85"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398e9698a70so665797a91.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511447; x=1789116247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFmIb/8YvdtZL49BMQqQktnO00n+EPHrLzK7Dg1eMRc=;
        b=VdY0iG85RNkm9SkCaEqHCBCPJvjQCFRiRTVVxyJRlLXY6gFLiobguT2Ne1w6cUvCEM
         D3gEkgdol74YqaYwgxJXUdsCppnNHpFiUmzVvQrESERRM8iklThb3xVXk/Rppwa7UjPv
         +vVBhxRX6VVvPxyF1/pgk2dEHHC2eEOOggwpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511447; x=1789116247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xFmIb/8YvdtZL49BMQqQktnO00n+EPHrLzK7Dg1eMRc=;
        b=np6mUNU6Np9YNzjXhSkw0wr9q31ngMuuA7BRF/ghZ388EiygSQF44km37hrw90RlAj
         IdhUB4x8mGeYnTRPQ+eBcbEb/ex00hwFThED8iMTvgT2gQR4mf/7zguF21A7el7I6XrJ
         YHo8uBlG77CGrkyJDXdRdrpEyma+WxKTGyc0T8Xop5KBJf+tp0W4WQyeMniFpFiTu9OX
         sCL4vCO569ZoNfwfCScTW+LarVOyGufoVPVZi9oarWQjCs1ltC1DcJ1AVgH0xAw9BwIq
         32w0PnrHITvA1SoEO2yknjn3iw0aE9YtPaa70P1/xqayeWWP08xvoWzZHFSxEuBfqBHw
         HdHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYUpB1/gjQSyZ6m50ldFb7emPOOZBlfozo1+zUJWzDVe+wu13UGVIqzBQr1LaDuJydfw0UlHARkhXj@vger.kernel.org
X-Gm-Message-State: AFuF++m+7WlAev7xs6N1WdhRM/9HA8djQr3xFirmD9SjVvqSd479w56Y
	vbbhfhRMLeueusVsmK42ICGApR4IZ0e/vjifoPCkygpNKQvD7mGNI97rX0SzUZz1bg==
X-Gm-Gg: AYBFou24TFigooHM6LuXTd2Gs5D7RZAT6deoVmXowtWvPdXZ3sXGpfcGQQULdIz3mGZ
	gzkFD4kX2hgwZ4zJrqjiN+8Y3si7SpJyN5aNER15I4y5DtPevMUYVcjXoAcI8HTHPoB1n24QciH
	ng7E0+YQ29DaTf3qkWw3n39FsNZIjbLAlK0OHglKcIaufkbXmaN4P36ajcVwOM/NfVE8LPIDl9q
	DomwzTQazpd+GHnGNwGGG4v9+FebfjlUgMLO84vAolR1ankv98AgfeE6IWsM46NDwcmdA46XCJH
	77yZhjrw4GeK2L32qWkR3IiDSDY6rKyrho+jpRKJkYvS3nLvucQeQpgTiikkmDT8a+zZtWKoh9O
	Pr/sgFNZ43e6uq16bzvVve4+fOjS+YSi0KpfpJ6VOWV/IkVkB3BskWn6sRvW1LpRKzo6XcVMJ64
	sp3utpGOz01wMkirhuxC7smayPYQQeiSjatDxod4GTrCgGM6QveiQuINJViomcMdYNJMP77oy0T
	nvY5dqBgIATmNjNnGv+TyisEbg8CLt/W3EDukTjtZvO
X-Received: by 2002:a17:90b:2d0b:b0:398:c794:ca26 with SMTP id 98e67ed59e1d1-39b263167f7mr7127157a91.25.1788511447090;
        Fri, 04 Sep 2026 01:44:07 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:44:06 -0700 (PDT)
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
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH v8 09/16] usb: hub: Use usb_hub_set_port_power() to control port power everywhere
Date: Fri,  4 Sep 2026 16:41:48 +0800
Message-ID: <20260904084158.1341550-10-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are still some instances in the USB hub driver where port power is
directly controlled by toggling the USB_PORT_FEAT_POWER feature flag.

Switch these instances over to usb_hub_set_port_power() so that only one
unified function to do this exists. This makes adding external power
control with the power sequencing API easier and consistently applied.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch
---
 drivers/usb/core/hub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1b891088a653..b7991eb53197 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -976,11 +976,8 @@ static void hub_power_on(struct usb_hub *hub, bool do_delay)
 		dev_dbg(hub->intfdev, "trying to enable port power on "
 				"non-switchable hub\n");
 	for (port1 = 1; port1 <= hub->hdev->maxchild; port1++)
-		if (test_bit(port1, hub->power_bits))
-			set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
-		else
-			usb_clear_port_feature(hub->hdev, port1,
-						USB_PORT_FEAT_POWER);
+		usb_hub_set_port_power(hub->hdev, hub, port1,
+				       test_bit(port1, hub->power_bits));
 	if (do_delay)
 		msleep(hub_power_on_good_delay(hub));
 }
@@ -5440,7 +5437,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (hub_is_port_power_switchable(hub)
 				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
-			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+			usb_hub_set_port_power(hdev, hub, port1, true);
 
 		if (portstatus & USB_PORT_STAT_ENABLE)
 			goto done;
-- 
2.55.0.979.g7e5102b832-goog

