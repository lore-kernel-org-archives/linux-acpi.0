Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD441D640;
	Wed, 14 Oct 2026 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004763; cv=none; b=dOEmvKzJuyHfO8CMr8P/pnugXx5QuRdPCP9CleFKmrA/fYrez15gQzRfQshUxRF9cpqbV2by+YhmGD3nG7He1RFUL1ezak/kkjg8d3PAgkNCijHbbZFFQEa3sO2p6k8lvzj3YWaxtkGznjfKQMHuVW5vNwPdvg3uglxVLMMv/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004763; c=relaxed/simple;
	bh=rfRX1iHfQxYvt82fLACLtUFEcjdoTxE/BnzihATepfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibCxYVaVLNB77XK/Yk538jKT+GAf4mJdPnaHxZG59jilm+TJ9UP94RhGM0YHVOM83YkGe7zdRrG17hH5laro7DpTlO3feG81aCH63bqa1ZQsdsDPiqQCwT/aprXiaCcRQKbahWA55lwlRESiHjLlKD3BeGDceUdlVyYAG+DDpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HGqw1lvC; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HGqw1lvC"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4969B8090C;
	Wed, 14 Oct 2026 21:06:00 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id REbw_tkE7iV4; Wed, 14 Oct 2026 21:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792004759; bh=rfRX1iHfQxYvt82fLACLtUFEcjdoTxE/BnzihATepfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HGqw1lvCGmfwlhNZZ6Vv+DMAO9iHejQus5aZHVSJ2tLBZGSQQ0B5p/IPIDNHga4ey
	 1Kb/HQEvuFxShMhZd5xaAY+wdPDSYn9Q0wdU9VTFNK9yVz8M7lcN0GAVyjnCm42K7r
	 9xyVqlNLCH6BZkwZcV89ZOjfadpKFgejhXSp4fHZ+9rtcbW8kKzr7MElXQpUpTe8T0
	 k3OBN2QjKOZwuAg5H2MSlXDePSjPtdktB7Eaxlwn0+6LhyLuVc22gXb3hTyfm/SMiV
	 LYWqP0orIMrj5R4S5KvxkCMmyn+/s8yQEw1ZjwHqyKjwx/dhRNykfuoocjKFr6RvJ4
	 iJNZO9pGXdvVw==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Len Brown <lenb@kernel.org>,
	Ike Panhc <ikepanhc@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Rong Zhang <i@rong.moe>,
	Armin Wolf <W_Armin@gmx.de>,
	Avraham Hollander <anhollander516@gmail.com>,
	=?UTF-8?q?Jeffrey=20W=C3=A4lti?= <jeffrey@waelti.dev>,
	Rick <rickk1166@gmail.com>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-usb@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ACPI: EC: Evaluate _Qxx methods exclusively
Date: Wed, 14 Oct 2026 22:04:54 +0300
Message-ID: <20261014190544.150093-3-aliamemis@disroot.org>
In-Reply-To: <20261014190544.150093-1-aliamemis@disroot.org>
References: <20261014190544.150093-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On some Lenovo IdeaPad and Yoga models, _Q0A, _Q0B and the UCSI
notification query _Q16 take the same AML mutex as the battery, UCSI and
ideapad methods. Making those exclusive does not help as long as the
_Qxx methods still run interleaved with them.

Evaluate _Qxx with acpi_evaluate_object_exclusive().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
 drivers/acpi/ec.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a89f10256dbb..6cec5a319ec2 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1154,10 +1154,15 @@ static void acpi_ec_event_processor(struct work_struct *work)
 
 	ec_dbg_evt("Query(0x%02x) started", handler->query_bit);
 
+	/*
+	 * Evaluate _Qxx exclusively, as on some laptops they take the same
+	 * AML mutex as the battery, UCSI and platform methods, which then
+	 * time out waiting for it.
+	 */
 	if (handler->func)
 		handler->func(handler->data);
 	else if (handler->handle)
-		acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
+		acpi_evaluate_object_exclusive(handler->handle, NULL, NULL, NULL);
 
 	ec_dbg_evt("Query(0x%02x) stopped", handler->query_bit);
 
-- 
2.55.0

