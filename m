Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C53FE359
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511354; cv=none; b=dqM79g6u27ev1At6lgQnkCf66sS4TmS30zEqNAPn/jCQ3BEYu+gaNxGyh2NcPK7QpwVRve4rDeA6CVXD2bQ/c9zfTcKwlLCFy+1haG5sxJ53N7DQ5SjeqVJMs+u2keqpDfEoeNPImks2LmAhAdYSYSLUl4pShRXrp+fJn9PFcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511354; c=relaxed/simple;
	bh=B7Lu+PyhQKrwbSeiWnA/FCibSLvQ75jT0I67pSzcZQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmRmXDBY1c/QUXBSs1IARL0X/dcsSY7EqpE3XCItirY/7fKtbdi7SPSNF8Q0HAvTMyKEgGPXWPbtGJjVsEhjpACG+v1M3ttA1l8rMcmQH5MGeMUbDb/0E/YS2eny3Rk8IwwKteF5/aNEcl5KFsciYHnoFoCgu4Q+5wxn3MLf4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h+g1pKBE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h+g1pKBE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d9520b9155so7098345ad.3
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511352; x=1789116152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RQ5BUQyX60lAwoXOtJvq7hs8kBNzpXHT7+FU5vNuJYE=;
        b=h+g1pKBEmSf20QLY5llg49jgQylsjtbjFvxfP/fbBHy4rESg23r/liAcIo5ecMNYYA
         Z/FSNmOWFnd01kkoitWsqbWItWzuQgyEUEmMNTsvksJdk2SVFDLxWPkXZ+D4kfaIxFtC
         nRNKUdCW0bNipWdS7AzycmJwEy0AxLgkBTVzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511352; x=1789116152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RQ5BUQyX60lAwoXOtJvq7hs8kBNzpXHT7+FU5vNuJYE=;
        b=cYCvGnsY0Bu7huTKf+jGk6p0oGqfEVs1KyQoAei65YEp9JcwVsMW9daqvxmQI/9KuS
         n8CUoPJSCA462CtVHiY56cvlSAkexbD8+BTEGcQbqYudRtZy+Q8TGVNtr6jNnpx22Ead
         cDJHSwmn5em3j15msdqTu+yb2KYM1TWX4fn1a/hxpVP7x9xY4yumVrt8KWsi7bv5WkAp
         wwUX5/pbC73MM2Bumfe5Goe+6l2XyT5JwXuggYDdVDbO6E6mx+1sqMGTzl40pTm7wSKU
         vbOyN/eiQWJxO0tM2YtCs2RsnxOSXVPSFK6jtk/bMP8ARAadnVkGqmwvbB7SurkATUCd
         bRkw==
X-Forwarded-Encrypted: i=1; AKwUvBzS5Jve76ABxEuN0n/IbauhNVkk1/DJOaz1buGx9+GblYqYyyJGzuta9osilYlpK8XJIsAEEDqp7ec6@vger.kernel.org
X-Gm-Message-State: AFuF++kLM0MEPBEQxSXVc6Nm/XXANtJPHYbg3IUUeC2481PpmxIMyqGz
	Q/CwIrbrxJ106AFHn/kdQU0e9B8UIiFUY0BVFGZs41WZ0HBexoOPI5L3VjDmaLQtkEogjel48OV
	rUIc=
X-Gm-Gg: AYBFou17P5X4Pxmw2gN/SDBpK9mYhMFzyJvqaoomBWo4hU+/t5/wReQzK6ZvjzMXL8D
	XnA/GaLUEe6BOt99NzB100o7LNMZYVhQ8IqUcW0Pv6jeZQsQ4I0ikNjQkVJcTqZOCmAoUoBzXj+
	5x6oje2LJrg5wnCrECFxJSHdxwf5KpohF6L7xzN5nR+YC/ucVu+2ryzjGwE4Oo9PMT1ResxA8nT
	uT1QsNUD239n8XOIXGqnS44ncDfIUG+I12NRWB5usI6nNjkXmoM3xZngZqRGE4tAgywuSRHRzv3
	ZqNAuUajTpeBofX3lbwNGZr/k5ko9rV7BTkhFbUlWp5BsF27iDR+o3JWe198n0NgU+Gb5FIs4Vu
	k8S/MgfrkPZ0J8mf245Ww/BJld9Dnha0Y9Y/IPLWXLjldlxpJrsuuLzbhwUQZhPE277AjA6+yRl
	i07ArXQ3gSDP7bue/RfX+HNuSFdqk2yKBnkueQqmj9l8C9wkvnaHyysKAEJyeongzMPfKArUYiG
	/NgsxRfijDx3sNFofTtk4LcHauYt03GmVB2+FV8VgyS
X-Received: by 2002:a17:90b:1d4f:b0:398:9be5:b417 with SMTP id 98e67ed59e1d1-39b26221eb1mr7387796a91.18.1788511351714;
        Fri, 04 Sep 2026 01:42:31 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:42:31 -0700 (PDT)
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
Subject: [PATCH v8 04/16] usb: hub: Use assign_bit() in usb_hub_set_port_power()
Date: Fri,  4 Sep 2026 16:41:43 +0800
Message-ID: <20260904084158.1341550-5-wenst@chromium.org>
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

usb_hub_set_port_power() open-codes assign_bit(). Just use the
assign_bit() macro instead. This makes subsequent additions to
usb_hub_set_port_power() easier to read.

This change does not introduce any functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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
index 3345b3298daf..16e03ec8d1ab 100644
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
2.55.0.979.g7e5102b832-goog

