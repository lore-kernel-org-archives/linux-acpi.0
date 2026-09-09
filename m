Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F6577E4D
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967732; cv=none; b=FCYYgwjhrd1npqk72YwDnECCNLz6VPwhQKCbDIjVi6/EjqWiftY3D9aeYToecfiXodUKVZQ7V6v/CDW645xDL78SA7pXdtSR2ztPKmlQVegGtRhFsgbiJIW3okiceSZbrFoKrBS7Dt8fUrA4KTCsGtwKRlJTdFBp+f8uNLFVnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967732; c=relaxed/simple;
	bh=M6Z2bUHQ5NdUQaQtWXPPgDxWXz7/v5Gko9pictJ019I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWdt7epVwyTdnYn0Sb1a0OBB9jnkAwbQ8M0VbM9kygBmANjkjPpXnqOqnyMcRLF2ZBVYT9vrtu0KzXjsmIJZOgVkKDlqddNeDKdSGY19FtwNG7/+0uviYe4d5toDX+g+4ZAjFXvnW81BiimvdVzQ7OBCk8Med8mIz9wGOEGSRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4AP3ONh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4AP3ONh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA721F00A3D
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788967731;
	bh=J+xBWGF2Jo9wrR+OmKCdpldKBefFf+nVKqK5O8ss/6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A4AP3ONhFsGFVCU2Sz9uZTZdKqTItULBdI/mz8y5rn4WaOBNOd5Vk36YFAsN1yLEF
	 G/bWouln4uPjhthuHI3uhUIxESSL4bel0XWXln+RQ0thGHzFBxHQ2G3JqJDYVY46bz
	 uLYzJ97574d4av8KeKG/m6loV+gwlPePFHt63oRzkp+A91JdQADyhPwT/FMsf392Rg
	 UoRjbnmMn3I0mHI2xbE18fCiVc5Y+/UmYl+PDaqxV2bn5JAs1hYRarhYV81DJUdg8f
	 6QB0UWzZejKywWDWllfp+fo8pTcpCBv0c7fGYmvFcI/wU8svtSYTBN3zU2L6BrXD83
	 tLBmPum+qJYWA==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff174422so3384041fa.3
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 08:28:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBylSU1L4qUBd0YlryZTu6F9Lz9/eBhrt2N8QwKMm3fOYa+7uJuZDuq3+9L+gTWH+xqgYueLsfQwdhds@vger.kernel.org
X-Gm-Message-State: AFuF++noUCiv9b3gjS77S0Udg6uOVCAnxwkD7rX1fAB8jE09hog4HdBm
	Y3w2k42wPvvrv/HICXStxOkVthpjH2m+0tkXvRDaCVLEVEtSKfjmDUM0egwSGR14KZ/IK2TXe37
	U+rXecmjyC/aZlkzzvrfgCU7i+MNYDdg=
X-Received: by 2002:a2e:be2b:0:b0:3a3:5a01:a759 with SMTP id
 38308e7fff4ca-3a58d530a62mr4319151fa.10.1788967729535; Wed, 09 Sep 2026
 08:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827053741.79425-1-kmehltretter@gmail.com>
In-Reply-To: <20260827053741.79425-1-kmehltretter@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 17:27:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ioETPXqmDyp6-WJMFQ+Zbg9wpGKesyGN8qSb4Q=+Beaw@mail.gmail.com>
X-Gm-Features: AcwNN1W8ngSYHKt4JNyoIIQXPjI_PuRxB8P4AXOvPNhC1DehcV56Kq8jeQFI8Qo
Message-ID: <CAJZ5v0ioETPXqmDyp6-WJMFQ+Zbg9wpGKesyGN8qSb4Q=+Beaw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: pfr_update: zero-initialize capability query result
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Anirudh Prasad <icarus@a0rg.com>, Sashiko <sashiko-bot@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:39=E2=80=AFAM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> query_capability() copies four ACPI buffers into fixed-size fields using
> the firmware-supplied lengths.  The existing overflow guard rejects
> oversized buffers, but shorter buffers are accepted and leave trailing
> bytes of the stack-allocated cap_hdr uninitialized.  PFRU_IOC_QUERY_CAP
> then copies the entire structure to userspace.
>
> Zero-initialize cap_hdr before querying the firmware.  This preserves the
> existing handling of short firmware responses while preventing disclosure
> of kernel stack data.  Oversized buffers remain rejected.
>
> A QEMU _DSM returning one-byte buffers reproduced nonzero stack suffix
> bytes in all four fields.  With this change, the ioctl still succeeds and
> each unwritten suffix is zero-filled, while 64-byte buffers continue to
> return -EINVAL.
>
> Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update de=
vice driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/1a001e1fee9.637da6dc3533246.238498=
880682901704%40a0rg.com
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/acpi/pfr_update.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 9afd2c52fdbd..98ace679601b 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -422,7 +422,7 @@ static int start_update(int action, struct pfru_devic=
e *pfru_dev)
>
>  static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned lon=
g arg)
>  {
> -       struct pfru_update_cap_info cap_hdr;
> +       struct pfru_update_cap_info cap_hdr =3D {};
>         struct pfru_device *pfru_dev =3D to_pfru_dev(file);
>         void __user *p =3D (void __user *)arg;
>         u32 rev;
> --

Applied as 7.4 material, thanks!
