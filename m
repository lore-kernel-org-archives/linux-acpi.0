Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619F33A6F2
	for <linux-acpi@vger.kernel.org>; Wed,  7 Oct 2026 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336960; cv=none; b=J27tL+FL37gHzyXeOUASA99NAB6yuDyoQ1dDwKZaFduOp61v5iVU6wEOlnPk1ZvLn4bvKaVQV2g0mAW8tOTzrEbMURLoTHsWjwSL/fhwfqNzDbEFbaS2VQDCe/4f5VtyFWQj2IjpW44zffwfEmJM5OmfejKhcWXFlum0dUBdVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336960; c=relaxed/simple;
	bh=Q4YqXzmI+9oOgBh2DPw5n0DcgX3aRz5kn5SKwSjH6p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=Q0W1M52xMgTF1UGah0ospKkC4Le4BUFxSBgTH+XUOqjD9DiKe7bJbHpa6casYqc2XZ5eunWDT2RZ40Ez8+U823AjyxzOKGsFjl8uNCBA4K0s+/ncwxsTe4MmMonGQLR1YmzD3JssE8a2NtswHXNaimLEHg3yTHOR31NOTabMXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgEjoFgA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgEjoFgA"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e635220b4so106649185a.1
        for <linux-acpi@vger.kernel.org>; Tue, 06 Oct 2026 18:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336958; x=1791941758; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4YqXzmI+9oOgBh2DPw5n0DcgX3aRz5kn5SKwSjH6p0=;
        b=cgEjoFgA5kDVdN8GkgKVWnvwk5Yrok9MBVJphnYa1UGqemfFBzJVVrFeTlEjosXg3E
         PdtZGH37k8p3giDuhKO6O2KyzEGxGCYGqA7QzYDNd3LfUIp2CbbpV2EpDTBpRevG6/Jb
         1+90yBuhOn90xI9iRRWxA6hWSxjlFYyDa/hUiji2gt6M548aF3IZP6fXyO08OOgy0/sD
         xcevFsCEzO+5jhPGYZUKHqrB4VfxpHII23iJIMshvZSjUYennRr0dorH919QXHcRZ3VN
         pRGwDe/G3eGXnKcvP2e+Z9OwT173aJK7Lvj9DYNA/yw1TPm/i2nz2mdaWJHP3BRM0+IW
         hA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336958; x=1791941758;
        h=content-type:content-transfer-encoding:mime-version:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q4YqXzmI+9oOgBh2DPw5n0DcgX3aRz5kn5SKwSjH6p0=;
        b=gahS2sHoNqDLN0xtqnfZ6aXHSgHkg48bgiTn8WbagR1v9DR0hoPAdV64s/KLt2trZc
         fFVwHuaMN3VElA1gUbAyBQ9RDeO+tslFQa2spFXms1UvR7WMxrnxPYZFrln5S3FgcfkB
         S648gOMKrIH6nb6A70LtySq0/U5LZbSQdm5Tel2S+pNLNSyUWaTAnQ+XcHIKhFCIcaIx
         HX/3xgXVGol/4cJhclNsJ6MBRm2MToienoHRB4maIKzjK5r9oedh0bfY1jXxyEji7fvm
         C+KRbWCs8VUvwyxqZberz4bblvVjeBvFRIIURSJs7k5GtqEQD75ZAbvlEji5uZfdBEDL
         JTeg==
X-Forwarded-Encrypted: i=1; AKwUvBwzi1NZnPujHfqgAWbaq7TItou9McC9e7LaIp5s0k/UExNPTwI/PgtaEIRHEQPqFiaNz+SlvSefiruG@vger.kernel.org
X-Gm-Message-State: AFuF++nL//buDGM0RXdybJLj5tDZt3VMBJkKrLoWo4S28D+vpTuAUkqF
	QuM2KkGECdf3hoDPlIEgkDdr8VWIj6phOKncWrIIeAINrhQPnL88s7Ae
X-Gm-Gg: AYBFou2hHeDB9+9cUMuk7wARk7Vj4ZKTEig+UkOFtJs6C/Z8l4mZEt3+CIu5GR0Cl6y
	Rgnsuac8ENzCtxsk8leViecy4u1GNFBF+0O/yQ/SacwDt+RTyX1FQia/y5uFamTf1nbFp6V31qP
	hSTiatMwI9zR+0D+8iErcQQY/2eJGHKBSI9Y3JgcwUxgfr+xsL8QmnMPNNwlTltj2P2s/7svcBW
	Jv7DrmH5EPdnXaZRYPiWfbBYpr0tCMnk9lszYjUu2DZl7CpeHUr1AI2gJQF5mp8hqdAuDhPKsaX
	GQXp7/gtlZ4mdkGNaI90GaQcWxq+bfriDVyqL41yzYCPLut+io0w9o40CM5Adg1Xk3AZYnMm01m
	BUTai1pV8oSvusnMLhktXfR50JvMnZgFeB3UKhsRoeJIkuU815lCeP4XJfqash8V/Ct2Utf9Eyo
	krmmXQXQbPbwN7UiZMgmlp3Z/ibBMqG2VIS/OZrHqc+zoVJDRik97XEzbIWEJiShCaAK10N8eF9
	wQqLfTfWvtXHpzO4XOb4rjALQ==
X-Received: by 2002:a05:620a:a18a:10b0:93e:9807:9790 with SMTP id af79cd13be357-93e9b8581c6mr104499085a.81.1791336957720;
        Tue, 06 Oct 2026 18:35:57 -0700 (PDT)
Received: from daniel-desktop3.localnet ([204.48.77.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e98f6f8desm101574785a.3.2026.10.06.18.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:35:57 -0700 (PDT)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: rafael@kernel.org, linux-rtc@vger.kernel.org
Cc: alexandre.belloni@bootlin.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bart@gpxbv.nl
Subject: Re: [PATCH v1 2/7] ACPI: TAD: Support RTC without wakeup
Date: Tue, 06 Oct 2026 21:35:55 -0400
Message-ID: <5383347.31r3eYUQgx@daniel-desktop3>
In-Reply-To: <1959268.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Someone's previous patch hid some sysfs attrs when without ACPI_TAD_AC_WAKE
support. Should you add something similar?

Link: https://github.com/linux-surface/linux-surface/blob/bf1921fc63f33d03a007fb38c4f88ff7e7bc1a55/patches/6.19/0015-rtc.patch


