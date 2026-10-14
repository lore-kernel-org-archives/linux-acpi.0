Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8EC4AA00F;
	Wed, 14 Oct 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010674; cv=none; b=aDD2pyqsIQeQROwJpsdzAp8s0vDHZSd/2kklBTz5ByquFd7zF1DtFJonWC+Reihr0Ts+Ybi/5nQTEl6RPWDSb7OmH4mf/aPTAhAtu6mveDS45/YSSExw7l8LLibPQ3qPAlMq9gFh4D21H1qDfxA/AqP7/gsP9o1alE+MXWK2M/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010674; c=relaxed/simple;
	bh=MSeI6VMsOH4y+l3Xwrz5SdB+0WLtLBqUW/w/cWtLYlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUwmjEGDRZtBiNk4Z24mUBDJvRCqElKsGlsTQ1CcT1731/BRCRJ8qF/CL+4P6T4WJH9/Yt6MoVqPFQYpzPJtXyX4mfgQKkP1vYvWa4nKQmKNIJQRj1+U7nZ0g9rLsq/TVqpmaEs0RB2w6sOzksyKJn8juIWA6eUUz9OyixRDrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WGbVzuy0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WGbVzuy0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=hiLfNJO7d4xLlo97mYwFH+Jb3RrWBPZPMof4xFhX9Yc=; b=
	WGbVzuy0RXVvolt9G7Yhm4lRwANxVe/k0PM7WDwhL4gYjl28R6h3AEQIqfw5SUbrub68SbbuveOj6
	qnUioxvMjTVo/kMDtzFWZGFEF6JOO9FIHoKf5Cl5KTEmWvyxDziXfoUjKl7RLmz9HFOpvltFHNGPN
	BVNeaLG6ai5PCHUrWsVbq+u7UcPIws5B7T1t+9o4g04Nxy9YJ5+IYNwgAqZZquPObjfC+Y+7dVX0r
	d3XUpgA2qvOXzc/ksmBRr2mszJq1mK0VYwRiAyhMgJQEtzt+aFvcrdkyQTftHWhurMbfCABgzMCmG
	u9y9eb8by1414CMMZrAHkw28ju/AcGc+6g==;
Received: from ip-86-49-238-151.bb.vodafone.cz ([86.49.238.151] helo=uajain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xH5pq-000Dyf-AF; Wed, 14 Oct 2026 22:44:26 +0200
From: Umang Jain <uajain@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Umang Jain <uajain@igalia.com>
Subject: [PATCH v3 0/2]  acpi: battery: Query BCT method for steamdeck
Date: Wed, 14 Oct 2026 22:45:56 +0200
Message-ID: <20261014204558.466130-1-uajain@igalia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Short series to query Battery charge time ("_BCT") from ACPI tables
for steamdeck devices.

Patch 1/2 introduces the steamdeck device battery quirk.
Patch 2/2 handles the case where steamdeck devices can report "Charging"
even when low power PSU is connected which is discharging the device.

Changes in v3:
- Only query BCT method for the steamdeck quirk
- Drop charge_time member from battery object
- check for returned value from acpi_evaluate_integer for max
  ACPI_UINT32_MAX bounds as per the spec

Changes in v2:
- comment improvements
- split off BCT method handling into separate patch
- https://lore.kernel.org/all/20260923082932.1049270-1-uajain@igalia.com/

v1:
https://lore.kernel.org/all/20260918135628.2322188-1-uajain@igalia.com/


Umang Jain (2):
  acpi: battery: Introduce Valve steamdeck devices quirk
  acpi: battery: Read Battery charge time for Steamdeck devices

 drivers/acpi/battery.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

-- 
2.55.0

