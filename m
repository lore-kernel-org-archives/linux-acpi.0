Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824795;
	b=nwK9Fp6giyWKct1gDnUmdem73VHRNNTY4IdbqusNmd1N3IgkEIlswxjiNCmrNe0YX/Bv
	 RDbDS0c0HBqSULGsKrPva4LC9b3dOzCG2iot4f31YcvQjYOCIXTktWNkjk8WqL4YCPKMQ
	 CFKv92rs6+5Eugi8KdCvHUtNNs9av6hYKte5sdesWyc8d54AIyelkV3u+cog1H9HznPTU
	 2vEoABCB/nqvgI21Jh9Q75bU9SEIpAx3BzQR0HlScT5qSiSfl6iC5V3c/TfbgLxcBdCkB
	 SuM452JPZz3dDdaItpGwTU1mLinzRAqnT/CBHx8WaP7WiXUzRMf1Au6otz0M/Tahvcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824795;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Rr8xAJHBX8onqJgiA7CM7t7W+lJc/kV23lML0z/MCkY=;
	b=TGSQK4VQ4V5iGnmN/sPMR8cmcixu8fl8VKapRq3+b3Vhh4PBoTMLNabm1z9p10AIfeCa
	 vaGHvKmjDCTGPCmFRgkFDK24KnK17g+pPpHoV/p01HmRBVGLh8jSznVic9uOHm7nzn5EU
	 HdrHU6Ig4SfrbVPxtqu5uz+F7yIY42UcbOPHYJIm0gcJhvipQe+DfPd5cQUYcBtKXS2HE
	 fQovzIkFnR/fxHgLhwWZKjAyG+KFZuslACgwXiTke/BdQW/LQMpVrDrO3v1O6NGmlsCWV
	 G1PVBwUzcWDey5UFB6/bWbKWcWnz5pVlos5QJv3GJx6/v1AHwdc386VVV0Ws7DGFReQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Os5jxAio;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91418606A31C;
	Mon, 16 Nov 2026 10:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91418606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Os5jxAio
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=Rr8xAJHBX8onqJgiA7CM7t7W+lJc/kV23lML0z/MCkY=;
	t=1794824793; x=2110184793; b=Os5jxAio1f5jViu8Qf/jiZwQ3wydRUI/roA+RsZg4HnGBMX
	awVreLVxArL+86lrfLAFBeIKy0zAT3WQ8+GXG5/3FGgEAmTK+jue67PKoW13QqMswgJBcsDdPMm/8
	QcRABq5kEQ7TaF3VCYgY4abliicaQuuq/ndBAcAzFT3gMXC2dDNC3KchgkE2EWIN69yO2UG9Utkx0
	8EkRibGuwEHIqVjP69DrRUjoM8NaiFDxd/oeSYwQxeTKmK4D9PvollQh/p4tY2wDab3ToFIjm3O5S
	C5FafI2OExeOBnBulYduuqpLMdHmlR8xo/6Qfi02/QOu69K7Ma+t59dJP9/FlLKg==;
Received: from [103.238.108.137] (helo=uajain.bbrouter)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xStuw-00000000958-22Ad;
	Mon, 16 Nov 2026 11:26:30 +0100
From: Umang Jain <uajain@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Umang Jain <uajain@igalia.com>
Subject: [PATCH v4 0/1]  acpi: battery: Read Battery charge time for Steamdeck devices
Date: Mon, 16 Nov 2026 15:57:51 +0530
Message-ID: <20261116102752.520062-1-uajain@igalia.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch to query Battery charge time ("_BCT") from ACPI tables
for steamdeck devices to determine when low power PSU is connected,
which is discharging the device.

changes in v4:
- Merge both 1/2 and 2/2 into single patch
- Set quirk and _BCT reading at same place
- Edit comments for the same.
- Log failed message as acpi_handle_debug()
- Split case when _BCT value > ACPI_UINT32_MAX

Changes in v3:
- Only query BCT method for the steamdeck quirk
- Drop charge_time member from battery object
- check for returned value from acpi_evaluate_integer for max
  ACPI_UINT32_MAX bounds as per the spec
Link: https://lore.kernel.org/all/20261014204558.466130-1-uajain@igalia.com/

Changes in v2:
- comment improvements
- split off BCT method handling into separate patch
- https://lore.kernel.org/all/20260923082932.1049270-1-uajain@igalia.com/

v1:
https://lore.kernel.org/all/20260918135628.2322188-1-uajain@igalia.com/

Umang Jain (1):
  acpi: battery: Read Battery charge time("_BCT") for Steamdeck devices

 drivers/acpi/battery.c | 49 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

-- 
2.55.0

