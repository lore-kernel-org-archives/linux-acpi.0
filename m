Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2C4EBAE9
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085452; cv=none; b=r7+EPTccnWNSGjvvvRDG2sheB0rpZ+4TRPV15SH1N2cqGkX01vMzlLgRc6Oir4f1mTAFOpzgSu8f82PRkia8wmp2tUQJBcqf7nfSwWAqhNYlSEJy6F5f2lOHiBAG4aAs8fz/fNWAiLtfu/seQlxAN4dx+ZxdfRfMJcFHn19ngw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085452; c=relaxed/simple;
	bh=jzXshqsq8LpTtp/eHftavX8CC47Hi2RgETXeFOYwq6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlFAByYHICkiUyTihREMUOGnNMtyF1Xo8G2vmBerhMftdHb7Umv1q4nE3UkWMfmb349lMIE5Ir4tVU4MtRI139RBA6FgGgz1ahwM4meGpA29WUM11PTet80dzWbhJuAbtFhpwBTUrYri0NjeVqgdcEsXXKLt8fJgcZOTzlXq6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XYO+kwr1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XYO+kwr1"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e635220b9so388705985a.2
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792085440; x=1792690240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Ij/yqmblFjl2otRcuDhQ5WPtlcQLmq30NR3nWc3SBE=;
        b=XYO+kwr1XGq9ffky7iQedv7871Sf2Y4pvTbjHS7Q9wng5YxOySEgCHbulG5rwVPNwg
         oIZIU/XZgGjCFbJGZ0nKk9/yenG7YK0mCATWX4+Yu5AIg5ErS57SjfrNQSS3FXr7ohrl
         3ew4yRX1MW/diHWRFQylD39rD0PjNsqvu8Ap/wLlhatctfRJsFHY7M6z4wAd5HvnRdno
         1hemMZD8UIm9f48RBV8JzPRZXwDCme/0Z25BzQJxoz8D7NFLd4yBfEb0m1hddFTUx62G
         InHz28+S80Lnm2P+GJhER1zvC7m7zBf9HFY1cr1BoI2Fukg1VBIHluRahQO/1IbyvbmR
         51vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085440; x=1792690240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Ij/yqmblFjl2otRcuDhQ5WPtlcQLmq30NR3nWc3SBE=;
        b=LwVYjhOYhSbQODdIIxItHFfYJGhT3V+09kqGYzg/AaRDZhl4w6oThFUgwE51HNBzuB
         nNbaOej9Arf7vENn55V22TBj7ysamHwMLr6hgtmzIhFa97tNknB1MpH09Uwvb3dFScAY
         J1ZnJ6pPEyI0uC+QI2pM5oz8Qoy+Z7O7jGub4hiKTYV2f/EO0tyYqaOQm4gTI+PRGPIa
         E8ssRm8z/QDgggfdScIgyOJUuf9eCL3XrvMMyMi6QbMjND2d4asfre0ERyZKsqfgMg0h
         FbUwQ/LpleqbmZ9nl+631kNeKzEO/8aQ7IiMOu/76VTfHcCNiiRl5TsVaD5L9C+49I8H
         XqCA==
X-Gm-Message-State: AFq9FYJjOc+VMlmF1oBxPNx7346nelQW+woz3hI6HWijNnKCoqrRwZTV
	Y7U13z7Bl4LWo7KeTEHOvD/LPGgnwvgQA9UmAKGRxjCl92O7hsaKmOirCJ+QmZv+SFE=
X-Gm-Gg: AYBFou0HO2oiaroFNh9y5Cw8WscuLKGONXhfASydWGbErrPfj0073jk/AgwiBugyI0+
	y5EIVpYHzdAVknogCN+aG/PG7ZkmtOMMlmE8ug9iICvNtzglbxOdn2f8EMC01OSOsFO3DcusJ4X
	hZFik5NmrYJN8IoClOqr6KJtOF8WOkIZOvO0DYb41hob0qATj+O9IHTk7pUzzQlsq8lExOfy33V
	uB4Upwy0hqJnzipdxhBZfdhzINEQLP0/C+spEu90BCDg4Va4Wog3ezvwobm0taLNuMZ5oKXpUF0
	uNV45o5vB2py2ceOrAutbE04JU4KEGyxvXukti66hh0Wzd9nVctVUEvyeEbHu0JJwNheapqLjz3
	WvKCC36P2wh1aNWYm3ua72foSow5O8wLyN2B1GzgWTWMkMW1H2rfJYX4y5ItmKT1bn/SIUNSfeT
	cQPAO48EOdG1iK6oObfYraDH8E6HUvrEMbr67Nyc9QXyqH69784ANMetuv0gfvbRGWfFZ5WslWN
	9L5cIxKdhysFvCIVwGzALfoUEHwjRot71qO3IrVuLP4IfHJU7yFb8TMQR/ssTwwyiDLmWs=
X-Received: by 2002:a05:620a:4141:b0:93e:d364:ca10 with SMTP id af79cd13be357-93ed364eb7cmr2739104485a.12.1792085438698;
        Thu, 15 Oct 2026 10:30:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50095bbsm825062485a.9.2026.10.15.10.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:30:36 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	alexandre.belloni@bootlin.com,
	rui.zhang@intel.com
Subject: [RESEND PATCH 0/2] rtc: cmos: Fix ACPI RTC alarm handling
Date: Thu, 15 Oct 2026 13:30:27 -0400
Message-ID: <20261015173029.3091872-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend of the series first posted on September 9.
https://lore.kernel.org/linux-rtc/20260909225132.1392883-1-gourry@gourry.net/

RTC update interrupt emulation can stop delivering events when rtc-cmos
uses the ACPI RTC fixed event. On an affected system, a test that waits
for five one-second update events completed only 40 of 50 runs. The ACPI
ff_rt_clk counter stopped at 218, exactly matching the number of events
delivered to userspace, with the event status set but delivery disabled.

The ACPI SCI handler disables the fixed event after dispatching the RTC
interrupt. Because dispatch queues work that rearms the next alarm, the
handler can disable an event that the worker has already enabled. Move
the clear and disable operations before dispatch so that rearming always
wins the race.

During diagnosis, an explicit rtc_cmos.use_acpi_alarm=0 argument was also
found to be ineffective. The automatic platform selection runs after
parameter parsing and overwrites the explicit false value. Record whether
the parameter was supplied and skip automatic selection in that case.

On the affected system, ACPI mode completed 150 of 150 runs after the
ordering fix and delivered all 750 requested events. With
rtc_cmos.use_acpi_alarm=0, sysfs reported N, HPET emulation was active,
and 100 of 100 runs passed without using the ACPI RTC event.

The in-tree RTC selftest also passed all 8 tests under VNG with
rtc_cmos.use_acpi_alarm=0. VNG does not deliver ACPI RTC fixed events, so
the ACPI ordering fix was tested on hardware.

Gregory Price (2):
  rtc: cmos: Disable ACPI RTC event before handling it
  rtc: cmos: Honor explicit use_acpi_alarm parameter value

 drivers/rtc/rtc-cmos.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

-- 
2.56.0

