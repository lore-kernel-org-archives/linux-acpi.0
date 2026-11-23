Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416481;
	b=miIt38w6NFL01xBZbZGu8zg7icdOwrRqoZH0ctKO1JSwO+6NQqfuWHddjnp417WDA1H7
	 EuriE66Gv1ttE1P4NadDBLHdp0nfBorzDebRcxaZ0439f8xlidZ+RyLLygHB4vZM4Sbs4
	 eoLwCClsfwKcstpwSHq2jNntdAgMB8oLzVVfk4C4I+e99xZbY5XqGuZhGl7U9Y7kihZy7
	 ++04sOil6Ig9+OAUCNwZ5im7jv0BgSb9ulzW+XCDHY6LMNaQqIjiX8rLUuq5mFcRrtV9J
	 8jev3O5lGyiufclNpO6aHeJPPOJnqo66SM5XPKgADAF1Q1LhZ6Q/mqbHhbu9XVk9Whg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
	b=rv3GgN6HjYM/hw2wepX2kxO0g29BjQearSAgJae/6TYDFmeD0uSCvnctDpnWTYybFjbW
	 mBOu8ub2Pkj69KM+6BZR3NLV/c1e8OBQ+RCTklk/hPX/rjBLcTi9+lEqP38T0N9rhj5ZW
	 un20Pa6Tka65egFgHwoq+wLX3PKnXy2tPdbQh/PgoleUkshq6W/6mQTdETxiyqEHGeDXI
	 tbroipA9S/3qH/MdSFPAZMZ7RV9fa/32kgr7DrWYI5G18XUlzx0Kfp82PauQhLSfQzGBQ
	 Vmfa9gQaZmYn1I6bT2PJSWwofEyRJJVEwGU9QHda81L8M6NFPqMCM741WIfGtVtsoDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtcT5jHJ;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A6646606A330
	for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2026 06:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6646606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtcT5jHJ
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f037bc348dso24316415ad.0
        for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2026 22:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416480; x=1796021280; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
        b=QtcT5jHJqWm1+yYAA4VFMUP9cS+spmeKwR5RDKEV3n+c3ftxMf2A+S0r6XtwhfzSkA
         i89BXqck7v1ltIBc4g+zcm6rPOPLJn/WoTGr6fWujJ5HHX37VCCqn+5hkt4UpvPDAyK/
         DzuOh0Appm/d4BWAtNs5xZba9MLv+lEZJLKeuv9+JAAyKr9eFkW+rOMsNjggp1sksr5X
         B2JKTwP7urRGyQVRlhafyhdA2ffZMnmFgkniU7mpAO/qkc49LYqaFAX5hYEglksH7mef
         k7TEeU43ML1MTVqG7C5tNuJ/CESrvVz2mPnzpvEBeefrauZymIXXWJIHNRH3mUgbvMWa
         6S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416480; x=1796021280;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
        b=nIra/C95JD9bQlsOa8GDsUXrv3QzotUF66/Lgxbn9ICqw5P/gyd2ArADqFBT5jCTrZ
         CBrp3uJSMiEsFivZkR8rZ3/ki/h+vaRPDUkqYb0X3+xHRwQbmZ6LNuV0dATmQp8td5fA
         80HDiusZj3bgSYdGARKwYNSMuXDWkTP4O7rwTcwaOnIr+FFnHIhSSYubQw905KDSHg0B
         RX2aJi5b+kQjrpwidMJRoc7oAWJqkat2MrWDXmnbZz2WjqWZ2Q0mypRDVsKOwmnW6ojR
         MYIe4LqGfphDsihpwNWgFCadqlSPT4Pjv1vb4O7ZRm1Kvl27Oq67xZx9svUrdFJmueDA
         kthA==
X-Forwarded-Encrypted: i=1; AL+hErGHzznfYITBhnSx70JjSTj/MUZkf8ggtpWV66hixyWdYj5sklo2jNyAzVhs1bR1umekB+Etn8uBiRRj@vger.kernel.org
X-Gm-Message-State: APuU4Z8L8HruLlbUik99mWb3uPLuNteg0jo+quv6lyEp0X1PbOUvHzDD
	1aJcNdsaAsbPMUQn4R2fbeeywQQ1NYfdNUOrd4DsFkyvru/RlStUf3wM
X-Gm-Gg: AZFdTZeRm6zFW98rCE4RCuqkLDcM27QHdG/UaRGrHmN2EGwHvSLJ/K4KKvKtUYttsI7
	S5ZkMbMg12fs/ZKBwd8/37GUgeiJcM6oMK1B8DfQ8rjI8C80xyH/H+2YST+2OzBpZAmMrUplv7J
	+9dlZ38khwZQhWX7XlLR3iw3h8S6TjVWvWmYPRm0jnPlDV1PUH/hFY/hgVM8f5RTVfuB/HK4gx0
	WEXWdBoDIMtR4L05unaqj5+GpSp85qtVeKwZJviG8idT20XkaB7LJRd3DI0uTrHL4SZMFBfeOoZ
	QHxS6Mh8jR9B7XJSVqY3z2NNI0iZ5h9lAzMOuX2FO2Ud4o9XNeGiLV5PNVZgERo6/VVyz9q9lLG
	+9CvhDqoi7zekx755IXVnupKUnnsJQIWcyelxlms4TAQ/1WIkz919syo8nbTNrRj4u2j//kdZpH
	w9ZjpiULczj1tMoL8xL0In8z/R0cUQwZNVRauCSYz0atZHx6o4t/rqWAfOVpn3BnYDiYfXGaR2F
	xWZV2RUW28o8LoTEXTAzmVqR/694ilBnMKX64SRARLOSquhwmGCDIKDCdHozCmBMwqF5FIJglNI
	TNEllaXhVOt4T5xQuRNxk3g8MOof/CrxP5TGxvdSuuTuhhyO8wGtR0UrwVUynsF/FZWWlA==
X-Received: by 2002:a17:902:ce82:b0:2ef:e9df:2422 with SMTP id d9443c01a7336-2f03f1cf4e6mr103786255ad.16.1795416479999;
        Sun, 22 Nov 2026 22:47:59 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84364sm48678155ad.5.2026.11.22.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:47:59 -0800 (PST)
Date: Sun, 22 Nov 2026 22:47:58 -0800
Message-ID: <8ee0713aa3e3cb1e54c0a60f1b32cb86@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/8] power: supply: sbs-battery: use 4-argument i2c_smbus_read_block_data()
In-Reply-To: <avELD9tlEfl9Uth7@venus>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com> <20261024-i2c-smbus-read-block-data-v1-8-19bb97467982@gmail.com> <avELD9tlEfl9Uth7@venus>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sebastian,

On Mon, Nov 09, 2026 at 12:52:18AM +0100, Sebastian Reichel wrote:
> On Sat, Oct 24, 2026 at 07:48:48PM -0700, Dmitry Torokhov wrote:
> > Pass the destination buffer size to sbs_read_string_data(), and pass
> > the buffer capacity reserving space for a trailing NUL terminator to
> > i2c_smbus_read_block_data().
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thank you for the ack. Will you be applying this patch to your tree, or
do you expect me to queue it through mine?

Thanks.

-- 
Dmitry
