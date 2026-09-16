Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0A4483B3
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545535; cv=none; b=OlwqjtUCkfXhuMEjZ9fV747n6VbZ7ASd8wezjTUVbF3bwpTwnTSrvvbIpOhRfRz2O5wLvLoejkHBiKlax5pqIoeAvV+S6pEBRDHM3wkSI2WZ3gvq9r4RIm796/6LYkHfJytYw0Oe4FmDpGmNWx/Xie75hZ4JQAun1wDe+8MQyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545535; c=relaxed/simple;
	bh=guAn9TMfJdLxEfb0LTGkrmmVx3DDJgyF4Kcka2QfUz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyDufZhXdfV/Cad+vsKaY9F6LR6HX6CmQxR7pi8ixTzcM1TY3/+jF6jeVzNPyCPAmgWvs8oq6eYI4LDoGI0qqIG23SSwtjGvkd54klAJo+SqjOUK7JoYPHFNghrAA9dhTNL5U+3bnG1FcHXnYU6E7WrarP0rSfBZs50VSdHdESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bFRS5K0f; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bFRS5K0f"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so353159a12.3
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545523; x=1790150323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9EP7B7Ij+uzgh7ozqOWENJmY+4dziA6HYdxmCK1rOAM=;
        b=bFRS5K0fJAFRwemfCnobO4KDZTJ0Upc+aurdNPL5HXxuXmicqD+uwP31FwD0DPH+2h
         guPLAibJTdNgLyZ1K8XB7SpjnWbvJ6sd6N2NPfzzBbnRJUZv5BtKeDkNWIzn/YTEs1p5
         p/SihHo7CsS/rx2z6z70oTxKTyoxlUNDjUrVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545523; x=1790150323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9EP7B7Ij+uzgh7ozqOWENJmY+4dziA6HYdxmCK1rOAM=;
        b=MjihEEnfd2qw5LFU50KBw0Zxug2K1VMdwMZ+2esRJr12c3g0MXK5L90wvneQc8jKYk
         nZ58euk7w8dSEpQJYL0vtC7pcuyNAMNj98gPjWPtYePlLwb27Y4wyyi1K4r3qfs6KVF0
         VfBXcDhKh/CamukBh52gBKKDR27E9T+87yMCVUp1/95VUKzEC/L6UTRzuWJu6sgqnx9M
         e4fQxi1SyWDPTKLEgBFnvEh1dJKxPW0dR2MMsxtjzR1us8QBNC5+IzDiHLQUvz2c3Ken
         vj1rlY/Z/yU3i5Ygr8kLeB2gclCjyDwGIEIpyorFSrUXez3pJu8oWDtff/mKC/cqB51K
         qdmA==
X-Forwarded-Encrypted: i=1; AKwUvBzXGWCM7YozDnK9xGZ5EoJPvEBg5hfPpjzv5jiU1Y+M16AoSWrTgxcOLENyNZN4u5VUX/lzFMfF0vG6@vger.kernel.org
X-Gm-Message-State: AFuF++ldn1as3AAenXNukYXcwcVhQNJQzjoGh30s5Wg5oFwfnXvjel1r
	0H/iWkmHcEqVHvDTzRyjLUr9lADPEzxFPmgTWp3ssLQCw1PQqCKe4+dzlqiFdjF16Q==
X-Gm-Gg: AYBFou1vNxdPVAOpIF3lgVM5fA9hDeE3YnWI6QnHSNZZo1VSDROKA4Og4lXrLjdNIX8
	nU9/cPcFj9HQqEifObPWapvpHh8VciivPraDvZl/mke9qCBGkfiTvb4DVOxKUlV2ONBgUdiu6W+
	JDHJHlK+re3p122vbI81vo0vDC4PTenXARUylOTXRp48HONjKJ6djQGeqvoK7GrbUZJzMIz3ydu
	p6OSYIruRqoEYu9n/f9oKK3MBJjfQnQ4pjr8k2lLblPY2FdWY693B+xZ/oVRzD4grsWM1dkq+Vg
	MLft7Gm/zIGoIpwUn0Al9HV5oouZq1nZgY/DprXNQKWNXatLo1BDFZ/IZLWbazaDEch7PstGo73
	MujC+H6mBN3241oE7eot3Xxz5M2QT+FqXQ80MSmPOWMAEpTBZzKxnDteq06rcNjSjtcvx3pnsJ0
	Wup9hsYM6iK2DnP4sZ43wiWO4ojwL2P7E/w35TyTFYwBlEEOm2WvSt/gf+AwpdwDLoztG4a4QoF
	gCE4Uo6xGG2ddOD3omWllmss30McAfbJey6bovo1zI0mjVVJ8ZIjqCE8A==
X-Received: by 2002:a17:90b:440c:b0:39d:fea0:c17 with SMTP id 98e67ed59e1d1-39e1e309c21mr3792094a91.8.1789545523106;
        Wed, 16 Sep 2026 00:58:43 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:58:42 -0700 (PDT)
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
Subject: [PATCH v9 04/15] usb: hub: Use assign_bit() in usb_hub_set_port_power()
Date: Wed, 16 Sep 2026 15:57:30 +0800
Message-ID: <20260916075745.3549953-5-wenst@chromium.org>
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
index 199d3f535a89..a4ec79a06a5c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -10,6 +10,7 @@
  * Released under the GPLv2 only.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/module.h>
@@ -902,10 +903,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
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
2.55.0.1032.g73a4cd73de-goog

