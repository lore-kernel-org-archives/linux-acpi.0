Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286872;
	b=ULlalM5W9W1L/7AXOcr/EzrUp9a4kBk/5o6kQzix3HLf6yZrolptmIvTcZdBeMwCGRcR
	 J8l5PEnyFKrrVDqysNI57Jf95G1NhYTv7/E32lSwzqyTnD+zWId5UADz3hLQ4EkHDlDwA
	 loie3WWQ5ZTVnc53brph8kh2EFnxHOBn1hNkxFmWvdkqGvQhn1zwbZ0gEIzFXOkF8cQUd
	 NKZ9BIQ+R1lH+k/ioukPl+fUPYIiwhQlIKkOeywq41YpBX7hzZhZQYcxkL1cYX/UquFQo
	 1I66/EytKX8mGVUSpCinpMcxkyrntNDNINDT8VZPx4PFCtqQVVPytlgoZRJ8iO5+Hsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hfS5OIzHxiX0eHuVw19YiRz/YZ1IYKJf2EBJhe4l3W0=;
	b=HlO34mBjhHUPCJC7SUMuZOdEGvGuQ+9NjKjT2RsK8W5p/biYIavCemgiBS00SWGbh0Zk
	 AY+i9FNryt/XNqebrpzM2WkgNQrHG1JRuckSNwgTKLvY4UI0k29WezEAQgeUC4LPooSlD
	 CuOc32sGkAnvzZL7j/M/ShmsEB+lHiYkLlLaW1m01PsiAZQIlck1gSNC1gkE98ogzb1N4
	 enDc4xpfaqOt1utDFgLFfB12XntyJ+xDJBde/Icpe+QhHg3GTtG4vc8XhETdsTnsu0tPg
	 wyarXiNsnOQ9QWVL6Rmda0mIXzJBQ5brLn3UG2cgECZD1LZJ7sRrhMrdLJgfG1w6X8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fireburn.co.uk;
	spf=none smtp.mailfrom=fireburn.co.uk;
	dkim=pass header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=keR1zdwP;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8C606A31E
	for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 15:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD8C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=keR1zdwP
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e0d1da913so598040f8f.1
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793286870; x=1793891670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hfS5OIzHxiX0eHuVw19YiRz/YZ1IYKJf2EBJhe4l3W0=;
        b=keR1zdwPulTo+d7tvTdq31vAWQaT8MlLAM32Q6b1EcV71wHPyV/HHE36X73/MV4HuZ
         X9TwfacHNzU4JqpSHWr4jGZgd4BHuqJ84fBXyRoDrTvk1EcmaHbjcZZUe7nXYhRip58B
         0JDycm67VMVvEs+SlklA4ABYvrqmuIaHbbH+AbQJqMQaOGS355ihcsxTt8EIJoOLPkZg
         PaYN/y3utuEJqU8cz2H7kCxX98A13/bV06UJ/Njbbq7xp9iKA2JItXAkM8DzD7BFGcVN
         0ZpsiipQVIA+tUkw2zaJvbZI3MWWfrbCGwQmPgnWXIXfQIDznbMRAo8dP+dlQ3aWjOrf
         x7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793286870; x=1793891670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hfS5OIzHxiX0eHuVw19YiRz/YZ1IYKJf2EBJhe4l3W0=;
        b=ilcnVmx/XOi3+kSUbCcx0TA+5yOX50DI4m2fzEBN7PzcTn5+eThbSo92QJ08Upe8xl
         dRc0yAMJYB1gV8V5IW3xdbN+C8sQLrifrFvNyiJp7aMHG/ch3JAuOjLtK6E58XIg/dca
         JL2eI/v8ezW/KTWGy25TF+t46OhKV0OemMQLV+73mfmrnBMFyEeaMV27SMnBg41721hf
         gF2cSYWY9+O/+Em/HiwdLUUasOKoZ6GHl/Z1xUT3xDQ9VsZZeg4gBFKJi4qJ6DToATfx
         JOGv+mjetzk60PEEe/NPv/tECi3P5C3yi/hgmzjjDuoYmokqhNg72+X7kw1MOWQAgMr2
         8IDw==
X-Forwarded-Encrypted: i=1; AKwUvBwKvVSpFkBXNiIwPg0yftvVVNcT+LGKv3nuVjKjxlv6+eJl20jR5L5HRyNjIY4I2GdXqGnzoQ+qLQaa@vger.kernel.org
X-Gm-Message-State: AFq9FYI2hYY2T3mu/LAkerJiBkLb2mK4ki0WF/st8p4FcZcSLjKJGqCT
	tNs7L+KBB2Jxz1Gzo0oangL6R5bwRDP4Xt5UMoQqOzX0nYSKeHtSa6MYdJnQj61XEw==
X-Gm-Gg: AYBFou1HK2Og/d6+4x9URzy3lXZ3k/nzCR7WI3xyqJ+ilMdegmceGyXmnmIC1iSn9Jc
	nZk/bIBfAKp4NT/W5f2zvnS3Xw8IihM4dEmI8ZkR3jFuEjSG2YnBQNedPf9BAs0djwBPYr/HGnU
	+gdIQKoQ2DsJeZiHLHfHJTHRTEspUxDa5LqKB00OmUsM7KP8BpvSsr31Q/TEcMczfOMWVGZZxCl
	ImhYQRdDAoNS7QCERYC8yPxPb2YKTv3LEY7hXoA8j+ThhbOramUI2yaD1zmNVoFcpe79EHXAPHD
	iRqk1CmdY6DpdQdSrqM0rbhsHE0bKa0csYFXhUumc4RntvFSBU3xdxtvLiEW4Z93FvzKmb6OV9i
	FEu5KwJhLCK/OVnbbsQTuaqdc0EaTIMADLfz3cdC0bTeADY+XMT46Jl0mJ5msCdwS/I/qIBg/Ad
	EPGiDINRLSPlfrnFtKFS7IWoXNqkmzX2MRvCFSFKqPIIeD+RK0jDHhZwWjK+Ha/ux1GvoPhKSTT
	OtN8ZGFuVbZrKHVWDVzmYajAixl+HIxudfK850UgtLXKihAJ9YtZNSAfjU6fxqCP7mYUmXK+xLN
	VuXpo+30vAJTg78+r6u5GSp8LQvB22m8QQUO7WTZdippxKRwRKY+MTDZ/8dpuLKLlX1xwUE9hBp
	72QpQD0KpXOPL+l3ntEaOfg==
X-Received: by 2002:a05:6000:2805:b0:487:13a9:80d with SMTP id ffacd0b85a97d-48e649658c1mr5331076f8f.10.1793286869865;
        Thu, 29 Oct 2026 08:14:29 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb851sm30191373f8f.26.2026.10.29.08.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:14:29 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: superm1@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/amdgpu: wake a powered-off dGPU on a dock hotplug notify
Date: Thu, 29 Oct 2026 15:14:20 +0000
Message-ID: <20261029151422.56791-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
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

On an ASUS ROG Strix G513QY the USB-C DP alt mode lanes are driven by the Navi 22, and the firmware signals a dock being attached with Notify(<dGPU node>, 0x81) from a level triggered GPE. Nothing in the kernel listens on the dGPU's own ACPI node, so with the dGPU in D3cold the notify is lost, no hotplug reaches userspace and the external displays stay dark

1/2 adds a notify handler on the dGPU's ACPI companion for BOCO devices that requests a runtime resume. Runtime resume already re-detects every link and sends the hotplug event

2/2 handles a board where the firmware method cannot deliver the notify at all. The G513QY's CPM table notifies \_SB.PCI0.GPP0.VGA, which does not exist because the dGPU sits behind an on-package PCIe switch, so _L05 aborts with AE_NOT_FOUND. On a DMI match, and only if that path does not resolve, amdgpu takes over the GPE and does what the notify would have done

Tested on a G513QY with a USB-C dock: with both patches and no table override the displays come up after the dGPU has been left in D3cold, and the _L05 errors are gone. 2/2 is only a DMI entry and a handler, so other boards sharing the CPM table can be added to the list

The patches were written with Claude Code assistance, as the Assisted-by tags say

Mike Lothian (2):
  drm/amdgpu: runtime resume dGPU on ACPI notify from its own node
  drm/amdgpu: handle broken dGPU hotplug GPE on ASUS ROG Strix G513QY

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 132 +++++++++++++++++++++++
 2 files changed, 136 insertions(+)

-- 
2.56.0

