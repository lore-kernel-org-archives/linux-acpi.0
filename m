Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38F40096F
	for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882708; cv=none; b=kAjpwyfccHvqu779Kt1y8XO/xLIGuoNSyJajJpRkXWpqYF0xNfFh/Ecrh58eVyy/ISjypkVf5PegO28+/A2J1fxs7Tm18rGjrluln5T5uff145c7Rawy8Eejy7f82TRkuz7OltVPMdQeSlM9/D+67bcFIAwgoZt5jrUbrbF0dgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882708; c=relaxed/simple;
	bh=TPxqymmswATTFY0Ts3z5ZJsgeicU9hkYXr5TZUF7F/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bk3kXrsI1ZlJY9XmL/xe1B/4jhzBnbWk6rG/gFXF6Q4mLwGo2YJeAhaD45Du307Cn9LbiU6BOfkJvA9unI+8K0q7H/gqEU9e+NWCh7a708W12CLQXYqGh1zD5wVSknAlOAutDdPwOz6T18XAUrWpGwfzxOLzd/xkQr7rSynYWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OTRGJfbX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OTRGJfbX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e58034d05so163957a91.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882706; x=1785487506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=52TzlozFyu8oOUFzVHVO43WIZLgCMoBqx/sMPHBx7bQ=;
        b=OTRGJfbXn6jlSMk0TKof54mYgUxVw6F9PMX9UQsE2cl0RhwkwKlxL3ZFkxugqKrOT/
         szNNkxjpyjIQF3zJT5LWWbYpCA8UZnpIK9NWvPwRWBExJd50d/LP0+zReVinM81Te2cq
         O5sJ5bxGjX7PDid0h/La5V1oIObWhcH0CY5VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882706; x=1785487506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=52TzlozFyu8oOUFzVHVO43WIZLgCMoBqx/sMPHBx7bQ=;
        b=k/2FmHcGmO6eCOwNso96VV/ylcSewsQlo2ZZ8AoGblRGvRAnmnd4Yd7K/WZncwwa5r
         jvvYcDU1tS26riytABSosW+SDbgBT+YYAQGFqnU47zlzJuCuZEM+A+oHKiUYi5xLnu1y
         ifcWPpHtWcswJ3yE3h3dGnKMG5mdE3/gFudJ+Po/9JD+co8WioJoNDyQbWaOVWkcfS5F
         CRY/FRVMEJ1OB+Tajg5NZGxfmThrlt8nmQT3spvgnoqgkPC+KECcRYofwTZtayDgxHVp
         Atpmkg3xTbo5D1bb11HBsRifQSvGshC5BVeuMRxDkLaRuiZK5us105kliGV1xsZ1cKiz
         0Jag==
X-Forwarded-Encrypted: i=1; AHgh+RpdozgjmyMhgu62dcw/C21gPINP9HEkxDUo5ByIOKArgWuhvtoxmgJaVOyXM1HjFAry2CGbaVIHAlLy@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZKLTqrZ0TVN2qjrSALTyA5o1mbV70fyRuV22aGymRahDdm+A
	j5AuPpX3e+EE4LOMh+dEiOAuoCW+wQW/d1tcfjYgw76M2Ye3GXcnsMy/4Di7wjMoLw==
X-Gm-Gg: AR+sD10vjOY6wErdOrJNmNsBtF+o7aEC4R9O6IomuYeCbWI47zovRxSXlAta1Y17vvN
	uBT2y8iYHl0MBRpG5xPcb0ImSzcPi0irPsFGuASK8dWXuqbENKGo/EMuCWKfVW0GQLlu3QhpB2T
	IuN95ft6diKw0ZqnKCz52E8OHTCU7cXWNfPVOr3HnK9RaRQI0VZZ41axb4dDsWRbm+yECBxVfag
	d1McF8NYm7XzgZ824VC7IQJXQfBED0fg5FIDrnsbbqCZ/NExXd5J47te23LmyZu5aEJWVVplPg7
	g7x7B28q0GQa8gFw00vup/sayWBZWfYzVCr8mX56mIS3zyttRE9ltjk88alwIZuxwAcdSL3/ZNi
	SHHNyjpMFMpDjfFc2l/dIgzg91DDQoczicbiI+XhzdkZS/CEoocNyDe3G4lMlbNdwArBZyIE+cz
	y1SHwYt1GDeQa7FvN/R1rrXSaP4IkBCMtizGJcbw8x+Op4/BpRL9bujQwuU0k=
X-Received: by 2002:a17:90b:5687:b0:387:e0bb:57f8 with SMTP id 98e67ed59e1d1-38ec6a9d77bmr7085311a91.41.1784882706348;
        Fri, 24 Jul 2026 01:45:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:45:05 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v7 12/16] power: sequencing: pcie-m2: support matching on remote "port" node
Date: Fri, 24 Jul 2026 16:43:21 +0800
Message-ID: <20260724084328.3943997-13-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A USB hub can have multiple ports, and this driver needs to
differentiate which port is being matched to. The USB hub driver now
associates the "port" node with the usb_port device, so here we can
use the remote "port" node to check for a match. Then fall back to
the remote device node for the other connection types.

Also rewrite the existing "remote == dev_of_node(dev)" with
device_match_of_node() for consistency.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Dropped blank line between __free() variable declaration and
  subsequent use of the variable in conditional

Changes since v3:
- Drop redundant device node validity check; device_match_of_node()
  does it internally

Changes since v2:
- Use device_match_of_node()
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 83fe6a1396bc..691cad0a6dd0 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -175,9 +175,16 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 	 * parent matches the OF node of 'dev'.
 	 */
 	for_each_endpoint_of_node(ctx->of_node, endpoint) {
+		/* USB port devices are tied to the port nodes. */
+		struct device_node *remote_port __free(device_node) =
+				of_graph_get_remote_port(endpoint);
+		if (device_match_of_node(dev, remote_port))
+			return PWRSEQ_MATCH_OK;
+
+		/* Try the remote port parent for other types. */
 		struct device_node *remote __free(device_node) =
 				of_graph_get_remote_port_parent(endpoint);
-		if (remote && (remote == dev_of_node(dev)))
+		if (device_match_of_node(dev, remote))
 			return PWRSEQ_MATCH_OK;
 	}
 
-- 
2.55.0.229.g6434b31f56-goog

