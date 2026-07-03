Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95333C3459
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076641; cv=none; b=b3Fn26rzrZ2u5wao7RIc0tTBXIxhvgsyHwJy5n03yGwOBH1h0zirMnzdfleifVfOAv//QxXBAkjDR83Rtank7WRP79ugBGM12FMODItrfMf9MUWt+Zw5qg2qMuqjluuraHAPLhosTU3T+aV4cv18CIhaa8YyLeHNqQ/UkNX72ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076641; c=relaxed/simple;
	bh=KSKcoZhcUNUQt6mbvtajVqwGl+bjGPliu89rdk9IcV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJcUfuTNbOo2WMnb+Q1EKsQ3xFJQREFrRin1m11nzF4Cbg/CQKySAmlv6qP1OI60FStivvfs7i1hkhnxkGnlh9Zenu/JvkgRKL7/8FlBGYk0BojYKKN2oDSYaArK/QWWK1NEp3Mg/Xkq+GqD9rXEEHSv0+4GF8+5xWGG1Nn8ehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KvtWtgZf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvtWtgZf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c99672293cso5074915ad.2
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783076635; x=1783681435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXNEvMizuglXOCjkp4mAG2muXyzVgQAtby1OdmgJjvw=;
        b=KvtWtgZflkdFyH3Vz8ZXtWc4++GF8XRZ7Rpap/TYpW8PpQ/edQUeloSAQycBcHxSj8
         /oe4VgHNNuW6Hl1Vjv+B5Avl5+S4Qkla1OfkXp/Qe4REkztQ1qg2BmFelb4KEtpzZQTs
         ey9qzpu2t6VX7COz3OHdjyEplNfgjhMIKkhVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076635; x=1783681435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXNEvMizuglXOCjkp4mAG2muXyzVgQAtby1OdmgJjvw=;
        b=iUWgFNrfCvWhWSPFXrQeG2r61S/B0p5B0fYtEBE7TK2c+9HF8CV+vkiawjnmxVN/zj
         D//3qYn2H2tTGAx0B++FK+Le6+mZkct8D+Wp/oHkxakAo1OUHuixo06mQGlwTji9G65k
         W5cbT+UyO+81H5zZ7VXji3qMORn/X56bSrKVOYVyRj3qCK1bXxYBFnPVEGLE0U7W+MGP
         XK0tVI/Nk0I2mQakUX4bSfA3S0aJQAkVlOXlUzXrkQFUmVYMLkvpCIs+Hc1BGKs50BaX
         64NEtptkOICQrJklv3U1Q2+98YEJyrLfWET5Fdf3rMdYTJi+OaYpd2DNMt164n2RwKy3
         0buQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIVqyN9mr5py+FKyQ4gNgUjy6ZfV48qJW+VbKF182pgxjoh223iC4V9sE/WN4tV9zxbixcgSLmY8/8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7CyoHLLdI3efCqEuE9vdoUJxBNUiPD9zfMn+V4bBMuIGxXaA5
	dqp+tp60KluuRqxOwJ2lDjoVGKmhXd17LqKEsN6Mlxb0IFgOlQGIhUSsxLCaXkcacg==
X-Gm-Gg: AfdE7cma0wW5PczJRhCf+STAP+YaDCFNVBPCUGt9vQL0Csy+Bq+rQoeRj29s+lXtOzp
	r+vwaym7jwl5/rAdY+ZtVd9Ca3D4SliV+SErN+natuwXn4KrPvhUHMOjvSfbnj0vz69rS2BYS0G
	6eDfS+AMF04fYNmGWNghNAx6UQaHkFH07dgESDr2HMSdnHT6u4j9BgJi9YJZ10agKIc0s/4eLGZ
	29JuV9AE75Ip++ZKTTrKOmLvfrJLPeJEL/FEoo3EI0/697MGtgu/ohs25iXaZ8xG+ZUXXucji9I
	0W42E1Kw56QE4fhzepYRje3V4v7hAd/hI88OUF5Ei75tkGkkTpVPFSoC1Zik6xn4h2iEuW7VIMu
	24YdSJIqjK5z+Z/t1bYIOQrMQurGfKjhostU6Cs1EOYpXH6uxrvWWCvxAliL1LHRiLXQUwcqoeY
	jpfOcuxhRRzmUyZCiTqQiZPmgA4M4j/pWDsl21UEyI/IhwA13xsMMRpoKyHkAJEsv2dUJ9gw==
X-Received: by 2002:a17:902:ce0e:b0:2c9:b01a:fbd4 with SMTP id d9443c01a7336-2ca7e6c4036mr107709695ad.16.1783076635124;
        Fri, 03 Jul 2026 04:03:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm7785315ad.13.2026.07.03.04.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:03:54 -0700 (PDT)
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
Subject: [PATCH v3 04/13] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Fri,  3 Jul 2026 19:03:05 +0800
Message-ID: <20260703110317.1283411-5-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703110317.1283411-1-wenst@chromium.org>
References: <20260703110317.1283411-1-wenst@chromium.org>
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
2.55.0.rc0.799.gd6f94ed593-goog

