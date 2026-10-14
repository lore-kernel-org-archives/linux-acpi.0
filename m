Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE392418346;
	Wed, 14 Oct 2026 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004763; cv=none; b=YMy9NXy3PMzzrwdnHvUGlLI1ie14rU49W3hGdOr7/d4Sn1GT1rc6ipf3eKRVZod4B3N6J18jJWnbmR52L1bIqzgXO4YHXRPuYl+CRlZGmeCdSxfc3aQ1OoTKQQhBFxCIMi+muxJkTdfC2f07Gs9yqDs9CFIXOe93hS92O0d4JTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004763; c=relaxed/simple;
	bh=tai74cT1U2n+M8s3mfCvRqPe0rFgUGBdipz6EPcscOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VeOF35R9Tec91+RDJf5maSEWC+7MxosttQyR0INYoFs5tsICaZKUWIvWMMl5X4gKx2xX97LrHVLM7e3HMEjmVo5/JNjyFrKBNtXoKeczbfhtLcYDhvxC55mTVs8IBlZbknu0Gf0zts/qeAeOO3y0EBhjTYQPHr61gRpmgDGg9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hLidZkIr; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hLidZkIr"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A36E680B59;
	Wed, 14 Oct 2026 21:05:57 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o7FGUn6_ISzO; Wed, 14 Oct 2026 21:05:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792004756; bh=tai74cT1U2n+M8s3mfCvRqPe0rFgUGBdipz6EPcscOo=;
	h=From:To:Cc:Subject:Date;
	b=hLidZkIrFd0SAKq98dQszt27CbM4TtfkM/uarDMsdVfYgKKSrg6e27pzveMyprIuF
	 x9puc1q5b/+u0TamUkXjfgdLV0mv0XeLXnH/QcPZTc1blhLWBWhLubVMo9dXDsoOg0
	 0Zt6phlY3Cpfm/ROyIL0RWkQEnowkRXhrcVBn3McOKam9BaLBf96CHh9GZpQHdl2g/
	 4Xhf9+qr3O1xQUHJ4z/dNiLockD/3/yTNDp2E8lKeXUBotkaFp/hwO+ed2DpdH01q+
	 NRrP3pVaAyZqtuKCovatnOGnDbn+a3sAJY/FihbU1nlEH72GDDSlgqxckhGNLYUBPy
	 NyNTWBymYOh6g==
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
Subject: [PATCH 0/4] ACPI: Serialize EC queries, UCSI and ideapad methods
Date: Wed, 14 Oct 2026 22:04:52 +0300
Message-ID: <20261014190544.150093-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This goes on top of [1] and uses its exclusive helpers for the other
users of the shared EC mutex in bko221065: the _Qxx methods, the UCSI
_DSM and the ideapad-laptop methods, as discussed in [2].

Patches 3 and 4 depend on patch 1 and on [1], so it is probably easiest
to take the whole set through the ACPI tree.

The ideapad part is only build-tested, so it would be great if someone
with one of the bko221065 machines could try both series together.

[1] https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.org/
[2] https://lore.kernel.org/all/8be1a245-6061-4f86-9223-0da18d5e423a@oss.qualcomm.com/

Ali Ahmet Memiş (4):
  ACPI: utils: Add acpi_evaluate_dsm_exclusive()
  ACPI: EC: Evaluate _Qxx methods exclusively
  usb: typec: ucsi: acpi: Evaluate _DSM exclusively
  platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively

 drivers/acpi/ec.c                            |  7 ++-
 drivers/acpi/utils.c                         | 54 +++++++++++++-------
 drivers/platform/x86/lenovo/ideapad-laptop.c | 21 ++++++--
 drivers/usb/typec/ucsi/ucsi_acpi.c           |  8 ++-
 include/acpi/acpi_bus.h                      |  3 ++
 include/linux/acpi.h                         |  8 +++
 6 files changed, 76 insertions(+), 25 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
prerequisite-patch-id: 4bd123d6caded06beb9a977d502370df046f82aa
prerequisite-patch-id: 19de145660fffa3651defed4e6d536cb78418940
prerequisite-patch-id: 01d8992be9ebc2b28dd3986fe06269eb2fe959f5
-- 
2.55.0

