Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8045346A5E2
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545546; cv=none; b=KBVyp1s5z4XAnBKlLtG3k4zOIWhd/SjUDW1FGn2JaUhzqAc4DmNEyTa29cCyEeiKbqg6l//j7p/vmu0v3xYWVsjIRl9IZidzQ9cmrgGOWRQRckQPSBkZa+upJM1A63SnNDxG6jg3XF/pWBgH8OeUodnU3DE5J0mPgsPZjrpGT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545546; c=relaxed/simple;
	bh=PPQwnBevhndYutuKDdDvehHKW7FqGHGO5QlRVDsedNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbZtRfFJvQnTyr1ArAogt9ikg12UaNX6Npo1rT3PT0h4oPnLZV0Mtu+XoiP1yvX40NxJd/ehgMafPGDq866DZQEgYtOQsSVcXncUheGz0BuLTjmaNp7w3RJHxUOtPpK0wH02PluW/E7Nm/AhOOnxVnTi6m3Koy+t/kQpBgvsSqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ipq2ISt0; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ipq2ISt0"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so555982a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545528; x=1790150328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SWwi8XOZ6LU+PxR6btCprbkiTyl3Q4dICGc4z937Hmk=;
        b=Ipq2ISt0pOHBw/MedOHquRdKJL8cr81NU8lTbtIi0375m9EvnwtQ5Cu0+JLOohQWAH
         Z2yAczKbLMHtbCZ1JR5dvkvOPKbIZp1zWutKzSKJouwlTG0iavUXgS6XXeUJucT/9HoF
         LmR92+Lbp15SkFfG87C9Q9+StcoQp2bKXq/oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545528; x=1790150328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SWwi8XOZ6LU+PxR6btCprbkiTyl3Q4dICGc4z937Hmk=;
        b=WWvitkJd1vAj5ob+3c3HlxvuB7bewx923oInzqhoMkt6goHEllFOu+AV2z21jNneiG
         wWRkq/PSxvMO+mqGBvO8JXG93Ov4fZihe2UGhkGwL33keBKkOp2MqtTcIaTdWOSGHrT2
         0xqKT8hQHMMlbjUQ2SmVM1946unl/mR3ntPKO1l5lSbGFsyhXxgVxV1b6+JIsNtW8mgC
         czI37cGS1esJ4fk0sCWS0B8mkXah/BV7ZMlPP0LKKTLC7R8+yG72B6vvCO+YLYQRcqEP
         Yr3Hjym4BtPauNzGMFfT6oGvribDKgUmFwibtv3SqEB7vDyuVDoIFIM/V1DcAIkUx17w
         6VWA==
X-Forwarded-Encrypted: i=1; AKwUvBzI+e7l0DeA8JCIXoMtI2RVT/PSSDUJ28OCedkJS4jeElysGDUqQXiH5TdN4wWjxz5saMAZ1D203eXe@vger.kernel.org
X-Gm-Message-State: AFuF++n6GKi78tynjQPAUih2ornop7zo6Buc26USBMQsYpCerDtUINvb
	kBgIN0Em+wwiNOvQLHiOsIVxrvnG51gHMrnc1ph59JHBHBgpVDQvG53Jasg4VLAaA6EHXBkxsVe
	QHDM=
X-Gm-Gg: AYBFou3S5fEp8WOS6wU1dMrmjB39diAQzzQwPaN9RiiP1bYZoUKzb+RX/LWbE9tzMsl
	UMzPlULsQFmJjcaGxDpeyji7Qy1auk219AavICTXCUI25vQ6mzAr/WFZbUCaKKXYORoxhqyFBrI
	MWwJb1isWGEpRJqyaRqQZNnt63fqg/oE7tLoznP7ZvamvoCngl4AqLMBJ18rYejkmM1jZIbPWdo
	wbMbYxj3qrRgZdktcaGGwGAfH7o25lb84THzuWAeSXrLX/mfczSsnFTHISfaPHrptacToNlxAMu
	+Z6Cm6JmXk1EvxTIUAIcmQleqdVNQ07FiINAqlHy4gvmfrGEXwuktkoaDUO/U29DRZ0Qm9W8lOw
	sM+oo9+TbHISh61aMo/ZwqdsE1Ul15DLE+/wyObi7MEinNauFckRd/HQ0+rye+AIAYSRYzAYZ23
	RNJsllJivMQzhTuqVlhIReLMvcwWILUiqC+aBDS6YtUg1xj7tAkKtm5umawV5Ullt+cmLCFDnfN
	q7P7iazE17mlp4xyJjv+zb+61h7f5FEHJGOVlTLbloOUwlsqYROKlYc2287TqTT+cYS
X-Received: by 2002:a17:90b:39a3:b0:39e:233f:cee9 with SMTP id 98e67ed59e1d1-39e233fd063mr2563733a91.11.1789545528600;
        Wed, 16 Sep 2026 00:58:48 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:58:47 -0700 (PDT)
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
Subject: [PATCH v9 05/15] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Wed, 16 Sep 2026 15:57:31 +0800
Message-ID: <20260916075745.3549953-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916075745.3549953-1-wenst@chromium.org>
References: <20260916075745.3549953-1-wenst@chromium.org>
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
index a4ec79a06a5c..707eeee198b0 100644
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
2.55.0.1032.g73a4cd73de-goog

