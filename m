Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115E3CB565
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511396; cv=none; b=YeS9tlZipFu+Auc6B9C3Ck0kmbDaIchE/uu7DpBI8TdW+ix3S5Ir69W0pianZS+414l/dz+AEtKHezjOaj9W88GyoD4X5AbwqejEAYQqruZthhY6fRg/OMPkQYPHIGlPERSfx5oSBG/tho0nhFRXkgr7TxVCu0t4VaqR74DKe0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511396; c=relaxed/simple;
	bh=k4P8O6O1bZN0BviRcm5rHj8gLkm4KLla0pyDEJs44j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naAj5lA1af82Rft9QJB0Tr+czdq1ydj2zoJQW3qCq+I+zLts3H6rpUmfFN07gnZbRFRPz9yy37cExhgjzKcJw10J86zpr99LyyoE2uVpfDRH+/+R9O+zjVNzeFnFZUR6fxNZ37cGA/ZRvue01CX/pnAXVLYDpAP2VGLxUVdtmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AjaPsfJC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AjaPsfJC"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso489807a91.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511388; x=1789116188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bo+9+1CvfJ71hhRjJqHX7wWrfIVVnPJvwTAuLV2zMPo=;
        b=AjaPsfJCDWwaYk5Q2MyDX1ZPpsoqRQGPG+Emu8Y6xIcd/0OadgECJ9nA0jX28jDtru
         Pqn3liAVhw1Qj3C2NJz3dSjf+fGl5C/7JrciDRPzAwaP6yEM0VLJXlaUTr8QcS6Q2vfY
         V5betmLGwpj1LY5OroPvgLIntf/LQBAzECazg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511388; x=1789116188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bo+9+1CvfJ71hhRjJqHX7wWrfIVVnPJvwTAuLV2zMPo=;
        b=coiFJgnL9D5aeMY50VosiH+1/tza/y5T1OZqCgVpFpKHH4CyVC2OFYor1Ic/xd6nMU
         qeIkQbDWJ+y6eB/zcHmCXgge1N/+sg9i/5ipY3NDEIw0d9h7x3VF2TXUQaQaVgqn4flP
         JlR2N7tD0NAuTSfV1rG8X1uXzVq0EEufL6Cur3CVELAm+6NVTotHqiMjNz8+BjKg6Rei
         fOWH6hZEdrt6bVA8e4a0cuD2Q2jnuVbAfIXdhphUvRaQr8dSyV4ULbIvFeO8IhudWtB8
         pvfRN3V4YUwSQT3K2w8zJgiskbf9pJn2bDXKqITh9ile3p3GZ/ivFngzEQYAshrIPSiI
         V+qA==
X-Forwarded-Encrypted: i=1; AKwUvBxlr5en72HUOLNtLjANWBEYpCIAnnP1qP/YVwlWbc7pwwfOZNcvYqF/JUWiFSQjfozFyHOpHrh5E+Xh@vger.kernel.org
X-Gm-Message-State: AFuF++nut2BJnoPvZmT8xbVF10H0mv74rH41zv9M81lFP8MRe9w6WAUK
	5/QQJQxlKzBC6MsOLkaGYaiF5JvnP5PDZRgNI58Rrx3Yromkv0vkpJ3mL9yKTujWMQ==
X-Gm-Gg: AYBFou0D/AnZbt/8gL4EOOxOK5kEqGk+e63tORzzZaBavyjJyAVN3qkN7rT3hX2ZN6y
	Ly/0bC+Yksnae2+7W/PGpO75AcPSqDfwhJaxYjYbHXXpLEZRkabRKtKrugN6+/4lyRxnmJKF86J
	ekLf34RJ2E8xL+XWNk3geqZ82GKvP68n20phW21smmC4APhJT+G2g3H7eCD0Jov4+sE6uNoy3US
	FvROey1ifIpssWyYRU0qBY2VUma05/USbgaspre1eoW3WMjvWOm32A5Vbk6iBAk71pK7jG9hlD8
	aHupWOO91IKoozPAxo5W7tJDsUFt7/cAx7hgqVEmt/qecKrTk0iL0y2B3BmnKzXx6UQfPn+YTAk
	cLCwyLchZWCFxd311qrX7hew6KmLPpD2Zxmcb8W2iJHHXwhqll6N9bEPnsaGLtORE7oZYzPHa42
	I85uPiHO4tzRqo+6MQ1eMonpf5v+OSwvxN3W07gdfKNbWfpNgJLsGt/Cn98MhBtxh8RclztkXOW
	mmAEXxDBzrP4StypT3+TWvYOBVTDZ/++4Ic181JP4gq
X-Received: by 2002:a17:90b:1d52:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-39b260d338bmr6986016a91.5.1788511386742;
        Fri, 04 Sep 2026 01:43:06 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:42:36 -0700 (PDT)
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
Subject: [PATCH v8 05/16] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Fri,  4 Sep 2026 16:41:44 +0800
Message-ID: <20260904084158.1341550-6-wenst@chromium.org>
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
index 16e03ec8d1ab..c19c9912c740 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1870,6 +1870,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_host_interface *desc;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -2001,14 +2002,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
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
2.55.0.979.g7e5102b832-goog

