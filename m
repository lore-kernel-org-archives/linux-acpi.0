Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642788;
	b=iExldOkkGPBbEa0igJ+Kg/0nufUyJAAkuhDvohV8PK/H+KoLrOQK/sAoQ/Wd54yPHAda
	 bE0Vl1mg9jLRyCoVOKi7mpDrcQS68DdVdQiqqWrt0ctD/xEpI+YDGWV5YbDv6fzFxuhnb
	 XAqFSpo6u4eImrvugWq5fSz9xb23h1ewKbilUwgwUMUGFg0C0xhFR1CO6Udkhg/VPwye1
	 QS1vJes6hllI+LPHkH2R3560fKKKfN6l0XZ3hawjo+KcOpu01BXqvHzdooAW5dWPPNtN4
	 khoasZaChQcEbLxEW3Skf2xuxIOhb+znPSYDYEJ39mopAzww80UJU6Jt5P++fKvexCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=aSqaUB3Z8X7dh7aumqk3NJhD3QTtmEmARxojDoz37T8+x7KrempqcFzX4RFEYR2t0oXD
	 lCsokz0dN5aVbpGZ2VshhCdNeZnquVX4LjYYZfATjiE8Cwn/GphOqBqd6Vp6Q0VbJV660
	 2bW1ktKO++gz2+iL+HoKW2Z9bnu4GR2OUHgkZ+NsCT8dDNV1R6F0iKpj7V6UwnNgnsmkG
	 lM0twT7BkccIALxO4l7NFM92LxwXV6f+ZGN+aMM/cRt55zkCO7vDrXzFBthNbykz+j5rw
	 WJ5r4CjCJ8j6JQ81LrFvrZa93bGoZNlG8MH4GUS44NxHs4gameBdXKtgtC+5QfKY2ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=MG0MhcY7;
	arc=none smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486E606A329
	for <linux-acpi@vger.kernel.org>; Mon,  2 Nov 2026 18:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D486E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=MG0MhcY7
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bfc32574e7so1754066e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2026 10:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642786; x=1794247586; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=MG0MhcY7SaqyPKieCv/MrJr0rntrt8JJl793XjKHK1rYl16jQpRy/PZYW8SPG5n9eM
         6vIe8nEU4SkgLIXsj2rkSWXX0TWBM/QGxbxA/IkGZ0lmBpBVAHZK0JQfLOkmJBQ3nUqN
         Z8E1X77Mr05Hex/AYx2/Pror4s9CvJbb+647Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642786; x=1794247586;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=fGfnXgi+SX2wfZ3nTQp0otg9N30FcGc/y97ZUGEoQofcND/KAUDdmkBW4NSXu6ReF8
         wfHug51MRZ832Clay5Wbn2VbuI/YmkCxFcjbUwpQ3HfNeEVU6Re4zyI0sVrBeLF0W2mj
         31LHsYQ9+z48Kc3y0+MAI+pr5qYbiLPcN/9XgaBB4H+jGIcFwNH2r/l8a3lMQqHWOF1N
         IOxGTRU1g+Bmwo7nnoScg9VptuvRTFUDTVrbon512HEF3tOQg4s4fvcGv1ckUNQd44Nz
         1PrEu4wtTu/PgnNNTlHryQwRB1eZw6Ift/a+zxp8pRtffQmsqpJ5fn/7tHV+wwObkgBk
         9h1w==
X-Forwarded-Encrypted: i=1; AKwUvBzI/0kBrPztBxd9929Vj7SuGqWEs2SPstyVE+fKR0rdWAA92utJoenI1SnfCI8WiwUb3U5GvRGYGvK+@vger.kernel.org
X-Gm-Message-State: APuU4Z9kckSvleSaAOT0h7m9KCXIkxruusBcd5JtrdeimwbFVHWJLDxU
	F8SKaKHezlPIySxQYbCKAwj/tttBrxXBYeFi9lVwD2DEs/VKui9EU/qEbIjq9WEdFtfnK5i8WWn
	KJZXR1z4U4w==
X-Gm-Gg: AYBFou33a8RLDf2axkK22elRX8tUQYdsiiZdIeX6Um2fOzRiLyFGdbzAdSRDJZBFPMs
	rtz67maCSBbSlq8GRagTBlj0/lQtqsgiiJ9RJo3CQq0sjNBM++GY+WT5KqqL4XOtPiCFby1Pf25
	qbOWtHQoK2GlSUjEoWWsTcKeCfGPpRVmLX9EnjFnNK1PDWvtJdFuEid3o+HNvsoZiM7+78N/KT/
	roGVOA1iJ3Ki42r7zw5WbzGV+30jbvH+Gugryh0+c1BY9Ez7eR03c1umVKgnCiErDx0YHcAPzec
	zqdj0tT9jxoXE6elWlZGX1GLa7b7etVnGMP81EWDDweYM5PBQpNWcOIuzF/xQwsaXY5jQDWi8eP
	DfxKO4CFh9Tudue6m3BKkPN1LzQs9Fb2Q3L4DjDDr9KijYJL0lAaSMPiCPWG+u+GjknfmsvNFZR
	OkurWiREKwGojQfJv+bPRkV/HM7zLwd5Ion4bezbwnCCwxYNuLjdgU+tJC6eEZGV1hL+jy/lPVD
	+pj+6N47BOHRqfQucGCjNPLMkhECGMxztg/x2KeN4dcXPwqouToOBNniq3gwqfHGAklidiEaOZg
	YpImeeKSlMpYanPsDVNoQdhsecyrFC04s17lJRXTTulcIA4HI00yWIRSGpgIsv+BHr6BBvSdQrp
	12A==
X-Received: by 2002:a05:6512:3e0a:b0:5bf:c79d:68f with SMTP id 2adb3069b0e04-5bfd118c56emr4439686e87.2.1793642786062;
        Mon, 02 Nov 2026 10:06:26 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe0740446sm1793164e87.61.2026.11.02.10.06.25
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:06:25 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso4764751e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2026 10:06:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwX977UKrvhq42i92mLybp/ZJSJpW+BU2da9gMYzgE9L/nOWk6lDEiAglkddupNU2l+Yighu/5MltUF@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus
