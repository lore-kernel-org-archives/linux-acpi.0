Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF8B3DB63F
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105685; cv=none; b=OxS9i+Q1HKIMncOG/HrP9BbR8dxrsX5YroME5upR9vfNxWTL41s6OM4gFmfqbZqU26HO8B65/PcpPeR3XKhKioV0dql3J1sXNzBq7kgUU/646mPXWgngAFIr3YpL/8q2dG8lzwHEeg4gwdsJ85wVBsZDUyl19GVcNJJxsnf7oJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105685; c=relaxed/simple;
	bh=zZejQ+aVWVSSNX1WygLHkrfwpLKJjoR2C2VYQ+E3BZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSm+lJyCH0MlnI8zCBTIWCq99Gf/KBflLMeJ7DCGMQabRPJT45hWZPs5HDvlTMYSLKq89ROX/+5e5uyfkFTZ4faRTYOn4FRGuSppkuq2PlWjFYwXPAjL0l44AlbS3BqjOWn7YKRB/e80hNmMXIDzzFm+53XJgyhjlbxRPw0Llvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZXCHVCMn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZXCHVCMn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84847482584so1438699b3a.0
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105681; x=1784710481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PR/rf/FwXUFRek4b9eCK6DZXZyozjvhZuepJNtfrJR4=;
        b=ZXCHVCMnM2Rmhrt+5rSTUruCNAGpx/zKEnsicqNkAeUwqpNzRNwz9l6SegOgcv1EEK
         LG5RB1pJU6rd27Tob1oTWJkLtRdZwciIn0OEh1BKXaMpLv/sD7pbP5KSh8N1+GFmFR0W
         fjMObK0JH9k2Rs0+NDbRHKIG1YAgvOiaxNbRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105681; x=1784710481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PR/rf/FwXUFRek4b9eCK6DZXZyozjvhZuepJNtfrJR4=;
        b=b+TG+J56uIW2CeXLGEpXMzH850L7oA4EiH3HawPOBA4GmdmcwqAeDdTKj5xn/jESn7
         dlJxGBiPzR+sB+07nouQnAUXSfMnWWsjikFRy7Hbhbx6O3rnQSx194RLScTE8zIRCBhe
         4wQjbeNNZ3yebHzW1TxZqbOuEO6i3KF4h0Xv19hlySP0iazDuHsbApcQCOy+RO1Wlm6Q
         YZWYSPEM6qmU8Dq5/UzZ3+s85HGJD9drYrnmqyMOrOj061OkIV85ujJRFT8cpJO3PDfp
         dWIwPdyq0JYbR+qPQmX+pseAFrboEMygygnuhHM4fUjXRBuIEeOXDDcOBLmVdlweRZ3a
         EqLg==
X-Forwarded-Encrypted: i=1; AHgh+RoDs+Yn/RtOgLWFylYlzS3Rbf54A3HO4FQcbdGMoc5+zLoeAQTmX0M/0OmhqtLhgm+YkEwmNtFEmc5q@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXNwBbX1wVWecfH56g/+xDbgbBO5TRVlJeuxXieEs6UxCRSkC
	lKdOibI9KNBV8gcpAtyFxvRAa2X0VKyY3mHTBpwFRyVxSDUOAw9Tw5yZgb7j8mmwmA==
X-Gm-Gg: AfdE7clxuGy+SoDrxDvQBC5DB0nxaVpv8rZeLPpKYVbCzF7oF/MNAqir+YqwdD2EeRA
	pBxtOOVTGOhsPrk1/xWsL/4WKD1WrzQDZYBBcIBnvVOiVi9AqkYZq5tmgEmyqE7oQp/bmwgqLWB
	j/f84RU5t0BYMMxjuoWWoZfWonkK8oYkYKEDpiTLKjcqTlcXWSMx11mFfsLo1X/M94MssdDiuMg
	ST7syW/qrvHRRdobSFMlbIqjUyQIaXOxrbeGkaN1RDqfT4xIILw6+lw6/KzFNh28tSHDxuMkJFm
	Qtr8NTzH5Mj/GI6K+KuGnaNLdtYEi/w4UdVZgWSgenGt4gykVXieXalCErlZ/07J9277wqSzk5V
	JiHuzgpPAFVPwuN9RglY7ve+EDRpWx7FK8oco1FyazmV2ehdYtTjjbGReSLqY4PXYzqni6EQUST
	wwc2vHyG7TLc56r/jMLKKOqvVd+vxKqXIamBc32dUU0TlH9tJLARCbeEAtNRKQU/r732CjTg==
X-Received: by 2002:a05:6a00:2384:b0:845:3033:6cbb with SMTP id d2e1a72fcca58-8487036fc99mr19629780b3a.11.1784105680847;
        Wed, 15 Jul 2026 01:54:40 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:40 -0700 (PDT)
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
Subject: [PATCH v5 05/16] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Wed, 15 Jul 2026 16:53:35 +0800
Message-ID: <20260715085348.3457359-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
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
index 36342c5718bb..a260148091c5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1872,6 +1872,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_host_interface *desc;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -2003,14 +2004,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
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

