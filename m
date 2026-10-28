Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175466;
	b=Gf2Y/aGGjzuIMwiE1dk3E2tGS76mfUjRIbYBEA+u6719Meu7yi2ottNd3rgsPTBg5bOI
	 R/Vv39t7hJJCaymZtwkmNP6vAvK2zt1llKpaRaDtzFo8e4BNigiGH6xJbHWVIHrlQock+
	 rUUzypb0Rt+8ZmtzBVisZJqiExdsU0LnHG/PuTsHHN4T9rkULlRgHX1ZCvOGyQCgyf0JL
	 NgZyBQ9U1ei3RXZyYppZxT1mBMFscWN7Uohl02D++IkaXs46mKbgbg5XBYdtmpxztssRf
	 pXe9RP3etGQsr3khFabfWSBbiLsMQFHELk65oSrtT/JoD1hrTRRhh6rumsJ5TaAH27w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RRuxTSHqwbMEC1Vyc99sUTotqRotw0K4rkvyEEzXBAY=;
	b=N70wuZBkilyeD3hRdDhvaohQ1DfYUwVs5/6EnxWeRKclor1GTKPDPDWa1hMaewaUcQeY
	 HwFBOgTX/Q13w4E7KjDkMh93nmPgBNu2Gsie60BpjBLn8UGMeiF2gJMsU/t9Mq0Wd3Lrj
	 TCW84BYTYaZPUJ6j+qzOtkDvH1DYOANQ1jehSnfy89sMLi59P4OGva8v/gYN83wZ53Tk1
	 mlqD41RQlM3SdmYtNa499sfPFCoI6yzlXfptuXM65/Xfj8ICVSph9GY5HPIEF1Mglu2nV
	 IA57pikkkn4fr2ICI4rc7w+6eiIE4XGxWHrTVlhgida88bMRyt7BlWaWVe7leSh4D3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6e+HXR4;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78A606A31A
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2026 08:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A78A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6e+HXR4
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df54150dfso384213f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2026 01:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793175463; x=1793780263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RRuxTSHqwbMEC1Vyc99sUTotqRotw0K4rkvyEEzXBAY=;
        b=w6e+HXR4E1vIVIMChFIyAOb31XxYhOEt3Zrz2IiwM3LhOCQBmnrDukcry722WCgB93
         SSb6PJmaklJ66J7JbsmjxSLeYpqANik9BIVNyINZJvLzWops2H3lR+ICz4pF/BkxwNtJ
         p/8dr98ELXO5kZWfu58phA2aBZWnMe1X/8GoRxqG0KcGFniooOdFW4i3F1KEn8TFIh5i
         9qOTv43hoMT2Z5oPLNqsIWekEi9z5no4kqJ51UgsNM9fIDLkJTwZ3Cj/kgUUxxejapis
         H6nZKdcMhFBN91zskq/ilLB4+p6Q4WIFyKD/8gj8Wz+8cFzC5V1+J8hgYm/mCED8i7HO
         /WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793175463; x=1793780263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RRuxTSHqwbMEC1Vyc99sUTotqRotw0K4rkvyEEzXBAY=;
        b=nlP/++1wIGxCsONx5BIE2f9I8Jwx9jEYdInf0EXvM+P5fnZzTz4t/aIKzD4CIiiDUW
         Tiqz03J5+N8ocUpCOqW3e2GkIHewiSqQUIUsR0cdycRtSFkltKJ8PXzh2dP0h/+lR60N
         Zw48tArqwpEFABC4UQmDR3pfZtXz2tFS/koLsPaMNPlVnUO3txP8SCBUzA53ugpoLEeV
         4VkE2nDvYuM9J3xl06G9abIiGJgDty2mu0YVkOX5rkfBVZWhA1kw/a3dkwp4NHvKzSkH
         WnLpj6cFbAM6/qs100yoWvldZgZuISvfYWBXEuF0cQdy99Je5TMjm7RxXCERCotWFCcD
         RDcw==
X-Forwarded-Encrypted: i=1; AKwUvBz8R0ZPZGjhEeLva+c1lWaivByeL5IoOSDmMtL9p3h2HqCzxsqeUm2kA6d+WX08zqzuwVdnnLrJJEGm@vger.kernel.org
X-Gm-Message-State: AFq9FYLLGC7skF/fQo99y2GfbWRAaoTwIAGlFBzQTGtwj/jGUVi3cCho
	0xFLXVwaFoFNo5ffnNsmNGxQtCcaJc4POtVcu5xVvt5gFDZ7NmhllYqt
X-Gm-Gg: AYBFou0W52YbzmfnVvr9+ePK2dY/Sc2loTKlSHEZGfeTZewXiSKLPsNECZ6IYH5Eit4
	3t9NS5J1lyuxU82Ss+geJLtaSPQS8pQrjPNnrAVpINAOqiAfjOaZvvSfeJQeUIjF1HfHRao8FLM
	+NmWvvcrFpFjgWsA49OOgwMds+nKxK5ffocaBFszm45Op0jh8iT1TIiO29puffPlu9k8kc1btOy
	2weLzcz8BNxhcseaDjlOykxMqDIm4XouOl2g+k6jGRx1SA9E8Iqf5eN/+40K5mJcNXJuBGycZIx
	ZY5zHBpDcVy7wAslNq4YDJiMbWWEHaq3OpIPwtuqnkrtsue7Ip52da1ImXM8T2zLF0WtzcuEEzq
	IVGZ+766Rior//B9rSuxC0AUV0bYPIIZ7CqEpizGPIQDBUhQXVA69HIhW2GCZLPEcshPl+63MU9
	SsP3vjHCnNlMYbHRS6BvkHl36ovwCRZEXxfyPiSfKTH7wWL27HMEpcoXqxPOP8eKCMbbkD+EHh3
	7YyL/0YgFX+TyYXD4CWToB6J4t7s+mV+x7Mke0l3/qoy1tqmyiT/DWRoAAWflpVlZjJAOWkhemW
	TplZMju7SxMa6lBumm087bssBbiKhuorlq2KWuMdRTfsareUtH34695oZvtvLEiE3BjFX7XXhmz
	O4lXNM8wB44G0727atbqUytwDKSK+mo6gObZx/ScD+MfOjUqzHmuBXtuzoL0TfrveWGcM2yzI45
	AUB/oQJWIl8pY2JGAbnA==
X-Received: by 2002:a05:6000:24c8:b0:48b:ec8:b0d8 with SMTP id ffacd0b85a97d-48e5d5c3dd3mr4027197f8f.32.1793175463262;
        Wed, 28 Oct 2026 01:17:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-63a8-e900-0915-3df6-8525-b963.310.pool.telefonica.de. [2a02:3100:63a8:e900:915:3df6:8525:b963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb9cesm28393931f8f.27.2026.10.28.01.17.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 01:17:42 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
To: maz@kernel.org
Cc: Frank.Li@nxp.com,
	afaerber@suse.de,
	alim.akhtar@samsung.com,
	andersson@kernel.org,
	angelogioacchino.delregno@collabora.com,
	baolin.wang@linux.alibaba.com,
	bst-upstream@bstai.top,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	daniel.lezcano@kernel.org,
	devicetree@vger.kernel.org,
	dinguyen@kernel.org,
	eleanor.lin@realtek.com,
	festevam@gmail.com,
	gordon.ge@bst.ai,
	guohanjun@huawei.com,
	heiko@sntech.de,
	ivo.ivanov.ivanov1@gmail.com,
	jbrunet@baylibre.com,
	jernej.skrabec@gmail.com,
	jesper.nilsson@axis.com,
	jonathanh@nvidia.com,
	kernel@pengutronix.de,
	khilman@baylibre.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	lars.persson@axis.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	mark.rutland@arm.com,
	martin.blumenstingl@googlemail.com,
	matthias.bgg@gmail.com,
	michal.simek@amd.com,
	neil.armstrong@linaro.org,
	orsonzhai@gmail.com,
	rafael@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	samuel@sholland.org,
	shawn.lin@rock-chips.com,
	sudeep.holla@kernel.org,
	tglx@kernel.org,
	thierry.reding@kernel.org,
	wens@kernel.org,
	will@kernel.org,
	timpambor@gmail.com
Subject: Re: [PATCH v3 11/17] arm64: dts: mediatek: Add EL2 virtual timer interrupt
Date: Wed, 28 Oct 2026 09:17:16 +0100
Message-ID: <20261028081716.75598-1-timpambor@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260523140242.586031-12-maz@kernel.org>
References: <20260523140242.586031-12-maz@kernel.org>
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

On Sat, 23 May 2026 15:02:36 +0100, Marc Zyngier wrote:
> The ARMv8.1+ based CPUs used in a number of Mediatek SoCs are missing
> the EL2 virtual timer interrupt. Add it.

This patch doesn't seem to have been applied along with the rest of
the series. After updating to v7.2.11 on an MT8195 board I see:

  arch_timer: [Firmware Bug]: VHE-capable CPU without EL2 virtual timer interrupt

With this patch applied, the warning is gone and the EL2 virtual timer
is used as expected:

  arch_timer: cp15 timer running at 13.00MHz (hyp-virt).

Reviewed-by: Tim Pambor <timpambor@gmail.com>
Tested-by: Tim Pambor <timpambor@gmail.com>
