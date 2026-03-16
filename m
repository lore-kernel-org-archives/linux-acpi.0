Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F3282F36
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671611; cv=none; b=Ko9HPHT3KDu5mkFI4z214bGPhI+welBto8LqFmKtuTagIBCO/C2tJctfIlUaXDNquPsM9rOwfuSsIuchSQjK8qdd7gFqFe0rD8Zdr77EpSz9GiVY7IfLelKQFlwWsA05u3KiJmL5Cn+WVOyuOTEtcxPpdYj0fOSAjtKKpiVgy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671611; c=relaxed/simple;
	bh=ovFl0FRA/Y50902pWqD3zOFTf5Y8L0LkM20eP95/xVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmhZFfnNxdW8lXat2Z3N4abxhOw8YV9Naex8SQbrGqLI0U/s6aq6Qe72K3hm5zIveQcCsgAk1o25QaHz4v4V+r2dYvwIT4tx0LWOuxP+rf0s3kF7LTe04ixgSGr+28p1IZY0Q1XELt81boAdUUn1vPz4JTvmP/zt+lUpCttpE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtkVn6h6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtkVn6h6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b467dcf0bso519341f8f.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773671609; x=1774276409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovFl0FRA/Y50902pWqD3zOFTf5Y8L0LkM20eP95/xVw=;
        b=KtkVn6h6JqJikItyIXK6w6Evu8ALKW2c3vDiRRMAF3DKvXKfSfx9tJP2VlZNI+om3U
         tCxG8uf0VLhsV2ungGj3G8VrPibRs8d90seIi9UJo3CiSyphmubwmGDxcKZ8p+0/Qsf0
         wYPdnhC/1doIFu4ZOr5c1VYYJjH6FNMPUz5KVhiIiKl/fXhmuiZzyU+sgYqX3h46TI3n
         d9AaKFXjVdwhd3H4UtNOyRjBLgJCiGr9YVb9xkVxBNZTSTCBbK6Yf8caiXxiv2tBfgwV
         szBYQf2ZW8FAoi4Flz8PzZD8J7jlyPeEbd9+YvB3UHqkty3LxBR4A1CEhOZUsY/q4JSJ
         lc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773671609; x=1774276409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ovFl0FRA/Y50902pWqD3zOFTf5Y8L0LkM20eP95/xVw=;
        b=V6UAIOIYxRpKwGWxxA6RwBlYdWHO+TNuDS2WyYemWxTkk056LA5Z27xM3P8Bw9N+MS
         TBti4UK4cqlykJoNb/NCJ6XvmIk7vsVh+jlSZsiBHK1ePCeEPWUITuZ55YsSm0GKhTpc
         oKaHvFczGtsCqgMRsBdK5567jcHMK0OcKiIzHl3UK5C4R1o6dkf51n7USJLHk5XX+h1T
         xNodJN15CO3nFyVn2O7Vk1w6MnXdMC9XczULrMb5ISADCBQ9iifEotMhvQBTeRwtCVpt
         SpfBL4JzYmEQu5zsSnq1GBJWfS4TuyBMSUPsVgHpMoj7tUPbj+2l3Ats/XEmFeIF7PSv
         CCYg==
X-Forwarded-Encrypted: i=1; AJvYcCUCztwSqVhK+4NwOyQq9EMOm09DTkUxW6wtnpdur0+/tiTRejC8Jum+qvq/oQU4oybw0bhwV3ZGr9Xf@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMmL5bTUs9XYnj6rEK+GjTUfqzEpWtd65Z7jMApYvBFcUPFGY
	nWlvTsTeFjGAjfKKMj6vh82yh7Th2kNQ1qjLDLrBRQTUCKdGGjJy7aWC
X-Gm-Gg: ATEYQzyRb637HTn84RJRmtjAP2q44l6NM296lfoFm6V4ESnNOzUDlpMn3SIz+gh+ttQ
	bsWDp1VdyEHMruLcnSYffyPxfw7XXCtRK9oSBd2iJAu+thFP2sTcq0jxZQfZ16/xsEcL89KpwYm
	rgUrzV2sX2hdbChI9ZPtcs9Exhv0HmtOfzj+FpEftFyqpCTHnNoxhXVPbiu990zSxsSTF5ofcmo
	iVGoid+EkG6XHi4J9BLdHUk8NGHungN+w4uJ3ZE0BavKdIA+BJIdquy9YOryCoSODv8KsxD2hyY
	jOFYFyCWkq0g8ZDCppQvz57Jdfc4rdduUWyfe8+A/blJ1pBJVE+BR0p2HW/6vwbVCwkYM3YMENi
	fHyBv8FV2HnpSZ51qfAY7BT+twY0ziPCODLFj+Ob4tkP/Bj2Bk4lvUu68dGArjouC07jAkVYj/Z
	HQpc+U+3HtiyAXvBPhL+K5aaTrgi5Dg/TSvc+EpeSCGlV8WSocNBPJWppo5yl2FfDkYfKwmSDTQ
	JqVhbzsKeOhGqI46F0w9M80dH6icFNVA9uZNXqGEalOr3dJ7pi/88VQZbwDe8TMvjSNBDwrtQ72
	k9qapFK4Cvk=
X-Received: by 2002:adf:e984:0:b0:43b:3c32:d901 with SMTP id ffacd0b85a97d-43b3c32dbd9mr10069381f8f.11.1773671608811;
        Mon, 16 Mar 2026 07:33:28 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b468cf785sm4877457f8f.12.2026.03.16.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:33:28 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: acpi: skip generic I2C device when vendor-specific sibling exists
Date: Mon, 16 Mar 2026 14:32:42 +0000
Message-ID: <20260316143242.24248-1-edward.blair@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316131219.GD2275908@black.igk.intel.com>
References: <20260316131219.GD2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Mar 2026 at 13:12, Mika Westerberg wrote:
> Are they both 'present'? I mean their _STA() returns 0xF for both?

MSFT8000:00 has no _STA method at all. The sysfs status attribute is
absent, which only happens when acpi_has_method(handle, "_STA")
returns false (device_sysfs.c line 591). So it defaults to present per
the ACPI spec. ITE8853:00 has _STA returning 0xF.

As Heikki pointed out, MSFT8000 is the RhProxy device, not UCSI. My
mistake in the commit message.

> We have a quirk table already in drivers/acpi/x86/utils.c that I
> think could be used to mark the other one being not present.

That would work. acpi_device_override_status() runs before _STA
evaluation so it can force status=0 even without a _STA method.

My concern is scope. MSFT8000 is a Windows-only Resource Hub Proxy
(RhProxy) device with no Linux driver, no module binding, and no
in-kernel consumer. It's a static ACPI node with no _STA, so the
BIOS exports it unconditionally. Skipping it during I2C client
enumeration would have zero functional impact on Linux while avoiding
a quirk table entry that needs duplicating per board.

Thanks,
Edward
