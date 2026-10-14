Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2F43303E;
	Wed, 14 Oct 2026 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004767; cv=none; b=f3/3i5eEroUPkDR/0Rw1GAIAzXvuGklM4ATeHJivyhm65+vGqmik4hST6uLmqyDAU81hpty8AAYUjzko2r5nsPWNJGohJUR1hvg3UBAJtTxp2MnvRt7FWPRDWWEUpx1IxeE5kW7XOguQmbAcf4Ruok7VGYxSgI8BvFUa0Kk7tNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004767; c=relaxed/simple;
	bh=T0HGTTse7JgGal4jEjqGboGEfv+qM3L0V+D9r39mdWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFYqz5/xpi1IC8NFLnBOy5LHTU3LMsudQT076frMzNfVC6AsxxcggLyXRx79HZL7KkjRxU+TAkeov4D4G401ATSjjignLOYWnX6Bc4Ejm1J83ckIsZNv6iY7x9XoiaKJSbUSc9pCNShMkBB1n5jECAIHfREpbBctozsa4dPiibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NaG/A/50; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NaG/A/50"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D395E82B59;
	Wed, 14 Oct 2026 21:06:01 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oDC2TBvo-w5v; Wed, 14 Oct 2026 21:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792004760; bh=T0HGTTse7JgGal4jEjqGboGEfv+qM3L0V+D9r39mdWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NaG/A/50h7MLW1yTvKoP8jNkxVwrJ47N10iOYjxTEaFnquwIX/u9aZMTgmYHNKbFE
	 u8mPx+6K1RYuo0W2VpR4H/3vC0zuL34sFS7qgViccX5s/8u2iWEL4bDItEqJfUxXyQ
	 LcbaJ0wl7QWUXSIzuUD3UL9VBBhdbkUnaMszKtrLqDywLWBalo8ljUw/VXholBln5i
	 PVSKMDlwjn2NLO//0L2lbNHX3ajzax6GI2zKXGS9Kvvs042W6rMbNf0dGPaEkuMOtO
	 AU9GluV6LcPd8Q4Ur4YWFTtlX/7IQGasz0m779XVMmNlg2wZzV7cc7VaWTsH+Vqitj
	 4Zt0eTj5dEB4w==
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
Subject: [PATCH 3/4] usb: typec: ucsi: acpi: Evaluate _DSM exclusively
Date: Wed, 14 Oct 2026 22:04:55 +0300
Message-ID: <20261014190544.150093-4-aliamemis@disroot.org>
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

On some Lenovo IdeaPad and Yoga models, the UCSI _DSM accesses the EC 25
times through helpers that take a shared AML mutex with a 1 s timeout
and return 0 when it times out, so UCSI commands fail under contention
with the battery and ideapad methods.

Evaluate the _DSM with acpi_evaluate_dsm_exclusive().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 5697ccc24ec3..0b9aaf317d2b 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -30,8 +30,12 @@ static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
 {
 	union acpi_object *obj;
 
-	obj = acpi_evaluate_dsm(ACPI_HANDLE(ua->dev), &ua->guid, 1, func,
-				NULL);
+	/*
+	 * On some Lenovo laptops the _DSM times out on the AML mutex it
+	 * shares with the battery and platform methods.
+	 */
+	obj = acpi_evaluate_dsm_exclusive(ACPI_HANDLE(ua->dev), &ua->guid, 1,
+					  func, NULL);
 	if (!obj) {
 		dev_err(ua->dev, "%s: failed to evaluate _DSM %d\n",
 			__func__, func);
-- 
2.55.0

