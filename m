Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872288;
	b=5N2FfqtvgH6BjBecUBbNuY7DAYR0IXEcrpBCDSqYJ7XUWbKM5mATUnG/eEm2YoDRGYpZ
	 STzahw84NVVzLDbj022F1sYb1mhP8qax8ByiNPPfXycqUleEqncbG6HTouAd+n7WneiEO
	 qurbVTEqsVOmI6JxXhmetSvxj0szimuFEsiOs8BKNEvFPoqEOYAAZIooAiX4P3dLdxsV0
	 3tpdVEbcWQ/zypkVXo50+uim/ycpvtxjatr0KZa5yxzLr/Cot9pC4Fhw/tO0WxhiWC7BF
	 uzoeVFzGE7t7l6tPIeauC9Akz94yZaIXKbr7CoT/V8GCLB8rHPvO4Q0DNdih26izVug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872288;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=vMV6cAeh7/jeV49btAS8wV4hJ9Ws/AeJPWcJ/yDE2YVM/Fq/MqfhP2gazvNkzjprP4jq
	 W5+QSYhLV4GOln2cqFIqLNomBNg8zn1mxu5pa4NjyHG5ySMDbW7i4qOxI1aqABDcR85Av
	 vIuROFvZDW8Uk2qDmgXVDQb6kO6Leje/+TZP+3EFT3/n37I3V61SIuAdnWNGsFjaJxpOz
	 m64okDuoyOTx2FhxoTAxMSdtoIoyqNR7jDrp/BYvseDdBEJB/ruRqlhC8wm6lK1Eym+qa
	 ZyJX5dt32XxN8g65UHSyzAZeWWkRuOYiIuscnWVLUnq330Xy+KAl6dEoyAr7hUKCfwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59057608361A
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 09:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59057608361A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93cc1ab5f6cso197304985a.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 01:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872287; x=1794477087;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=PBjRmcaR1r/7jaF8l+xULHJmDp6MMLWCzBazGij3/oXhszGw9moAhXH1npo0avagZF
         cRxU/l4jjSC/ch1k/wgx5Befof1R1xEbaGwHSGhPp/jptkn3sWtd0X/USLxnZFV/qMkb
         ko9SB6Qunef/SVSRzE63/yc8DgX0rLBEsAXimFwiIte6ur/ZD3/ZoRvBPRCrA1J8YW5Z
         pBlt7hvh2SgI/GGSElbAS1qc+AnhAtwIh8kOLIkDA5sdgkZNB2dGSsXtPZc35iqQe0fz
         G7klPLg7JUg4zJymbaeKlzbvfGnrIrq3ZwOwLA22IDVLdPuV0imhRhXd3aJiWrlii2Y/
         4Ofg==
X-Forwarded-Encrypted: i=1; AKwUvBwzSWXTFmuenR311JH8d1ykaajWsbjbWggeMKfDKR7sdY9D3L2RuUcp45zyv6KyUFuZ2Q+sU5igIcSd@vger.kernel.org
X-Gm-Message-State: APuU4Z+18m9aP1LEFiS2EKXJ6N190Ze1g6SpltE1eEUqeu84fFJHavAk
	4O0WIXq6z9dqfyH02b2SLspXDKi9oElYZCveI+03v5mmd6chSqN9GTm7Y9mav4SJV1s=
X-Gm-Gg: AYBFou2ZeiWsPMy7mkK8qyHxvoYisGBj9VFJEN+5nV9GaFalq4/T9LU9lZ1uC+bDLMO
	BKYkTMeUjcUrywihskxM3YWqPDPok/vc7OPhf3FjhNef7JX+kGl0xpFuJqjFau79wdhVVgVCBge
	YKcktQwaaeQC0oK+CN5UVNZ+E7Zwuq/XevkuPC2kegKsCxJLe1LhaCxkhtrO/ZlSPfmoNEAoD3j
	YURviBrMX6wtAN3jdOw5viyXjQn6CB5veEn7VXZi+m+Dgd8Z4ExvF7FQhZJRV9uJ+MuejRTQSnj
	LYySquIYdOx/wsNBZzWu/ZgibMr0Z0oBOjX81zHCU3/bGUmhAiairMZOgghz41hmSUx7VuVd8iF
	VwftUOUBaej1f2wBGzZ7IeFvAmWJZ4OBXcs+Vs1rQOXLIL/x1vIvK+QM5utQj+3JTYR0nzDnL/O
	tshroYkZ9haLZCYUTjZjt8p570XW3re531L74VX8aKldUUk0bBxR0X6IbOETUcvndWnzX82Ma90
	YCXndALiHp3MvYGzK405Wg+byFta7ngJo41GmkKRP4mdXSK8OV+ffm481rhjypNNCRQOqc/hPpQ
	QPOVFTfKD/hsSBqLzZ5F7limqKbie6OfwG80Og8ifpiuBTLhrsG/+keaySD9tUsJJ4FQ3Q==
X-Received: by 2002:a05:620a:4515:b0:93e:5cf8:e5aa with SMTP id af79cd13be357-944216f1f16mr3317358385a.61.1793872287186;
        Thu, 05 Nov 2026 01:51:27 -0800 (PST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4844be4sm425545185a.29.2026.11.05.01.51.26
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:51:26 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53c4b82919fso21002841cf.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 01:51:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx4AWzzNDDWL0cQSzFGqoCV4MYnuqn0n4LzRYELWvE5LypCEK5shl7FoydPs4okKaweVyW8W9UBpfgi@vger.kernel.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
