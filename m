Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284789;
	b=A48vqmhSfaop2z1XkgJfGKx+O5Gq10CGIVHt1drHTETl00Dx7hZ2kHc4i9wYg+8B4egY
	 YFodbMHXM2wH5OFSTMy0a2IsjPUnHwnuYRlT42KaOP3A9QOQGgCYRym7ffzbwvAM9Ynrm
	 AG5QDLmPWVC9mO0/SVTrOMeNX9of9qmTn/ZpQNyPxBBSfUd06o+qUzf7uJnBfv9wbbaA3
	 lGNZ6Ys5bokLzTG/Z6ty7mF9Cu6YjxcmTl88iyNQAnji8jyozZ1M/i3ggNylaAkU7VLaM
	 ybtn1hYOGzPma9Pvdw0qjJKth6s8FswsMbwmDbAW0tfDh8HuR8/xh89eznlQ5OgmOuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
	b=YU5mPTluDCqbi9f3GxGBh/kTeKC6rol/iS1ANEJFWsrf7L5poiTcC6snnVRFTvRCGzJl
	 Pyh7nSNfCDlj04n54qk5d1XjYs+rBuyahx6hYgNeM/MVui1B7JzMU6dbjjp2zLO8ZhEpp
	 UaJU6H2zfwn6yhweuyq1PtxTZ6GlJKDhmbgv+dca8gXysleZtCcOGUiT0t/j+g7aEPOp0
	 NqnFB6U22SMsRO8Xqj+XAWTmGIkjil5nDI6MygfMSjF3MRqMHYM5b051kiuVMXwNN9o79
	 r03ktG670WQtSQXeEYUq5HU3tA3Qd7rfXrqyRveL8ZNnu3RYjgjuk6XueEdN7qsn04w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fPTlg3YK;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F06606A329
	for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 14:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50F06606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fPTlg3YK
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14fc585291cso1992554c88.1
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284788; x=1793889588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
        b=fPTlg3YKi8LCEYl7MWaRXbl+fOsMT8EooFaEX/qteZRl8FsZt88RyX9Nz4rh62atDU
         N2mi9nkHHOJC4qFeiUXhTHbjbhHQHXOF+NhhfCQK6iUf4J/Q9ypFok7z2wgCKAPn6EjK
         xZ9kY5ZnP4n+8lX6/VsHr77Tn99+eesUK7yOJOQntEtEMQGRE1D1vlqqCLeQI7lI9/6d
         T6b6GWLz4O6TATQ+xATuCOZzKNxV75JOEocPZj36+KoGY18UuoHpbDZjja7BkGHZcM0B
         8XE+KTQjlqXnRe4OF7u9IeoFkO5y9EWni2EDctTAKHudHO9Rp8OhbT05Vxxf/IOtY+cj
         QvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284788; x=1793889588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
        b=CrWi43/rdk99JQluCC+OaWv90Wpfbz4KhBbbjoyZrM5er45Iqikn2UWEprgnGGBpCm
         duInHVdIfyQe41pMcgAqJ4MpThaW5l+wHhyPEMelQyb6w5FuySgv95dQG4UKw56S7AgR
         kgIYVwfaVWRHAPwBLF/9k9JzP3/XM5XngMOQoX47BjV9cHNOQ9OavGYEUV9e6sD69GJT
         Bhhu8Nrls6oJ6ktkvjn95II9BVnL9K++6myM2uEwBqQyecPIwBxjoNorKtkeQBl18fsG
         7yz7NHuDdrpcqtjc3Zo/FrduYOP51VfCgP/tvLsL17Pv72q+hCjZJc+DlMxmlgwY4VKW
         252A==
X-Forwarded-Encrypted: i=1; AKwUvBzvJBKRS1K/axhm2g//98IWGdIhWv9ib1ZGdasc+3vsT+G8O7UgQKpOWcf/X6MhEoMnJApavDIVDaZY@vger.kernel.org
X-Gm-Message-State: AFq9FYLuWwb3jWcRhdV/QbLiKd3OwO97BpkaIgB3l+KbziawVXWxdvgT
	LAycvkiLDeeUSAnNhsbgl3Lc//eGhvDwPpoyzr2rlyoxUMO4b9yPEJc=
X-Gm-Gg: AYBFou26V1w4phhOthJQsfqiLqcKykzfZyoh1MG1bmO9BaztD0HVFx7DJYD/8jqqoP7
	lxn18yLBNwzF+NsZhwXm1tUaUO+8Zg92VUmp9o/c9fha/q/zPSc9dNqLYatKYbm7nPBrgkURkpq
	zoKCyefEENA7umXoBRM1ZFAdFxfO70QIIxNpwKNIq+vC7amm2FMn2N7gO/npStuT6GqUcK0kp3i
	ECtk4mvdmLkf7rsLOFbU+Y5Gg9Mx0sprjEZkO1PeqMf8yVAmelYUDXSLVVAGakqD1mj7+7Ia25L
	rbyYgoKB98zIfI4CufkHSd0UUIA73zH1HySPYDICvkLFvFWDPxiX7hZC4Pab2sFm6sHFoR31YeF
	PMNkcI7sQ06BqNUbkL47+xwSwcg7G1MFEIC4fHkYI084oGuD3wbwEszSvATYAr6RsCr0YmuM+Y4
	DwY5OZVAOjE1SEjbhEdxqWVmkt3CsVF8quJhE7CHvefxImx8ceff9csCpEOLEPu75E3Xe5FZpra
	aNAC8z2W4GIShPWo31AL+BZ1ZfWRaAp+ei3LJbO+5uuulWKfvXFSX7Lzxn0taBd7Oc15r7Eto/B
	vsE2Hwm8roZWYdwnjXZV+vbc0rtHwxZuQ5MKzs1UEWWn1LT4q9HPe3nSUZjO37RPjdA=
X-Received: by 2002:a05:7022:ed07:b0:1a4:c892:b14f with SMTP id a92af1059eb24-1a6ced8e7afmr7393000c88.29.1793284788293;
        Thu, 29 Oct 2026 07:39:48 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.115.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75cdd21c3sm15396439c88.4.2026.10.29.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:39:47 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: k@chaosmail.tech
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jic23@kernel.org,
	jmorris@namei.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: Re: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Thu, 29 Oct 2026 10:39:26 -0400
Message-ID: <20261029143926.1246-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
References: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
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

> This should either be dropped from the series, or be hidden behind a
> `melt_my_mac`-style module flag, or switched to a whitelist approach.
> We do not know what keys will be introduced in new smc firmware
> versions, and there are already keys that should not be randomly poked
> at.

1. The patch is required, atleast on intel macs, as without writing GPU and CPU
	states to smc, the system gives PROCHOT signal under small load
	, and heats up a lot.

2. the smc dosent expose keys of nature that can physically damage the system
	it only exposes power/volt data, and the most you can poke is reboot
	keys and gpu/cpu p-states.

3. If a person is randomly touching keys, Its their problem and not ours.

4. There are a lot of things that can mess the system way more and permanently
	than smc (undervolting for example), but they are not safe guarded, why
	should this be then?
