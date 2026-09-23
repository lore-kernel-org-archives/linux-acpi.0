Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DA45D180;
	Wed, 23 Sep 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152094; cv=none; b=X2/ydDmDeXoHu0g8oUb7gcU+Uq+czrp0V+PLt2SmH1fF6hx0i7656LeVIdZCBrudpRSs6iKm5d4NF9FWgRTiOqKlwna+CyLT/nq6aZMSpTLaJzdspdTcBGrEUNkLy9gYogxqv+BxAWIk67I7ojmQpTJOzb8UAMMVzxg2a/dh9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152094; c=relaxed/simple;
	bh=eHy2f3cQE4CMQ01UeDyJ1qKzBxvlGzF/FSFw70WzLDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=to7AfljHeishNxv8uauHuC2yAmj3cch/WuyGT7FO+E4tnghp3ekFjo5JULdVUbP+BbQjx57BrPuO0/Nqnrsj8hy2UGOUCYp+LNNeYxg80YuVqC+8cLhBm3o3ei4WfVI0/8JlULm5Pk55nkbNnSUMiJQ9s7wDog22yVa2hNdTeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LYIv6yw6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LYIv6yw6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=idGYAD4/snHPJP0YfxlcHPs5QZDavMTdq3t02UEQ7jU=; b=
	LYIv6yw6mT2K7T4kGgEYulrPxARtJpwWuwZubK+50eiSGTfO/7UxyhJWvMiLN3mW8UpqQMWcLZbK9
	wEiu+pYtGesWePGGtozm555JRTx26FMnS5kQMjScAxm0KgomwblPwvx09iJpcRNGlaJS5BqtJeShq
	mLDz1UKyS69T611T0IepVLOblxHADFAO7OO9FFZ8lNvn/aHJ3JMck3Af69BsdkwnSn6+aOSRYSPXS
	7QmckmFYnTP3/b5xV6vD78vcjtiKjNG92rL1W4WXkSoh5kNdBrSKxAWhpeZyCI4Sy2/Gd2oVvJz62
	cAO0FeFBUMhEjGV2kojowvxGr/E2Frx0eA==;
Received: from [49.36.127.125] (helo=uajain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x9IKe-00628i-8R; Wed, 23 Sep 2026 10:28:00 +0200
From: Umang Jain <uajain@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Umang Jain <uajain@igalia.com>
Subject: [PATCH v2 0/2] acpi: battery: Query BCT method and steamdeck
Date: Wed, 23 Sep 2026 13:59:30 +0530
Message-ID: <20260923082932.1049270-1-uajain@igalia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Short series to query Battery charge time ("_BCT") from ACPI tables
(1/2).

Patch 2/2 handles the case where steamdeck devices can report "Charging"
even when low power PSU is connected which is discharging the device.

Changes in v2:
- comment improvements
- split off BCT method handling into separate patch

v1:
https://lore.kernel.org/all/20260918135628.2322188-1-uajain@igalia.com/

Umang Jain (2):
  acpi: battery: Query Battery charge time ("_BCT") method
  acpi: battery: Handle Valve steamdeck devices quirk

 drivers/acpi/battery.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

-- 
2.55.0

