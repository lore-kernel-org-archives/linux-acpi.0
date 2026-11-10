Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273748;
	b=dXe9kE66bPNDpE3rxESHB1vvtWXaTal2dYw6b3XP+3NopZsogo0R/UNZcL6r7yyqC565
	 pXt8uQzyQQvegZS44Dic3/n24EUPr5MpmVvPTP0ysoPrPztDJwCuPn2csO9r3/278fKMl
	 Ja9cONOPe5WPzHgtgGP6QIwLAiSVSV5TF7rqhZ29V596me1oJSQcJjb80TptUJPvMVQ6Z
	 ItVGQeoTTe6QDJAg7JlQTQVMLYXBT8in8mEtqGYTr8i5y4pGSCXQ8Ig/7+pfPMiR64kNn
	 RGrunNawZIESP/Kr5N5vjhEWSaBBbKziux/Kl6/KvrVGk4mbhIEkB+9xbKSrDy4HfEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=FLSvV9TspWHmUvzWAAZa+GxtLVrKX7tgGAaFn7uUEcjO1TE6a2zBdiLR6QTFdmofUP0I
	 rumKVQN6emjbeX7gkBIZ+p5ann0x4UYpGBjL9X+SWRO0Fdt9trLI0x1zL046qsX10GvVA
	 C3MRHqUhMa5Tki5bz4p8hqPwv0y7RKYPx9YGgPkuTdmbyZN9MTS0zOlupcAVynfyOpo2b
	 lpSeLsA/X/ghuQE9WQerzR9HvOu+IG8EesN+FT7R95O1e3rwLS2XFyIBu4QvdMnRzKswo
	 m4nDaY2ScmbXFOpJqzzOPvfGsQgXQpAiLW6ej7K4NDiVoLMPypn1wGKf/ioTBxr8lng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SO6DpQI5;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396160A262B
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 01:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5396160A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SO6DpQI5
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c450ab1483cso245923266b.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 17:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273747; x=1794878547; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=SO6DpQI5rWf6IkLjQMSvZE9JbnfsANv9gaW+WXFi+6RdbC9/SQqYt6tnFERyOnCNfL
         psF3TFWS6gRZaS/QDwQqi7qDNuwEw6I26eThf69k8Cc6fNLlki/yYmlTIrQ49s6WEYHV
         rvhlj/+VrkL6Bv2u2H/EZ6IUuppFNmvUX8lDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273747; x=1794878547;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=QzOIUJsyAYwiLJ9Uyuayly/EhbVfQVlmRaGu6XQc5kmV0njMK+3RtQW0AgUjLyRjwg
         Rt9H2QxTLfXcJQC8/9rp0dYxNNFhLju5W7IHFbuLir93gIb/uYPUvLExAYT65Hk5Yo92
         hq0d+Ft85sFMcyO5nfAvd5GbdaoAx4tCU4N3gGnRNotcE7f/ab1Xj0K6L9IK/MaH+WYM
         lK/VzNrl+TMidwrGdnxhH2uvmdra1c05irQhlRXK/fit3BHQC58V3Eg3uC4Cv+Rjz45U
         PKBvujHDREWNvQVmp1GipdWyLpdIqgDKsEn5VWrGuSQY1WGSGeQ6JBbXNUfOEvgIDj+v
         A5xA==
X-Forwarded-Encrypted: i=1; AL+hErELO9Df4ZIw6Lb9jfrOkTTfTL+ISZpu6EysNeMiHBAiijUCjLzaBPnGLFlYie91J8adgah4plQIOYzh@vger.kernel.org
X-Gm-Message-State: APuU4Z/Jg3ITMhcaGow0BixhfhGmJxPiqPca8QfeIEaH0p2324qsDW8H
	T0fsnoyYK8o+FIALRkGn7DUeurhlgfUAcc/kb2Va22qGewsV5vKl1MfpFjWS/AWG/OLNj5cNBmt
	zURJW5exogA==
X-Gm-Gg: AYBFou1u0zTG0vUkbzsV4tjoSuMSC0aPWOMYkvFdG0znxTR425/SjdGUCr4RYrhphd4
	gnReUPej8tz8tZXoLWSuTSqqkrKB/avNs1njoUSlwXhHC/j0IlaxV/7psmxQFt2skhYhm4GM1b0
	Z4nGOGCfwZLdBmRt6FOp21y5p7MMTuDYh4jmM3kLReawxjchYD20SxpuUC3t5+jZbFT+ONb8O+t
	qAJn2Xy6xLUXihyzJRwUlwz2IeEBiaoVUiSZnctyTQDwA4JVj/odNOWE1KwDMV2a8uiQ2wLh9KH
	Q6Yb0KaqlM9LuAIBzD4ydpmc13qsN3+v5nP9diK9jXMx16Zb426hh2v0IQiWOIHInJg2D5Seir/
	W4wZyd+oFolUOrZ6b94fOGQfb5o7fDanhPpNNSbj/MNtyirWaSmEig9yVL8ufv1w65+7cULrpvk
	MMJN+KZEnmnBt3zGUYgQhNPSiVcKz2BYpSzTK9acLs0awIii/ANqzunO91nnGJVOsa/wonO1y+M
	AYOuOiX+dBzwVSO8xUHvPxmHHyjWfs6Lx0LrZBrYdAlNEu9Fle6Rtr2kk3cHBTmJVHmbk5bpZly
	3JUiEvDtpaIZNJFM2mqI461xMsYgbyBxBJ/hPsJjdw3IqHzcXGDtRRlQvKBBVeN3TPFm/yqRshy
	mFw==
X-Received: by 2002:a17:906:6205:b0:c41:23bf:18af with SMTP id a640c23a62f3a-c504945304amr90104566b.5.1794273746819;
        Mon, 09 Nov 2026 17:22:26 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5049ef69c7sm44146566b.0.2026.11.09.17.22.26
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:22:26 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c450ab1483cso245922366b.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 17:22:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEiSo4j4S9xueNzWP30ohLE0xonXMy+5sUD3kpY3kNPPQMpSwRHOeicarPOUTXNkolF6vzuvFE0xNQ6@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus
