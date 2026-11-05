Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872803;
	b=xjxG9vneP/NSndvggwlcZRc2J0EFIrzaTHpxRfKCLq+7efYCyXIt/flOf4ikhs9dhU2y
	 ACcxz2h1bWkFMRfBHYXX/nr3NNn3bjUDSpPBZQ1NP+NJfoVcNVTbyn3HTZeb7MFBemrz1
	 dR2G0r2MP0RF7LHwoRTcwOwyOv6qWmzX15sbyo70f9dFykL2JYYjzeyZoIdKmxsDp1lYg
	 txyWC1zbgoVBpGFg2MY+XCxaVT//vM6uZypsfjfoYYvOkXll673dUKkbUOhwa0p86m3bp
	 3tUpheIDhe4fBUrkeJogCLqXk47vo1btm2zDN2HtXxYICxM5qe5kgjbNrdYQBy6iyKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872803;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	b=dfE74P7huTrCNtRmWxAocdtLC4FV3LfP5obKIPtnU+RZxpZopyq+nSpP0BROr/uKlm8u
	 LwKWzQQTKsX7ynuCS+dxiZZ6WJjwhyMsvLI9Cr7gaz1SxGC1ZroPYsOcx4Du1qfwfSVvT
	 SAYe4phsgYNddpvmw1J7oBZo0tMZWubdi8o2ZzI/7TF0800gQfNpwbcHwnmimdXPENTsg
	 cinxTjW6IXalDQCyhE19R2ojTRSUzklbker9Ao8qsX7VZ8WHji6HarifPamE/3BfBh9AO
	 hs8j/CPpAcDb56tTc1eSbnSPIvoxVhXGWXn+bN+sldy9Ri3LyVSQTmeiEHPRMjPWewA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9360606A329
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 10:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9360606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53c4b82919fso21100981cf.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 02:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872802; x=1794477602;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=NqvZisJwWAn+wFdN815dlOjQHS18QL4aPqMlnc/wpsR2MqXxc+ZqHaDM1uCRrbvbW9
         bv5pXQgBgwXpgv8jL9AV21TMHvFJPaFS+6r0Be+bVMr4MiW/+1gnyGyXfx+JyP42HP/p
         U7ZH8HUjUb/CLcrIiNsjvLA0xRPJYAzQcE4EYKBjyarLWwJTk+ZPfRuAVwFAp6IDJCXA
         EsKcgeH8TWkQ70dmmUCDeVrkmxINnmDG21M+5C7NEQJQHgr9+F2SB1ca/Q0H4DKv5dcq
         vV5pbj60JVaS3XUAooeborB8lxYLheiAVYrX/CiaJMvsszWYPyaBgm5AbxEScSEHy+bl
         bfdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFZhGxj0u3DKBk6J/8mN0oAi3caUfIlBXQDfEjGN08RL3Y7CL9gWppsOJCsNsDZRNjhmDOMiJT0OcQ@vger.kernel.org
X-Gm-Message-State: APuU4Z9Wd+oDhAXGKIg98CagmbchLS0JhAGMCi70ClN31KvMUGNnteH+
	vVYM3u0YUlC4i0iorPacn54SaxriJY4am4QYaaZ9sEycd9B1xGdh3fRNSKOhcaxnCHc=
X-Gm-Gg: AYBFou1SC5L1kckpC2IBMA/CTVxOEmWSQxjhs5SwvmWpnr991Y2ks7S2MZwPPXy1r3P
	15kXs1pqJX3uabMLlHPRhbPSSsFUs++M2jsQZzy+2pBdrHzT2LzA8oI/dV5twx3NRxLU4Tdq+TZ
	ABYOmVJrdXlMpmJb8KksK+yP6r65mxj244FH2HCJ8Z1tq+8iT4HYqhn1zUIwdvG9hDachoquvAP
	8qRkGgBk+fLCQETEs5sY1bj+bG65n27HIM0Cy1NyfcrzGAS2RdXXtkEdaBaB3BAv73vonQfpIhM
	Nj/KETo4/DInonD6M0Brj1zSr0yVd54inKHaY1YdlNK7pAmX292PKHfLWQVaeLSCX0JConA5CWO
	kNfBX2X50pikihlmBi+MgUr0QTw1xO8jffbPfZ544HPHwb2w+i+O3m3Q0kZKAwUq94e8xCE/jfN
	csiajsHUvx86hf59zBsXZKJsu85WfIyuITNKMCGnlx85aOq5xJk7GKH1CMy7lmBCPDLdta5mwej
	f+5jk2xigkZitAuKYQkTD4SwhAep7rDBMi99VwP4Jhr4YMQobNztSjYXl2+vweZn729rj6F4aF5
	2veSKHtq2a6w9s1mKx6an+5Bv3bKbDqgVVurK6+QtQJUFXiVmA61Jm6OjdHTGxr4ug==
X-Received: by 2002:ac8:5fc7:0:b0:536:6c4e:13ff with SMTP id d75a77b69052e-542b7916ff3mr320641361cf.56.1793872801445;
        Thu, 05 Nov 2026 02:00:01 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfba098sm43508856d6.12.2026.11.05.02.00.00
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:00:00 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c1f548f87so26516506d6.2
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 02:00:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx3IOsqt/YdegNSJN9avWNiCCd3mFsavqr/Xcl3ZTOa3Z6jr1GSmhL8gENw70eU2X7jn4Fo+HRBOo8S@vger.kernel.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
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

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
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
