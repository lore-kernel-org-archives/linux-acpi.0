Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF204343FD
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616935; cv=none; b=MXoJmrTFaIRESBcwzcIQcKzSVVNR/PYCOMpSMRX4kMOZagFDmrCcN0h39aBOXQek98HYY02VPQ312OBiVaB7N3uDfDxFGx65Lr+Iz/eUi5Rj5xGeKtXTkvzRhCvAcwBawkJ30cWP4u+wOH6CAPRiyqx3/gLIrlsirXWNke5BFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616935; c=relaxed/simple;
	bh=TPxqymmswATTFY0Ts3z5ZJsgeicU9hkYXr5TZUF7F/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amQ/Hr8SO8ADEUdZFocQSkHrdUs9L0Q3XhZ1Yf6Q/BxuET6sVM8X3/aE5fVMyRQyf7UPY8QouTEr2kiLQ22RVv2yjp+E4r1IPoj3NX+Ed6lS9X8IdnBKxpsR3QkavS1nxsJjTQc2lEIB7C47raBmzg+6qYY8aj7UkMi76n9aPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HnrE0Bfk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HnrE0Bfk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cca0c5799eso86501365ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616932; x=1785221732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=52TzlozFyu8oOUFzVHVO43WIZLgCMoBqx/sMPHBx7bQ=;
        b=HnrE0BfkJcQENp+fx6WYE1H9Xyzox5+4j72mtBwMiaYOcnFTM3sELlbFIabUtbj/Uf
         Z5KtAc5aXXtFdTn3pIAfgdjjUrbGm82eZ9JFz5lAP9wXJlCTnINVXZDx4eznn7uhUugw
         daqI5tczffyFEOFQTjOYT+Mq+KQT0rTCRx908=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616932; x=1785221732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=52TzlozFyu8oOUFzVHVO43WIZLgCMoBqx/sMPHBx7bQ=;
        b=hpb5QIL/vL3NJxBBN9c5BeCzAhhW+YYAIdTc5FOIAO00YhnNg+B3df+h+YlDyQCc8f
         9RRM9+twRDBrN99i8ggZhzR3AsaWnEYp7pIddV0j6QwywVWoYoEa7SokRaAnc1dbI9Jn
         VweGw91mu3ANiGVoEZ2HCL0x2z1BnfA2AvSzGxjJcLLK8GqGqj2oeaLMSrP53gSeccqW
         H2UYEj44+biUAlfR03R4j972cAbzamfIAHMpGAmeHt3S4gwQ/XdVnGFO0aR5uDPWOjTB
         aFoiakn7xLwg2GrZWarL2b4QwhX4SMhnQ/g3hJsvKkI8AJEbgAA8yN/VRdSnz+z6e39P
         XKyw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2Bt/2Z1E6CZVXIRj/L+piua5oEwJ9/U+xgQE2vxK+U2N8pMLULDbdQFILPkM6PnFG3/8JTBcTtrty@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPDtVLjCzB83Vy0lagBx/TfANnUlaBtTGZTKzxw5U60mjr6U/
	tbqbmyorVvnBJP+bGlaIDPqv5Zscr/YmEeoMx++qdfq2nQZ908U6GyiaQfQPk5l3tQ==
X-Gm-Gg: AR+sD12SWw/a0E2tiw70uaImUh3KPVC3RTeeX0HN3OgZDt5tEoNMgGPJWjydmHl7T8e
	4B4+BuiBUc3cEFC3QVOiUqfKtSogv9U412q1RB272fuAmZJtxNDEHKwYoHEMipsExmTDUcMGW6D
	DwePrdx0toaS3CO0gTeX5E1wuJVR78lco9jjozr+Ns1lSYcTkvQ0gd5FWYJwg8Ba7hEOFZVe9dT
	E3tnutY9q71IPTWd2U2gPDZ39rpkUhfhUIBOmBK3fk9ZuLpOD0JmKy/hI6VqIBanObASZruaerU
	7ndnSTzhL3vNgi+60/wUyP+vVkGTp+HY00YiJiYsKXGamcgwfaC57d2SdxJeeQIBGR1i8fBbExJ
	fY9FXWHTNLQDlqQxyHomRfM1l3KcGNuMpzn5hIT+uywDO161Wy/R7yKfUsp+MovELjX6cRxgv7P
	WOJMmnrk52xgQGd+pDKWlq1NPG2iW+8QIuOXd4o8Y+BexQCXqzgL99gQ22lIc=
X-Received: by 2002:a17:903:2287:b0:2c9:c517:d070 with SMTP id d9443c01a7336-2cf348366bfmr176522085ad.3.1784616932321;
        Mon, 20 Jul 2026 23:55:32 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:31 -0700 (PDT)
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
Subject: [PATCH v6 12/16] power: sequencing: pcie-m2: support matching on remote "port" node
Date: Tue, 21 Jul 2026 14:54:07 +0800
Message-ID: <20260721065413.2306137-13-wenst@chromium.org>
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

