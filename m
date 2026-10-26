Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013970;
	b=yLosVgalLWPbQg6s9WY6d6xHlAaZFcbEMwtsquj9nJnGLDTunV7OaU017+EgR24wWCGw
	 1NdrLX5mJvCKNKMG5/0U2yX+3ciVCvL8/WNcdzdpBYn4dr0s9wudcKcBjNTn6118XhJRH
	 OB9ziJrPXUtWAB6hNTTA0O0OnU9pm1bnjkh6CXk3oQaeRoVwU1dl05Iru/16C+jdJXWmL
	 YwDV+dqnTIRUO9JkQ6Ub3dF3hy1eLijNCGDP1Ok7GIbwxAhziNAHF+wflgxyPQ+HqXugW
	 UOeg1pKLDdmIYdVyoRaKwJ9sxX8d1/8swP7j3uPsin27mVv6zrV0+oyc35AYIxAT8nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013970;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=uOaURFmZY0XyV5YwXDbVEHdbFFNaws2NAdEXPOTyh6A=;
	b=BJ3+T2h4EomV2EwdY+BpDsKJkCtICOkULwENIhvu5yWfCjxACFCF/magoF8Xm7XNXtis
	 wK1jRpQbYYLZxH971l34v46ZdDJhKyVZU3yi1xsmnvQ7+NgycY4A8kWxJX/uA6PiJOME+
	 NjvjZ0jqWz1pXKqIFmu1ffhkZEZj+Sj1secE95aRAolbbda+2B6flQ3qpLzqXBSZutbou
	 SBsNbPk3zV+bAdkSkYpZimrVdq/+EcHmt5xpUxTSOxtgEt9dxritZEa3hBIImo3F41QFe
	 46ka4XiHyo1tZ47zsSQ3s1XqMCVRJ362jAYHVDaUQccTrP768lhmJdyffkyN05bV6Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=AoJJKUeK;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE66606A31A;
	Mon, 26 Oct 2026 11:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEE66606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=AoJJKUeK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793013963;
	bh=uOaURFmZY0XyV5YwXDbVEHdbFFNaws2NAdEXPOTyh6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AoJJKUeKTSlVKHamUAWhSKzrbgZYCI2LK/ceLBJF0Xbp94qHDWdjyBZq5FrhxiO9L
	 XjLNECkg+tUQKzt+bayQkuz+2ATmHSIHBEqUDl7/nXDzLHh0J+lV3/zVPISbflfxSX
	 rh9CI9q/ZcpWWV7P2dTRJrVb7S/xvUefTHJKSClo=
Received: from [127.0.1.1] ([223.66.54.214])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 680AD89A; Mon, 26 Oct 2026 19:26:00 +0800
X-QQ-mid: xmsmtpt1793013960t669rs50j
Message-ID: <tencent_8D20C52D31F04EA8CEDCB3B1A80A8451A707@qq.com>
X-QQ-XMAILINFO: OaUQ/Dm85kfN4rI7hmeeoT7K2H4gNfCwwIubMTJSqjDYTGsc6QAdImXom+jk4i
	 ldG/0T93+58Yg3wYwrLXxyVvgMGVdIq1buarBNBlqdt7/5KgVSwYtOi7iGun+Bkg71xRpq6+jKns
	 SbMyUAjjp1+0qCizYoP2TDANnvov4VNeNYrhEeXvPhhBQWYwToyutZtvh3DMN+R+TrMH3R4LVt9P
	 Zft0Kpv/XtN16EwDHcUs+phD5ujssTN0PkV9j7H1JJl00IxTpya6P3yUP6Lif1GP5FJPC/TXiywk
	 GVQ4ULFBAsg6CycX8SFXmqfb0cYeQyeHpkfvU3gcGA1oS0v8opygmszt0satPvbaDuHVN/nXXart
	 KJzH3+vbhFzp9ULpSzajCMxYC/iUF3BMr4gRKLMzVSiRwKirrlPRPn8rZowKlye1wwshpAs1Mt3m
	 +aKIDwk5Z0V819UI49supeTl9PsaUU9NoMHZamH0bPqWrP7w8fxH0rZSFQTg5rELc9g9GxazdufF
	 sWZZ9qETQZ9dtL5/uvhvwTUNvLxP2iari56UYOXLBYODmg9hon2tLaVMFyaCoItsJBlxbCidR2GP
	 yaxSD6mbV5mJerkeHVxqywevV/HuTQpvpojbdnuOcujoo6p36tOxLgeDKD0Tnx8W8DHOknLnaXZG
	 Ky5zX/ObEPnXHXnHnnjNmcqTTz6XkYStuFAn+DM+jK+SV5Vvv5MW0Bg0a05lBD4LI7EhXIWVHGxF
	 GFelFhqtG+Rz2/WO+wLeAp8oZzRpLvVXkshV5zGkGqEVQEKBbgLb4/pjB+rPdquBP7Og7J8kNzWR
	 JWOLD0NWbfZapZeXK/zqvqoImMdqxKqQWOVdHk54TnDEEGmg5HWfKGafpqX5wjJqPzNx1UvgTgLW
	 uzbeNZb7fAnP8N7kMh2LY8DvuWMZY3nE4/1m+u/W8VczB1Jy+Q+7xICY511/yevw/0oiiEFJCw/J
	 2RywmuGP46aWZ+z2+GrVNZ8jqHBEcgzy48a5vnr33A8O6U7jvK65008rp1qj/TET2rwgU8EHx1+i
	 YRkC/tNVFCkSk/0MmMAIIESMmq1//2x1E08kgJtl6UcTOJ0z2JR3RyDelxa5Q=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Wu Zhipeng <zepwu@foxmail.com>
To: Alex Yeo <alexyeo362@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: Re: [RFC PATCH v4] platform/x86: panasonic-laptop: Add
 platform_profile support
Date: Mon, 26 Oct 2026 19:26:00 +0800
X-OQ-MSGID: <179301396052.9675.2367290265121810364@foxmail.com>
In-Reply-To: <20261025191300.1259541-1-alexyeo362@gmail.com>
References: <20261025191300.1259541-1-alexyeo362@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Alex,

Thanks for v4 and for settling the mapping =E2=80=94 cool/quiet/performance i=
t is.

I applied this v4 to the v7.3 driver source and built it out-of-tree against
Debian's 7.2.9 headers (the unit currently runs 7.2.9, not 7.3; the driver
code is v4 verbatim). The 8-line CF-SV1-2 DMI entry is applied on top;
without it the profile device does not bind on this model. BIOS V2.00L24,
i5-1145G7.

  $ cat /sys/firmware/acpi/platform_profile_choices
  cool quiet performance

  target        CEFM   EPLE   read back
  cool          0x0    0x1    cool
  quiet         0x1    0x1    quiet
  performance   0x0    0x0    performance

The passive+unlocked combination (SEFM 1 + SEPL 0, written straight to the
EC) reads back as custom; the ABI itself rejects custom (EINVAL) and
max-power (EOPNOTSUPP). The values are the same through the legacy
/sys/firmware/acpi/... interface and the class device, and writing through
either frontend works.

Suspend/resume: this unit only offers s2idle (no deep S3). quiet and cool
both survived an s2idle cycle with CEFM/EPLE unchanged, and a profile write
after resume still reached the EC. No errors in dmesg on load or on profile
changes.

Evidence (choices, round-trip, custom, resume logs):
https://github.com/numuly/cf-sv1-2-platform-profile-evidence/tree/v4-test-202=
61026/driver

Tested-by: Wu Zhipeng <zepwu@foxmail.com>

The CF-SV1-2 DMI entry follows as a separate patch, as you suggested.

Thanks,
Wu

