Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.194
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795682909;
	b=mDxy6s6FHChhz58QJtjcGlwddjhfp+J8TZcRjONex9LpxXGgHufkGPutsEuQ3n7b8ek3
	 s585oGCXJ/jbJjM3jW/1fnxUwhuqYZ7Hddp2Wi4KXSqDcGCUbyNI21BE0jgVIH90bL6/6
	 /xPV+hs5l0V0+ysI7Dfd4Kqay+tHmbbsXiJPQzcR+na85beA6kwE/RMq15C5h07IpWKY7
	 Ma0j3GbGCKKyc4tSxyXi5wUPlg5lE5YQVnqyoiR8dG0H6gtlx1YpEeCywx1UGQd4qjkIO
	 zIMaTZsFYX4YVJs9SjOpJbhe6GnwxKpBm8t3yhyd11SyY2kea1WTMfAt76JCzzu7o9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JPdYs6vJCqBkUvR8U/kgx89YZgfci4So8XtWHpp1ZRo=;
	b=hjQkkNwUF2LiiszmTRLOL9uJL3xtCQ3TZUrl0G2/MpSWk1CRu8AUX9rSEL+ffZdeBFSd
	 1kLiJp8Pk+UclfhzfDyGl0v0B0ap/w3IPXOBbxPxB6yO3MFKdXHXUWX3mDhZn+JgYbNDl
	 qJACYN5iMu1o6XeJtOnCJ4QWrXsSWya5/HC90taosGboaEx5ZDJeePbmSN9WgKBim57+i
	 eXOIYSIM4MAKcwBUBJ+0wWxGAGaZt3u7g8J8BKjRUTzBcYvAoAa1mj0324mC1VtTC/e7t
	 k5d3h2zUVFgPsrddwqy2cDncerPOla/ZUTZqu2xTw4/F2PMk+u6/l6Ljp7zf5TvRpmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqZA4KNM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.194
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D64606A323
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 08:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D64606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqZA4KNM
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-8b32daac9d7so36736247b3.0
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 00:48:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795682908; cv=none;
        d=google.com; s=arc-20260327;
        b=JBHPhME4condTrrhvopO8KBTy7iy7mjq2OoeDRakXjhUIQ8IjKkFzWU2HzDz5o5KVQ
         LVOe54iRkLn1kmJG6a+hI4gqpErLAkHyTAf2zWqP8i/HLHJ7kEkc1IXAZUfOImn3fNnG
         f48+MRck4c4FT1zVzTlEGMgOdYes5i2UDjUixvKPN3YQmiWUuNULmk7rsONMDK01R8cD
         kARAxVrZi5KB6abpNc4xuJR3/e8J84C24bX8on+edfJQtGtJ6Qk3NiyGFMBtWYPaBYpG
         CIUfhLPAF4lpp5++v2bp9+UlllLwwEizDNtWLtJMdI+DklK23zpsfh8UGVNeDmn8bHKK
         cZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JPdYs6vJCqBkUvR8U/kgx89YZgfci4So8XtWHpp1ZRo=;
        fh=G05xz4P+b5r42O1FspNZAEc/2bFo0NU0152PDVaMpSU=;
        b=T0NCObA3GN/5/zcA4arwYMlGGUgZxQH3Aw0X9vqaQlTQ54Zgm0iMdGwKOAL9PMvXsG
         Qp6pDNt1SFV4Xluq9NoObOnQxqf/3UhWaX6Yc/HSa2+NVcLzfPIfMUzi32/g6YQccmcm
         0h29gyv0r4aGWM5fHhLET6W77+Lmvz5o/Sne5Pe5NPA1bpTQBvegZF1lha6kNZNxBSy3
         ePtvPQ/lxGngeG3mLQfArlFuRoO2sLPWrVxeDXU1QS3mZckkEmRZEtDnoif3CTr89sDJ
         192hzpdXRcMTaEGWzfG4IqAOzHYR38pQJluvLmHsxmRzzsUJqRhKtGNBopnphuTLnjye
         CAIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795682908; x=1796287708; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPdYs6vJCqBkUvR8U/kgx89YZgfci4So8XtWHpp1ZRo=;
        b=hqZA4KNMjir4uDRbPdzddXknwBMNiZwUnWs1LyJYcmBdMyuPRz+A2IXaH1ZmoqPng9
         hoDkbzk1i8zEcLWa5o8/AgeP3KieJmt6J2aBc9/wys0KofS7JFcZSC+zqh9On20LDKB/
         QFnrLIPuAkfDWCtEBSHiabEIq0DXdykj9ZMlsOOFM0RnmIq8W+asLQB+uXhL8MwQkjeE
         UUIYEL/t/Zy7hd3i/a4qACtKVIGe6nUcTWB5f23vczw5Nj6L7D85gEdwMg6KeZzdh9j7
         4qcqKR9bjwZyjnjTq2btS7kn60CIlzpsGtnSL9d4gylpBnzpTH6KT4jYg++NjSLGtSV1
         Yzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795682908; x=1796287708;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JPdYs6vJCqBkUvR8U/kgx89YZgfci4So8XtWHpp1ZRo=;
        b=s2IDiETpLGSES7B/xNNygaCBXJkl2RPvcNuL8XiAItQGobtM6tjnJLKZpL2tk2vkin
         cX1bnWTWuwjognjhX1ag2obpnvlfq7XAgRMunDV4E4q+ABpLlVCW7VsDiMcvoCAYnOR/
         BNN11i3FMc1tENIyuqE63qmUqr5f0MWeWyPtFbPtdDT17vQ7TDXhKe5IbUS/lAVI9N0T
         cfiQVnvY+MX0q5EwN7d0/E/CMGwKtY+6DshE04POBTLWnX/PsLSNbsTUxr52wi0iN2xN
         jXDW1YYkeT82nJ7MIb51Z2fBviZVPUHIRJr4MP02kL+Ow3owmklg+IZodFXQPUT1SAaN
         ieSw==
X-Forwarded-Encrypted: i=1; AL+hErHg+NQ3a0r/4ecoZGpSW/OO6WyD7dSZhy8fOpE0I55t++CCeEV4b6iLa064H3QFwnpV8F0ey6ReSIla@vger.kernel.org
X-Gm-Message-State: APuU4Z+CW2pTiywPmW2hZD7nDDOfMGkYjM3KVzcdnc5nym4wR95/RH9q
	p7AXyGmpSKuYiDb1Fwu54705jtSUwzG4OW0UeYLmY1uvrYY387fvF7BkPlyM1ViKRe0VgmuNkLk
	tnvINHFmnhPqwnSUHYj+z3Y1Trt3wduQ=
X-Gm-Gg: AZFdTZcQCChRAOdHQmdxdQd0dhZzifLIWLUC0CF02MiiYrWf0VzUk+gBKbIQJA6Ujuh
	iXWEETlwqBnVkAwhdWi+7WyFsKgOJG0zfa3yfS2gvoKAUSXlBZFMv4uf5JfVAKw5VdyK/HmWkA3
	XxqhYNoJ2+mJfMpuMEIVG2Y35Ag4bevsq9PldkIf7zFYaFZuiEYOqa8AzdT2pznxM2gTcuYbjov
	qLYGv7QjrXtrRk6LYqZPxCpWm8pQ2WwCGwc1v6lclecH7QKlHCpMD/IDicBwsoTO+smOGQ7RC2W
	8jAvUdzUQgvrYXwgVrkzkp8Z8n1zNct6mZ8SUZjLTbWknaWILwg7t/59mNiCzWHrETIekzfHoCn
	Zvcl1nsJqAMjI9E0mNy4vqD4pPZiFoHrzLgciiP9kMtJcT2xcv3OZcs7nDQw=
X-Received: by 2002:a05:690c:85:b0:8b4:c1ef:e027 with SMTP id
 00721157ae682-8b518e8aec1mr83284417b3.9.1795682908396; Thu, 26 Nov 2026
 00:48:28 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
 <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev> <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
 <CAMnz_-Dztuj3CRsxcVnfe2=OCB3tTJzK6Lu7-AKfkbuqn5N-UQ@mail.gmail.com>
 <DSVPR12MB66402023AE5250384B26515942BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
 <CAMnz_-C02J6CznPD68GgWCPCWEDSGsq6hoC+AJhsZjw39H+hhQ@mail.gmail.com>
 <DSVPR12MB66402044074D6A8B1EDC584825BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
 <94785b4d-c807-4465-84a1-25ae317df4b8@linux.dev> <20A82893-B458-43A0-A3B9-0C090BAF7F00@nvidia.com>
In-Reply-To: <20A82893-B458-43A0-A3B9-0C090BAF7F00@nvidia.com>
From: =?UTF-8?Q?Riccardo_Zangh=C3=AD?= <riccardo.z.dev@gmail.com>
Date: Thu, 26 Nov 2026 09:48:17 +0100
X-Gm-Features: Aa3M54qIOIptLLdBNDvtxOYX8Oy0vd8iLsonH3drtLVWoujSV1jV7wZxtx5bRBM
Message-ID: <CAMnz_-Bah1bg9mR-t+oTnDVMXBwwm9n3GJ3cPB=q-X2y+_=YUQ@mail.gmail.com>
Subject: Re: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
To: Daniel Dadap <ddadap@nvidia.com>
Cc: Denis Benato <denis.benato@linux.dev>, Armin Wolf <W_Armin@gmx.de>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "hansg@kernel.org" <hansg@kernel.org>, 
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, "luke@ljones.dev" <luke@ljones.dev>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 25, 2026 at 23:14, Daniel Dadap <ddadap@nvidia.com> wrote:
> You could also try patching the kernel instead, maybe with something
> along these lines [...]

Hi Daniel,

I tested your kernel patch (the later version using
acpi_evaluate_integer), with these DMI matches filled in:

  DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
  DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A16 FA608UM_FA608UM"),

Kernel: 7.3.6-1-cachyos-a16test (CachyOS tree plus this patch),
no acpi_backlight parameter in the command line.

dGPU (gpu_mux_mode = 0, G40C byte 0x07):
  /sys/class/backlight: nvidia_0 (raw, max 100)
  brightness control works, no "Unable to read" warning

Integrated (gpu_mux_mode = 1, G40C byte 0x4a):
  /sys/class/backlight: nvidia_wmi_ec_backlight (firmware, max 200)
  brightness control works

Hybrid (gpu_mux_mode = 1, G40C byte 0x4a):
  /sys/class/backlight: nvidia_wmi_ec_backlight (firmware, max 200)
  brightness control works
  dmesg still has "ACPI reported no NVIDIA native backlight
  available; attempting to use ACPI backlight." and two
  "Unable to read EDID for display device DP-0" warnings

Happy to test an updated version.

If this becomes a formal patch, I'd be happy to have a Tested-by (and
Reported-by, if appropriate) tag with the name and address I used on
this thread. This is my first kernel contribution (I'm 17, if that
matters :) ), so I'd appreciate it!

Thanks,
Riccardo
