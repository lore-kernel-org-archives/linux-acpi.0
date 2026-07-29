Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD148125E
	for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329089; cv=pass; b=Mjz7TlIvWBvjYDOxlizNj475siIKrTjzgR5SeTBAIwrd+2HLzzQHDeS8YmmJJfn8zsBgfv37m0qpOChGS3ZW/5LQYFM5UlxK7+VV7LTlvgaYReExeZxbFITBlW01BZpfR1xDaRJ/uONUsBXQQG9GH8cmVjEuD3ErXI5+69Of96s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329089; c=relaxed/simple;
	bh=FZDjz/F55Ie1M0v56bfpoehgRTLCH7hYAH2EKNVwZnY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e30M1yj/msvA6R2m9asfEs7C9SulpYRdj+NM8NQztTle6z5/jZbvmolj6IW8bvSHJNLFs0W60kWBeZr/EfwBbR12d5okp0EV+7zGSbKTUtEBGMyV6X4Pnr6arqzZf1QNgJvERgaa15ZW728TncyDX43VOmGvIOmDmcfAqrgDTLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHmKnWhX; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHmKnWhX"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84874b52eabso1197505b3a.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 05:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785329079; cv=none;
        d=google.com; s=arc-20260327;
        b=XfCqX8BwYGYJEoTXQCeSVI1tf+0Fl8JLpE5Y4aOItYZfVQDce0xfnfCMBk9o40Y3Ie
         OlLYr5u/iE9swF1RS2MrilYs3kgCKKLDaKuI2LJrWWUyYB4xsIO/NsYz9xYLHKFVT5b4
         WwySvTVI6d+mCLBIi5tL/5K4lf6IcFp7UaisgnQ8vCZVEQbEjN5pbIosTjKThpajwREr
         yHlAQEViZGJbZXsDqCCHCYLBZHb3el1o+cuPlYbrfD/yi0a8F8M3uOZ1PF1qz23OrD1b
         HrxsYYCaHzSI08SZ1L+HcmZV0OOo8aSi2nmsOYTa6q7ooxYyx/wfejFH8KTp0mUOi8lH
         DOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=FZDjz/F55Ie1M0v56bfpoehgRTLCH7hYAH2EKNVwZnY=;
        fh=fNCk7gCpj73DQXRkrMjciSI5FQ12zZk+glanoKTZCDk=;
        b=nqtGIoPctYV8lZU7AnHoMIO47muHDVyfGcwauJmDOKKDfNr+irLlQx7xwdBYwD85Vi
         rNZJf5keExeD9fMdrgIgwJinBb6BowAYaZ+Z3AL193b7G0D+h3OcLxIbbn516XYuHMdy
         Y1nLyuMxwVeFFrfTubt4fXT5/AQjPzcNsJLaemgW4oTg+gVFoqef6dVdusfVw7bJ7yBk
         7CHpNY3W8xthClES8eAb/412OfCkHCA0P57vLymXvFKp5qocZPaEPTIO+LsD3psb5hyH
         jf2CvRY7GJh9cBEnHxpHq8tGWQE00cPdNIdxMwRI4PsELw3WPJ32ybWuZ4Z1otWRGghS
         R0yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785329079; x=1785933879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FZDjz/F55Ie1M0v56bfpoehgRTLCH7hYAH2EKNVwZnY=;
        b=QHmKnWhXNEhPoaM9N6RX699JMx1ztHLbmma3zlB0OwLWJVf3Q1Oj1FT6eMl7U4aBH/
         uTU8rWN2WB32x3J4IMbmjNUBs3WlIMzgU0ZAPAWpI5van/LikKsEMUj6hg83udsrK9VN
         qo/zCRzOfdxzADXKSEkGo0QXGeS562JrUq0SSnmpdfyfAiPkHBisbp/HXgw80T+MNL+x
         VrhKbVEymuP8F0w/1uJymYFi+nv8BUYGvLPSA8vd0yRvzm/qMxM+o0Q8tk/nqYdZZO08
         lDNr1vAuYeXuxD/P/CRn36vJpQCDGtT5zw+dRqF8HVPGsQhagYjULEZeiKEhqW4ZBgpC
         vE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329079; x=1785933879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FZDjz/F55Ie1M0v56bfpoehgRTLCH7hYAH2EKNVwZnY=;
        b=MdtBX9cYgQrDZ6XVU6B28Nd7HuwxLOp4Mwz8xfoS02ltgeSCcg14OJrcLPPkUDsJc2
         8Yv1amNksZLx1GgFDgMHSdSBCIuFCreKt28qlHl2etdyw6GfzxerDYGOJBrfC3e0JwNd
         GuPKCr2b+6+WaxLCrTKZAn/LSS4a0C0vEfcpAnHZrAAm44msU+Cb6oxQV4fGMcv3WK+f
         vhf4Mfa+f4teIXVpyzW1nuR0xxGEEWjC2J5L0x7LiWyLkZ5/WTudDsf/p0pWJvDYMUuA
         9fjnv2H/4Oy4ZaPb4R0O4hkxQxB300YdYpz32jBPOWROgus4oaJKdYtB5ZiB/kPgO8qy
         lrpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqv1TZniBq7pOzeJGTrFroLmoYjcPVA2t8U++8OMix39LlID6iSp4LPxuRDnmh5/fLjvFhSI9BLxr1N@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+xNcXGt5QJSM+YkXT4jZWHrn2PTLUhN3aONtLOVA/CZ6opQL
	IzEhAKMfIirjcP2s7sMQYLY9O8e1vKljgmKVaHrJmQwyVMxnZxjXkVN51Bxqaa58PKwpjQp2fb+
	axJ5A6mc8ikH1k8xoGWuPcP6wcjwBDp4=
X-Gm-Gg: AR+sD11uPKjVPwm6vhzFae/jjpWVE20hOVB/kZO8wYyuWvZjefQPoj7KzjtiZMCFu2B
	yJor8agSfYJR5wFGNwQnkoic+fyFesKYdv2IxUxvzZr4UMCJd6j/3rae7vWmzV204/HWWpYGFLh
	FTVGnOvbyC/JbHYA2Adi0338dvNk+Vid6aVlLDrgDctGUMLW2QRkNSLDWbn01C5b0FrgViTta6K
	7xE/NWO1MIxe02GlyX85tWOt6DPp1WPV9Za9rowEU8RM0rsVjV4jfn0rgQaxRXhxVmJLdj1Y7vB
	hBGkauLPAwz6ZHWpuar7ANCNY6zlIiWYPtD9iYpvh4E=
X-Received: by 2002:a05:6a00:35c4:b0:845:e432:e93 with SMTP id
 d2e1a72fcca58-84e9331e5eamr7041497b3a.48.1785329079445; Wed, 29 Jul 2026
 05:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pengyu Ma <mapengyu@gmail.com>
Date: Wed, 29 Jul 2026 20:44:27 +0800
X-Gm-Features: AUfX_mxA4etvlqMH1AkG8JNXFGenrt_C92n1wg3pKM4Nj8bFnD6JmwEU7iPTaME
Message-ID: <CALSz7m1iW_hZbkL56+OMLXm5wE2s+ytxT_oGEU+DHyvYEMx8jQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda/realtek: enable AW88399 on Lenovo Legion Pro
To: marco_giunta@outlook.it
Cc: broonie@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	imitoy@imitoy.top, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	linux-sound@vger.kernel.org, munzirtaha@gmail.com, nadim@symbolic.software, 
	perex@perex.cz, platform-driver-x86@vger.kernel.org, rafael@kernel.org, 
	tiwai@suse.com, wangweidong.a@awinic.com, yakov.till@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marco,

This breaks 4-channel playback on SSID 17aa:3906 (Y9000P) and
bugzilla 218329#c31 reports silent woofers on 17aa:3928.

override_conn_list(0x17, {0x02}) forces both speaker pins (0x14
tweeters, 0x17 woofers) onto DAC 0x02. For a 4-ch stream the parser
needs a second DAC, grabs DAC 0x03 from headphone pin (0x21), and
assigns FL/FR to the higher-priority headphone (muted). Result:
FL/FR lost, RL/RR played on all speakers.

Pin 0x17's hardware default conn list {0x02, 0x03*, 0x06, 0x08}
selects DAC 0x03* which has full volume control. Without the override
the routing is correct: FL/FR =E2=86=92 DAC 0x02 (tweeters), RL/RR =E2=86=
=92 DAC 0x03
(woofers).

Does this affect other 4 SSIDs (3906/3927/3938/3939)?
Please drop the override_conn_list if it is the same on these 4 SSIDs.

Pin 0x1d is already 0x40600001 ([N/A]) in hardware defaults on both
3906 and 3928. The override is redundant.

Aaron
