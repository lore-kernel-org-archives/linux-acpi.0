Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994E3822A3
	for <linux-acpi@vger.kernel.org>; Sat, 18 Jul 2026 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784362485; cv=none; b=PDRCIIiBoOgxWykVYPM7ndbrGY67N8Rj5jLGrkhDJ/vwYjBcYZVoFic9UyinUMSJEoFMpY2RtL3LBoCVFi74aeuhIfNIzcHkAq3WUIsrmWHVqwe80RkE9Q2fKyoNBAfblOsnGTC0I4d3acoRx/HDPUmPJCh0L68jGjLDfzeEwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784362485; c=relaxed/simple;
	bh=26TxEaZXjVJo5tBGtmwTRSiqCE9SIgBq2GP3qLNfyYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M05g9d2M5P5bChnvXnRKfp5uO7H11hXRXm5iR4lItseoZNlN7C/+hXmL+rGchG3YGJmxbVNblT73+zP3xRjE2GPw3voWY/sAo7m1RoUdq8AePhLYoPfmfnw0Fi/3o+7XoToqzHAsFI9tzjClY+V6ndDrbRjnlFDD/Ojt+6vRVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBFAcBQw; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBFAcBQw"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473b8c0fe47so355357f8f.1
        for <linux-acpi@vger.kernel.org>; Sat, 18 Jul 2026 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784362481; x=1784967281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eQ6kK9yKWQDUj7jQssc4rdEfAQwIGwXXm+Ja37pL5TU=;
        b=tBFAcBQw1YlEoXdB8GCekJyIePirzb+sSQz4uCwZ71m1iwXv1cVC68jLlyZaecXJeX
         x9RuWAzE+bzRFnObAf8H9ubdH4yuq+I0G95K34WPBdSgcJURO0qEQyUpDwK54StsLDOf
         zaX769FOQgjAsi+UdiUB5XDuXVyIk12p3kimFoBwgWEr/O29IEZ/i6fSDEfLEqtvGghx
         Zmb/LjNGijTMyYBgeu9O59aU59nNPKIB5giFxvhaqLuRWEGFM395IBTQ0Sdht2+Boxup
         SJDFAFIokUl9tOxaWPh1Jx+xklhIC1hq4kY6EFCVklKlOomI0F/sko9JJ7td6A36Fd1d
         eksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784362481; x=1784967281;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQ6kK9yKWQDUj7jQssc4rdEfAQwIGwXXm+Ja37pL5TU=;
        b=Szx6Hq3la97TgKZisL53i5pLSa4GLSfHYz+4Dp9PkhNASg4reSN8eaVPotdPn/atkt
         3qoDewysVwN0BlAEGzf1mvlTy6P1oDSZZAf7HzkDHbiRLYTNK269ssoalA1li/kUgKwW
         jbve0EnoZzSxDnHg+NUyMctWvND1wYGPMAHrob/rWv6j42K0jXF29W/CRmFhDAgLk4Vy
         nhZHznUAaWd2tVFiOGTKA47gYDBrEL8eE6ZFHUOJIyBkKXcp6yjFe1DT3kX6EJ2Rd6yO
         X3djmiznu6QOFOJmrLf0z/Q6ZRhXX+z8tefET0ht8f2ZN+IzBsu15hSZI90zDqqZPb/+
         bH4Q==
X-Forwarded-Encrypted: i=1; AHgh+RqiuT+I/o6F9mp1x7/QBZzysGO3u938+z0VNuB3Svw/Z3UslYwfQ2jiXdDgnmw7WZKkGJpE5jx/rPKb@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvNIQfJeS106UTaYWcrCE+GzlyP6e8mmTzdU3n37W2L/eOwCU
	puKzbXr+ngd9c6uA7nwoWEuXIxqtMcuOIhtKtti3gR3A/9ynx3NFGpt4
X-Gm-Gg: AfdE7clP6DjKaKahOOproYRvEZ2NQDyWl/HFLMXZe/2WbNeyKZF9IDdBNodm35/8vuB
	74Vgxq2nNeFrSlmrx89pmkXSX4aJ/JObGOcqU+nIrwMcrGHOzfAH55nTtJaHYPc125WDoSsa09U
	zRV4N7ZWgGxyrRngWyqNsdI2HrnQYIoKha4TdhhLlXMG1Re1yl9IY3YkX0vEcc9q+HSRHiaeyKT
	xT7MgMAMaokvETNYtmHzlIiK2rEH4aHfjCMI5v4NKVJQS0w+KvBW21HmkmGc+Zct2G3lcSgq2tq
	RL4lSxDIXWmz77eX5jRPZwvdu49LN8trjhO2RNjQi76Ki7pit1zrkegzLPSyjP0px3Su+wiv4fY
	W1Jvdclq+qecHU18QGjXt1UQXu49z2Tw/+bBVpNqPcfjp4YdTj/LhZ4UKcmLYiF04yDqBJmoxxo
	D3NFhJaYZSDDqO
X-Received: by 2002:a05:600c:548a:b0:492:6e72:eee with SMTP id 5b1f17b1804b1-4954a50b65amr34547365e9.3.1784362481213;
        Sat, 18 Jul 2026 01:14:41 -0700 (PDT)
Received: from meto.local ([95.70.199.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954995b78dsm73234285e9.0.2026.07.18.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 01:14:40 -0700 (PDT)
From: =?UTF-8?q?Metehan=20G=C3=BCnen?= <metehangnen@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	=?UTF-8?q?Metehan=20G=C3=BCnen?= <metehangnen@gmail.com>
Subject: [PATCH 4/4] MAINTAINERS: add entry for GXFP5130 fingerprint sensor driver
Date: Sat, 18 Jul 2026 11:14:31 +0300
Message-ID: <20260718081431.25456-5-metehangnen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718081431.25456-1-metehangnen@gmail.com>
References: <20260718081431.25456-1-metehangnen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add maintainer entry for the new Goodix GXFP5130 driver covering
the driver source tree, UAPI header, and documentation.

Signed-off-by: Metehan Günen <metehangnen@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a674e3652..7d18b5410 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11048,6 +11048,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/connector/gocontroll,moduline-module-slot.yaml
 
 GOODIX TOUCHSCREEN
+GOODIX GXFP5130 FINGERPRINT SENSOR DRIVER
+M:	Metehan Günen <metehangnen@gmail.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/misc-devices/gxfp5130.rst
+F:	drivers/misc/gxfp5130/
+F:	include/uapi/linux/gxfp_ioctl.h
 M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
-- 
2.55.0

