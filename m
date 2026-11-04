Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823222;
	b=k8Lzk2+2wft6ReWjrPeMIsIGLPw1DozdqzN3daqrbLntxUNbcMTQZZDEXRXTMAR55Fb2
	 nTiWpwHgSvHo2OJLded839jKM1C40JR9uidO4hCCbWJyDJBC7nh4oIhV1ZMxomD1R65Nu
	 YzQWhnBvOj1wXn81IPu8vOwF3PvBumKYz5uNohb6lVMwBmQuwgm1r6ug/hy+aXY19nnpz
	 FGRXZMovQgnPhyvspRaIkxhp06MRaql90ICjuG/fzDVgzOzsIRUrITaYXZErOksLN9ank
	 8TcxTomBNGfbhsXlihA6p0JuGSpood1tmtCYNqpzl8m4BKDJR3czhYaEiQSyZzcT1zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=KRoG/XN2dSja2wzYHwkJfL/eAreEnxtUILVSIe0qMMXZKKSd/zoWVOY44Ds5hYGw1CvJ
	 yb2LOx4FPwZE0cbMWZ84cCHkBRQPK3hnmjZ77JfyWN1r7H630wyQGpBptfrv5MBkZtgqx
	 RN5Y8djbIN7aKzW8y+gwq1O9hxIglvtil6M5w04ksQYqceBsLffPcvQbFFQHAryzCa3cK
	 HC5Fj7vVwjEgtTj5ppq+hZEjGlzuUVTtja+GutG9Xcav9x7jZjpf8C27Srfr1hUWYbYGs
	 bGb3dGuQ9jGfyy5pNwjzV7NDhtGoLHjYbKhPcSf+9om+J8VmZDTNx18Hr+Qjf2rkRlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=N5PnK4TU;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C9606D81E
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 20:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 536C9606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=N5PnK4TU
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b579003f29so83758a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 12:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823221; x=1794428021; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=N5PnK4TUqH2zptNH4Su+5LwVFRUZEwQi1Z+wMNf/7H8XLSMP0pZVzNDYWgDKrWRwPC
         m7HQUHn7+rLlFfif1u7e9kletsJjmpGBdTyTlD7FeubL7No0GM15gmHgR3Az58aZem39
         vnbLoM0Uoh61r7nVj2IAtlzpdUM4+B/fPR3aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823221; x=1794428021;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=fqlf2dDNtGNntVPtk8KxnCtMyApmegFNdQqQ3v7cZkuOrJr5g9eMDuEXnJNdd4tE0H
         oSj5ZApgbt43nWKpFErTC+ZLF4E9O+d18FP11t7xJButCLk4A/2qXG+xF0HwbP4MfPlq
         tP5bDnHcrUl/YKmVF7CUxpgCqhTr5RZDNgjy9pf5vBIynHRwlDgju1tVSZVjDg0Doi+P
         K3myrLxyhfX4a4eOzzhY8FQSEvWWeZJC1CCcKw2E3v7lQSZI711BCgu32Si5+ePhT2A2
         ZmPRjJtkSjp94X4DNDOrIbs5ABmY8qnKQuKEcWBOtR5V5RC5/YPbjj6peOV8PT5AD8is
         avDA==
X-Forwarded-Encrypted: i=1; AKwUvBya23ATYDw4l2VmDqbGOJdFflND3W2EldLNKBawO+vZi+93/9I5hCcZHWllRXXnyWhc71/Qd1zuFGRH@vger.kernel.org
X-Gm-Message-State: APuU4Z+r5RYA8zhCkNuFDlIe1Tg3v0GWBOl31MFPQofY6jQp1UiiPGAK
	Pa/XosP2XHTWmZWopu6WKi6Q+L46lFOoJqftfpBFKs/P8bglnJqhMy66uKNeVAHrwb1TdsWA+Uz
	1wXe+nPDRxg==
X-Gm-Gg: AYBFou2f9mYo/pDcQP2JfvdgTu+pjfdtRy10QBckubiynBVX2VR/+wqr+zjmZHroFJo
	kMYcoWzHAMEgwDxshidR4+yKETA0UhNmG2Ns1di8lEcgdkfEnNDWXRjCeNmU1Uq1wVg6Ae3F92j
	Pw1PyBP2QN+/rBs+p977Q/ZAK0WaJ2Y6ZkDDN+R10xQ5G1LQcrfbo1AcB1ZK/Ih2WY9EY6PX3DE
	6zGXb0O83GJIBt/nIQplkmnfvcJ9e+cp446zwyhSNUy8FFN/CNVw8yYppVR51Oa4RBEZmQ08ub0
	mfW158zwi9M+36jZaN5ckcmr9PeFsTssL2k1QML83nVuxwk9rKfR8vg/I/lWRPThIpRI9Ag17gV
	1ZQ2K4w0n1H42R6z7SVCX9VBlh0GFFV3kAMAGkzQTEFTu/Uq/AYsuFSJ1ERWLRLRtQBeNpmfyeb
	YMMkapL7cUNpHIyLRzVGLqgSCzWcN3rIlxDQDRhCWv0ZBMs69Vp7C19eM3zdOtJbClO8hjUnGaw
	iOGoEeZ/rnoOpeNktsAcYtYPxNS97lk8ZC33XOCBTq3BeJLliADnHGy5i58SEl0/hpzfH7zDF2A
	vv/15Pxtfq1ZollNp9pqdt+yR7PL7J5jTE2GmDJCrFs95JEr9BwEBfe8/2tWar1HeZQSN10As4N
	gJQ==
X-Received: by 2002:a05:6402:a4ec:b0:6af:a64f:bd44 with SMTP id 4fb4d7f45d1cf-6b4d62c35c8mr9842922a12.45.1793823220771;
        Wed, 04 Nov 2026 12:13:40 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac83d9esm1094921a12.32.2026.11.04.12.13.40
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:13:40 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c445c95d553so165110466b.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 12:13:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwKRRO1govWN51onMuRfxaYAx4LEhNq85priRdR0ktTbh2n/lllNJHZSfZ5jk588YDVoWoaGs3jfh/7@vger.kernel.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus
