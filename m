Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=LghMLYEXym+bqx8mGPkWvj3duvjTWJUKSJYrFaEI6TGI1YWdGGcz+WURzDwXymqBgx7O
	 7n5n29y6ZhAZjyFT8ZekhewqmaW69n51IK/Zfse1OMILeFyHglUkgirvBM2ykR/+jyFDv
	 IF/aEEJqEZnM95Vhfty0XIxjjvYA6RUamOImnTrREBy3AkBwveDyEHzMth/7HR1/gaiKp
	 VpLFeVVJn4wjgp5EucTds94Ki6uVIVtpbDVmW/hK7RoGtyDUmMKvCjFyhVrvltx2cTU+n
	 SztFTG6KOQeO4tMc2V/gt6O2XnXdQNoANTvQXWZvGwvPbW3FbAAP4M4AXBaCgoYRneA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=UcvmckKz+Ify9mA7ZtUKo66pzyCNUj/0n7MlLz3jia+bCBPTgV+KcAzwFxX2N83c4Jvt
	 /mb3zbyiSCE+4rGlL+LC3O0AkOiKucGuWWIq4GHMVx4QbYyw1ygG0MDqE1HVR/xSDgKwF
	 WMAponsHgbGsrL2GMivl3oafxeepwOa6du8TOD9j3VQRkd6ysWiEJNGvTG6Lo2BJfl/T6
	 Fy3Mx3LyQllAXplZ/ftI5h9If92qKVGO+uSf5jJFZEQEM3OtmEvZ7R7u4G2xv4WT7DMEQ
	 OQQB5G2M1vnIyaM4eHRr8hCPsFXMOb7GhP5E+xzRXDVf/Gtnmq6yaIST6kBHQ0wjvog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R1wo23fo;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC9606A330
	for <linux-acpi@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32FC9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R1wo23fo
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso1148415e9.2
        for <linux-acpi@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164396; x=1794769196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=R1wo23foPI+Ww2Y4cpq43W07Mf+jit8FQA4fqT2qskAAUi1V7hffRwMpOB7+Qy2feP
         zp6ldJHSuMH1zABQV7szZf0nfxC20mZGpEGGAYUnTMCSA+D/eM3r40446T7et2bkfjiC
         dreWD5HpEsS9nqCgyxIq04eCKbTgTbecdrGOOUVU6ZMxtSJBu5DsFEalLWpDFdkgQ0uB
         aL4KHaRzCve8FwzdGS5EGGspb2mKb0HSEJeXONH5i7OkOKbeDnK72SKcvi+y7+XCn36O
         0hhhuZpIRf7jFenNh+SDQ8wSqcE+XBpGUeI1p8lamNeGQoxRmIsRYhy/w5iH4vbINrAq
         VQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=t06iVjD4L176I8kFa8RB2E10msseobsRQJFp0l6iOIgEpT924XarVFA/ZE9OoShUSs
         nIlbm6z6JGjHtqg3QuFrxn8Ok/uhO4pDT6HLbutPHLvhEuzYITMRMhpgrvp/Pn9CSPnA
         0QnjVd2KZG/8VrGIfZzqCPeG22cvQsXr0M9xDa0DAhELp5jYYBjxYU3QwFGdScFLaa55
         KE9j3FhtRlFMomn72gEuyBC+M+WY+TOA0TrWaf/OoE0yp9a8suEYbniAji1IgukpdQC9
         wSM5xn53ggeX+SqSf0Rk+ORFyUr8/Ztbo+LVjr16eb0jHPefmcJAn3tOIKvhIrlsZXSm
         ANkQ==
X-Forwarded-Encrypted: i=1; AL+hErHNwBzgtluo8DBskODUJqyKxfZegXE3xGTYAKpg8FyFO9+I/dCUMjPs3k6GUHw2UAzlPFw+i32zCn+B@vger.kernel.org
X-Gm-Message-State: APuU4Z/vQ+Qy1jobWeZfPbszBrYWK/kZb9kTBg4Qna8pBahbZvESKipN
	2asAAvPC52dIosL0DW3ia1g9j0/Lft96kSaGVch096/0qWVsehYxEvAu
X-Gm-Gg: AYBFou3bANUmk/9mT/gC1roBK4NqmvPVCtYFnu8Z5128XpEq/Jo9NZfD7SOY89SGzSt
	z64zqNswpLSYG7ZeoEvAhskHM3eWt2RS4vWqUsWXu05bNBG9izoaBNf4nO70uLhgVytZz+/jiBl
	n0Kqlo8iHrOqhYIZbowCQUmoHcxpjkMZXJwR0uH2FjGgzk3tXQIxSX6/kH/Pdd6WwK2e/lxNr76
	GAdCKqjun03/rXgVtC7BZJA1AIu14oQp4yVgSfLDpc73qWGIiFQQYqkJuMQmO6VtbMPumYkiqPO
	d0otChL0tyDCt9m+p/olsVHYEXGy5PAPFKOx6DoqNEePrLPJABv+CWKKhqf7kIPE8tVX/2/zDZY
	1+RbRg56yoPMoCUef8HYs7QfoJUHJj2y4mHebCUWKLYQdi/NhFz6H8yiiGGuVTxkwcGxKgp2rX7
	n0A3ZTXIhOYIImUK0c4iSGKdsEkrX5BjwUIj0NOe4tZFFSiWPUT3EBu2b0DjfjJzhYR8EOj7WH/
	R05eG0Q/OAbyE7vqR3B2+6C5VoK5DFp4Y6552ttgK0O4ZorDrsaiQw+Ul9hQ7VtVZDDSHbjlGLA
	NzqPh/Uzht28ndaXN3/xUnkLAmJT9lxXJoMZSKqF8bEI3PhEKzG2i1YzF5C3EL2X
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David
