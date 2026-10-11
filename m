Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681F2DC76A
	for <linux-acpi@vger.kernel.org>; Sun, 11 Oct 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734620; cv=pass; b=M5vInuehmWFGxmDibvHnSMb65BCIBAKJ2tqyMErLH+Wr8eQR5lol4b/8CHa3fbpjChTmVJqwj3Dn0jkPt0ubYA51Ou2viyEroWTztFOJdlGSz4ZweWLWYS3Gp0ivLngqN1izFKtgw5EkgQOKDp3SEulmrrggG1K8FFjznwWlVx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734620; c=relaxed/simple;
	bh=b1iXLNnxmMfxdkLth2B+WAyB1Zb8M6f97ML8FgaIeyM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dYUKMjDUIaxcBYjQos1dCyGjVFrAGCFECiPYSeaEMVzr5pqlnPSP8SKw+GfY8SRDJZMrHOTDOl/VNAxs0asGlsztjm4mJZeyX/NiALPhuqX8VXqOecBsZcVHLi4l5cjm56IdwjZSD+12djEh7XHaPDhlA13AdAIKvW04RI6xQKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLhBI0wj; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLhBI0wj"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a76d1843eeso1938161fa.3
        for <linux-acpi@vger.kernel.org>; Sun, 11 Oct 2026 09:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791734618; cv=none;
        d=google.com; s=arc-20260327;
        b=VDIJmo8lP1i0mBvIgHBIl1VcqjcSWViwdJMhjsP1oE4PBvmTlC3CZvU3woHorEYXnM
         RPUQtNM36jvb6bkdn7NiFkGu5roTWFY4N87je49ijW5eL4PgSInhgMLvBldPa7YgDcMV
         abvvLwRvPFs5kpLhS6hl2tuwSnYP9kPZqkarCxmaWeY9MfX5HA8qeEOHkRIlSNFHc58L
         jkavvivLrBZjVD2lIMI2dDv0NWgg0CRYM8bs1ghfDXPXxZDD+6KDSTrSzC18aBPqXHyg
         7zPd3xcBMBtVzHmiWTVdfmFm/pd3r921+c0/wB3Zlr/sRr06JE1DghklmoECz29r4p7p
         fMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/PMSeNAK3G1G5kn1Fzn6SJkaNYLMwbOteLsGmnNeuhM=;
        fh=JUxIXxUKuaNokefyYiG3zc8GyYF0N/i9Gq5mI054qqA=;
        b=lzo37WEy/qbWrfpz/pzYkwfsCIIIWzN4gBkowdDM8GBx4aFqiWOl0ZCv29SjuUObd+
         VFaPowP5myKq/yrN9CrbCNbjFZX1AKB0La/igEr5pSEmDoh5pdJFpMVCe7ExpZKzE1RQ
         4Oizdymt7WOS0i1Q5+yVWU10qZ0AZAzQM3TjBMs2IvjJJuIZ/4YXZwOjAShk4xT9LXWi
         UOJjQp1GIIDvAKIJaRaGAeuXbrUhb0NbB/dgOfZGnzIq2rbkAcA69gIWO8KoSPPIlxWb
         1XMNJfQWacSe4LN47xyiB8jcYpoqB/kC1tzRUhkaDJFbLwt3LxU1dDwVOcgNi6tRIRqH
         0SgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791734618; x=1792339418; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/PMSeNAK3G1G5kn1Fzn6SJkaNYLMwbOteLsGmnNeuhM=;
        b=lLhBI0wjeYMtpqAHjc+I9x/37hOJrqnrbGa/wJDXM4pRPFHoxhIKG7+53P4r15Agjw
         vechKl23smX01l7Z2HtXxABzo5+rdMcw5OwN23F7rtntFAok/TIWaPFeFQ6u8Sa0m1HU
         KlRpeFDhCerG9Xkc9uKF1zeUkpp/NgW2pLv2A0zHvBlaDo6zOphDP+0X3S1BlT4+9tcU
         Sa53v4lUoSd405tBWYMxteFUkvc19YEJv/LxZllATEf2s9r6CFi574Rek2POhRE9e/yt
         equRJ49dJEBtMAiU5f5xwawmrHAhfirbEDfb3IaSzDoCklJGDmYYGhUXnkfc31nbOen/
         SwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791734618; x=1792339418;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/PMSeNAK3G1G5kn1Fzn6SJkaNYLMwbOteLsGmnNeuhM=;
        b=nqZocRcUvs+gtkE4X1PcGgDGQ6prHhxbJB7UQqFS4UoSlE7Nj2H4qz+Ek4cOvi7WQs
         /vhR/rJD463/SKLOkJlEOVRa8sZgIV83O38611sjyAltcfpFFxaR+21uThAmXOGzfx+v
         kWqVFO3hDCszl56c2cCguOXt9+a0m8pCVN9Vz0U/Ltt7KtIKRpf0umcYel9pgNm/RB8d
         2T6f9r7omiwxCc+SkigkfgifHiXIaLcBlVbSWWOkhAMY1gobSRPzhD44HE/kX5zvKGff
         EsCk84ytfclCLxc1rtQDhzFrs4g7qfMKX24aNZaOX6MBlq+JuKO3hbRo0zGOfTuAW79h
         0oPQ==
X-Gm-Message-State: AFq9FYJtNBtLFIu8/OdZ2FKqKwl0a0fM0dgX2msy319A8yNHatqpZ95F
	7dhjAXFTxcvwnFUs/Ym5g4vsXv7USIR9kQmPQW7SY0R3+2YI71eZxgJnUEIAQXWzIUoeOBVs9Y2
	ERTItJEOhx+QpDgTQU9IX0Vfw1QVEBDWKn1/pIi0EEKNX
X-Gm-Gg: AYBFou3GCNjZoRbY7hhXWPwvYqMKw9A1RNHyscz+80tyhza6nvSendpyqWqxIrj6FQY
	S6yvg++E3tskV9R86EQQo7zS1HAxQWYn52TE0unXmUk58uK2SAe8kAehefdJbEHgX511GLZumhG
	u0xu1HBe06VXXvwTIXEEiB/yT0Z6KkwfwMLAYUP6uy6H1Eep365dpnEUMJunwk79CVgoGtHEfth
	85SCcDJqAsNeINpHVBOhToSywHK/JnxAbNbgPmeFul47B4DnQyBqWIfRnHc5K3TR+KOpsOx7mpJ
	EPDjIpVUK/ijZ5vucHMonz+7VWIyTLwUQ9JdJMoypPlz6kt8QuqKNB4fW7ONRmXpomxgUubXyoJ
	h1C5gC7plvTzi1chPW3SLjPk=
X-Received: by 2002:a05:651c:1448:b0:3a5:cee6:9413 with SMTP id
 38308e7fff4ca-3a9c513afa5mr13579721fa.1.1791734617412; Sun, 11 Oct 2026
 09:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lorenzo Collevecchio <lorenzocollevecchio17@gmail.com>
Date: Sun, 11 Oct 2026 18:03:25 +0200
X-Gm-Features: AclHuK995l-38syMAtORusdE9_IR8iSJRcB-5VI4C0rfZ3oDBfMdVrg5rlpAnDs
Message-ID: <CAPvUaSo1D+1Tvk3-4TMiXw-ScBtY8Mu0FzO7R_EG6zrjYfjYqg@mail.gmail.com>
Subject: hp-wmi: WHCM AE_AML_OPERAND_TYPE and fan init -22 on HP OmniBook 5
 16-ag1xxx (board 8DF4)
To: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am seeing hp-wmi fan interface failures on an HP OmniBook 5
16-ag1xxx. This is not a gaming model.

Hardware:
  product_name: HP OmniBook 5 Laptop 16-ag1xxx (16-AG1002SL)
  board_name:   8DF4
  BIOS:         F.12, 04/10/2026 (no newer firmware listed on LVFS for
this machine)
  Kernel:       7.2.9-2-cachyos (also tested 6.18.55-2-cachyos-lts;
ACPICA 20250807 vs 20260408)

Symptoms:
1. At boot, \_SB.WMID.WHCM (called via WMAA) fails three times with
   "AE_AML_OPERAND_TYPE: Needed [Buffer/String/Package], found
[Integer]" while resolving operands for [Index].
2. Immediately afterwards: "hp-wmi hp-wmi: Failed to apply initial fan
settings: -22".
3. Later: "Attempt to CreateField of length zero" in \_SB.WMID.WQBC
and WQBE (AE_AML_OPERAND_VALUE).
4. hp_wmi still registers as a platform profile handler (quiet
balanced performance).
5. /sys/devices/platform/hp-wmi/hwmon/*/ contains only pwm1_enable
(rw); there is no pwm1 and no fan1_input.
6. On the LTS kernel the same WHCM error repeats about every 2.2 s
while something polls the hp hwmon device (277 times between 551 s and
1165 s uptime).
7. ACPI thermal: "Invalid critical threshold (-274000)" and "No valid
trip points!" for thermal zone TSZ0.

Fan behaviour:
- acpi_fan (acpi-fan PNP0C0B, "Using Microsoft fan extensions")
exposes fan1_input. It sometimes shows about 2400 RPM and sometimes 0
RPM.
- The fan works normally under Windows on the same machine.
- I once saw the CPU around 95 C with the fan apparently stopped on
Linux; I have not been able to reproduce it yet and am collecting a
temperature/RPM log.

I suspect the WMI query path the driver uses for fan settings is not
implemented by this firmware, so hp-wmi should probably not attempt it
on board 8DF4. I would be glad to test patches or provide acpidump
output, WMI GUID listings or any other data.

Thanks,
Lorenzo
