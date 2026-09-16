Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A146C4BC
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545567; cv=none; b=XYch3KfwkuIFp+O+Iv/IJOQwsK3YOm9A7JmiVTVH+45UD7XBpX7tSzsADpBSFCn2D9/gHfv/LGJIUxpwwrolO4LkzRceKiB0UkHZj15JPt2OlXqaN/gvwsNUrTiZG15bnAs3z2ppF69rcnRf4R0V2gc7WtRr5+mEoPywJ1/c5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545567; c=relaxed/simple;
	bh=SHgJWoiUkxW7Auz32fIVCxJL51q1VUFL5lzA1MkMflA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgOLgsoxqTDynKAR+gU7kC0QiBdmHrsABzNEqWGP/HvvAsik5OEV+sLhWfEj+AEEmGhWF1dsbFVds0JtCNvaapSDBHuMSD5WKmSeJx7v76cUFoIpB4IYHJX12Xy9lAnbzV4nytZPYMAmlHqBIsO7eFw7LzdwRgOiPRzC+iCgsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bTpPwfgt; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTpPwfgt"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba91so453781a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545545; x=1790150345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JKZMmlDJFNSMtO9huPhOVTb/TTA3LxjwLBEnHIboH44=;
        b=bTpPwfgt2dg6mAR22GIGoVXoXt5LVnIna9UME4o87hnvazveaRCXjchh3OySTCMIZo
         8Me+CeP2zrfN60uDgL0ffEtx3e/YGqozMJK5dE/lp8b5IdHuBLYJ1JzEbpmvUMCpiEYR
         PgD1ToM0uCq3nFBiay7EB5kBKI5ygM4mXxamk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545545; x=1790150345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JKZMmlDJFNSMtO9huPhOVTb/TTA3LxjwLBEnHIboH44=;
        b=ulfaz+mgeSVMe97TOulLmVqfM8fbGS7+lDv5kn0a2sS9TtvFK2zAoIqRuc4qaIqaOu
         +vgUNCI5KfeKac64VMvDobBM0IiC3bS/85Lu0lfpYcgM11ua1eh+Bij6Jx3n6M1xSNU0
         n2UDcHR09wmbBWTtrZz89kcqQqPA4pIxR4agixE65kKLkDXEB7m5gICV0Y9KBSvI6Xve
         gzxEI0wnAb4P38cADtfzV2woNRLwKHTucYieGlWbx5I32zmoHhIQXSpDVJv6a7G6bH2w
         wtBBD8dhJHFkM4JKv9dRcbdThsC1NpWpi4pwcMSssu5fYEadQYZlJiQsoRzYovLNUE8X
         LVSg==
X-Forwarded-Encrypted: i=1; AKwUvBx4F+t/KPrf2lMxLtINKYp1qRgwGseJOBiHKQMexndFGN+0bL9oacM0is+7ah+uvB5swYJBRcFLXrOb@vger.kernel.org
X-Gm-Message-State: AFuF++lapjpcNyyL1IxevtMzJpV7jAC1Ss0yokuclceXCie/PWSxLiyl
	ixC4TpDN/w2++NMLbrhMa3vWs/tN5fgSJMoIlSim0qD945+YppyVWupCSrBZ++otPQ==
X-Gm-Gg: AYBFou0X2AQvv6BG3D8DqPtOZB7pWZ+HwOFVAnHdm50zwh/lgMZs8iLMfDJK07cJLxf
	RTA0aCXdSUBy17Owxh2ViyjlhRJGzFd+zAoMTuMfnnC4f3ruKDI3SKPYahksYiIxXhkwrLKCMXl
	CnyshlAYpVuLeJtZgzXN0o9BR7Yiisbj8Azq38WzANolxqUlrlOGm7OrsfRlBGlTM9kQAMno4QM
	aM2PFnnMD6IATACaXSzvoIE/eGYvQRUoqqieeeYT5XNyNgWQMh0cPtCN2LU6xO6NYiWYp53gM/L
	GWa9kQxH8bsfWUuC+eCsb1eKsjfG6b7C7jx5dvy9Xcjy8iUJ8BiwvoSht4iDIcG/7bKRCA/w+ni
	MB9DOW3mAPRXAmrcvSgA7f+eInliyJlh8zoJ5BQVgzl0NVh/deFUgGjLn9PQiuZTa5nu0s7wDx9
	hjm2eh5Ed44BsXRtsS98q/GHG+RZJ//qbxno55JP0s60XLgAVqQNJmpZgJjmdF8XQsOJA/mGrwu
	9y5HNvg8EcMU5dBU+DkowY1rISNqZMOsw1YVtwsdLfzZFDN1SuqS2PuVw==
X-Received: by 2002:a17:90b:440c:b0:39d:fea0:c17 with SMTP id 98e67ed59e1d1-39e1e309c21mr3793724a91.8.1789545544841;
        Wed, 16 Sep 2026 00:59:04 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:59:04 -0700 (PDT)
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
Subject: [PATCH v9 08/15] usb: hub: Use usb_hub_set_port_power() to control port power everywhere
Date: Wed, 16 Sep 2026 15:57:34 +0800
Message-ID: <20260916075745.3549953-9-wenst@chromium.org>
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
index 1a98ccfe2664..f309ceea1969 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -979,11 +979,8 @@ static void hub_power_on(struct usb_hub *hub, bool do_delay)
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
@@ -5461,7 +5458,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (hub_is_port_power_switchable(hub)
 				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
-			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+			usb_hub_set_port_power(hdev, hub, port1, true);
 
 		if (portstatus & USB_PORT_STAT_ENABLE)
 			goto done;
-- 
2.55.0.1032.g73a4cd73de-goog

