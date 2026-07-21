Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBEC42F6F6
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616897; cv=none; b=W0yMBZ9fPS3ep3ZVsuGFlOJ8b7a4ULoi8GktHNRuBsF6Ost5yA8AbMp4tEDA49Alu4UmrQe2mBC1IJWFmLdcfo6V2hhIP5V5Pnin/g9jI+vsDQVqOPE0J9/k5MpSETB50Wk5o/bmTGDUQDaMpmMbW6g7WCHHkFU1T7gvKDNoCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616897; c=relaxed/simple;
	bh=DZukzCQ7CZkay93mS9H4jkJ+htZvTV7aL2cJyc7/2CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFYX0Y/CnJIVW+HMWK6dspoL7+NkyTMjSmoiaapoK0HIenoXRGfhzkovomSePkB3V29pk1pxds9fdRlf0B9cPeylGpD4ljm+iQMonayAgqqAMvIYg3e0ifWvhGs3E14LNQMuTg0/YSyswmyEP9PdzgDY73uHKlCFDSSCV1jYZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TRp4Tdb5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TRp4Tdb5"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacf197759so124508195ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616895; x=1785221695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xc02KBsQrd1xdK8Ho0VEf5G63Rz5XQrKjQwFcbcQ37E=;
        b=TRp4Tdb53zpmXKorIc41xp1t8wmTayjsPM4PK5fPlj1LSUfXfcSXEPOmVz/58B7vKZ
         iDUEJRXDZ/SSSqXFjHvPSk3EKVH0FBDIlcx4Gx8tvzKd9kqrrAPSffOt/NAOH/u5l1pQ
         aKgfclmZXnBQ9fswEwto2MwK0vlbPfOyucXbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616895; x=1785221695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xc02KBsQrd1xdK8Ho0VEf5G63Rz5XQrKjQwFcbcQ37E=;
        b=I60/iwT4lHD2cMc9/VOr7NsLkZZa9a8RYNZ8upf9V2HY+jkh4+ltOZ2ASUmgmvetJs
         O2dN9+mAp/Nwor1oyXvi6UQtJj8UeeO2nsU1k6pA47utLy7rhsVYC8nyMAIHSFLblMGj
         8GL0XM+06A7WdEC2HSnzOP3Dh2pbNEWIM4TEtM8gK2ucsPc6Rlaz7z//wEsXf/dxkuHz
         pZA+sqcALdfsvOWACBF70jppPCsLqrGQ+24Bp5q/zNJut0wHNSGAP6epHnbWJ0eRkAS/
         Qu3Rtz7qH5hFqOS7YkyDeFVRJ9FjUE2gtLNWfMFiLQeW/58yZJOtjDcnAQ+sCmz8WYFq
         tWnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMnjUO63uTXtF3v7cS2Cgh2j8eKTiYYo1dpQWnboNeexQ0am+2VIV4fE0CleevSx2BoLapk34EgIm8@vger.kernel.org
X-Gm-Message-State: AOJu0YwqmKq7jVdFvDtjNPxVPJfRbysdG0md9n4O/ZvY+t5QvdqN5uYi
	XN5/vK5kjfCraUFsuTV08pYRO+7P+LPhGtwaDHmnWkO98pYqa+RXam/jfh3o7hc6Ng==
X-Gm-Gg: AR+sD10uHMec32iDH5SQwXIW9AfZnFG3FwSrZ0Uf6jt6OEgc3kJQS8rRQe0/TGPyQeA
	RRmqJWbtszGrM8bHK7y5bL6j+vpS46wNPCMN7PItLt7OlxobeVwWILiv25DS/UNxi9Yq47Njni5
	OsE2EAgDvIHJKDJWlx/TBrD6q4nULV0NthD7MmoGEnWEk+3TmLqyUEsaAwMK0yZKDHGX7BIg4VH
	kWznAFATSe5aBeJZ/RJxR7MDQX0jdKVMpD29Uoskb1HGNX9oz5N2pPmMjwpj/es4ca//jqsTqi1
	3vVpWkNKuQKY4SJn60klz4DkgFIlZupgWLtbPvsJxM6eUs7rp+9E9ooevXG29HTilkIaQi8KRZT
	FJgnC2Eh+Mruj1Ag/HJYR3oRidHX8qnnzzsSf7gPLh+uw0zCel4l6y6po97mX9De9YOAiS0WAQo
	s+iH4IKT2NRC67dAptprtpkfgTdJNGSceNBtLbSCulZTm/qHIasAmL8k1dlE8=
X-Received: by 2002:a17:903:41c3:b0:2c7:1200:bd7e with SMTP id d9443c01a7336-2cf3486b0b1mr185750155ad.18.1784616895361;
        Mon, 20 Jul 2026 23:54:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:54:54 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 04/16] usb: hub: Use assign_bit() in usb_hub_set_port_power()
Date: Tue, 21 Jul 2026 14:53:59 +0800
Message-ID: <20260721065413.2306137-5-wenst@chromium.org>
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

usb_hub_set_port_power() open-codes assign_bit(). Just use the
assign_bit() macro instead. This makes subsequent additions to
usb_hub_set_port_power() easier to read.

This change does not introduce any functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Attributing suggestion to Andy, since the change was originally
requested as part of a review.

Changes since v4:
- New patch (split out from "usb: hub: Power on connected M.2 E-key
  connectors with power sequencing API") (Andy)
---
 drivers/usb/core/hub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 2cfe09a141d8..715f26f05a31 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -10,6 +10,7 @@
  * Released under the GPLv2 only.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/module.h>
@@ -899,10 +900,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 	if (ret)
 		return ret;
 
-	if (set)
-		set_bit(port1, hub->power_bits);
-	else
-		clear_bit(port1, hub->power_bits);
+	assign_bit(port1, hub->power_bits, set);
 	return 0;
 }
 
-- 
2.55.0.229.g6434b31f56-goog

