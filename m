Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872851;
	b=ejud4cKUi+11DHNXHVyAGNc9cZ+MemVoWDtR00KuW6PAtR1AgiBxFfEBW/gt3MxSoiIK
	 WPGyZPh0QXKniPVJba+hSmDRpxpAA1Fq2EVPAhKN7+bDUDZRNTkbFFbpkYmW6hxCBH1b1
	 oJCSkZoYFcXXVOBNfH0953iPJaqCZfdZC1OPMnYxvuPBo7BFL1ciCTzFXDnVjgZYYRgzm
	 avKoyCeLjRtCPallTnwjjhcHHeMhcqOB+W/prUBBgzZGzeTGii3FzaQXC/V9T6pdBUs/Z
	 b7sMhkpw0BSSJD3LmmMmhFfG794JZx1MOoaOFTvxd5pSWStHWO5eevneYe4cMt2ZN0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872851;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
	b=KXc6WVOGe+I79E79tMqaSFIeNb780lUPepMTWp+iaWIg7xYGGz2OBVcK8m78TGabqytA
	 W0So9YnbnCpq68dyuDFCtL2Y+yIIj2AGODo2SznK6ZBTw+txnc0+FTldflAykN5G0tenZ
	 KvIS3XAHc4QO/Kx/IRKuPUpzeNgd4/RmfeBRnA7qKnNcRDvaQzmnpydyEI0ChH4FOw+BX
	 xi0C21g972YMLKWpm2BjLjv7bNVIYUdrnbeT4dZJsHFFjboKbvX7eo1iPc1jV3/0D+UX2
	 AfEkfI7bJqosjk22MLyovAY8rLrayZ3O8kngDlsPISlGgUZONcuxfwjzYGZ62Gx6KPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E34606A331
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 10:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E34606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5364042eecfso22715991cf.2
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 02:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872850; x=1794477650;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
        b=YCjP8bsJ2po6RaTF8U8GNVSlzdhEjdLvJQbmK06cwH8Si46LLY25I75PIGxuCxbum2
         9rlh8ayPHTeL6MPL/QJvfpwfYuiNdgvfNZmH0q0KUDMWHFVeyKtBxpWv33jf8dRg/C/E
         Lf2yGf25z4OAQ19XARzoUHFrYfekQrGd04RhVzAJKzpBxygzJIPsgL8tNCcMqxlnyYXP
         TWrXyEkUqYopM0Q/F99gQq4CsbG4B/xOpmLLJXrJUn/JTiZlgkKNb/8YX9qszXBivqev
         HZ7m41phZ9kH48ThaPMJZ6LTw0T27vxu+sp8Tx/FgZEWGn/u4yuIhnFTaHJ2F45HSjTw
         dsRw==
X-Forwarded-Encrypted: i=1; AKwUvBxle/kjmB16kljhC3fnzfpAKwLjFf01n3rJq0hfiNkgt4VjwEOdznydQGGAY0sAyk9UQFmJPDCkTsQw@vger.kernel.org
X-Gm-Message-State: APuU4Z9uE91A1XMycXY/OpWO+nNRDZlFqMbKpIOE6eOgjN6TAxzyiYTj
	8cZ53wQjjr6sekkeiu9pvn8DDHHiDtQRhUkYE9R/kJX9jvfNrbb7vxqt2wJFPjbd0Ug=
X-Gm-Gg: AYBFou3k2f/I4S7Uq3iEnHOFhdHC1LwAJnraSTSuBanuo4y6NORi7TrUSrdW8La9G5u
	QYcObtV+OWFQg8MlBT32JXfXVCYB9NkHk0eZz/p/FTk4TE7sGKNTAsVZE6RUf7iySkOlfptIOtB
	pRAWOf6LsYB3ggixnQeKZ3D2iougFQYsynKZZ8N5y5QxGUZv//KEtH9elzSs1nZIPNJFWALSlVd
	IWyXXExEiX29iwpOafGsho9uIA0O0REmwgF/ols90Jgnci1t4K9pbSiaG6keKPXMyWBtwm+4U8E
	qSTW9eNZgQM51eMRVV3OnoVArPkXqrSLoLmj+g6GBtXmzhJOf6JosLYe1Vk+6+6LATUdmj3pruN
	1Hy5lHoMvUCdS3JKa/jTzOkFf3E9NVKEZ4rt/WYqE3wep5Qr0+QJkKwkLKYRl78XaYG+Vik/+0p
	V4QIxB7cClda9P9m5sjF8C5jI1lk7fcuSAhCQ2JGXp8tLZJKX+2eYnG00qPy8SiH4z01L1Rzuft
	Skqa1pzH2QE/NzWw3D38Bf7uJksIuZ5Ym84TFMci08R/dc3XCb5V4t/jD4vHiF1UMOk5Mp+IDwn
	eRyl+OfgAEKhA8OaXhO/aHfKA+eRzFDHN27Zp40B4RyFDC/fBico56umaEUzR0pxRnXnDQ==
X-Received: by 2002:a05:622a:2510:b0:536:72b4:b835 with SMTP id d75a77b69052e-542b7141e17mr322347751cf.46.1793872850203;
        Thu, 05 Nov 2026 02:00:50 -0800 (PST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a7006asm48089601cf.17.2026.11.05.02.00.49
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:00:49 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5364042eecfso22715621cf.2
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 02:00:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzGPTgUOX15nHEkFhoAa1kyxtfFZT2ohMeEe/EkcbkxMSuqcpCkIfUkwPnDERBj6U560lU16khpL1wu@vger.kernel.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
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

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
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
